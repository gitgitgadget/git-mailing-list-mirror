From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH/RFC 4/9] add sanity length check to format_person_part
Date: Tue, 29 Mar 2011 00:17:26 +0100
Message-ID: <1301354251-23380-5-git-send-email-wmpalmer@gmail.com>
References: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Will Palmer <wmpalmer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 01:18:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Lhe-00010L-TD
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 01:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552Ab1C1XSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 19:18:07 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35885 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab1C1XR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 19:17:59 -0400
Received: by wwa36 with SMTP id 36so4410093wwa.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 16:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=HGeUfyhpOOI/MlS2xTJTA+tcrZwXD2BIM9Ao/KNhKXA=;
        b=k0MYHWHJQvLEf0pcPpI9cSluU6hRonRSzu6yy/b+FDbzWVqCQ2SzLxrR6kT7+sLAn5
         Ydt3otbwJi0RtBRaLmAD58tWFtjID4ruDN5XtYH1gYihNf3wWttFZEuZPaLuob5JdRtS
         5iD3QcRle5neaRcV8dxPHNsT6sYZTd2/I2gV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KnGRqe6kgq37/TpU2zrrH91YQ7Wab5K2AxBEyGFS1B1NYQbScebzaSVTRXdZvoMQZN
         hS1Gdngzxt+W2sf05L0jeR+fp4j3DVfZ25/N+Rg9X8ytOjXh4ZMJzA6kdhcxfEw9tAFT
         v4C9duQFyz52kYymwjX85l70oPYm8dhderqiI=
Received: by 10.216.69.131 with SMTP id n3mr4286038wed.47.1301354278042;
        Mon, 28 Mar 2011 16:17:58 -0700 (PDT)
Received: from localhost.localdomain (5acc3aad.bb.sky.com [90.204.58.173])
        by mx.google.com with ESMTPS id b54sm1678272wer.45.2011.03.28.16.17.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 16:17:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170205>

previously we were relying on the length check from ident.c, ie: relying
on having been given a good object to parse in the first place. If the
object should have triggered the "Impossibly long personal identifier"
check at commit-time, for example, it would have resulted in an overflow
here.

This is another one which, due to the input constraints, would not have
been a real-world problem for regular usage. I was able to cause an
overflow by viewing the log of a commit with an impossibly-long Author,
created via hash-object. This is admittedly a pretty far-fetched
scenario, though it could potentially be considered a security issue.

In any case, the lack of it rubbed me the wrong way when I was
refactoring this section, and it is trivial to add the sanity check.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 pretty.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/pretty.c b/pretty.c
index d5a724f..8a288f0 100644
--- a/pretty.c
+++ b/pretty.c
@@ -449,6 +449,7 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	unsigned long date = 0;
 	char *ep;
 	const char *name_start, *name_end, *mail_start, *mail_end, *msg_end = msg+len;
+	size_t name_len, mail_len;
 	char person_name[1024];
 	char person_mail[1024];
 
@@ -469,29 +470,36 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	name_end = msg+end;
 	while (name_end > name_start && isspace(*(name_end-1)))
 		name_end--;
+	name_len = name_end-name_start;
+	if (name_len >= sizeof(person_name))
+		goto skip;
 	mail_start = msg+end+1;
 	mail_end = mail_start;
 	while (mail_end < msg_end && *mail_end != '>')
 		mail_end++;
+	mail_len = mail_end-mail_start;
+	if (mail_len >= sizeof(person_mail))
+		goto skip;
 	if (mail_end == msg_end)
 		goto skip;
 	end = mail_end-msg;
 
 	if (part == 'N' || part == 'E') { /* mailmap lookup */
-		strlcpy(person_name, name_start, name_end-name_start+1);
-		strlcpy(person_mail, mail_start, mail_end-mail_start+1);
+		/* copy up to, and including, the end delimiter */
+		strlcpy(person_name, name_start, name_len+1);
+		strlcpy(person_mail, mail_start, mail_len+1);
 		mailmap_name(person_mail, sizeof(person_mail), person_name, sizeof(person_name));
 		name_start = person_name;
-		name_end = name_start + strlen(person_name);
+		name_len = strlen(person_name);
 		mail_start = person_mail;
-		mail_end = mail_start +  strlen(person_mail);
+		mail_len = strlen(person_mail);
 	}
 	if (part == 'n' || part == 'N') {	/* name */
-		strbuf_add(sb, name_start, name_end-name_start);
+		strbuf_add(sb, name_start, name_len);
 		return placeholder_len;
 	}
 	if (part == 'e' || part == 'E') {	/* email */
-		strbuf_add(sb, mail_start, mail_end-mail_start);
+		strbuf_add(sb, mail_start, mail_len);
 		return placeholder_len;
 	}
 
-- 
1.7.4.2
