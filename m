From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] git-imap-send bugfix: Allow lines starting with "From " in 
	body
Date: Mon, 22 Mar 2010 00:17:49 +0530
Message-ID: <f3271551003211147x538d7682wc67dcc4f914ed97c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: me@mutt.org, ossi@users.sf.net, tytso@mit.edu,
	Junio C Hamano <gitster@pobox.com>, mike@codeweavers.com
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 21 19:48:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtQC9-0003EW-8G
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 19:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306Ab0CUSsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 14:48:11 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:48876 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab0CUSsK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 14:48:10 -0400
Received: by yxe12 with SMTP id 12so1434875yxe.33
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 11:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type;
        bh=Wab2xyEz0dmIlXm3tTJMdm/c7UsC50P5l4eYrDJbfzM=;
        b=gj5KPw/sHZMHSjuiSCzYAoMFNAm6eEFnL9yrGRn4zsR+SLu2HCwoANLz9FDs66NqSI
         PVo9H/zweI6TVvQcNZvnIa/yqAIU+Bi3xjutOjSe2MYKgWYuwWfpO15+/wKVePxAdgND
         9P/uRCXtB4j+EaZKndNaTIBC9OdN7M/ble9S8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=XNd2EXFzh/MI9+ogiUHtO7rqtytOFbHz/Bd6g8A+YTuardIOkexCdYkupoe8N3S32m
         BnOqjKIfqKmQM5PXRpefYuoiiKRzChZ/uyhXoIV9hP4qnH/W+9WbFnyvAPhoMbQy3T/j
         vxG/yFHIJvRozTdrf1gMlCA5lSV1munkXAnOE=
Received: by 10.90.136.2 with SMTP id j2mr3241437agd.92.1269197289153; Sun, 21 
	Mar 2010 11:48:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142849>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-imap-send.txt |    5 -----
 imap-send.c                     |    8 +++++++-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 6cafbe2..ed9d3ce 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -123,11 +123,6 @@ users may wish to visit this web page for more information:
   http://kb.mozillazine.org/Plain_text_e-mail_-_Thunderbird#Completely_plain_email


-BUGS
-----
-Doesn't handle lines starting with "From " in the message body.
-
-
 Author
 ------
 Derived from isync 1.0.1 by Mike McCormack.
diff --git a/imap-send.c b/imap-send.c
index aeb2985..3163bb9 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1431,8 +1431,14 @@ static int count_messages(struct msg_data *msg)

 	while (1) {
 		if (!prefixcmp(p, "From ")) {
+			p = strstr(p+5, "\nFrom: ");
+			if (!p) break;
+			p = strstr(p+7, "\nDate: ");
+			if (!p) break;
+			p = strstr(p+7, "\nSubject: ");
+			if (!p) break;
 			count++;
-			p += 5;
+			p += 10;
 		}
 		p = strstr(p+5, "\nFrom ");
 		if (!p)
-- 
1.7.0
