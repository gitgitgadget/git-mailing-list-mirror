From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 1/9] ref-filter: add %(refname:lalignX) option
Date: Thu, 25 Jun 2015 17:13:08 +0530
Message-ID: <1435232596-27466-1-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZSsVqFy4OrSt295qAZdjKTC7z44EVsx3cPEd2jb8Y-sHw@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 13:43:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z85Z9-000670-0b
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 13:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbbFYLna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 07:43:30 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36583 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbbFYLn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 07:43:29 -0400
Received: by paceq1 with SMTP id eq1so48451040pac.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 04:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=foWy6q+hxFRd7PooqMtQLWUsO03b2opmSyg0MDRjVSc=;
        b=WNkJjbBpG3f2oKm8fqVNOunpOwwRH/6SwY99t5mw5m9TxUUt8qS/8K7bCvkwwbYqLP
         B9/C82KoB5zrEt4T1nvlXhWpFUGAPhGGL+IbWbBbS6vJwEMu7gu+gOB9LFtbR/PacVzu
         Tlj7UZ5bScE5G2p626eUysaS/ogE7Gt+m8A7vUSVJqcTPj5xf/q3jR0DtMvbussi9y8T
         jeIJvrSRJY0U12W5jmZqx29wTgjEa5fOJQYY8HBLkVVDQXh2fTgdpFYhKtUmQIPPgZBV
         Qb27qpI43RMuJkBaR1jk93htpo3mwV0mPBbrpMZbt5sq034fkrY1uidsmXm9L0XivITY
         etAQ==
X-Received: by 10.70.5.101 with SMTP id r5mr90222069pdr.139.1435232608976;
        Thu, 25 Jun 2015 04:43:28 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id xn2sm11575446pbc.44.2015.06.25.04.43.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 04:43:28 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <CAOLa=ZSsVqFy4OrSt295qAZdjKTC7z44EVsx3cPEd2jb8Y-sHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272659>

Add support for %(refname:lalignX) where X is a number.
This will print a shortened refname aligned to the left
followed by spaces for a total length of X characters.
If X is less than the shortened refname size, the entire
shortened refname is printed.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 00d06bf..299b048 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -695,7 +695,22 @@ static void populate_value(struct ref_array_item *ref)
 			int num_ours, num_theirs;
 
 			formatp++;
-			if (!strcmp(formatp, "short"))
+			if (starts_with(formatp, "lalign")) {
+				const char *valp;
+				int val;
+
+				skip_prefix(formatp, "lalign", &valp);
+				val = atoi(valp);
+				refname = shorten_unambiguous_ref(refname,
+								  warn_ambiguous_refs);
+				if (val > strlen(refname)) {
+					struct strbuf buf = STRBUF_INIT;
+					strbuf_addstr(&buf, refname);
+					strbuf_addchars(&buf, ' ', val - strlen(refname));
+					free((char *)refname);
+					refname = strbuf_detach(&buf, NULL);
+				}
+			} else if (!strcmp(formatp, "short"))
 				refname = shorten_unambiguous_ref(refname,
 						      warn_ambiguous_refs);
 			else if (!strcmp(formatp, "track") &&
-- 
2.4.4
