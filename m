From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] [squash] fsck: revert --quick to the default and
 introduce --medium
Date: Fri, 30 Jan 2009 03:05:17 -0800
Message-ID: <1233313517-24208-6-git-send-email-gitster@pobox.com>
References: <1233313517-24208-1-git-send-email-gitster@pobox.com>
 <1233313517-24208-2-git-send-email-gitster@pobox.com>
 <1233313517-24208-3-git-send-email-gitster@pobox.com>
 <1233313517-24208-4-git-send-email-gitster@pobox.com>
 <1233313517-24208-5-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 12:07:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSrDY-0005ur-PL
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 12:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbZA3LFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 06:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752497AbZA3LFl
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 06:05:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41630 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbZA3LFj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 06:05:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 80BBB2A11B
	for <git@vger.kernel.org>; Fri, 30 Jan 2009 06:05:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CB88F2A111 for
 <git@vger.kernel.org>; Fri, 30 Jan 2009 06:05:37 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.312.g5be3c
In-Reply-To: <1233313517-24208-5-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: ED1AA206-EEBD-11DD-B05E-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107794>

(This commit log message is designed to replace the previous one when
patch text is squashed into the previous one).

Traditionally, "git fsck" only checked loose objects and "git fsck --full"
checked both loose and packed objects fully.

This introduces a new medium level of validation that checks loose objects
and runs the quicker packfile validation introduced earlier (in other
words, the individual objects in packfiles are not validated, but we still
make sure that the packfiles themselves are sound and individual objects
pass their own CRC checks when the pack has version 2 idx file).

I hoped that the new "medium" level to give a cursory look at the pack
data would be acceptable as the default, but given the benchmark data,
I think it is a bit too slow to be the default.  So you pass --medium
to trigger this new mode, instead of --full.

In my private git project repository (almost fully packed but with may
dangling objects) on my AMD 64X2:

    $ /usr/bin/time ./git-fsck
    0.18user 0.02system 0:00.20elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+3205minor)pagefaults 0swaps

    $ /usr/bin/time ./git-fsck --medium
    68.61user 0.43system 1:09.06elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+116707minor)pagefaults 0swaps

    $ /usr/bin/time ./git-fsck --full
    90.36user 0.61system 1:31.00elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+169641minor)pagefaults 0swaps

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-fsck.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 72bf33b..83faa98 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -20,7 +20,7 @@ static int show_tags;
 static int show_unreachable;
 static int include_reflogs = 1;
 static int check_full;
-static int check_quick;
+static int check_medium;
 static int check_strict;
 static int keep_cache_objects;
 static unsigned char head_sha1[20];
@@ -578,7 +578,7 @@ static struct option fsck_opts[] = {
 	OPT_BOOLEAN(0, "cache", &keep_cache_objects, "make index objects head nodes"),
 	OPT_BOOLEAN(0, "reflogs", &include_reflogs, "make reflogs head nodes (default)"),
 	OPT_BOOLEAN(0, "full", &check_full, "fully check packs"),
-	OPT_BOOLEAN(0, "quick", &check_quick, "only check loose objects"),
+	OPT_BOOLEAN(0, "medium", &check_medium, "also check packs"),
 	OPT_BOOLEAN(0, "strict", &check_strict, "enable more strict checking"),
 	OPT_BOOLEAN(0, "lost-found", &write_lost_and_found,
 				"write dangling objects in .git/lost-found"),
@@ -594,8 +594,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	errors_found = 0;
 
 	argc = parse_options(argc, argv, fsck_opts, fsck_usage, 0);
-	if (check_full && check_quick)
-		die("--full and --quick?  which one do you want?");
+	if (check_full && check_medium)
+		die("--full and --medium?  which one do you want?");
 
 	if (write_lost_and_found) {
 		check_full = 1;
@@ -614,7 +614,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		fsck_object_dir(namebuf);
 	}
 
-	if (!check_quick) {
+	if (check_full || check_medium) {
 		struct packed_git *p;
 
 		verify_pack_flag = check_full ? 0 : VERIFY_PACK_QUICK;
-- 
1.6.1.2.312.g5be3c
