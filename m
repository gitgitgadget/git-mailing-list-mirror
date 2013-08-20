From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] mailmap: fix check for freeing memory
Date: Tue, 20 Aug 2013 15:22:38 +0200
Message-ID: <1377004958-14489-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, peff@peff.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 20 15:22:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBltV-0000CI-0g
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 15:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335Ab3HTNWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 09:22:42 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:44943 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab3HTNWm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 09:22:42 -0400
Received: by mail-ee0-f54.google.com with SMTP id e53so202755eek.41
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 06:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=av2vtRwagcaA/tGWcKoPqindHw2Lh1k7iAFDu9ixZko=;
        b=e0i4KC3YkMGDkDVGBIvqU1AgcVZfKGjXD6SuaR54lCfpE5i1/aj09tGuOsPxhRH6tE
         lJaNoVC38hduYu3U0L2yprgx5Wo7DtMaoweXa5LsIDAPl+eTqcVntE6No14tJzt8CQ69
         MAV/Nyuad4ZrtKlJderUk+aRWhY/y5ZRpxv1kzCCPm++WLPdtHjzNgl1yZ/5E9NtQ89i
         iSHzZgo78bhW50E3dlqdWkVDKFFzM1PnOtmZdq8F1/eglh2DZ3bwmUkDcAiE1IBN4NTw
         f25V6BNzgQ4tSdALc5sn3CndTDBzI4gwhiIn9QzRe480u1mpQa6Vmb5yiiikpoMyj7w+
         tSRA==
X-Received: by 10.15.27.133 with SMTP id p5mr2284015eeu.65.1377004960654;
        Tue, 20 Aug 2013 06:22:40 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id f49sm2408494eec.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 06:22:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.1.gc1ebd90
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232593>

The condition as it is written in that line was most likely intended to
check for the pointer passed to free(), rather than checking for the
'repo_abbrev', which is already checked against being non null at the
beginning of the function.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 mailmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mailmap.c b/mailmap.c
index 44614fc..36d2a7a 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -139,35 +139,35 @@ static char *parse_name_and_email(char *buffer, char **name,
 static void read_mailmap_line(struct string_list *map, char *buffer,
 			      char **repo_abbrev)
 {
 	char *name1 = NULL, *email1 = NULL, *name2 = NULL, *email2 = NULL;
 	if (buffer[0] == '#') {
 		static const char abbrev[] = "# repo-abbrev:";
 		int abblen = sizeof(abbrev) - 1;
 		int len = strlen(buffer);
 
 		if (!repo_abbrev)
 			return;
 
 		if (len && buffer[len - 1] == '\n')
 			buffer[--len] = 0;
 		if (!strncmp(buffer, abbrev, abblen)) {
 			char *cp;
 
-			if (repo_abbrev)
+			if (*repo_abbrev)
 				free(*repo_abbrev);
 			*repo_abbrev = xmalloc(len);
 
 			for (cp = buffer + abblen; isspace(*cp); cp++)
 				; /* nothing */
 			strcpy(*repo_abbrev, cp);
 		}
 		return;
 	}
 	if ((name2 = parse_name_and_email(buffer, &name1, &email1, 0)) != NULL)
 		parse_name_and_email(name2, &name2, &email2, 1);
 
 	if (email1)
 		add_mapping(map, name1, email1, name2, email2);
 }
 
 static int read_mailmap_file(struct string_list *map, const char *filename,
-- 
1.8.4.rc3.1.gc1ebd90
