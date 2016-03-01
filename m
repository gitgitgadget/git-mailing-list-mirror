From: "Sidhant Sharma [:tk]" <tigerkid001@gmail.com>
Subject: [PATCH] builtin/receive-pack.c: use parse_options API
Date: Tue,  1 Mar 2016 21:06:00 +0530
Message-ID: <1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
Cc: matthieu.moy@grenoble-inp.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 16:36:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aamLZ-0007sB-Mx
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 16:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbcCAPgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 10:36:22 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35020 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358AbcCAPgV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 10:36:21 -0500
Received: by mail-pf0-f171.google.com with SMTP id w128so69965620pfb.2
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 07:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Ft1IkePr7PXOz4r+g2e092IZ3m/n1hBjwc2oqteoBKM=;
        b=uD16/DDYFGvwQOFJAQ04n02q85gcov0APF/r9peEgLv4LWvSazTFDNz3F/OhPNP8La
         qJP6MeHlStiLRp8+P2jm0/0T5w1GmzUnUDSmeuJBXh9iK7UtKybgl8oDOUaVnpR9WE5R
         Dc2HFOQbOinnpb05Kb/C2RphNnVwZ224FhLERThMcUu4mdOJJX6Tk1LfZxttE4fR3Qxk
         35HxOYDZvvadVtUTUVC9ECC1TlcEFlUTWFywJVBHCs3UOHmKsnnG4V/FEBlBQR8wWCBC
         T5fDrmmG0aBI89ys+Y6wybt2UZGwIyzn5khopFj2Jcd66K0p8NbXUV8tpNhFSyNWeh3U
         wL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ft1IkePr7PXOz4r+g2e092IZ3m/n1hBjwc2oqteoBKM=;
        b=Rj5OSVaEp9SozK8VWI6Wk6nyQxrsQIdu25I4nUK8yWm6Fxy/aYC1dSXxE+7wIRGa/p
         uEgdM+ieSW3nsmeza8DuGKdWm2pu28vg2JgBt68dLLkFMsQxtaArHBpj14rPdT5apu9N
         o0lxSskAMrcqVICIJFyRTLJtfORP0WWZ3y0UFVObamnRXB8yDnaAcw+K/CFewPHN3JKW
         4Ar5AefGR4vg+H5NqPTRISFqa3hCRoCMIm2dJbjh26MZcdBddmz1ki2tBdVeuUHw0kYw
         9ZMF0fyHKQh50BfY2zbFNw1uQ6I0Cf7lkF5sJ29EqHkvOVUhkEdrUVeIRqIPvjtHBOsn
         u0yA==
X-Gm-Message-State: AD7BkJLaY2l+H3GX3mMKo4CvVmdxjou7iWD00+wg/tvdWfT1Nusb+4zud2km1kGafn4kjQ==
X-Received: by 10.98.2.197 with SMTP id 188mr31061151pfc.3.1456846580405;
        Tue, 01 Mar 2016 07:36:20 -0800 (PST)
Received: from localhost.localdomain ([182.68.185.50])
        by smtp.gmail.com with ESMTPSA id sj4sm7685235pab.43.2016.03.01.07.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Mar 2016 07:36:19 -0800 (PST)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288035>

This patch makes receive-pack use the parse_options API,
bringing it more in line with send-pack and push.

Helped-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Sidhant Sharma [:tk] <tigerkid001@gmail.com>
---
 builtin/receive-pack.c | 55 ++++++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c8e32b2..fe9a594 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -21,7 +21,10 @@
 #include "sigchain.h"
 #include "fsck.h"

-static const char receive_pack_usage[] = "git receive-pack <git-dir>";
+static const char * const receive_pack_usage[] = {
+	N_("git receive-pack <git-dir>"),
+	NULL
+};

 enum deny_action {
 	DENY_UNCONFIGURED,
@@ -45,12 +48,12 @@ static int unpack_limit = 100;
 static int report_status;
 static int use_sideband;
 static int use_atomic;
-static int quiet;
+static int quiet = 0;
 static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
 static int auto_gc = 1;
 static int fix_thin = 1;
-static int stateless_rpc;
+static int stateless_rpc = 0;
 static const char *service_dir;
 static const char *head_name;
 static void *head_name_to_free;
@@ -1707,45 +1710,35 @@ static int delete_only(struct command *commands)
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
 	int advertise_refs = 0;
-	int i;
 	struct command *commands;
 	struct sha1_array shallow = SHA1_ARRAY_INIT;
 	struct sha1_array ref = SHA1_ARRAY_INIT;
 	struct shallow_info si;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("quiet")),
+		OPT_HIDDEN_BOOL(0, "stateless-rpc", &stateless_rpc, NULL),
+		OPT_HIDDEN_BOOL(0, "advertise-refs", &advertise_refs, NULL),
+		/* Hidden OPT_BOOL option */
+		{
+			OPTION_SET_INT, 0, "reject-thin-pack-for-testing", &fix_thin, NULL,
+			NULL, PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 0,
+		},
+		OPT_END()
+	};

 	packet_trace_identity("receive-pack");

-	argv++;
-	for (i = 1; i < argc; i++) {
-		const char *arg = *argv++;
+	argc = parse_options(argc, argv, prefix, options, receive_pack_usage, 0);

-		if (*arg == '-') {
-			if (!strcmp(arg, "--quiet")) {
-				quiet = 1;
-				continue;
-			}
+	if (argc > 1)
+		usage_msg_opt(_("Too many arguments."), receive_pack_usage, options);
+	if (argc == 0)
+		usage_msg_opt(_("You must specify a directory."), receive_pack_usage, options);

-			if (!strcmp(arg, "--advertise-refs")) {
-				advertise_refs = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--stateless-rpc")) {
-				stateless_rpc = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--reject-thin-pack-for-testing")) {
-				fix_thin = 0;
-				continue;
-			}
+	service_dir = argv[0];

-			usage(receive_pack_usage);
-		}
-		if (service_dir)
-			usage(receive_pack_usage);
-		service_dir = arg;
-	}
 	if (!service_dir)
-		usage(receive_pack_usage);
+		usage_with_options(receive_pack_usage, options);

 	setup_path();

--
2.6.2
