From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] fsck: three levels of validation
Date: Fri, 30 Jan 2009 03:05:16 -0800
Message-ID: <1233313517-24208-5-git-send-email-gitster@pobox.com>
References: <1233313517-24208-1-git-send-email-gitster@pobox.com>
 <1233313517-24208-2-git-send-email-gitster@pobox.com>
 <1233313517-24208-3-git-send-email-gitster@pobox.com>
 <1233313517-24208-4-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 12:07:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSrDY-0005ur-1M
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 12:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbZA3LFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 06:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752464AbZA3LFi
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 06:05:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58822 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbZA3LFh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 06:05:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 61F8D9472F
	for <git@vger.kernel.org>; Fri, 30 Jan 2009 06:05:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A028E9472D for
 <git@vger.kernel.org>; Fri, 30 Jan 2009 06:05:34 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.312.g5be3c
In-Reply-To: <1233313517-24208-4-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EBD620F0-EEBD-11DD-84CB-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107796>

Traditionally, "git fsck" only checked loose objects and "git fsck --full"
checked both loose and packed objects fully.

This introduces a new medium level of validation that checks loose objects
and runs the quicker packfile validation introduced earlier (in other
words, the individual objects in packfiles are not validated, but we still
make sure that the packfiles themselves are sound and individual objects
pass their own CRC checks when the pack has version 2 idx file), and makes
this new mode the default.  The original "loose objects only" mode can be
asked with --quick option.

In my private git project repository (almost fully packed but with may
dangling objects) on my AMD 64X2:

    $ /usr/bin/time ./git-fsck --quick
    0.18user 0.02system 0:00.20elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+3205minor)pagefaults 0swaps

    $ /usr/bin/time ./git-fsck
    68.61user 0.43system 1:09.06elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+116707minor)pagefaults 0swaps

    $ /usr/bin/time ./git-fsck --full
    90.36user 0.61system 1:31.00elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+169641minor)pagefaults 0swaps

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-fsck.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 8dc7881..72bf33b 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -20,6 +20,7 @@ static int show_tags;
 static int show_unreachable;
 static int include_reflogs = 1;
 static int check_full;
+static int check_quick;
 static int check_strict;
 static int keep_cache_objects;
 static unsigned char head_sha1[20];
@@ -576,7 +577,8 @@ static struct option fsck_opts[] = {
 	OPT_BOOLEAN(0, "root", &show_root, "report root nodes"),
 	OPT_BOOLEAN(0, "cache", &keep_cache_objects, "make index objects head nodes"),
 	OPT_BOOLEAN(0, "reflogs", &include_reflogs, "make reflogs head nodes (default)"),
-	OPT_BOOLEAN(0, "full", &check_full, "also consider alternate objects"),
+	OPT_BOOLEAN(0, "full", &check_full, "fully check packs"),
+	OPT_BOOLEAN(0, "quick", &check_quick, "only check loose objects"),
 	OPT_BOOLEAN(0, "strict", &check_strict, "enable more strict checking"),
 	OPT_BOOLEAN(0, "lost-found", &write_lost_and_found,
 				"write dangling objects in .git/lost-found"),
@@ -587,10 +589,14 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 {
 	int i, heads;
 	struct alternate_object_database *alt;
+	unsigned verify_pack_flag;
 
 	errors_found = 0;
 
 	argc = parse_options(argc, argv, fsck_opts, fsck_usage, 0);
+	if (check_full && check_quick)
+		die("--full and --quick?  which one do you want?");
+
 	if (write_lost_and_found) {
 		check_full = 1;
 		include_reflogs = 0;
@@ -608,13 +614,14 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		fsck_object_dir(namebuf);
 	}
 
-	if (check_full) {
+	if (!check_quick) {
 		struct packed_git *p;
 
+		verify_pack_flag = check_full ? 0 : VERIFY_PACK_QUICK;
 		prepare_packed_git();
 		for (p = packed_git; p; p = p->next)
 			/* verify gives error messages itself */
-			verify_pack(p, 0);
+			verify_pack(p, verify_pack_flag);
 
 		for (p = packed_git; p; p = p->next) {
 			uint32_t j, num;
-- 
1.6.1.2.312.g5be3c
