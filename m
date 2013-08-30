From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 12/28] cherry-pick: remember rerere-autoupdate
Date: Fri, 30 Aug 2013 00:56:06 -0500
Message-ID: <1377842182-18724-13-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:01:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHmH-0007TR-HR
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701Ab3H3GBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:33 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:33362 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636Ab3H3GBb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:31 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so1767021oag.7
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oFor4wod1NJWvfNgj7eGVrFI7M2Opj9bPnlTn6jVQdc=;
        b=wema8VnpWvJ3z7HbYKKYzhloSmz6irvgnMb/od3A1vbcI2SlI9+oSTIc29t8fPc6wB
         4nLcG8GOUJN9Y+cou6sdNOixzpQlYhGym7eLVufznw2qEruWxXkbCkpv9tfcjNWbhKXD
         dzo/70NCDWTRdpYN0X9wtFnM0zCmNDO7wYbWtN3ZyL6Qvh/GkFUUHtv9tK5iR3hBLFHl
         XXNbOsDzdmAl/nIwQdmv4XNjANxlena3OHOPRlMUtdzkG6d0pHRRG+S56FBqrv1NOceO
         7ypP0IEN2d+LcjdE/7CuY7/Xh4zvhHYd0FFRfiqk0Li/Dhm3P1rNaoLfs7agbyxdgunX
         +x7g==
X-Received: by 10.182.204.4 with SMTP id ku4mr5632284obc.21.1377842490841;
        Thu, 29 Aug 2013 23:01:30 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm32421277obu.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233406>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 076bb9d..453e4a4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -847,6 +847,8 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 		opts->xopts[opts->xopts_nr++] = xstrdup(value);
 	} else if (!strcmp(key, "options.action-name"))
 		git_config_string(&opts->action_name, key, value);
+	else if (!strcmp(key, "options.allow-rerere-auto"))
+		opts->allow_rerere_auto = git_config_int(key, value);
 	else
 		return error(_("Invalid key: %s"), key);
 
@@ -1026,6 +1028,12 @@ static void save_opts(struct replay_opts *opts)
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
1.8.4-fc
