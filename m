From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] help.c: strip suffix only if the STRIP_EXTENSION defined
Date: Wed, 16 Mar 2016 20:27:29 +0600
Message-ID: <1458138449-26690-1-git-send-email-kuleshovmail@gmail.com>
Cc: Git <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 15:27:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agCQS-00076N-65
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 15:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935050AbcCPO1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 10:27:44 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33865 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934994AbcCPO1m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 10:27:42 -0400
Received: by mail-lb0-f169.google.com with SMTP id k12so49015760lbb.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 07:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1pvqWUnVhtYnZ0aTZKfXExnJRY6HPU8vS+INGuvUy+o=;
        b=0E7SGeCk94C6J4NLDvOLnLLV9DHu8fJXxxOHts07l9jsAy/Oq3p3rtyjsuTMj+0HtN
         L5ere2z8zToOTQEuIFeCX6bj7egsQ0LzxyqBsLC1ZpMAUCv4dQjXbNWvIoOFMjUO574a
         fxADAwREcFxamQOsjfPi0d1yR3Gh2dqScgQffqzJvzKv1SqUXNkXvvHA+ynF81JFaD8N
         RcSAZyUtjC0IdkMnoGXrkNvXeqV6oczDDSWjRgt+SeUhHqRM5TAV67dBFVVmNxZF2r9j
         BjbEneOZKPdixxPYuHLKWa5dmMSjXa7ywzbXBseRHekqNe+U+JRGx9IqwfbJtnIBJgJV
         4s9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1pvqWUnVhtYnZ0aTZKfXExnJRY6HPU8vS+INGuvUy+o=;
        b=YS4TL1yFJYXKTUN5q8TXHKyLdOLmUOio8O8oJxJ9cbyEV88LwSoM1wRok5kJIZP//6
         sgA696Hxv21VsJ3vo8P+7384QqqH5/xh6VgMCLtwghkjdIWdbs4rtpyWNoBzADLs7cY7
         VMy6SNuECd+Qigd5CIqMj7XEBhvvsKrRZqwfswT70eheU2EsfJPbuKlVLJN5097AVR/4
         /aiSAMkaZyLntl3CVFTWvg4fiQzmteBJKgm6LPVuMBaMPgyFOwzjOQ9fS4VM2RAKE90L
         /Igkj9kJDPkhrFvWAmnDpPVxk0CGShxkIeF69XiiV/ZUTYkCwYMFImRjzFUDPpifb9gL
         eZag==
X-Gm-Message-State: AD7BkJLUN2bNTPEojAMXDKqFtI4E517qb+qmwNJwoElyalQIu7Y6QGJEPSUOAzYU6iA4Ag==
X-Received: by 10.112.16.230 with SMTP id j6mr1541349lbd.27.1458138455695;
        Wed, 16 Mar 2016 07:27:35 -0700 (PDT)
Received: from localhost.localhost ([37.150.78.168])
        by smtp.gmail.com with ESMTPSA id h8sm581602lfg.10.2016.03.16.07.27.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Mar 2016 07:27:34 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc2.216.g1477fb2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288975>

We stripping extension in the list_commands_in_dir() to get
commands without '.exe' suffix. Let's do it only if STRIP_EXTENSION
is defined to not spend time for unnecessary strip_suffix() call in
this case.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 help.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 19328ea..c865991 100644
--- a/help.c
+++ b/help.c
@@ -153,8 +153,9 @@ static void list_commands_in_dir(struct cmdnames *cmds,
 			continue;
 
 		entlen = strlen(ent);
-		strip_suffix(ent, ".exe", &entlen);
-
+#ifdef STRIP_EXTENSION
+		strip_suffix(ent, STRIP_EXTENSION, &entlen);
+#endif
 		add_cmdname(cmds, ent, entlen);
 	}
 	closedir(dir);
-- 
2.8.0.rc2.216.g1477fb2.dirty
