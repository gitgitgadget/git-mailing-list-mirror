From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge-Recursive Improvements
Date: Tue, 12 Feb 2008 15:11:19 -0800
Message-ID: <7vodal22js.fsf@gitster.siamese.dyndns.org>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Voltage Spike <voltspike@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 00:12:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP4Iv-0003Ke-LT
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 00:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762628AbYBLXLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 18:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762613AbYBLXLs
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 18:11:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42263 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762546AbYBLXLp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 18:11:45 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 23A546076;
	Tue, 12 Feb 2008 18:11:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 01D196073; Tue, 12 Feb 2008 18:11:36 -0500 (EST)
In-Reply-To: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com> (Voltage
 Spike's message of "Tue, 12 Feb 2008 15:16:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73710>

Voltage Spike <voltspike@gmail.com> writes:

> I would like to make a series of significant improvements to the
> merge-recursive mechanism in git, but I was hoping to solicit some early
> feedback before submitting patches.
>
> First, git is overly zealous at merging differences and two functions
> added
> at the same point in a file become intertwined during the merge. A
> trivial
> example of this behavior:
>
>   <<<<<<< HEAD:file.txt
>   void newfunc1()
>   =======
>   void newfunc2()
>   >>>>>>> merge:file.txt
>   {
>     int err;
>   <<<<<<< HEAD:file.txt
>     err = doSomething();
>   =======
>     err = doSomethingElse();
>   >>>>>>> merge:file.txt

This lacks illustration of what you change that example to, which
makes the proposal harder to judge.

I suspect you are saying that you would want to coalesce
adjacent hunks that have too small number of lines between '>>>'
of the previous hunk and '<<<' of the current hunk by duplicate
the common hunks, like this:

   <<<<<<< HEAD:file.txt
   void newfunc1()
   {
     int err;
     err = doSomething();
   =======
   void newfunc2()
   {
     int err;
     err = doSomethingElse();
   >>>>>>> merge:file.txt

(here, two lines that are "{" and "int err;" are taken as "too small").

I think it makes sense.

> Second, git doesn't tell me the original code inside the conflict
>
>   >>>>>>> merge-base:file.txt
>   Original code.
>   ======= HEAD:file.txt
>   Head code.
>   ======= merge:file.txt
>   Merged code.
>   <<<<<<<

This is a much harder sell, as external tool like git-mergetool
that inspect the result depend on the current output.

And it is not as useful as an alternative.

In case you did not know, you can get a much better picture by:

    $ git log --left-right -p --merge

because you would then see not just the merge base version but
the changes _and the reasons for the changes_ in between.

> Third, git doesn't appear to have any sense of context when performing a
> merge. Another contrived example which wouldn't be flagged as a merge
> conflict:
>
>   ptr = malloc(len); // Added in HEAD.
>   init();            // Included in merge-base.
>   ptr = malloc(len); // Added in "merge".

Are you saying it a problem to report or not to report?  In
either case, I decline to comment on this one, as I do not have
a strong opinion either way.

> Fourth, git doesn't provide a mechanism for merges to ignore whitespace
> changes.

That would be a good change.

I can immediately say that 1 and 4 are worthwhile things to do,
as long as they are contained to xdl_merge().  It would help
other users of the merge logic.

I've started working on rewriting revert to directly use
xdl_merge(), bypassing major parts of merge-recursive, and I
imagine such a change you propose would be useful without
affecting the callers.
