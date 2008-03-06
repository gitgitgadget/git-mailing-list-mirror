From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clean: correct printing relative path
Date: Thu, 06 Mar 2008 14:54:37 -0800
Message-ID: <7vwsof8nv6.fsf@gitster.siamese.dyndns.org>
References: <20080305094058.GF4793@artemis.madism.org>
 <20080305141720.GA11542@dpotapov.dyndns.org>
 <20080305155359.GA15843@artemis.madism.org>
 <20080305155943.GB15843@artemis.madism.org>
 <20080305234124.GD11519@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, Git ML <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 23:55:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXOzs-0006VZ-80
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 23:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbYCFWyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 17:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbYCFWyy
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 17:54:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbYCFWyx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 17:54:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C30D92591;
	Thu,  6 Mar 2008 17:54:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E77E8258F; Thu,  6 Mar 2008 17:54:45 -0500 (EST)
In-Reply-To: <20080305234124.GD11519@dpotapov.dyndns.org> (Dmitry Potapov's
 message of "Thu, 6 Mar 2008 02:41:24 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76429>

Dmitry Potapov <dpotapov@gmail.com> writes:

> In addition, when I ran 'git clean -n ..' at the top a repository, the
> current master version of Git though printed the error that '..' is
> outside the repository, still exited with 0. When I test this with
> 1.5.4, git clean exists with 128 after printing the error. Bisect blames
> d089ebaad5315325d67db30176df1bbd7754fda9 for changing the exit code to 0.

You need a change similar to the one that updates builtin-ls-files.c in
d089eba (setup: sanitize absolute and funny paths in get_pathspec()).  The
commit should have adjusted builtin-clean.c but was overlooked.

When you give a set of paths that includes bogus ones, get_pathspec()
issues an error message and gives back a pathspec that does not contain
the entries corresponding to the bogus ones, and that is an indication for
a caller that wants to refuse to operate upon bogus input.  Other callers
that want to issue an error diagnosis and handle the remaining valid input
do not have to die, but "git-clean" is destructive so it would be sensible
to error out the whole operation if you see the user input was bogus.

commit d089ebaad5315325d67db30176df1bbd7754fda9
Author: Junio C Hamano <gitster@pobox.com>

    setup: sanitize absolute and funny paths in get_pathspec()

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 0f0ab2d..3801cf4 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -572,8 +572,17 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 	pathspec = get_pathspec(prefix, argv + i);
 
 	/* Verify that the pathspec matches the prefix */
-	if (pathspec)
+	if (pathspec) {
+		if (argc != i) {
+			int cnt;
+			for (cnt = 0; pathspec[cnt]; cnt++)
+				;
+			if (cnt != (argc - i))
+				exit(1); /* error message already given */
+		}
 		prefix = verify_pathspec(prefix);
+	} else if (argc != i)
+		exit(1); /* error message already given */
 
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec && error_unmatch) {
