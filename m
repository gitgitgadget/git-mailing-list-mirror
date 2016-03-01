From: Saurav Sachidanand <sauravsachidanand@gmail.com>
Subject: [PATCH] Store EXC_FLAG_* values in unsigned integers
Date: Tue,  1 Mar 2016 22:32:59 +0530
Message-ID: <1456851779-38548-1-git-send-email-sauravsachidanand@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Saurav Sachidanand <sauravsachidanand@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 18:03:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aanhr-0003Rv-Sb
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 18:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbcCARD1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2016 12:03:27 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33836 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbcCARDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 12:03:25 -0500
Received: by mail-pa0-f45.google.com with SMTP id fy10so115082188pac.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 09:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sub2ggXAbIU1T5GBPiO9F43HHe6insnegVfWhwDFPdI=;
        b=gqNoD6u7bMUK1G7V122lgBOIyGq0i4i6WkunkrzzLnpM3xbc+qlJvAXTzApIKzXiTh
         5TikTgP27x8K5xLCfDwVqsUfe2Hk8bsAivCWUdledtiAIIdscym7K67UmMaitOUbFymS
         133XCKMqojTh12lhfKHCklmyZGxSeLuYn7HulAjF0dJ5tYd6DYJ9Gv6Y67VbRac6l6Va
         kJhV1M1x9FuCqF6kylSI+wg71hkpGioTenhzrJKWEnydG2fXRdVmX9DiYvadXIuqWU4O
         rJqYqxRXbtMxHUh024JQWk5pbiB94ZmqqwMtKRnmujR7ePmOAQLG4ft+QmUtR4CckyPm
         8asQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sub2ggXAbIU1T5GBPiO9F43HHe6insnegVfWhwDFPdI=;
        b=dTuD+jIwFN200h+4RJ7mTEUp8e67QkkMsAAl8L5EhXmN7lvP6UM/8+vJeB41St1+/B
         F+E7NEtQeK7HK4qTkj7aEjTbRhpSr4277D6OEuk/SRqWL4UUB6h7s5C8HmS/qqbmaLfy
         K9q9GrYKl0ElGbAA2LT5zkzrx0f01uxr5oZOlx6vGTi9oXMF82IO5LNXB4pMKshZlBXR
         5B0Sz1pxpipNKYf0UOwut7MeoMm0RJjxckgOTy50bnaGDgeSgNHUFpi9dx1fB1woOz82
         cM2k/adR9O6ceHuS+d56MS58V7T/QRIlB+RCW4WTUHc7AZXYsLIdizO08UqNfrt1WfFQ
         5kbA==
X-Gm-Message-State: AD7BkJIj8BnqxFgovR7ckA0b1oGWkAlrq36PVqIUcTivMdAbWPkb75l5AKv20bPEwo4eyA==
X-Received: by 10.66.142.193 with SMTP id ry1mr31610295pab.33.1456851805022;
        Tue, 01 Mar 2016 09:03:25 -0800 (PST)
Received: from localhost.localdomain ([106.51.19.158])
        by smtp.googlemail.com with ESMTPSA id h2sm13384254pfd.91.2016.03.01.09.03.22
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 01 Mar 2016 09:03:24 -0800 (PST)
X-Mailer: git-send-email 2.7.1.339.g0233b80
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288037>

The values defined by the macro EXC_FLAG_* (1, 4, 8, 16) are
stored in fields of the structs "pattern" and =E2=80=9Cexclude=E2=80=9D=
, some
functions arguments and a local variable.

No variable that holds these values uses its most significant
bit in any special way, as it=E2=80=99s value is either checked for a
variant of EXC_FLAG_* using the & operator
(flags & EXC_FLAG_NODIR), or assigned a value of 0 first
and then any one of {1, 4, 8, 16} using the | operator
(flags |=3D EXC_FLAG_NODIR). Hence, change the types of such
variables and fields to unsigned.

And while we=E2=80=99re at it, document "flags" of "exclude" to explici=
tly
state the values it=E2=80=99s supposed to take on.

Signed-off-by: Saurav Sachidanand <sauravsachidanand@gmail.com>
---

This is a patch for the suggested microproject for GSoC 2016, titled
"Use unsigned integral type for collection of bits." It=E2=80=99s the f=
ourth
iteration of this patch that incorporates changes to the commit
message suggested by Moritz Neeb, Eric Sunshine and Junio C Hamano,
and to some function signatures suggested by Duy Nguyen. Thanks to
them for their feedback.

Previous versions of this patch:
1) http://thread.gmane.org/gmane.comp.version-control.git/286821
2) http://thread.gmane.org/gmane.comp.version-control.git/287387
3) http://thread.gmane.org/gmane.comp.version-control.git/287838

 attr.c | 2 +-
 dir.c  | 8 ++++----
 dir.h  | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/attr.c b/attr.c
index 086c08d..679e13c 100644
--- a/attr.c
+++ b/attr.c
@@ -124,7 +124,7 @@ struct pattern {
 	const char *pattern;
 	int patternlen;
 	int nowildcardlen;
-	int flags;		/* EXC_FLAG_* */
+	unsigned flags;		/* EXC_FLAG_* */
 };

 /*
diff --git a/dir.c b/dir.c
index 552af23..82cec7d 100644
--- a/dir.c
+++ b/dir.c
@@ -459,7 +459,7 @@ int no_wildcard(const char *string)

 void parse_exclude_pattern(const char **pattern,
 			   int *patternlen,
-			   int *flags,
+			   unsigned *flags,
 			   int *nowildcardlen)
 {
 	const char *p =3D *pattern;
@@ -500,7 +500,7 @@ void add_exclude(const char *string, const char *ba=
se,
 {
 	struct exclude *x;
 	int patternlen;
-	int flags;
+	unsigned flags;
 	int nowildcardlen;

 	parse_exclude_pattern(&string, &patternlen, &flags, &nowildcardlen);
@@ -811,7 +811,7 @@ void add_excludes_from_file(struct dir_struct *dir,=
 const char *fname)

 int match_basename(const char *basename, int basenamelen,
 		   const char *pattern, int prefix, int patternlen,
-		   int flags)
+		   unsigned flags)
 {
 	if (prefix =3D=3D patternlen) {
 		if (patternlen =3D=3D basenamelen &&
@@ -836,7 +836,7 @@ int match_basename(const char *basename, int basena=
melen,
 int match_pathname(const char *pathname, int pathlen,
 		   const char *base, int baselen,
 		   const char *pattern, int prefix, int patternlen,
-		   int flags)
+		   unsigned flags)
 {
 	const char *name;
 	int namelen;
diff --git a/dir.h b/dir.h
index 3ec3fb0..e942b50 100644
--- a/dir.h
+++ b/dir.h
@@ -28,7 +28,7 @@ struct exclude {
 	int nowildcardlen;
 	const char *base;
 	int baselen;
-	int flags;
+	unsigned flags;		/* EXC_FLAG_* */

 	/*
 	 * Counting starts from 1 for line numbers in ignore files,
@@ -229,10 +229,10 @@ struct dir_entry *dir_add_ignored(struct dir_stru=
ct *dir, const char *pathname,
  * attr.c:path_matches()
  */
 extern int match_basename(const char *, int,
-			  const char *, int, int, int);
+			  const char *, int, int, unsigned);
 extern int match_pathname(const char *, int,
 			  const char *, int,
-			  const char *, int, int, int);
+			  const char *, int, int, unsigned);

 extern struct exclude *last_exclude_matching(struct dir_struct *dir,
 					     const char *name, int *dtype);
@@ -244,7 +244,7 @@ extern struct exclude_list *add_exclude_list(struct=
 dir_struct *dir,
 extern int add_excludes_from_file_to_list(const char *fname, const cha=
r *base, int baselen,
 					  struct exclude_list *el, int check_index);
 extern void add_excludes_from_file(struct dir_struct *, const char *fn=
ame);
-extern void parse_exclude_pattern(const char **string, int *patternlen=
, int *flags, int *nowildcardlen);
+extern void parse_exclude_pattern(const char **string, int *patternlen=
, unsigned *flags, int *nowildcardlen);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *el, int srcpos);
 extern void clear_exclude_list(struct exclude_list *el);
--
2.7.1.339.g0233b80
