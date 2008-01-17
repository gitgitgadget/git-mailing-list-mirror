From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Wed, 16 Jan 2008 18:28:09 -0800
Message-ID: <7vzlv5kwxy.fsf@gitster.siamese.dyndns.org>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
	<alpine.DEB.1.00.0801151444180.5289@eeepc-johanness>
	<c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
	<alpine.LNX.1.00.0801151728120.13593@iabervon.org>
	<7vhched3kw.fsf@gitster.siamese.dyndns.org>
	<7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org>
	<7v7iiabjyh.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801151902080.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801151919440.2806@woody.linux-foundation.org>
	<alpine.LNX.1.00.0801152256480.13593@iabervon.org>
	<alpine.LFD.1.00.0801152017490.2806@woody.linux-foundation.org>
	<7v1w8hploy.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0801161524390.13593@iabervon.org>
	<7vprw1mfpr.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801170108440.17650@racer.site>
	<7vejchmeom.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801170151040.17650@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Ortman <chrisortman@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 03:29:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFKVA-0000r0-5F
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 03:29:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506AbYAQC2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 21:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754384AbYAQC23
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 21:28:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbYAQC2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 21:28:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BD46430A;
	Wed, 16 Jan 2008 21:28:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4142E4309;
	Wed, 16 Jan 2008 21:28:17 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801170151040.17650@racer.site> (Johannes
	Schindelin's message of "Thu, 17 Jan 2008 01:54:16 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70813>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> No, what you are talking about is a need of negative prefix, which you 
>> did not implement in that no/src/dst-prefix patch.
>
> I'm probably missing something, but wouldn't a "diff --git gitk-git/gitk 
> gitk-git/gitk" instead of "diff --git a/gitk-git/gitk b/gitk-git/gitk" in 
> mbox format be directly grokkable by git-am?
>
>> Using --no-prefix is a _hack_ that may happen to work only when
>> the subtree-merged project is one level down.
>
> Yep.  But my point was more to show that it is still a valid git diff.  

My point was that the validness you mentined above is a
happenstance, and not a result of a good design.

After I move gitk-git one level down to modules/gitk but before
making it as a submodule, the output with --no-prefix will say
"diff --git modules/gitk/gitk modules/gitk/gitk", and that will
not be a suitable diff for Paul to apply to his tree.

I think he needs "-p2", but then he can already do that to diffs
produced without using your --no-prefix that talks about "diff
--git a/gitk-git/gitk b/gitk-git/gitk".  IOW, --no-prefix is not
a solution to anything.

And that is why I keep calling your "--no-prefix happens to work
if you are only talking about a project that is subtree-merged
one level down" argument a _hack_.

If we were to do this properly in "git diff", we would:

 - introduce a separate --strip-paths=1 (or whatever number of
   levels of leading prefix);

 - not use --{src,dst,no}-prefix

and you would do:

	$ git diff --strip-paths=1 gitk-git

in the current tree, which would first strip one path component
and then do the usual opt->a_prefix/b_prefix thing to show:

	diff --git a/gitk b/gitk

Similarly you would run:

        $ git diff --strip-paths=2 modules/gitk

after I move gitk-git down one level.

An alternative would be to use the jc/diff-relative topic
currently parked in 'offcuts' branch, and run:

	$ cd gitk-git && git diff .

or

	$ cd modules/gitk && git diff .

which would give diffs in relative paths.
