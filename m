From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 01/11] ref-filter: add "%(objectname:size=X)" option
Date: Tue, 28 Jul 2015 12:26:26 +0530
Message-ID: <1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 08:56:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJyoW-00067K-I5
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 08:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbbG1G4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 02:56:32 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34554 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbbG1G4c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 02:56:32 -0400
Received: by pacan13 with SMTP id an13so66197866pac.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 23:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EibqEEFWJcLbKhL3GlA/PqtVGoeeykPIoz+nnrxzyyA=;
        b=xBfl3iWS/kehSsBLWDjOEK2YSOeC+i6uodg9xAnQ23cMHwXbmgQA1Fwwc2tzWptN8R
         pleK9tm830u1eW5TEz4gjTM3p+z/aaVhVdMfq9Ktvwx1TTYadLmPnd7hnK39Hmbk2R9S
         bqn9/yS9iiQXh01DqIvvLIWoGATE729IJxlWeLV8oWhrCI39yzGwLc4STmxhYTfOKPEw
         l06kDtXUeGFOpe4g+c/k0Jasx9ETxhXEDKNJF9EK37iOCym43ytKqnQymkuPbQVEFFPm
         MmheCdfGbVj7fvQ0DyORxdi3UwetFLXelz5a/r/dcssD6HF+jBywA1WcyfIWue5nAsJf
         lWxA==
X-Received: by 10.66.138.40 with SMTP id qn8mr77881696pab.19.1438066591590;
        Mon, 27 Jul 2015 23:56:31 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id q7sm33147846pdj.31.2015.07.27.23.56.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 23:56:31 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274738>

From: Karthik Nayak <karthik.188@gmail.com>

Add support for %(objectname:size=X) where X is a number.
This will print the first X characters of an objectname.
The minimum value for X is 5. Hence any value lesser than
5 will default to 5 characters.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 0a34924..4c5e3f8 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -196,6 +196,8 @@ static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned lo
 static int grab_objectname(const char *name, const unsigned char *sha1,
 			    struct atom_value *v)
 {
+	const char *p;
+
 	if (!strcmp(name, "objectname")) {
 		char *s = xmalloc(41);
 		strcpy(s, sha1_to_hex(sha1));
@@ -206,6 +208,13 @@ static int grab_objectname(const char *name, const unsigned char *sha1,
 		v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
 		return 1;
 	}
+	if (skip_prefix(name, "objectname:size=", &p)) {
+		unsigned int size = atoi(p);
+		if (size < 5)
+			size = 5;
+		v->s = xstrdup(find_unique_abbrev(sha1, size));
+		return 1;
+	}
 	return 0;
 }
 
-- 
2.4.6
