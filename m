From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 23/44] builtin-am: implement -u/--utf8
Date: Tue,  7 Jul 2015 22:20:41 +0800
Message-ID: <1436278862-2638-24-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:23:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTlv-0004qP-AN
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757728AbbGGOWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:22:43 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33638 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757688AbbGGOWW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:22:22 -0400
Received: by pacws9 with SMTP id ws9so115530461pac.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S43sDpKFCdyzdtgAK0/moi/Fh90OMdjpvlG8C6dZcoY=;
        b=UKzxhcsQkbidemIqxdS1OeK+0UXN6iMmo/s2OaMqKJ/98RywtxswZxDIBUhwP2xzli
         ql+0jWXuRgWFUP7/hsS5K4KkUFs0at8yapDDqjtRPJr7Ke/u78+mc5IHvhOPS4SiCGI7
         ukEdGVZU5C0NjlJJTvSayVPtix2QdpS8pJbANcjlVA5/YS3wcVozrz2O6PbKvREOmQk8
         22p42QLRtgqAYuyPQGoWRvi7KCm0YSV30b1pHHqJx4gUcdQGp5mxtv+20zBw19s5oWZ5
         +M2GKqx9G4EpAS+FHSXbLWIquj53DFCZuPwyf9Zua+IQliLHuESdPUCrrXtK18qE5gOx
         UBgQ==
X-Received: by 10.68.136.3 with SMTP id pw3mr9575122pbb.10.1436278941575;
        Tue, 07 Jul 2015 07:22:21 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.22.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:22:20 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273538>

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
 builtin/am.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index c92bff4..0b441fb 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -92,6 +92,8 @@ struct am_state {
 
 	int append_signoff;
 
+	int utf8;
+
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
 
@@ -112,6 +114,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 	state->prec = 4;
 
 	git_config_get_bool("am.threeway", &state->threeway);
+
+	state->utf8 = 1;
 }
 
 /**
@@ -390,6 +394,9 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, state, "sign", 1);
 	state->append_signoff = !strcmp(sb.buf, "t");
 
+	read_state_file(&sb, state, "utf8", 1);
+	state->utf8 = !strcmp(sb.buf, "t");
+
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
 	strbuf_release(&sb);
@@ -579,6 +586,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "sign"), 1, state->append_signoff ? "t" : "f");
 
+	write_file(am_path(state, "utf8"), 1, state->utf8 ? "t" : "f");
+
 	if (state->rebasing)
 		write_file(am_path(state, "rebasing"), 1, "%s", "");
 	else
@@ -750,6 +759,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	cp.out = xopen(am_path(state, "info"), O_WRONLY | O_CREAT, 0777);
 
 	argv_array_push(&cp.args, "mailinfo");
+	argv_array_push(&cp.args, state->utf8 ? "-u" : "-n");
 	argv_array_push(&cp.args, am_path(state, "msg"));
 	argv_array_push(&cp.args, am_path(state, "patch"));
 
@@ -1464,6 +1474,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&state.quiet, N_("be quiet")),
 		OPT_BOOL('s', "signoff", &state.append_signoff,
 			N_("add a Signed-off-by line to the commit message")),
+		OPT_BOOL('u', "utf8", &state.utf8,
+			N_("recode into utf8 (default)")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.rc1.76.gf60a929
