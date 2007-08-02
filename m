From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 02 Aug 2007 11:23:15 +0200
Message-ID: <vpqhcni47ek.fsf@bauges.imag.fr>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 11:23:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGWuO-00071A-8N
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 11:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235AbXHBJXg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 05:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755170AbXHBJXf
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 05:23:35 -0400
Received: from imag.imag.fr ([129.88.30.1]:44010 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754813AbXHBJXd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 05:23:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l729NF2i012420
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 2 Aug 2007 11:23:16 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IGWtn-0005pr-Nw; Thu, 02 Aug 2007 11:23:15 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IGWtn-0001vT-LY; Thu, 02 Aug 2007 11:23:15 +0200
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 02 Aug 2007 11:23:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54528>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> $ touch bar
>> $ git diff
>> diff --git a/bar b/bar         <--- here ---<
>> $ git status
>> # On branch master
>> nothing to commit (working directory clean)
>> $ git diff                     <--- status updated
>>                                     the stat in the index.
>>
>> Is this intended,
>
> Yes.  Very much so, intentionally, from very early days of git.
> This serves as a reminder to the user that he started editing
> but changed his mind to end up with the same contents as the
> original, until the next "update-index --refresh" (which is
> internally invoked from "status").
>
> If the feature still makes sense in the modern world is a
> different story, but I do find it useful.

I understand that it can be usefull, but I really don't like having it
by default (is there a way to deactivate it BTW?):

I've hit this while working on a project, doing a lot of modifications
through scripting (some regexp substitutions and such kinds of
things). Then, git-diff shows me pages of "diff --git ...", and a few
relevant entries in the middle of it. That's very bad from the
usability point of view (I actually had some ~20 lines diff surrounded
by 100+ irrelevant lines), and also kills performance: if a script
touches a lot of files, I expect the next "diff" or "status" to be
slow, but not the second next. Here, diff will be slow until I run
git-status again.

And I find the "reminder" feature very fragile. That means git-status
is no longer a read-only operation for the user. As a user, I expect
to be able to run git-status without changing the behavior of
subsequent git commands, which is not the case here. That means for
example that someone used to running git-diff /before/ git-status will
get the reminder, while someone used to running git-diff /after/
git-status (which I find sensible, get an overview before getting the
details of what you did) won't get it. Note also that this makes a
difference between git-status (which updates the stat in the index)
and git-status -a (which doesn't). That's an implementation detail
that shouldn't be exposed to the user.

Since I don't see any mention of this in the man pages for git-diff or
git-status (I might have missed it), I wonder how many user actually
ever used this as a feature.

I'd be in favor of disabling this by default, and providing a
configuration option and/or a command line option to diff to enable
it. I can try writting a patch for this if people agree on the
specification.

-- 
Matthieu
