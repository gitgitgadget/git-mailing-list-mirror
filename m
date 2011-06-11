From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/4] limit "contains" traversals based on commit timestamp
Date: Sat, 11 Jun 2011 19:04:09 +0000
Message-ID: <1307819051-25748-3-git-send-email-avarab@gmail.com>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 21:05:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVTV5-0005k6-F4
	for gcvg-git-2@lo.gmane.org; Sat, 11 Jun 2011 21:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739Ab1FKTFa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jun 2011 15:05:30 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49518 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753614Ab1FKTF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2011 15:05:29 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1232841ewy.19
        for <git@vger.kernel.org>; Sat, 11 Jun 2011 12:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=WtnPzEjo3fF87Nd4mXd9+mzgDu/QfYXcfrsQa3dudZc=;
        b=fdme9gL2WpR0Y7mVfu9/z63wUM7U9vbhZ1fdblhH1wgU6ZfSaPBdq7wpQ2MtFSUqwI
         Djcr7vLJoHL/FQgwo5qSzgr1jqkNmlm4DBqc+y2ppSdoM3dHimyC0u250yCSXvBjqdN4
         6NdbmqUki/Yk51IWIBn0yeuIZTb9JNFhHGSfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=mZKB6pjr/X6BgqqZfKCmq5zxNgSQS9rlkPJV9UndbFNGGTlKUREBa6QzKbltp5+Lp7
         jOF1Fcakhdw0SLNwiwVDgQ/XPOXJVMbIVfFV9nmgylJlXn1yXHbPQEmhYwHoUHTEMhJP
         syYF05HCT+zccxgDQmGQc7d7EFhs2MxjZcSd8=
Received: by 10.14.41.155 with SMTP id h27mr1594007eeb.199.1307819129112;
        Sat, 11 Jun 2011 12:05:29 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id v76sm477161eea.17.2011.06.11.12.05.25
        (version=SSLv3 cipher=OTHER);
        Sat, 11 Jun 2011 12:05:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.3
In-Reply-To: <1307819051-25748-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175645>

=46rom: Jeff King <peff@peff.net>

When looking for commits that contain other commits (e.g.,
via "git tag --contains"), we can end up traversing useless
portions of the graph. For example, if I am looking for a
tag that contains a commit made last week, there is not much
point in traversing portions of the history graph made five
years ago.

This optimization can provide massive speedups. For example,
doing "git tag --contains HEAD~200" in the linux-2.6
repository goes from:

  real    0m5.302s
  user    0m5.116s
  sys     0m0.184s

to:

  real    0m0.030s
  user    0m0.020s
  sys     0m0.008s

The downside is that we will no longer find some answers in
the face of extreme clock skew, as we will stop the
traversal early when seeing commits skewed too far into the
past.

Name-rev already implements a similar optimization, using a
"slop" of one day to allow for a certain amount of clock
skew in commit timestamps. This patch introduces a
"core.clockskew" variable, which allows specifying the
allowable amount of clock skew in seconds.  For safety, it
defaults to "none", causing a full traversal (i.e., no
change in behavior from previous versions).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/tag.c |   36 +++++++++++++++++++++++++++++++++---
 1 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 575a03c..0f0d784 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -25,6 +25,8 @@ static const char * const git_tag_usage[] =3D {
=20
 static char signingkey[1000];
=20
+static int core_clock_skew =3D -1;
+
 struct tag_filter {
 	const char *pattern;
 	int lines;
@@ -40,7 +42,8 @@ static int in_commit_list(const struct commit_list *w=
ant, struct commit *c)
 }
=20
 static int contains_recurse(struct commit *candidate,
-			    const struct commit_list *want)
+			    const struct commit_list *want,
+			    unsigned long cutoff)
 {
 	struct commit_list *p;
=20
@@ -57,9 +60,13 @@ static int contains_recurse(struct commit *candidate=
,
 	if (parse_commit(candidate) < 0)
 		return 0;
=20
+	/* stop searching if we go too far back in time */
+	if (candidate->date < cutoff)
+		return 0;
+
 	/* Otherwise recurse and mark ourselves for future traversals. */
 	for (p =3D candidate->parents; p; p =3D p->next) {
-		if (contains_recurse(p->item, want)) {
+		if (contains_recurse(p->item, want, cutoff)) {
 			candidate->object.flags |=3D TMP_MARK;
 			return 1;
 		}
@@ -70,7 +77,22 @@ static int contains_recurse(struct commit *candidate=
,
=20
 int contains(struct commit *candidate, const struct commit_list *want)
 {
-	return contains_recurse(candidate, want);
+	unsigned long cutoff =3D 0;
+
+	if (core_clock_skew >=3D 0) {
+		const struct commit_list *c;
+		unsigned long min_date =3D ULONG_MAX;
+		for (c =3D want; c; c =3D c->next) {
+			if (parse_commit(c->item) < 0)
+				continue;
+			if (c->item->date < min_date)
+				min_date =3D c->item->date;
+		}
+		if (min_date > core_clock_skew)
+			cutoff =3D min_date - core_clock_skew;
+	}
+
+	return contains_recurse(candidate, want, cutoff);
 }
=20
 static int show_reference(const char *refname, const unsigned char *sh=
a1,
@@ -277,6 +299,14 @@ static int git_tag_config(const char *var, const c=
har *value, void *cb)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.clockskew")) {
+		if (!value || !strcmp(value, "none"))
+			core_clock_skew =3D -1;
+		else
+			core_clock_skew =3D git_config_int(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
=20
--=20
1.7.5.3
