From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/02/RFC] implement a stat cache
Date: Mon, 21 Apr 2008 13:06:35 -0700
Message-ID: <7vprsj9dmc.fsf@gitster.siamese.dyndns.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl>
 <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org>
 <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl>
 <alpine.LFD.1.10.0804191515120.2779@woody.linux-foundation.org>
 <20080420111346.GA13411@bit.office.eurotux.com>
 <alpine.LFD.1.10.0804200836310.2779@woody.linux-foundation.org>
 <20080420215700.GA18626@bit.office.eurotux.com>
 <alpine.LFD.1.10.0804201520370.2779@woody.linux-foundation.org>
 <alpine.LFD.1.10.0804201556290.2779@woody.linux-foundation.org>
 <7vk5isatpe.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0804201959590.2779@woody.linux-foundation.org>
 <7v3apfawry.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0804211203460.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luciano Rocha <luciano@eurotux.com>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 21 22:08:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo2Ij-0002xT-9Z
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 22:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761699AbYDUUGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 16:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761652AbYDUUGw
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 16:06:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35736 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761594AbYDUUGv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 16:06:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E87C1FCB;
	Mon, 21 Apr 2008 16:06:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 13F9F1FC6; Mon, 21 Apr 2008 16:06:42 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0804211203460.2779@woody.linux-foundation.org>
 (Linus Torvalds's message of "Mon, 21 Apr 2008 12:09:43 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80037>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 21 Apr 2008, Junio C Hamano wrote:
>> 
>> Doesn't it become very tempting to replace lstat() calls we make to check
>> the status of a work tree path, with a function git_wtstat() that is:
>
> Yes.
>
> That looks like a very good abstraction.
>
>>                 /*
>>                  * As far as git is concerned, this does not exist in
>>                  * the work tree!
>>                  */
>>                 errno = ENOENT;
>>                 return -1;
>>         }
>
> Well, how about returning something else than "ENOENT" here? 
>
> As you point out, git doesn't actually think this is a "does not exist" 
> case, but something else that may require more work:
>
>> This unfortunately is not enough to hide the need for has_symlink calls
>> from outside callers.  When we check out a new path "a/b/c/d/e", for
>> example, if we naively checked if we creat(2) "a/b/c/d/e" (and otherwise
>> we try the equivalent of "mkdir -p"), we would be tricked by a symlink
>> "a/b" that points at some random place that has "c/d" subdirectory in it,
>> and we need to unlink "a/b" first, and the above git_wtstat() does not
>> really help such codepath.
>
> Maybe ENOTDIR would be a better error return?

Yeah, and we could return which component in the given path is the
offending one at the same time.

In the above example, we would say "No, a/b/c/d/e does not exist because
a/b is a symlink".  But would that be enough, I have to wonder.  lstat(2)
may have already said "There is no a/b/c/d/f" in the same example, but we
still need to know "a/b" is an unwanted symbolic link if the reason we are
asking that question is because we would want to check out "a/b/c/d/f".

So the answer need to be "a/b/c/d/f" (does not exist|exists in the work
tree), and it cannot exist because "a/b" is a symlink for such a caller.

But when we are trying to git-add, we simply do not care such
distinction.
