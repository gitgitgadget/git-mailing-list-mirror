From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: fix ls-tree usage with dash-prefixed paths
Date: Sun, 29 Mar 2009 23:44:08 -0700
Message-ID: <7v3acvldc7.fsf@gitster.siamese.dyndns.org>
References: <22719363.post@talk.nabble.com>
 <20090326130213.GC3114@atjola.homenet>
 <83dfc36c0903260735q3231ce96h5949d1123858995f@mail.gmail.com>
 <83dfc36c0903270418q59a81290xcb8043b8c037be18@mail.gmail.com>
 <20090329060858.GB15773@dcvr.yhbt.net> <20090329061045.GA29721@dcvr.yhbt.net>
 <7v8wmoqdc1.fsf@gitster.siamese.dyndns.org>
 <20090329215651.GA4355@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Anton Gyllenberg <anton@iki.fi>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Mar 30 08:45:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoBFl-0006UE-FN
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 08:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477AbZC3GoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 02:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754975AbZC3GoS
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 02:44:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56969 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590AbZC3GoR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 02:44:17 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 44F2EA9B0;
	Mon, 30 Mar 2009 02:44:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6C383A9AF; Mon,
 30 Mar 2009 02:44:11 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2F88ED58-1CF6-11DE-AAEC-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115085>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Wong <normalperson@yhbt.net> writes:
>> 
>> > To find the blob object name given a tree and pathname, we were
>> > incorrectly calling "git ls-tree" with a "--" argument followed
>> > by the pathname of the file we wanted to get.
>> >
>> >   git ls-tree <TREE> -- --dashed/path/name.c
>> >
>> > Unlike many command-line interfaces, the "--" alone does not
>> > symbolize the end of non-option arguments on the command-line.
>> >
>> > ls-tree interprets the "--" as a prefix to match against, thus
>> > the entire contents of the --dashed/* hierarchy would be
>> > returned because the "--" matches "--dashed" and every path
>> > under it.
>> 
>> The above makes only half a sense to me.  In an empty directory:
>
> Ah, I think you missed this line:
>
> "the entire contents of the --dashed/* hierarchy would be"

Actually, that was what I was trying to demonstrate to be false.  Notice
the empty output from the first ls-tree with only -- and no other pathspec
on the command line.  "--" should not match "--dashed/*" anything (but
also notice that I said "should" here).

>>     $ git init
>>     Initialized empty Git repository in /tmp/empty/.git
>>     $ mkdir -p ./--dashed/path
>>     $ >./--dashed/path/name
>
> # Add a second file
> 	>./--dashed/path/ame

I think that is an independent bug.  Not just "--" but it appears "--d"
seems to hit it (and this is an ancient bug---even v1.0.0 seems to have
it).

> [1] But if we had time travel we could just release git before any other
> SCM and hopefully not have to deal with SVN at all :)

;-)

I suspect that ls-tree needs a fix, not about "--" but about the pathspec
filtering.  It appears that the part that decides if a subtree is worth
traversing into uses the correct "is a pathspec pattern match leading path
components?" semantics (i.e. "--dashed" matches but "--" doesn't), but
after traversing into subtrees, the part that emits the output uses a
broken semantics "does the path have any pathspec patter as its prefix?"
It shouldn't check for "prefix", but for "leading path components", in
other words, the match must happen at directory boundaries.

And I do not think *this* bug is too late to fix.  We should fix it.
