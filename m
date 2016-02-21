From: Saurav Sachidanand <sauravsachidanand@gmail.com>
Subject: [PATCH] GSoC Micoproject: Hunt down signed int flags
Date: Sun, 21 Feb 2016 16:43:09 +0530
Message-ID: <1456053189-5221-1-git-send-email-sauravsachidanand@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Saurav Sachidanand <sauravsachidanand@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 21 19:14:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXYWs-0003zo-2r
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 19:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbcBUSOn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 13:14:43 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36602 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbcBUSOm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 13:14:42 -0500
Received: by mail-pf0-f181.google.com with SMTP id e127so79778464pfe.3
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 10:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=zZJQo1qop/RRKdSeyM30Kku2Dgy7rGNMMDgsSxFQOSs=;
        b=Qa2ESDe9VD7CsgvgY0Ouw7BMaHCL602yTfbK2H+VRvHITrpacfhPCbhJSlUXa749vE
         OouNOqMgQHKnhIo0p32Qc5QqQfr9q10xt40rhC6yHyduGmPRKx4jG/LThVNEALtMs3Dw
         iAwb5PKuPKd4JgHzW1PKtbM4e3FmTYLdS8JeXngrRTC9wFpZ9C87UwlxNlAMaAjGLQjg
         jK0n/PQuKEd8BI3VPOm6hHjQURYZkM85CriCmVPrctVBQoUFIso6REnoBh6V6+3VlOiG
         2gZo7d5n34ImfUXzA/z6dgBkXiZeKvf8E+sAsHsaE+DMMz4cusWNJEwJUXNKWsWjJVGd
         CGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=zZJQo1qop/RRKdSeyM30Kku2Dgy7rGNMMDgsSxFQOSs=;
        b=m5Ylw9yT73SHIRJSHECwwRKB6d944GhqudxT3uDzx5VY8NWw+lvoTeFYcNLoPBvPML
         +RgJUzreP9dEUI8XTAsLIIP7jIM2mJOs5BAzUsV2lG22aBsWrt4BXU9RsLuQLf9A4Imz
         pXdcPYLi9bQkGpFRCRVvHF3rQ2rPiDV2rVAR3gf4yKdq6J8iNIW8lUpnoueslgb5mH95
         V4NfRuXmYJLzdQpxEPrGgEB/s8G4xKZRW1pXzaXeqKRJOT7dNftG/gcbPfWCnAdgjr1l
         8XMDHg7cAz/o54pJUKSH/P905CIvhXut/j3myh6WixGLTxak7EHJkJyijkzNEQXQ3yzc
         fAXQ==
X-Gm-Message-State: AG10YOS6AZYne8NoeSOV9CO9YP1FLU5+9eRPxZI7AJDwc6iWR91/S8g+9wt3EYbkPCrm4w==
X-Received: by 10.98.75.79 with SMTP id y76mr21290248pfa.147.1456053205225;
        Sun, 21 Feb 2016 03:13:25 -0800 (PST)
Received: from localhost.localdomain ([106.51.19.158])
        by smtp.googlemail.com with ESMTPSA id l62sm29519620pfj.7.2016.02.21.03.13.23
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 21 Feb 2016 03:13:24 -0800 (PST)
X-Mailer: git-send-email 2.7.1.339.g0233b80
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286821>

This is patch is for a suggested micro project for GSoC 2016; namely,
that of searching for a field of a struct that is of signed integral
type and used as a collection of multiple bits, and converting it to
an unsigned type if the MSB isn=E2=80=99t used in any special way.

Two structs, `pattern` defined in attr.c and `exclude` defined in dir.h=
,
have a `flags` field of signed int type. The fields of both structs tak=
e
on values from the same set of positive integers {1, 4, 8, 16},
enumerated through the marco EXC_FLAG_*. `pattern` is used only in attr=
=2Ec,
and `exclude` is used only in builtin/check-ignore.c and dir.c, and in
those files, either, the value of `flags` is checked using the `&` oper=
ator
(e.g.: flags & EXC_FLAG_NODIR), or the value of `flags` is first set to=
 0
and then set to any one of {1, 4, 8, 16} using the `|=3D` operator
(e.g.: flags |=3D EXC_FLAG_NODIR). And, so it does not appear that the =
MSB
of `flags` is used in any special way. Therefore, I thought to change t=
he
type of `flags` in the definitions of both structs to `unsigned int`.

=46urthermore, `flags` is passed by reference (of `pattern` in attr.c a=
nd of
`exclude` in dir.c) to the function `parse_exclude_pattern` defined in
dir.c, that accepts an `int *` type for `flags`. When make was run, it =
gave
a warning for =E2=80=98converting between pointers to integer types of =
different
sign=E2=80=99, so I changed the type of that respective argument to `un=
signed int *`.

In the end, running make to build didn=E2=80=99t produce any more warni=
ngs, and
running make in t/ didn=E2=80=99t produce any breakage that wasn=E2=80=99=
t =E2=80=98#TODO known
breakage=E2=80=99.

I also thought it=E2=80=99d be helpful to add the comment /* EXC_FLAG_*=
 */ next
to `flags` of `exclude`, just like it exists for `flags` of `pattern`.

Signed-off-by: Saurav Sachidanand <sauravsachidanand@gmail.com>
---
 attr.c | 2 +-
 dir.c  | 4 ++--
 dir.h  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/attr.c b/attr.c
index 086c08d..874f726 100644
--- a/attr.c
+++ b/attr.c
@@ -124,7 +124,7 @@ struct pattern {
 	const char *pattern;
 	int patternlen;
 	int nowildcardlen;
-	int flags;		/* EXC_FLAG_* */
+	unsigned int flags;		/* EXC_FLAG_* */
 };
=20
 /*
diff --git a/dir.c b/dir.c
index f0b6d0a..2d657e1 100644
--- a/dir.c
+++ b/dir.c
@@ -457,7 +457,7 @@ int no_wildcard(const char *string)
=20
 void parse_exclude_pattern(const char **pattern,
 			   int *patternlen,
-			   int *flags,
+			   unsigned int *flags,
 			   int *nowildcardlen)
 {
 	const char *p =3D *pattern;
@@ -498,7 +498,7 @@ void add_exclude(const char *string, const char *ba=
se,
 {
 	struct exclude *x;
 	int patternlen;
-	int flags;
+	unsigned int flags;
 	int nowildcardlen;
=20
 	parse_exclude_pattern(&string, &patternlen, &flags, &nowildcardlen);
diff --git a/dir.h b/dir.h
index cd46f30..6d205f0 100644
--- a/dir.h
+++ b/dir.h
@@ -27,7 +27,7 @@ struct exclude {
 	int nowildcardlen;
 	const char *base;
 	int baselen;
-	int flags;
+	unsigned int flags;		/* EXC_FLAG_* */
=20
 	/*
 	 * Counting starts from 1 for line numbers in ignore files,
@@ -241,7 +241,7 @@ extern struct exclude_list *add_exclude_list(struct=
 dir_struct *dir,
 extern int add_excludes_from_file_to_list(const char *fname, const cha=
r *base, int baselen,
 					  struct exclude_list *el, int check_index);
 extern void add_excludes_from_file(struct dir_struct *, const char *fn=
ame);
-extern void parse_exclude_pattern(const char **string, int *patternlen=
, int *flags, int *nowildcardlen);
+extern void parse_exclude_pattern(const char **string, int *patternlen=
, unsigned int *flags, int *nowildcardlen);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *el, int srcpos);
 extern void clear_exclude_list(struct exclude_list *el);
--=20
2.7.1.339.g0233b80
