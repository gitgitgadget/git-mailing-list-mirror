From: "Stefan Karpinski" <stefan.karpinski@gmail.com>
Subject: builtin conversion between tabs and spaces
Date: Tue, 14 Oct 2008 18:44:10 -0700
Message-ID: <d4bc1a2a0810141844x76223e76xf04e07ece834fc61@mail.gmail.com>
References: <d4bc1a2a0810141839r547a770j3a8e56312afa6a53@mail.gmail.com>
	 <d4bc1a2a0810141842q1e50c85au7d813f2e5e37a84c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 03:45:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpvS7-0007Ge-Hp
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 03:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbYJOBoN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Oct 2008 21:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbYJOBoN
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 21:44:13 -0400
Received: from rn-out-0910.google.com ([64.233.170.190]:7981 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbYJOBoM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Oct 2008 21:44:12 -0400
Received: by rn-out-0910.google.com with SMTP id k40so1165518rnd.17
        for <git@vger.kernel.org>; Tue, 14 Oct 2008 18:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rD4fSyiWthVYv3D3mpVD1Ck6Qc+5Kjc1UhqOWjd5Of8=;
        b=RhdDkDVlcJ7XZL9rBuRA8IKBZs2zn3tPzlX8K95Sd+HkWGT6sZ3Fif1aATvCEuPjYb
         KPDANxpliZr08MzTXaUu30Q4bcwJUxU2QJEHN0aRgDjTjyanO2/YvQGY0ed7QJCahf+J
         3ur1pbsasEzhOFeSZ51eVvpD15/VzZef0Y12A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ox2NmY5bk3qh2hSL13tM1q4pgjn+KbdrV29Oqo9ypiJmSqr0UtzFXFbP9j/yuzGHrL
         oE/X57YdFPwsC5qDmwfr5/2rSVdFL5wf113+dvGKi18y+eyyr6CCnPqhJdlwAZt/49a8
         te/k+fRgmE6WJzy96QVsWYoAk5cmmEhpOE544=
Received: by 10.100.58.2 with SMTP id g2mr321279ana.108.1224035051011;
        Tue, 14 Oct 2008 18:44:11 -0700 (PDT)
Received: by 10.100.197.16 with HTTP; Tue, 14 Oct 2008 18:44:10 -0700 (PDT)
In-Reply-To: <d4bc1a2a0810141842q1e50c85au7d813f2e5e37a84c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98228>

I find myself really wanting to enforce standards in the use of spaces
versus tabs. I deal with some unruly programmers who refuse to set
their editors to use soft tabs, but I *hate* tabs in the repo. And of
course others feel equally strongly about keeping only tabs in the
repo (e.g. the git repo).

This led me to wonder if it wouldn't make sense to have this
conversion ability built into git. The following patch implements this
functionality. It still needs work=97it's not meant to be final, just t=
o
give an idea=97but I just wanted to see if people on the git list
thought this sort of thing would be worthwhile at all.

If people think it's worth having in git, then how should it be
configured? I feel like a project should be able to define the
expected tab size for binary file types. Moreover, the project should
be able to define the default cannonicalization with resepect to
whitespace for different files types. Then, if they so desire, each
git user should be able to override the output format on a
per-repository basis.

Does this make any sense? Comments?

---
diff --git a/convert.c b/convert.c
index 1816e97..280f45b 100644
--- a/convert.c
+++ b/convert.c
@@ -18,7 +18,7 @@

 struct text_stat {
       /* NUL, CR, LF and CRLF counts */
-       unsigned nul, cr, lf, crlf;
+       unsigned nul, cr, lf, crlf, tab;

       /* These are just approximations! */
       unsigned printable, nonprintable;
@@ -48,7 +48,10 @@
 static void gather_stats(const char *buf, unsigned long size, struct
text_stat *
               else if (c < 32) {
                       switch (c) {
                               /* BS, HT, ESC and FF */
-                       case '\b': case '\t': case '\033': case '\014':
+                       case '\t':
+                               stats->tab++;
+                               /* fall through */
+                       case '\b': case '\033': case '\014':
                               stats->printable++;
                               break;
                       case 0:
@@ -235,6 +238,105 @@
 static int crlf_to_worktree(const char *path, const char *src, size_t =
len,
       return 1;
 }

+static int tabs_to_spaces(const char *path, const char *src, size_t le=
n,
+
                  struct strbuf *buf, int untabify)
+{
+       char *to_free =3D NULL;
+       struct text_stat stats;
+  static const unsigned tab_size =3D 4;
+       char *spaces;
+
+       if (!untabify)
+               return 0;
+
+  /* instead of calling twice, should cache these stats across calls *=
/
+       gather_stats(src, len, &stats);
+
+       if (!stats.tab)
+    return 0;
+
+       /* are we "faking" in place editing ? */
+       if (src =3D=3D buf->buf)
+               to_free =3D strbuf_detach(buf, NULL);
+
+  /* this growth may be excessive: not all tabs get tab_size spaces */
+       strbuf_grow(buf, len + tab_size * stats.tab);
+  spaces =3D (char *) xmalloc(tab_size);
+  memset(spaces, ' ', tab_size);
+       for (;;) {
+               const char *line =3D src;
+               const char *nl =3D memchr(src, '\n', len);
+               char *tab;
+    if (!nl)
+      nl =3D src + len;
+    while (src < nl && (tab =3D memchr(src, '\t', nl - src))) {
+      strbuf_add(buf, src, tab - src);
+      strbuf_add(buf, spaces, tab_size - ((tab - line) % tab_size));
+      src =3D tab + 1;
+    }
+    if (src < nl)
+      strbuf_add(buf, src, nl - src);
+               if (nl < src + len)
+                       strbuf_addch(buf, '\n');
+               else
+                       break;
+               src =3D nl + 1;
+               len -=3D src - line;
+       }
+
+       free(to_free);
+       free(spaces);
+       return 1;
+}
+
+static int spaces_to_tabs(const char *path, const char *src, size_t le=
n,
+
                  struct strbuf *buf, int tabify)
+{
+  static const unsigned tab_size =3D 4;
+
+       if (!tabify)
+               return 0;
+
+       /* only grow if not in place */
+       if (strbuf_avail(buf) + buf->len < len)
+               strbuf_grow(buf, len - buf->len);
+
+       for (;;) {
+               int tabs =3D 0, spaces =3D 0;
+               const char *line =3D src;
+               const char *nl =3D memchr(src, '\n', len);
+    if (!nl)
+      nl =3D src + len;
+               for (;; src++) {
+                       if (*src =3D=3D ' ') {
+                               spaces++;
+                               if (spaces =3D=3D tab_size) {
+                                       tabs++;
+                                       spaces =3D 0;
+                               }
+                       } else if (*src =3D=3D '\t') {
+                               tabs++;
+                               spaces =3D 0;
+                       } else break;
+               }
+               if (line < src) {
+                       memset(buf->buf + buf->len, '\t', tabs);
+                       memset(buf->buf + buf->len + tabs, ' ', spaces)=
;
+                       strbuf_setlen(buf, buf->len + tabs + spaces);
+               }
+    if (src < nl)
+      strbuf_add(buf, src, nl - src);
+               if (nl < src + len)
+                       strbuf_addch(buf, '\n');
+               else
+                       break;
+               src =3D nl + 1;
+               len -=3D src - line;
+       }
+
+       return 1;
+}
+
 struct filter_params {
       const char *src;
       unsigned long size;
@@ -370,22 +472,29 @@
 static int read_convert_config(const char *var, const char *value, voi=
d *cb)
       return 0;
 }

-static void setup_convert_check(struct git_attr_check *check)
+struct convert_checks {
+  struct git_attr_check crlf, tabs, ident, filter;
+};
+
+static void setup_convert_check(struct convert_checks *checks)
 {
       static struct git_attr *attr_crlf;
+       static struct git_attr *attr_tabs;
       static struct git_attr *attr_ident;
       static struct git_attr *attr_filter;

       if (!attr_crlf) {
               attr_crlf =3D git_attr("crlf", 4);
+               attr_tabs =3D git_attr("tabs", 4);
               attr_ident =3D git_attr("ident", 5);
               attr_filter =3D git_attr("filter", 6);
               user_convert_tail =3D &user_convert;
               git_config(read_convert_config, NULL);
       }
-       check[0].attr =3D attr_crlf;
-       check[1].attr =3D attr_ident;
-       check[2].attr =3D attr_filter;
+       checks->crlf.attr =3D attr_crlf;
+       checks->tabs.attr =3D attr_tabs;
+       checks->ident.attr =3D attr_ident;
+       checks->filter.attr =3D attr_filter;
 }

 static int count_ident(const char *cp, unsigned long size)
@@ -566,20 +675,22 @@
 static int git_path_check_ident(const char *path, struct git_attr_chec=
k *check)
       return !!ATTR_TRUE(value);
 }

+#define CHECK_ARRAY_SIZE (sizeof(struct convert_checks)/sizeof(struct
git_attr_check))
+
 int convert_to_git(const char *path, const char *src, size_t len,
                   struct strbuf *dst, enum safe_crlf checksafe)
 {
-       struct git_attr_check check[3];
+       struct convert_checks checks;
       int crlf =3D CRLF_GUESS;
       int ident =3D 0, ret =3D 0;
       const char *filter =3D NULL;

-       setup_convert_check(check);
-       if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
+       setup_convert_check(&checks);
+       if (!git_checkattr(path, CHECK_ARRAY_SIZE, (struct git_attr_che=
ck *)
&checks)) {
               struct convert_driver *drv;
-               crlf =3D git_path_check_crlf(path, check + 0);
-               ident =3D git_path_check_ident(path, check + 1);
-               drv =3D git_path_check_convert(path, check + 2);
+               crlf =3D git_path_check_crlf(path, &(checks.crlf));
+               ident =3D git_path_check_ident(path, &(checks.ident));
+               drv =3D git_path_check_convert(path, &(checks.filter));
               if (drv && drv->clean)
                       filter =3D drv->clean;
       }
@@ -589,6 +700,11 @@
 int convert_to_git(const char *path, const char *src, size_t len,
               src =3D dst->buf;
               len =3D dst->len;
       }
+       ret |=3D tabs_to_spaces(path, src, len, dst, 1); // get real va=
riable
+       if (ret) {
+               src =3D dst->buf;
+               len =3D dst->len;
+       }
       ret |=3D crlf_to_git(path, src, len, dst, crlf, checksafe);
       if (ret) {
               src =3D dst->buf;
@@ -599,17 +715,17 @@
 int convert_to_git(const char *path, const char *src, size_t len,

 int convert_to_working_tree(const char *path, const char *src, size_t
len, struct strbuf *dst)
 {
-       struct git_attr_check check[3];
+       struct convert_checks checks;
       int crlf =3D CRLF_GUESS;
       int ident =3D 0, ret =3D 0;
       const char *filter =3D NULL;

-       setup_convert_check(check);
-       if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
+       setup_convert_check(&checks);
+       if (!git_checkattr(path, CHECK_ARRAY_SIZE, (struct git_attr_che=
ck *)
&checks)) {
               struct convert_driver *drv;
-               crlf =3D git_path_check_crlf(path, check + 0);
-               ident =3D git_path_check_ident(path, check + 1);
-               drv =3D git_path_check_convert(path, check + 2);
+               crlf =3D git_path_check_crlf(path, &(checks.crlf));
+               ident =3D git_path_check_ident(path, &(checks.ident));
+               drv =3D git_path_check_convert(path, &(checks.filter));
               if (drv && drv->smudge)
                       filter =3D drv->smudge;
       }
@@ -624,5 +740,10 @@
 int convert_to_working_tree(const char *path, const char *src, size_t
len, struc
               src =3D dst->buf;
               len =3D dst->len;
       }
+       ret |=3D tabs_to_spaces(path, src, len, dst, 1); // get real va=
riable
+       if (ret) {
+               src =3D dst->buf;
+               len =3D dst->len;
+       }
       return ret | apply_filter(path, src, len, dst, filter);
 }
