From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/12] attr: (re)introduce git_check_attr() and struct git_attr_check
Date: Mon, 16 May 2016 14:05:42 -0700
Message-ID: <20160516210545.6591-10-gitster@pobox.com>
References: <20160516210545.6591-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 23:06:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2PiV-0001LI-Kx
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 23:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbcEPVGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 17:06:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54547 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751266AbcEPVGK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 17:06:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A2BFA1C454;
	Mon, 16 May 2016 17:06:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=B4jx
	PNQ7l1+RaRQiIQcZ6tVh5DU=; b=OIhdNF55EVSIq2q6Eq7ntbk4RGrSQTtBErCF
	RevXdiH3w0UzeEwgTawQvFB1/DBByx2JySXAnpgcEC2A4w3vpaSAGnr7DrDc5N8f
	+OGDtZNLONsv1kz/FXt4NgYgIRXsx6oAXnSPce93+hcncSgZoNIWfPqwzunSp+6y
	vX6RNnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=XCasa/
	o8Lw4ixEkRUtWtpm9B32JvN4LLlXaEygkWtn+0UZz876ifbGcgmixniEZX7sqKDQ
	cqEC92mnRPrBt/V4E/+5VXbpsl9zhN4s7l2jEUt39qFX9aCLPZpKmu2IH8q8agzj
	v5jdYk/ULFB/HVz6XRezSe21UjrTaVRDpLKNE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B3BB1C453;
	Mon, 16 May 2016 17:06:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0421A1C44D;
	Mon, 16 May 2016 17:06:08 -0400 (EDT)
X-Mailer: git-send-email 2.8.2-755-g8847aff
In-Reply-To: <20160516210545.6591-1-gitster@pobox.com>
X-Pobox-Relay-ID: 03032B58-1BAA-11E6-AE0C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294795>

A common pattern to check N attributes for many paths is to

 (1) prepare an array A of N git_attr_check_elem items;
 (2) call git_attr() to intern the N attribute names and fill A;
 (3) repeatedly call git_check_attrs() for path with N and A;

A look-up for these N attributes for a single path P scans the
entire attr_stack, starting from the .git/info/attributes file and
then .gitattributes file in the directory the path P is in, going
upwards to find .gitattributes file found in parent directories.

An earlier commit 06a604e6 (attr: avoid heavy work when we know the
specified attr is not defined, 2014-12-28) tried to optimize out
this scanning for one trivial special case: when the attribute being
sought is known not to exist, we do not have to scan for it.  While
this may be a cheap and effective heuristic, it would not work well
when N is (much) more than 1.

What we would want is a more customized way to skip irrelevant
entries in the attribute stack, and the definition of irrelevance
is tied to the set of attributes passed to git_check_attrs() call,
i.e. the set of attributes being sought.  The data necessary for
this optimization needs to live alongside the set of attributes, but
a simple array of git_attr_check_elem simply does not have any place
for that.

Introduce "struct git_attr_check" that contains N, the number of
attributes being sought, and A, the array that holds N
git_attr_check_elem items, and a function git_check_attr() that
takes a path P and this structure as its parameters.  This structure
can later be extended to hold extra data necessary for optimization.

Also, to make it easier to write the first two steps in common
cases, introduce git_attr_check_initl() helper function, which takes
a NULL-terminated list of attribute names and initialize this
structure.

As an illustration of this new API, convert archive.c that asks for
export-subst and export-ignore attributes for each paths.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 archive.c | 24 ++++++------------------
 attr.c    | 34 ++++++++++++++++++++++++++++++++++
 attr.h    |  9 +++++++++
 3 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/archive.c b/archive.c
index 0f6acc5..7779af1 100644
--- a/archive.c
+++ b/archive.c
@@ -87,19 +87,6 @@ void *sha1_file_to_archive(const struct archiver_args *args,
 	return buffer;
 }
 
-static void setup_archive_check(struct git_attr_check_elem *check)
-{
-	static struct git_attr *attr_export_ignore;
-	static struct git_attr *attr_export_subst;
-
-	if (!attr_export_ignore) {
-		attr_export_ignore = git_attr("export-ignore");
-		attr_export_subst = git_attr("export-subst");
-	}
-	check[0].attr = attr_export_ignore;
-	check[1].attr = attr_export_subst;
-}
-
 struct directory {
 	struct directory *up;
 	struct object_id oid;
@@ -123,7 +110,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	struct archiver_context *c = context;
 	struct archiver_args *args = c->args;
 	write_archive_entry_fn_t write_entry = c->write_entry;
-	struct git_attr_check_elem check[2];
+	static struct git_attr_check *check;
 	const char *path_without_prefix;
 	int err;
 
@@ -137,11 +124,12 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 		strbuf_addch(&path, '/');
 	path_without_prefix = path.buf + args->baselen;
 
-	setup_archive_check(check);
-	if (!git_check_attrs(path_without_prefix, ARRAY_SIZE(check), check)) {
-		if (ATTR_TRUE(check[0].value))
+	if (!check)
+		check = git_attr_check_initl("export-ignore", "export-subst", NULL);
+	if (!git_check_attr(path_without_prefix, check)) {
+		if (ATTR_TRUE(check->check[0].value))
 			return 0;
-		args->convert = ATTR_TRUE(check[1].value);
+		args->convert = ATTR_TRUE(check->check[1].value);
 	}
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
diff --git a/attr.c b/attr.c
index 8aa346c..285fc58 100644
--- a/attr.c
+++ b/attr.c
@@ -825,3 +825,37 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
 		drop_attr_stack();
 	use_index = istate;
 }
+
+int git_check_attr(const char *path, struct git_attr_check *check)
+{
+	return git_check_attrs(path, check->check_nr, check->check);
+}
+
+struct git_attr_check *git_attr_check_initl(const char *one, ...)
+{
+	struct git_attr_check *check;
+	int cnt;
+	va_list params;
+	const char *param;
+
+	va_start(params, one);
+	for (cnt = 1; (param = va_arg(params, const char *)) != NULL; cnt++)
+		;
+	va_end(params);
+	check = xcalloc(1,
+			sizeof(*check) + cnt * sizeof(*(check->check)));
+	check->check_nr = cnt;
+	check->check = (struct git_attr_check_elem *)(check + 1);
+
+	check->check[0].attr = git_attr(one);
+	va_start(params, one);
+	for (cnt = 1; cnt < check->check_nr; cnt++) {
+		param = va_arg(params, const char *);
+		if (!param)
+			die("BUG: counted %d != ended at %d",
+			    check->check_nr, cnt);
+		check->check[cnt].attr = git_attr(param);
+	}
+	va_end(params);
+	return check;
+}
diff --git a/attr.h b/attr.h
index cab82ec..3ed89e5 100644
--- a/attr.h
+++ b/attr.h
@@ -29,6 +29,15 @@ struct git_attr_check_elem {
 	const char *value;
 };
 
+struct git_attr_check {
+	int check_nr;
+	int check_alloc;
+	struct git_attr_check_elem *check;
+};
+
+extern struct git_attr_check *git_attr_check_initl(const char *, ...);
+extern int git_check_attr(const char *path, struct git_attr_check *);
+
 /*
  * Return the name of the attribute represented by the argument.  The
  * return value is a pointer to a null-delimited string that is part
-- 
2.8.2-748-gfb85f76
