From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 09/16] ref-filter: introduce refname_atom_parser_internal()
Date: Sat, 23 Apr 2016 00:34:00 +0530
Message-ID: <1461351847-22903-10-git-send-email-Karthik.188@gmail.com>
References: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 21:05:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atgO6-0008NS-Tu
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 21:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbcDVTFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 15:05:04 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34581 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbcDVTFD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 15:05:03 -0400
Received: by mail-pf0-f193.google.com with SMTP id 145so3074502pfz.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ypljdsYDkk0IC+e97puy+RCUegj1vbw40Ni031pFDIc=;
        b=s/fYQXpvrlSKX9wV57JlHurdDY6ZubFOZS+RpXQQ4VTnOyHZvOrlY2raH6FAdslEIu
         kgnVO348KVXPfO1ApDKeAL1NjLRQqjdgxEC7cJBTWAvORxCLvcfMXMrosfKiSe2zFXOv
         JApAVy+5272qu3OOSZ/vt+vK6oUDqD3Ps9cAG1KpFvLPwovdddRH2XhVG8YeGFU0qLa6
         XnUgVtB/oOSh61FF5aiwZwAynAcQ6XxbqllmL2arK7YnKJSqpH2qvrGIND5QPoH+jBR2
         c9wGE8lvSwmvKjc/2PS3FPZ0gGgPCiUTmqLZxnFhnG8e9Du+g1OHt5CodFZV92XmEr4G
         ky4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ypljdsYDkk0IC+e97puy+RCUegj1vbw40Ni031pFDIc=;
        b=ONva5maAb/OeSftT/GJEdz0GAVDpsIRHPvcbpjii/+1DKV85J2qSNYHiq4UDr89QXu
         o9dCyLdgcsseSUhoWxpwy9fP9ssX7pjpEKxH6ZQ3QYumjs3SlflKYdmIv2sOchVrLH6p
         wImmqvH+Lk/GFGKX9qnkCX6zW5q0uH1JcxxF6Q/2UB3/884ARrkA0Q+2c6dUDgESAsEP
         GxRaye/pLsT5K8ykxdeDAIn7XVkgECEfqKooPTb89/oCvbtUj7E4Oo5q9H223hvByDjB
         YGe5jcA6EpFdbNs+2cQcn0blHRbVwoFbhQFvSn3wz4rXUEEL1i3ro/k9tkW4TOyNs9wA
         LNLw==
X-Gm-Message-State: AOPr4FU+9fRWvwOyoe4Ub8yavgcASvEnft4sFeRGtUkw1Lsp9JEHrJLifeezZBPnnQpr5g==
X-Received: by 10.98.81.195 with SMTP id f186mr28316617pfb.30.1461351901600;
        Fri, 22 Apr 2016 12:05:01 -0700 (PDT)
Received: from ashley.localdomain ([106.216.186.206])
        by smtp.gmail.com with ESMTPSA id t1sm11266470paa.17.2016.04.22.12.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 12:05:00 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292254>

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
