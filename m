From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH/PATCH] prefix_path(): disallow absolute paths
Date: Mon, 28 Jan 2008 18:03:14 -0800
Message-ID: <7vbq75s80t.fsf@gitster.siamese.dyndns.org>
References: <47975FE6.4050709@viscovery.net>
	<1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com>
	<alpine.LSU.1.00.0801272043040.23907@racer.site>
	<7v3asiyk2i.fsf@gitster.siamese.dyndns.org>
	<20080128003404.GA18276@lintop>
	<7vodb6wtix.fsf@gitster.siamese.dyndns.org>
	<479D805E.3000209@viscovery.net>
	<7vprvmuykw.fsf@gitster.siamese.dyndns.org>
	<479D9ADE.6010003@viscovery.net>
	<alpine.LSU.1.00.0801281210440.23907@racer.site>
	<7vwspts9vj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 29 03:04:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJfpU-00009z-62
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 03:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756847AbYA2CDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 21:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755433AbYA2CDW
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 21:03:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38034 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbYA2CDW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 21:03:22 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C5352955;
	Mon, 28 Jan 2008 21:03:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 67FF52954;
	Mon, 28 Jan 2008 21:03:16 -0500 (EST)
In-Reply-To: <7vwspts9vj.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 28 Jan 2008 17:23:12 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71915>

Junio C Hamano <gitster@pobox.com> writes:

> I suspect that the right approach might be something like the
> attached patch.  It introduces a version of prefix_path() that
> sanitizes path (but not prefix part, which comes from git itself
> and hopefully there should not be a need to sanitize it) while
> doing the prefixing.  It also strips the leading absolute path
> to the repository by comparing it with the value of work_tree.
>
> A few things to note.
>
>  * Your mv fix is rolled in.
>
>  * This allows you to name a in-repository file as `pwd`/file,
>    or `pwd`//file (iow, double-slash is also sanitized).  It may
>    kill the bird in another thread nearby.
>
>  * get_pathspec() drops paths outside of repository, so the
>    caller may end up getting a smaller number of paths than it
>    originally gave it.  If an existing caller expects the same
>    number of paths to come back, it needs to be adjusted (I did
>    not check).  We could alternatively die() but I couldn't
>    decide which one is a better behaviour.

This is the kind of "fixing existing callers" that would be
needed if we take this approach.

 builtin-ls-files.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

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
