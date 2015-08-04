From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 24/45] builtin-am: implement -u/--utf8
Date: Tue,  4 Aug 2015 21:51:45 +0800
Message-ID: <1438696326-19590-25-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:54:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcfg-0002iy-Lv
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbbHDNyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:54:06 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36149 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964912AbbHDNyD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:54:03 -0400
Received: by pdco4 with SMTP id o4so4781059pdc.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0htzsXMFqEJO68E812lJYObFVvzj4MrMogjXlBDxCwg=;
        b=HAjzKRRMSfzH4kpjY9GqKGEhqRO6zjCCO1AEforw2zfwQL1n+Cqi1HOUG/MMe76Bz1
         dbShtg+/xLBnuH9jn0pl80ZfanwYVWW1DAxbOgY5fcQIzOSsSQ9u3iQkyJzsneDSjG3Z
         SdIfQMq14543MWNp4a+E/+gZEG1w1K6ZgwIXXxP1dOa8/alCrUouLHkp1dh+kdPCl17P
         xl3zZMW7Q2ZALfGSjtNgJhXFHxCBvdsYqiT4OQgB4HfOmTzbGy3B9FFM5T0+HBj79ZUA
         wH3XTlEAXQCCaLXwivsa2v8YpChbClh7HQj/ToIxmxqG5HAd4jFAxmJzrklOGTLR5ht4
         HNTg==
X-Received: by 10.70.41.78 with SMTP id d14mr8180427pdl.35.1438696441947;
        Tue, 04 Aug 2015 06:54:01 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.53.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:54:01 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275297>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sh supported the -u,--utf8 option. If set, the -u option will be
passed to git-mailinfo to re-code the commit log message and authorship
in the charset specified by i18n.commitencoding. If unset, the -n option
will be passed to git-mailinfo, which disables the re-encoding.

Since d84029b (--utf8 is now default for 'git-am', 2007-01-08), --utf8
is specified by default in git-am.sh.

Re-implement the above in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 47dd4c7..528b2c9 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -90,6 +90,7 @@ struct am_state {
 	int threeway;
 	int quiet;
 	int signoff;
+	int utf8;
 	const char *resolvemsg;
 	int rebasing;
 };
@@ -106,6 +107,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 	state->dir = xstrdup(dir);
 
 	state->prec = 4;
+
+	state->utf8 = 1;
 }
 
 /**
@@ -367,6 +370,9 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, state, "sign", 1);
 	state->signoff = !strcmp(sb.buf, "t");
 
+	read_state_file(&sb, state, "utf8", 1);
+	state->utf8 = !strcmp(sb.buf, "t");
+
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
 	strbuf_release(&sb);
@@ -556,6 +562,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "sign"), 1, state->signoff ? "t" : "f");
 
+	write_file(am_path(state, "utf8"), 1, state->utf8 ? "t" : "f");
+
 	if (state->rebasing)
 		write_file(am_path(state, "rebasing"), 1, "%s", "");
 	else
@@ -722,6 +730,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	cp.out = xopen(am_path(state, "info"), O_WRONLY | O_CREAT, 0777);
 
 	argv_array_push(&cp.args, "mailinfo");
+	argv_array_push(&cp.args, state->utf8 ? "-u" : "-n");
 	argv_array_push(&cp.args, am_path(state, "msg"));
 	argv_array_push(&cp.args, am_path(state, "patch"));
 
@@ -1460,6 +1469,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&state.quiet, N_("be quiet")),
 		OPT_BOOL('s', "signoff", &state.signoff,
 			N_("add a Signed-off-by line to the commit message")),
+		OPT_BOOL('u', "utf8", &state.utf8,
+			N_("recode into utf8 (default)")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.280.gd88bd6e
