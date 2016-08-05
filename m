Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C51672018E
	for <e@80x24.org>; Fri,  5 Aug 2016 14:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161439AbcHEOlW (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 10:41:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:49447 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161262AbcHEOlV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 10:41:21 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MGRhs-1bRGTS1fpw-00DCZZ; Fri, 05 Aug 2016 16:41:14
 +0200
Date:	Fri, 5 Aug 2016 16:41:12 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git mv: do not keep slash in `git mv dir
 non-existing-dir/`
Message-ID: <e0415c55e9bc651e7fa9f5f7717b4f6e44eb9ce1.1470407827.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5JWIyrpYdaC+c/RJCjDen5IgwS1CzV8aFK+w5JQO9+LrchbTMN2
 dyFpEN90QAdN3Jfjd74Uw6PnF19fztQ1Pou1VC/krN7HOc+LLE9HDTlyPB6yV3pxUwRIm6q
 iBKc8gZz4BTyUx0wAlgYiFG6gNPSG3wPopqST6iGKwpEl45H9pWNM+hzA5MMAxDKh6qUrHs
 D0KRYan1jkDogIlcYDCNg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:UqCewzK40mg=:lr74bqEnS/L+9ksiGEKv38
 qVJ7BUZNth03pbrnXL6t1QE285gUOCT8C9KYNdkqtMnuJ+3lMQbyCDiOJ4DUAaf9bKW4RkCsV
 I5lbzyTJsmG6246/nTTtL19pn8KyANUqj5ebHjIKCXul7CEnUe+WWjK/ywS7rrtr7rOPDlWiw
 Z+eVztsu84XvIR/7T+x2n/YWH+lJpkZi4wLbMN4K981YlaPJ4pgpEN1I3vWRNls5jEheU1d1Y
 cT8NBRelGzfYOEfMEvMeM83+sHoUTyfOLYtih8tH9MaeONIILpBo6NwmoH/3hDCEr13uJIK1g
 Or5ceofllBMl2wg5mb9J3/M3mvohCU2tfM4yVZiduaBq519WLqyr7OEB8XZKmDwTgNmPsiVsf
 EYFSIsJo9p44k7WWwd/MGmx4XeRf5xiq5DGrO7kZvrHP9yz9ES5f5G5Tjd4mxM9yg1KtWCbIF
 trfjFE6celcgwT70JddDcTH6tNIPAgX4gzKg/i1TIE3NXsZ/Hi5vj1Qq7ItZPBwxNVGBYxthe
 QrOe8O0f7ItznE9LW4fdSQtlVd0g6HflA5ssU3mc3N3V/MZIwB///BgRN1/twD3IekTJkx5ag
 a96RQsqsSa8g57jjG/bqlUSQ/7OkipPtYF6xX0n9PdKnr1byTy0uP+SdBQdiEA8qPxWi6hCq+
 I4SWcIupHtmzaSr3Ln0WC8TT8YBxopWnCAQ1CGgSEagggMwsATl7jL6RozErqJlb/yEiOx7p7
 lbAhrULZ6mIUFhj96xxZP2n3SsQo4qrDKaf1+9iloSWV0MmfNrTVFfNztSxuiSudYG7qSy/pa
 eiPfr0G
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When calling `rename("dir", "non-existing-dir/")` on Linux, it silently
succeeds, stripping the trailing slash of the second argument.

This is all good and dandy but this behavior disagrees with the specs at

http://pubs.opengroup.org/onlinepubs/9699919799/functions/rename.html

that state clearly regarding the 2nd parameter (called `new`):

	If the `new` argument does not resolve to an existing directory
	entry for a file of type directory and the `new` argument
	contains at least one non- <slash> character and ends with one
	or more trailing <slash> characters after all symbolic links
	have been processed, `rename()` shall fail.

Of course, we would like `git mv dir non-existing-dir/` to succeed (and
rename the directory "dir" to "non-existing-dir"). Let's be extra
careful to remove the trailing slash in that case.

This lets t7001-mv.sh pass in Bash on Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	There is unfortunately another problem with Git running in Bash on
	Windows: the credential cache daemon somehow gets stuck. I guess
	this is some timing issue, in more than one way: right now, I do
	not really have time to pursue this further.

Published-As: https://github.com/dscho/git/releases/tag/bash-on-windows-v1
Fetch-It-Via: git fetch https://github.com/dscho/git bash-on-windows-v1

 builtin/mv.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index a201426..446a316 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -104,7 +104,7 @@ static int index_range_of_same_dir(const char *src, int length,
 
 int cmd_mv(int argc, const char **argv, const char *prefix)
 {
-	int i, gitmodules_modified = 0;
+	int i, flags, gitmodules_modified = 0;
 	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0;
 	struct option builtin_mv_options[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
@@ -134,10 +134,13 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	modes = xcalloc(argc, sizeof(enum update_mode));
 	/*
 	 * Keep trailing slash, needed to let
-	 * "git mv file no-such-dir/" error out.
+	 * "git mv file no-such-dir/" error out, except in the case
+	 * "git mv directory no-such-dir/".
 	 */
-	dest_path = internal_copy_pathspec(prefix, argv + argc, 1,
-					   KEEP_TRAILING_SLASH);
+	flags = KEEP_TRAILING_SLASH;
+	if (argc == 1 && is_directory(argv[0]) && !is_directory(argv[1]))
+		flags = 0;
+	dest_path = internal_copy_pathspec(prefix, argv + argc, 1, flags);
 	submodule_gitfile = xcalloc(argc, sizeof(char *));
 
 	if (dest_path[0][0] == '\0')
-- 
2.9.0.281.g286a8d9

base-commit: c6b0597e9ac7277e148e2fd4d7615ac6e0bfb661
