From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 05/12] ref-filter: introduce parsing functions for each valid atom
Date: Wed, 17 Feb 2016 00:30:08 +0530
Message-ID: <1455649215-23260-6-git-send-email-Karthik.188@gmail.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 19:59:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVkqr-00088h-0r
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 19:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933199AbcBPS7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 13:59:54 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34368 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933189AbcBPS7x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 13:59:53 -0500
Received: by mail-pa0-f41.google.com with SMTP id fy10so68373799pac.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 10:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bfEK5daNp612iWNcMVnJ9y693A6wn3bHleKUeO4hdcA=;
        b=Eos4Pt3Hqdkzaw6DpDgY8CPDZ4QfeirwjINILhGIQ2FtHFyZKLZOmQs2JtPMd7eYYc
         wlQyKzvVaWhDHm11S9fQAuWA3J+zr7wCf9KNSDSweN6j+f7/2AHwuRGMvgbQKrvl7rHP
         z0VZcNdbL2YAVG98inxlNeK9+F1Sbq4t0JE984pCr2FO+hDzGIXTm6WjSwaYWBsdaWa8
         U+Y0h8LRuvSPR1vGV4IMmG2m9xvkkmcCrOPkbtVt8AqaIHGOBMKCDz/b+DAVdgLqhJv9
         xngCxkvpkMJXYkywXimVkoUWNonPM5Wqs/zmJQOMvSp5QzapdPZzZUbt5C1f3wy6luvJ
         51cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bfEK5daNp612iWNcMVnJ9y693A6wn3bHleKUeO4hdcA=;
        b=li0BDm4eSbExBnTGy6DDV0Fs4OprE+cI+PpkbxnXtiI0dnZgWwyB94fwUtN5ebU/m+
         iTDzhhnCTeYHjM1CT/6jgyn3mcgzM7ZDpIqJb0x8tmzsp9XlStC4qh1++JeB22LMQKbQ
         UWFJt6kEp6N97ypmwO0Vq1GSYXi+M/C6nP1wGCiZdb9zxJreTWGL/Q6lD6zd7FZwllDQ
         jM7m9hKxxVcExuHrLClKFY/jSnQABmCqQFo2/BrzwMKoQkWUcB0+zXC6FaO+octT29fj
         OPKOQH3x83nX3a4Yyj6sJnyXPOnQEwyF4DM+8gSX6kmxeq8WMxw1P5BtyUdKX/U/lvHl
         N/7g==
X-Gm-Message-State: AG10YOS7Q6UsrnA7C57VozFSKA4MnBRoC2OQz8dd+GHlk3HXMKRQKOR2mQbkrtrW1QR6Xw==
X-Received: by 10.66.62.162 with SMTP id z2mr32881147par.39.1455649193389;
        Tue, 16 Feb 2016 10:59:53 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id 27sm47469677pfh.48.2016.02.16.10.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Feb 2016 10:59:52 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286413>

Parsing atoms is done in populate_value(), this is repetitive and
hence expensive. Introduce a parsing function which would let us parse
atoms beforehand and store the required details into the 'used_atom'
structure for further usage.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3736dc3..974c412 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -36,6 +36,7 @@ static int need_color_reset_at_eol;
 static struct {
 	const char *name;
 	cmp_type cmp_type;
+	void (*parser)(struct used_atom *atom, const char *arg);
 } valid_atom[] = {
 	{ "refname" },
 	{ "objecttype" },
@@ -114,6 +115,7 @@ struct atom_value {
 int parse_ref_filter_atom(const char *atom, const char *ep)
 {
 	const char *sp;
+	const char *arg;
 	int i, at;
 
 	sp = atom;
@@ -132,16 +134,16 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	/* Is the atom a valid one? */
 	for (i = 0; i < ARRAY_SIZE(valid_atom); i++) {
 		int len = strlen(valid_atom[i].name);
+
 		/*
 		 * If the atom name has a colon, strip it and everything after
 		 * it off - it specifies the format for this entry, and
 		 * shouldn't be used for checking against the valid_atom
 		 * table.
 		 */
-		const char *formatp = strchr(sp, ':');
-		if (!formatp || ep < formatp)
-			formatp = ep;
-		if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
+		arg = memchr(sp, ':', ep - sp);
+		if (len == (arg ? arg : ep) - sp &&
+		    !memcmp(valid_atom[i].name, sp, len))
 			break;
 	}
 
@@ -154,6 +156,10 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	REALLOC_ARRAY(used_atom, used_atom_cnt);
 	used_atom[at].name = xmemdupz(atom, ep - atom);
 	used_atom[at].type = valid_atom[i].cmp_type;
+	if (arg)
+		arg = used_atom[at].name + (arg - atom) + 1;
+	if (valid_atom[i].parser)
+		valid_atom[i].parser(&used_atom[at], arg);
 	if (*atom == '*')
 		need_tagged = 1;
 	if (!strcmp(used_atom[at].name, "symref"))
-- 
2.7.1
