From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Tue, 01 Jul 2008 16:55:31 -0700
Message-ID: <7vzlp1jh1o.fsf@gitster.siamese.dyndns.org>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com>
 <c376da900806301549r6044cd35r5a23baa405570808@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>
To: "Adam Brewster" <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 01:57:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDpih-0001Jj-8G
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 01:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757128AbYGAXzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 19:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757093AbYGAXzx
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 19:55:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757128AbYGAXzi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 19:55:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A078B26753;
	Tue,  1 Jul 2008 19:55:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7F7B326752; Tue,  1 Jul 2008 19:55:33 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 33F18470-47C9-11DD-88AD-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87072>

"Adam Brewster" <adambrewster@gmail.com> writes:

> Git-basis is a perl script that remembers bases for use by git-bundle.
> Code from rev-parse was borrowed to allow git-bundle to handle --stdin.
>
> Signed-off-by: Adam Brewster <adambrewster@gmail.com>
> ---
> As promised, here's another patch with documentation.  The code is
> identical to the previous version.
>
> I know this is a minor patch, but I think the result is a more usable
> git-bundle feature, and I'd like to see it included in future releases
> if there are no objections.

Well, I have a moderately strong objection to this.

This very much feels like adding a missing feature to "git bundle" command
itself.  Why isn't it a new option to it?

For that matter, I am not sure how this integrates to a larger workflow.
You have a site (or more) to "push" your changes to, and you would need to
remember up to which revisions you have given out bundles to.  To remember
which site is at what basis level, you would need an extra infrastructure
than what this separate command offers (and "I'll have a yet another layer
of wrapper to this script" is not a good answer.  That wrapper can simply
read the tips from the bundle and record them without your script, and the
wrapper can use the previously recorded information to use the new bottom
refs when creating a new bundle again without using your script).

Perhaps it would be sufficient to have a new option to git-bundle.  "write
basis information under this name, so that I can reuse it in the next
invocation", and "I am not giving the bottom refs to create this bundle;
read them from the existing basis with this name".  It probably is easiest
to operate if these two are simply a new single option, like this...

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index f6a0612..d3e0716 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -9,7 +9,7 @@ git-bundle - Move objects and refs by archive
 SYNOPSIS
 --------
 [verse]
-'git-bundle' create <file> <git-rev-list args>
+'git-bundle' create [--basis=<filename>] <file> <git-rev-list args>
 'git-bundle' verify <file>
 'git-bundle' list-heads <file> [refname...]
 'git-bundle' unbundle <file> [refname...]
@@ -37,6 +37,17 @@ create <file>::
        Used to create a bundle named 'file'.  This requires the
        git-rev-list arguments to define the bundle contents.
 
+--basis=<filename>;;
+	Record the tips of resulting bundle to the file whie creating the
+        bundle, so that the information can be used when later creating a
+        new bundle to incrementally update a repository that resulting
+        bundle has already been applied to.
++
+If the named file exists, it should name the file given to this
+option in a previous invocation of 'git-bundle create' command.
+The tips of history recorded in the file is read and the resulting
+bundle will require them.
+
 verify <file>::
        Used to check that a bundle file is valid and will apply
        cleanly to the current repository.  This includes checks on the
@@ -165,6 +176,26 @@ $ git pull bundle
 would treat it as if it is talking with a remote side over the
 network.
 
+- Use basis file to keep track.
+
+------------
+$ git bundle create --basis=siteA.basis 2008-07-01.bndl master
+------------
+
+The new file `siteA.basis` records the tip commits in the created
+bundle.  Give `2008-07-01.bndl` to 'site A'.  Then later:
+
+------------
+$ git bundle create --basis=siteA.basis 2008-08-01.bndl master
+------------
+
+This invocation will read the existing `siteA.basis` file, reads the tip
+commits recorded there, and excludes the history reachable from these
+commits from the resulting `2008-08-01.bndl` bundle.  You can give this to
+'site A'; as long as they have extracted the previous bundle, it is
+sufficient to bring them up-to-date.
+
+
 Author
 ------
 Written by Mark Levedahl <mdl123@verizon.net>

Hmm?
