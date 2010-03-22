From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] imap-send: Remove limitation on message body
Date: Mon, 22 Mar 2010 23:37:52 +0530
Message-ID: <f3271551003221107w7a554c69scf43f2c99242808f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 19:08:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntm35-00050z-Ji
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 19:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540Ab0CVSIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 14:08:14 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47452 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754962Ab0CVSIN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 14:08:13 -0400
Received: by gyg8 with SMTP id 8so2789469gyg.19
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 11:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type;
        bh=41AmUuXCvIyW9zTrBRL7t9UysD+fI2Tbpl1flaEriL4=;
        b=KtAi5VU37al44lliM5p7pdv79Y9sXpIdzqv9EhyNWlyrLjdZAiTfz81pHyJo1OkUZa
         MGAieYlDTnK9Tw4XrZVdaUaLeas9BGeuqMoAz0rmTmBlGNo10pbFupbyZCmnL1BdPEit
         eTqhKPJToS+1Gee+HQpkgNsQhmmaCQozFVbYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=euv1nmcWUq2REyaUkN8fnJoijZ3HK0Y61lKYecQ3agxLCxZLTwkOk3/SyDPk0TN3nI
         bvWnfNrhgh53idzmptR3zFK7lzgsjBliCDz8ESK3M1QWX6Y+RKg/YnN5dViIgv/1M6zC
         KuxnRITnoNkIxooVjzT3ZkPYURxTBqglTgVRI=
Received: by 10.91.15.10 with SMTP id s10mr4641602agi.61.1269281292498; Mon, 
	22 Mar 2010 11:08:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142954>

There is a documented limitation on the body of any email not being
able to contain lines starting with "From ". This patch removes that
limitation by improving the parser to search for "From", "Date", and
"Subject" fields in the email before considering it to be an email.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
    v1 was git-imap-send bugfix: Allow lines starting with "From " in body
    v2 adds documentation about the email containing mandatory fields

 Documentation/git-imap-send.txt |   10 +++-------
 imap-send.c                     |    8 +++++++-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 6cafbe2..57aba42 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -16,7 +16,9 @@ DESCRIPTION
 This command uploads a mailbox generated with 'git format-patch'
 into an IMAP drafts folder.  This allows patches to be sent as
 other email is when using mail clients that cannot read mailbox
-files directly.
+files directly. The command also works with any general mailbox
+in which emails have the fields "From", "Date", and "Subject" in
+that order.

 Typical usage is something like:

@@ -122,12 +124,6 @@ Thunderbird in particular is known to be
problematic.  Thunderbird
 users may wish to visit this web page for more information:
   http://kb.mozillazine.org/Plain_text_e-mail_-_Thunderbird#Completely_plain_email

-
-BUGS
-----
-Doesn't handle lines starting with "From " in the message body.
-
-
 Author
 ------
 Derived from isync 1.0.1 by Mike McCormack.
diff --git a/imap-send.c b/imap-send.c
index aeb2985..2623862 100644
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
+			p += 10;
 			count++;
-			p += 5;
 		}
 		p = strstr(p+5, "\nFrom ");
 		if (!p)
-- 
1.7.0.2
