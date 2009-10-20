From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH] blame: make sure that the last line ends in an LF
Date: Mon, 19 Oct 2009 22:06:28 -0500
Message-ID: <1256007988-13321-1-git-send-email-srabbelier@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 05:07:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N054c-0006e9-7f
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 05:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbZJTDH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 23:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbZJTDH0
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 23:07:26 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:49495 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932452AbZJTDHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 23:07:25 -0400
Received: by ewy3 with SMTP id 3so4347290ewy.17
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 20:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=9eK9FjdENYyhqlkS3aJwzTEuskTuyssMpOxxlH6coKg=;
        b=ASTQ2G5U1wmc8XcGRE7RHQurYRoOh23TKJmu6xsyXKCZU1gw+ThTNC5aQyzVhlm4Pv
         omqGg8VDPvnADeVBfqM4y1QRsn91cjHXg5LL6e3TDQPwZZQKdU1fCR9Z8coX0xaN3mWP
         6XZ7ZHEA3VISJFiqqKpdrchLQ4Y5U9WlffVOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=peXQ5V1LN0NHuskC2iIRQ5dggOGlmru5/FZ4dNE7YbHNyr5yuOuJtqJ0qqywbmlTEc
         r2xFVx+90jyxdshs17XTBqW96zhphiorr/ihzLL+eUesIqIHqFBcPV0JYrPQJxGSCKD1
         AXq/foWC0QLiq9wekDmbk9IeS3j4TuzSdkGso=
Received: by 10.211.155.20 with SMTP id h20mr495088ebo.44.1256008048335;
        Mon, 19 Oct 2009 20:07:28 -0700 (PDT)
Received: from localhost.localdomain (97-114-183-234.frgo.qwest.net [97.114.183.234])
        by mx.google.com with ESMTPS id 7sm3428697eyg.2.2009.10.19.20.07.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Oct 2009 20:07:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.1.123.ge01f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130756>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is convenient when parsing multiple the blame of multiple files,
for example:

    git ls-files -z --exclude-standard -- "*.[ch]" |
    xargs --null -n 1 git blame -p > output

and then analyzing the 'output' file using a seperate script.

Currently the parsing is difficult when not all files have a newline
at EOF, this patch ensures that even such files have a newline at the
end of the blame output.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
CC: Johannes Schindelin <johannes.schindelin@gmx.de>
---

    Patch by Dscho, commit message by me. Apologies to Dscho for
    taking so long to send it :).

 builtin-blame.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 7512773..dd16b22 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1604,6 +1604,9 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent)
 		} while (ch != '\n' &&
 			 cp < sb->final_buf + sb->final_buf_size);
 	}
+
+	if (sb->final_buf_size && cp[-1] != '\n')
+		putchar('\n');
 }
 
 static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
@@ -1667,6 +1670,9 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 		} while (ch != '\n' &&
 			 cp < sb->final_buf + sb->final_buf_size);
 	}
+
+	if (sb->final_buf_size && cp[-1] != '\n')
+		putchar('\n');
 }
 
 static void output(struct scoreboard *sb, int option)
-- 
1.6.5.1.123.ge01f7
