From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5b 10/17] ref-filter: introduce refname_atom_parser_internal()
Date: Mon, 25 Apr 2016 20:47:51 +0530
Message-ID: <1461597478-31855-10-git-send-email-Karthik.188@gmail.com>
References: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 17:19:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auiHx-00065I-C4
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 17:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbcDYPSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 11:18:39 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34525 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932588AbcDYPSh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 11:18:37 -0400
Received: by mail-pf0-f173.google.com with SMTP id y69so47999946pfb.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 08:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ypljdsYDkk0IC+e97puy+RCUegj1vbw40Ni031pFDIc=;
        b=MA8KdhJ3a62y/h9wBJZ7t9TaLIbI3i5UXHFDH70gbL7JbxH1jH49Wbi9MYx4aWCBNA
         AUtMnSKzzZAlUxKzU8WQp1iUlu7huMwf/V8NhPfVK+1RxaxizAZ6wkOjhxxVVD90DojH
         yCGSYuMAB/uNONdmfYXzXqkPotPfIBRBOX+oExkr1tn0l0ywxMLTxuT71yRmYg6vN3Vw
         tNR66iC5ANoz6rEld6jH+dCp23c70F7AAAy30dyMlcPvrzoQR0G8yBqw8ttn6bIA7gQg
         h3y0YiFxfg6jtSPNkQAHA2RrRU4272i31pS0Av0zYXiDHwRjWhDfxIuVsA9U1spIz8+p
         iVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ypljdsYDkk0IC+e97puy+RCUegj1vbw40Ni031pFDIc=;
        b=JtPt5836zv6Oha0WjGQb/0xMAsZUqyCp6nJBhW7ntl2thua1RbYiTpBQmLhCFKvey7
         S4tZMb8i0evvUtwZy0OwG2Hzowsn+6QPpC/s2vP1sU/FTui1m6Mc4Hl/SNF5FW/AuE25
         rKMghzqRF7Ubn/t3OX52TPDosQ00s/QkFiWU/v0m/F2GYm/mkRnUXkBxdPgEC+MIAgbw
         Hstl1An/nOnvUFiq5WEirnNP4u/2lUZRe3HEhs5Huzl7pf8aYHV6JkIqtKYpXTtxBY6D
         zJQQJbkzYAA5+IdeFb3YHcRomRlBWVIoX60/CIDz8wROMBZ2joAudTkFYWQIU58q1Pmo
         h6TA==
X-Gm-Message-State: AOPr4FV5Hfn6IWP+0RL2KzinmJyrqi8G+jaaARE4w22QwbDQzCVp63rY1JDVbATHHFJPFg==
X-Received: by 10.98.11.205 with SMTP id 74mr49427426pfl.98.1461597511467;
        Mon, 25 Apr 2016 08:18:31 -0700 (PDT)
Received: from ashley.localdomain ([106.51.234.108])
        by smtp.gmail.com with ESMTPSA id ut1sm30812527pac.46.2016.04.25.08.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 08:18:30 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292504>

Since there are multiple atoms which print refs ('%(refname)',
'%(symref)', '%(push)', '%upstream'), it makes sense to have a common
ground for parsing them. This would allow us to share implementations of
the atom modifiers between these atoms.

Introduce refname_atom_parser_internal() to act as a common parsing
function for ref printing atoms. This would eventually be used to
introduce refname_atom_parser() and symref_atom_parser() and also be
internally used in remote_ref_atom_parser().

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 083cc27..778fe02 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -30,6 +30,11 @@ struct if_then_else {
 		condition_satisfied : 1;
 };
 
+struct refname_atom {
+	enum { R_NORMAL, R_SHORT, R_STRIP } option;
+	unsigned int strip;
+};
+
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
  * a "*" to denote deref_tag().
@@ -62,6 +67,7 @@ static struct used_atom {
 			enum { O_FULL, O_LENGTH, O_SHORT } option;
 			unsigned int length;
 		} objectname;
+		struct refname_atom refname;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -75,6 +81,21 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
 		die(_("unrecognized color: %%(color:%s)"), color_value);
 }
 
+static void refname_atom_parser_internal(struct refname_atom *atom,
+					 const char *arg, const char *name)
+{
+	if (!arg)
+		atom->option = R_NORMAL;
+	else if (!strcmp(arg, "short"))
+		atom->option = R_SHORT;
+	else if (skip_prefix(arg, "strip=", &arg)) {
+		atom->option = R_STRIP;
+		if (strtoul_ui(arg, 10, &atom->strip) || atom->strip <= 0)
+			die(_("positive value expected refname:strip=%s"), arg);
+	} 	else
+		die(_("unrecognized %%(%s) argument: %s"), name, arg);
+}
+
 static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 {
 	struct string_list params = STRING_LIST_INIT_DUP;
-- 
2.8.0
