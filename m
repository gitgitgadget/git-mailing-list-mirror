From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] commit/status: check $GIT_DIR/MERGE_HEAD only once
Date: Sat, 12 Dec 2009 01:02:01 -0800
Message-ID: <1260608523-15579-2-git-send-email-gitster@pobox.com>
References: <1260608523-15579-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 12 10:02:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJNsE-0001Mb-DL
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 10:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757977AbZLLJCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 04:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757873AbZLLJCJ
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 04:02:09 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757960AbZLLJCI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 04:02:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D87DBA68F2
	for <git@vger.kernel.org>; Sat, 12 Dec 2009 04:02:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=UgOk
	OA+ijpdD/rn3qDUuflwZl0Y=; b=j72pn9kWMIQh/hgUMGC51WREobgN3aPEQg0t
	yQHmW0lnkAW+nmZqoHvMinsf3aZcDOXB6pD4jhfxzVIBVSNnmOCTbXbrG3Df1bpp
	KvWnuDlrQ3GD//xoR1WXC6qgYmlFS5bFsGsADTYInQpiJcoRdwj6FcP8Xk1cwN1Y
	piSLdPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=MttrY/
	fCta9zlZTrR5MKFRPQLNVk01kgY2XUo1tXgQizUdTNrvVAA9UDMrQE25eNUgbRgG
	iFsePTWX4fqbTSyvDQUDJxFDeGR2+FrfTEaZnUxu1oHMiIzpASpqLM9NQ3TUK1qS
	/a2zkm24LQm+DqlVwkZXn77+KzxE/NEPCGIKY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D4B62A68F1
	for <git@vger.kernel.org>; Sat, 12 Dec 2009 04:02:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4AE62A68F0 for
 <git@vger.kernel.org>; Sat, 12 Dec 2009 04:02:13 -0500 (EST)
X-Mailer: git-send-email 1.6.6.rc2.5.g49666
In-Reply-To: <1260608523-15579-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0AB28E7C-E6FD-11DE-976D-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135126>

The code checked for the MERGE_HEAD file to see if we were about
to commit a merge twice in the codepath; also one of them used a
variable merge_head_sha1[] which was set but was never used.

Just check it once, but do so also in "git status", too, as
we will be using this for status generation in the next patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-commit.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index b39295f..17dd462 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -36,7 +36,7 @@ static const char * const builtin_status_usage[] = {
 	NULL
 };
 
-static unsigned char head_sha1[20], merge_head_sha1[20];
+static unsigned char head_sha1[20];
 static char *use_message_buffer;
 static const char commit_editmsg[] = "COMMIT_EDITMSG";
 static struct lock_file index_lock; /* real index */
@@ -319,7 +319,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	 */
 	commit_style = COMMIT_PARTIAL;
 
-	if (file_exists(git_path("MERGE_HEAD")))
+	if (in_merge)
 		die("cannot do a partial commit during a merge.");
 
 	memset(&partial, 0, sizeof(partial));
@@ -758,9 +758,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (get_sha1("HEAD", head_sha1))
 		initial_commit = 1;
 
-	if (!get_sha1("MERGE_HEAD", merge_head_sha1))
-		in_merge = 1;
-
 	/* Sanity check options */
 	if (amend && initial_commit)
 		die("You have nothing to amend.");
@@ -951,6 +948,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	wt_status_prepare(&s);
 	git_config(git_status_config, &s);
+	in_merge = file_exists(git_path("MERGE_HEAD"));
 	argc = parse_options(argc, argv, prefix,
 			     builtin_status_options,
 			     builtin_status_usage, 0);
@@ -1057,10 +1055,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	wt_status_prepare(&s);
 	git_config(git_commit_config, &s);
+	in_merge = file_exists(git_path("MERGE_HEAD"));
 
 	if (s.use_color == -1)
 		s.use_color = git_use_color_default;
-
 	argc = parse_and_validate_options(argc, argv, builtin_commit_usage,
 					  prefix, &s);
 	if (dry_run) {
-- 
1.6.6.rc2.5.g49666
