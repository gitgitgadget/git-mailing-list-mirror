From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 22/45] cherry-pick: remember rerere-autoupdate
Date: Sun,  9 Jun 2013 11:40:34 -0500
Message-ID: <1370796057-25312-23-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:44:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uliin-0006ud-Kl
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058Ab3FIQnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:43:55 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:39880 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab3FIQnx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:43:53 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so8851661obc.27
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Cpz8l5FqBLeF6ifsjoy4QxMlAyjSZj9h8U+9oKBGCKU=;
        b=vFfKWepfLvuq9/t4hf/h7REGj7uJ/Q9cpQWQBRevrd/17z7Id6V27/9L0QvbeKlZN5
         M/VOvcD9i1JIm7b9j3ah4iSLFoWy9at18EYalnapJ4xdNW+avml5XfZe9B+4hr4AvHoU
         tSw4piiccXUAoDI5Iag00hWCAc/fclV+BkjnqbirxQBAcoSFh6bYZzZNVPL2NOG54h/9
         dT6UC9YEG1sVh/lJvHB63kCY+Zops6dV42aQiiGwD0hB14/yEMKKUYKCCoq9cqsmMUYb
         rV1SF1BRN1oAJytNDi9NH2If81HwrhzUyY3WO3nLsAF5SiKkZR171/2u2n8JXK7i31ej
         rA2Q==
X-Received: by 10.60.97.232 with SMTP id ed8mr5290759oeb.96.1370796233394;
        Sun, 09 Jun 2013 09:43:53 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wv8sm14956740obb.2.2013.06.09.09.43.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:43:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226991>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/sequencer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/sequencer.c b/builtin/sequencer.c
index a419387..ddd369f 100644
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
