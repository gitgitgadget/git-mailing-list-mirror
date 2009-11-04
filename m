From: Jeff King <peff@peff.net>
Subject: Re: [PATCH bg/format-patch-p-noop] log-tree: always add --- marker
 when options are patch and a stat
Date: Wed, 4 Nov 2009 01:36:13 -0500
Message-ID: <20091104063612.GA24263@coredump.intra.peff.net>
References: <1257283456-7007-1-git-send-email-bebarino@gmail.com>
 <7vy6mmltz9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?QmrDtnJu?= Gustavsson <bgustavsson@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 07:36:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5ZTp-00006h-43
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 07:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbZKDGgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 01:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbZKDGgN
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 01:36:13 -0500
Received: from peff.net ([208.65.91.99]:60808 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253AbZKDGgM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 01:36:12 -0500
Received: (qmail 7921 invoked by uid 107); 4 Nov 2009 06:39:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 04 Nov 2009 01:39:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Nov 2009 01:36:13 -0500
Content-Disposition: inline
In-Reply-To: <7vy6mmltz9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132043>

On Tue, Nov 03, 2009 at 09:49:46PM -0800, Junio C Hamano wrote:

> I actually am more worried about 68daa64 from 14 months ago, as I vaguely
> recall seeing an explicit user request that in some community the diffstat
> information is unwanted on their mailing list, and I am reasonably sure
> that "-p suppresses --stat" was done deliberately to satisfy them (even
> though it may have been a suboptimal UI and --no-stat might have been a
> lot more straightforward).
> 
> Even though I personally find the stat information very useful, I would be
> happier if somebody reverts the bg/format-patch-p-noop series and instead
> fixes the regression caused by 68daa64, and does so without touching any
> output from the low-level plumbing like diff-tree that may be used by
> scripts.

I agree that 68daa64 is a hack (and I even noted in the commit log that
"-p" is now a no-op). The problem is that we don't have the one critical
bit of information in cmd_format_patch that we do in diff_opt_parse: was
the format set explicitly, or was it a side-effect of -U (or --binary,
or maybe others).

Here's a patch which fixes the regression, but it feels awfully hack-ish
to me, as it treats "-p" specially in diff_opt (but in a way that no
other existing code should care about). It would be "cleaner" to me to
have some infrastructure for keeping an implicit and an explicit format,
and then merging them at the end. But I don't think we ever care about
this explicitness for any other formats, so this is at least simple.

Another option might be for format-patch to simply parse "-p" itself,
setting the format and marking an "explicit" flag. I'll look into that
as an alternative.

---
diff --git a/builtin-log.c b/builtin-log.c
index a359679..3b5819e 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1034,8 +1034,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
 		die("--check does not make sense");
 
-	if (!rev.diffopt.output_format
-		|| rev.diffopt.output_format == DIFF_FORMAT_PATCH)
+	if (!rev.diffopt.output_format ||
+	   (rev.diffopt.output_format == DIFF_FORMAT_PATCH &&
+	    !rev.diffopt.explicit_patch_format))
 		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY;
 
 	/* Always generate a patch */
diff --git a/diff.c b/diff.c
index 9cd9693..9ce5520 100644
--- a/diff.c
+++ b/diff.c
@@ -2643,8 +2643,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	const char *arg = av[0];
 
 	/* Output format options */
-	if (!strcmp(arg, "-p") || !strcmp(arg, "-u"))
+	if (!strcmp(arg, "-p") || !strcmp(arg, "-u")) {
 		options->output_format |= DIFF_FORMAT_PATCH;
+		options->explicit_patch_format = 1;
+	}
 	else if (opt_arg(arg, 'U', "unified", &options->context))
 		options->output_format |= DIFF_FORMAT_PATCH;
 	else if (!strcmp(arg, "--raw"))
diff --git a/diff.h b/diff.h
index 55f3203..406c0c6 100644
--- a/diff.h
+++ b/diff.h
@@ -90,6 +90,7 @@ struct diff_options {
 	int skip_stat_unmatch;
 	int line_termination;
 	int output_format;
+	int explicit_patch_format;
 	int pickaxe_opts;
 	int rename_score;
 	int rename_limit;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index f826348..5689d59 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -455,6 +455,27 @@ test_expect_success 'format-patch respects -U' '
 
 '
 
+cat > expect << EOF
+
+diff --git a/file b/file
+index 40f36c6..2dc5c23 100644
+--- a/file
++++ b/file
+@@ -14,3 +14,19 @@ C
+ D
+ E
+ F
++5
+EOF
+
+test_expect_success 'format-patch -p suppresses stat' '
+
+	git format-patch -p -2 &&
+	sed -e "1,/^$/d" -e "/^+5/q" < 0001-This-is-an-excessively-long-subject-line-for-a-messa.patch > output &&
+	test_cmp expect output
+
+'
+
 test_expect_success 'format-patch from a subdirectory (1)' '
 	filename=$(
 		rm -rf sub &&

> With older (say 1.6.0) git, format-patch with the -p option does not give
> these three-dash lines, and it does look funny.  Even though the same
> funniness appears only when you use --raw or --numstat with the current
> code, if we fix "-p" to suppress the default "--stat", this will become an
> issue again.

My test case checks the current output (i.e., missing dashes). I think
it should probably have dashes, but that should be fixed in a separate
patch.

-Peff
