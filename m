From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] clone: do not ignore --no-hardlinks
Date: Thu, 26 Feb 2009 21:58:29 -0500
Message-ID: <20090227025829.GA22060@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0902262352380.10279@pacific.mpi-cbg.de> <da2c9173f403c4fb509609fb823b6be0728d94f3.1235690903u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 27 04:00:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcsy1-0004oD-In
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 04:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbZB0C6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 21:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbZB0C6e
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 21:58:34 -0500
Received: from peff.net ([208.65.91.99]:41614 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273AbZB0C6d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 21:58:33 -0500
Received: (qmail 9427 invoked by uid 107); 27 Feb 2009 02:58:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 26 Feb 2009 21:58:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Feb 2009 21:58:29 -0500
Content-Disposition: inline
In-Reply-To: <da2c9173f403c4fb509609fb823b6be0728d94f3.1235690903u.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111627>

On Fri, Feb 27, 2009 at 12:31:22AM +0100, Johannes Schindelin wrote:

> Somehow --no-hardlinks got broken by making clone a builtin.  This
> was discovered during my work on --depth being ignored for local
> clones.
> 
> There will be a test case that tests for --no-hardlinks in conjunction
> with --depth, so this patch is not accompanied by a separate test.

Hmm. But --no-hardlinks has an effect later, in copy_or_link_directory,
making it just do a copy. So it _does_ work, just not in the way you
expect.

I think to turn off local shortcuts entirely, --no-local would probably
make more sense. IOW, something like this:

---
diff --git a/builtin-clone.c b/builtin-clone.c
index c338910..7c6f59f 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -35,7 +35,8 @@ static const char * const builtin_clone_usage[] = {
 };
 
 static int option_quiet, option_no_checkout, option_bare, option_mirror;
-static int option_local, option_no_hardlinks, option_shared;
+static int option_local = -1;
+static int option_no_hardlinks, option_shared;
 static char *option_template, *option_reference, *option_depth;
 static char *option_origin = NULL;
 static char *option_upload_pack = "git-upload-pack";
@@ -229,7 +230,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest)
 		if (!option_no_hardlinks) {
 			if (!link(src->buf, dest->buf))
 				continue;
-			if (option_local)
+			if (option_local == 1)
 				die("failed to create link %s", dest->buf);
 			option_no_hardlinks = 1;
 		}
@@ -511,7 +512,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refspec.src = src_ref_prefix;
 	refspec.dst = branch_top.buf;
 
-	if (path && !is_bundle)
+	if (option_local != 0 && path && !is_bundle)
 		refs = clone_local(path, git_dir);
 	else {
 		struct remote *remote = remote_get(argv[0]);
