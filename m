From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] verify-pack: add --quick
Date: Fri, 30 Jan 2009 03:05:15 -0800
Message-ID: <1233313517-24208-4-git-send-email-gitster@pobox.com>
References: <1233313517-24208-1-git-send-email-gitster@pobox.com>
 <1233313517-24208-2-git-send-email-gitster@pobox.com>
 <1233313517-24208-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 12:07:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSrDW-0005ur-Dm
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 12:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbZA3LFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 06:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752464AbZA3LFf
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 06:05:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbZA3LFe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 06:05:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A3C279472B
	for <git@vger.kernel.org>; Fri, 30 Jan 2009 06:05:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C1A379472A for
 <git@vger.kernel.org>; Fri, 30 Jan 2009 06:05:32 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.312.g5be3c
In-Reply-To: <1233313517-24208-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EA34F9F6-EEBD-11DD-85FB-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107795>

This teaches "git verify-pack" a new option --quick, to trigger the
VERIFY_PACK_QUICK option.

"git fsck" is a more familiar command, and it checks more things at once
than "git verify-pack", and the case you do want to use the latter is when
really want a deep verification of a single pack.  For this reason, I do
not think anybody would want to actually use this option, but it was an
easy way to benchmark the change.

For a 32M packfile from the git repository on my AMD64X2:

    $ /usr/bin/time ./git-verify-pack $THE_PACKFILE
    22.16user 0.18system 0:22.35elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+44166minor)pagefaults 0swaps

    $ /usr/bin/time ./git-verify-pack --quick $THE_PACKFILE
    0.43user 0.02system 0:00.45elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+11569minor)pagefaults 0swaps

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-verify-pack.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
index 42ae406..fdc04d1 100644
--- a/builtin-verify-pack.c
+++ b/builtin-verify-pack.c
@@ -54,12 +54,13 @@ static void show_pack_info(struct packed_git *p)
 		       chain_histogram[0], chain_histogram[0] > 1 ? "s" : "");
 }
 
-static int verify_one_pack(const char *path, int verbose)
+static int verify_one_pack(const char *path, int verbose, int quick)
 {
 	char arg[PATH_MAX];
 	int len;
 	struct packed_git *pack;
 	int err;
+	unsigned flag = (quick ? VERIFY_PACK_QUICK : 0);
 
 	len = strlcpy(arg, path, PATH_MAX);
 	if (len >= PATH_MAX)
@@ -93,7 +94,7 @@ static int verify_one_pack(const char *path, int verbose)
 		return error("packfile %s not found.", arg);
 
 	install_packed_git(pack);
-	err = verify_pack(pack, 0);
+	err = verify_pack(pack, flag);
 
 	if (verbose) {
 		if (err)
@@ -112,6 +113,7 @@ static const char verify_pack_usage[] = "git-verify-pack [-v] <pack>...";
 int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 {
 	int err = 0;
+	int quick = 0;
 	int verbose = 0;
 	int no_more_options = 0;
 	int nothing_done = 1;
@@ -121,13 +123,15 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 		if (!no_more_options && argv[1][0] == '-') {
 			if (!strcmp("-v", argv[1]))
 				verbose = 1;
+			else if (!strcmp("--quick", argv[1]))
+				quick = 1;
 			else if (!strcmp("--", argv[1]))
 				no_more_options = 1;
 			else
 				usage(verify_pack_usage);
 		}
 		else {
-			if (verify_one_pack(argv[1], verbose))
+			if (verify_one_pack(argv[1], verbose, quick))
 				err = 1;
 			discard_revindex();
 			nothing_done = 0;
-- 
1.6.1.2.312.g5be3c
