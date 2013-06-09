From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 22/36] cherry-pick: remember rerere-autoupdate
Date: Sun,  9 Jun 2013 14:24:36 -0500
Message-ID: <1370805890-3453-23-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:27:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllHN-0003fR-4l
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391Ab3FIT1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:27:49 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:53705 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab3FIT1r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:27:47 -0400
Received: by mail-ob0-f180.google.com with SMTP id eh20so9179583obb.11
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vZaj8cJ7LN41N2mXtd/aaVElRH2oNpgYQDDEKi4xYH0=;
        b=H2mdyVmFp82+F/RazwyiP206bTD5i2YDCi9g/gPHnzpUxcg5JWX2kLTXNMbk1hiNzh
         vxgypoxJFH3gNC/pL9+RARxiiph9Ou9Z68asL6seL6Ct5q1mhAJTiZYS19WFMxRlo9Yr
         fU0asUD622Ye3nOFXgeNGn/gx94+JKZNtEGejuzSI00/AL6i0Fx4dpzrSL/879MWCfg5
         rwEOn1hPQB2LCBrWo3Jo4hPzaNwFpCtAMdqRoiSgyQtC9ULUZy9XwbxO4d4QYeJ+sA26
         t/cUeZtS+SWlz1Xb4gstL6zql/MdSIB2hW9uIbdeqMBmTUbkvgdteG7rIH+RdPLPHzDW
         Sz9g==
X-Received: by 10.60.68.13 with SMTP id r13mr5732531oet.71.1370806067310;
        Sun, 09 Jun 2013 12:27:47 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id rs4sm8782027obc.10.2013.06.09.12.27.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:27:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227129>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/sequencer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/sequencer.c b/builtin/sequencer.c
index 3fec505..f805883 100644
--- a/builtin/sequencer.c
+++ b/builtin/sequencer.c
@@ -753,6 +753,8 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 		opts->xopts[opts->xopts_nr++] = xstrdup(value);
 	} else if (!strcmp(key, "options.action-name"))
 		git_config_string(&opts->action_name, key, value);
+	else if (!strcmp(key, "options.allow-rerere-auto"))
+		opts->allow_rerere_auto = git_config_int(key, value);
 	else
 		return error(_("Invalid key: %s"), key);
 
@@ -932,6 +934,12 @@ static void save_opts(struct replay_opts *opts)
 	}
 	if (opts->action_name)
 		git_config_set_in_file(opts_file, "options.action-name", opts->action_name);
+	if (opts->allow_rerere_auto) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "%d", opts->allow_rerere_auto);
+		git_config_set_in_file(opts_file, "options.allow-rerere-auto", buf.buf);
+		strbuf_release(&buf);
+	}
 }
 
 static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
-- 
1.8.3.698.g079b096
