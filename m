From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC 4/4] attr: avoid heavy work when we know the
 specified attr is not defined
Date: Mon, 15 Dec 2014 07:50:18 +0700
Message-ID: <20141215005018.GA31006@lanh>
References: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
 <1418133205-18213-5-git-send-email-pclouds@gmail.com>
 <xmqqsigojr0u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 01:50:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0Jrl-0005eE-Sb
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 01:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbaLOAuV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Dec 2014 19:50:21 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:55066 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbaLOAuT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2014 19:50:19 -0500
Received: by mail-pd0-f169.google.com with SMTP id z10so10582972pdj.14
        for <git@vger.kernel.org>; Sun, 14 Dec 2014 16:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nm/qqLz322VsmXsbgU9VTJO8HcT7eEzzenIUlKaYU7Y=;
        b=bEbd8Fd6owF6jm5e/b8qzzefI4Bk1su06TBD6N4U59HhzA70pZvR2VB71ZE9U0s9k0
         f/aHBCfSgzLSNh6FOipeNz/cTLd7CPjBgp96vTYdlldnMFUC9ZGqGux+B0MlCsJvJ2uX
         9F9SqizyqnQ2p2+535kd+Wv0m5Xstg6uj8ikwcmGn8WPJZgVmbeRW4V2xIyTAAD2giO4
         5T8lGreIaK5FO5m5N/A+or35tY0SLNUJxAQIF1d4zDyW/y2N4siolJxi8+3AOtPLWqPl
         MklbO9rz3Xij1sUiAUu4F+I0I4y5TeXgkP9Kb5C+OsLza6tauOAqeL+eUsOyA6iYnYQk
         ZviA==
X-Received: by 10.70.123.138 with SMTP id ma10mr47104475pdb.39.1418604618662;
        Sun, 14 Dec 2014 16:50:18 -0800 (PST)
Received: from lanh ([115.73.197.229])
        by mx.google.com with ESMTPSA id w14sm7530092pas.14.2014.12.14.16.50.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Dec 2014 16:50:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 15 Dec 2014 07:50:18 +0700
Content-Disposition: inline
In-Reply-To: <xmqqsigojr0u.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261404>

On Tue, Dec 09, 2014 at 04:18:57PM -0800, Junio C Hamano wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>=20
> > +static void collect_selected_attrs(const char *path, int num,
> > +				   struct git_attr_check *check)
> > +{
> > +	struct attr_stack *stk;
> > +	int i, pathlen, rem, dirlen;
> > +	int basename_offset;
> > +
> > +	pathlen =3D split_path(path, &dirlen, &basename_offset);
> > +	prepare_attr_stack(path, dirlen);
> > +	if (cannot_trust_maybe_real) {
> > +		for (i =3D 0; i < git_attr_nr; i++)
> > +			check_all_attr[i].value =3D ATTR__UNKNOWN;
>=20
> Judging from the fact that
>=20
>  (1) the only caller calls this function in this fashion based on the
>      setting of "cannot-trust" bit,
>=20
>  (2) this and the other function the only caller calls share the
>      same code in their beginning part, and
>=20
>  (3) the body of the if() statement here duplicates the code from
>      collect_all_attrs(),
>=20
> I smell that a much better split is possible.
>=20
> Why isn't this all inside a single function collect_all_attrs()?
> That single function may no longer be collect_ALL_attrs, so renaming
> it to collect_attrs() is fine, but then that function may have this
> if () to initialize all of them to ATTR__UNKNOWN or do the else part
> we see below, and when organized that way we do not need to have
> duplicated code (or split_path() helper function), no?

Something like this? Definitely looks better.

-- 8< --
diff --git a/attr.c b/attr.c
index b80e52b..0f828e3 100644
--- a/attr.c
+++ b/attr.c
@@ -33,9 +33,11 @@ struct git_attr {
 	unsigned h;
 	int attr_nr;
 	int maybe_macro;
+	int maybe_real;
 	char name[FLEX_ARRAY];
 };
 static int attr_nr;
+static int cannot_trust_maybe_real;
=20
 static struct git_attr_check *check_all_attr;
 static struct git_attr *(git_attr_hash[HASHSIZE]);
@@ -97,6 +99,7 @@ static struct git_attr *git_attr_internal(const char =
*name, int len)
 	a->next =3D git_attr_hash[pos];
 	a->attr_nr =3D attr_nr++;
 	a->maybe_macro =3D 0;
+	a->maybe_real =3D 0;
 	git_attr_hash[pos] =3D a;
=20
 	REALLOC_ARRAY(check_all_attr, attr_nr);
@@ -269,6 +272,10 @@ static struct match_attr *parse_attr_line(const ch=
ar *line, const char *src,
 	/* Second pass to fill the attr_states */
 	for (cp =3D states, i =3D 0; *cp; i++) {
 		cp =3D parse_attr(src, lineno, cp, &(res->state[i]));
+		if (!is_macro)
+			res->state[i].attr->maybe_real =3D 1;
+		if (res->state[i].attr->maybe_macro)
+			cannot_trust_maybe_real =3D 1;
 	}
=20
 	return res;
@@ -713,7 +720,9 @@ static int macroexpand_one(int nr, int rem)
  * Collect all attributes for path into the array pointed to by
  * check_all_attr.
  */
-static void collect_all_attrs(const char *path)
+static void collect_some_attrs(const char *path, int num,
+			       struct git_attr_check *check)
+
 {
 	struct attr_stack *stk;
 	int i, pathlen, rem, dirlen;
@@ -736,6 +745,19 @@ static void collect_all_attrs(const char *path)
 	prepare_attr_stack(path, dirlen);
 	for (i =3D 0; i < attr_nr; i++)
 		check_all_attr[i].value =3D ATTR__UNKNOWN;
+	if (num && !cannot_trust_maybe_real) {
+		rem =3D 0;
+		for (i =3D 0; i < num; i++) {
+			if (!check[i].attr->maybe_real) {
+				struct git_attr_check *c;
+				c =3D check_all_attr + check[i].attr->attr_nr;
+				c->value =3D ATTR__UNSET;
+				rem++;
+			}
+		}
+		if (rem =3D=3D num)
+			return;
+	}
=20
 	rem =3D attr_nr;
 	for (stk =3D attr_stack; 0 < rem && stk; stk =3D stk->prev)
@@ -746,7 +768,7 @@ int git_check_attr(const char *path, int num, struc=
t git_attr_check *check)
 {
 	int i;
=20
-	collect_all_attrs(path);
+	collect_some_attrs(path, num, check);
=20
 	for (i =3D 0; i < num; i++) {
 		const char *value =3D check_all_attr[check[i].attr->attr_nr].value;
@@ -762,7 +784,7 @@ int git_all_attrs(const char *path, int *num, struc=
t git_attr_check **check)
 {
 	int i, count, j;
=20
-	collect_all_attrs(path);
+	collect_some_attrs(path, 0, NULL);
=20
 	/* Count the number of attributes that are set. */
 	count =3D 0;
-- 8< --
