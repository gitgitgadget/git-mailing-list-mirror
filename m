From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] grep: enable multi-threading for -p and -W
Date: Tue, 29 Nov 2011 10:54:39 +0100
Message-ID: <201111291054.39477.trast@student.ethz.ch>
References: <5e3bcf651b31b299ca411296e6e7c4d11f6ae617.1322232319.git.trast@student.ethz.ch> <4ECFC320.4030003@lsrfire.ath.cx> <4ED0D875.5050900@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Nov 29 10:54:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVKOn-0004G7-3A
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 10:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539Ab1K2Jyn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 04:54:43 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:50394 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753026Ab1K2Jym convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2011 04:54:42 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 29 Nov
 2011 10:54:39 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 29 Nov
 2011 10:54:39 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-47-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <4ED0D875.5050900@lsrfire.ath.cx>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186048>

Ren=E9 Scharfe wrote:
> Move attribute reading, which is not thread-safe, into add_work(), un=
der
> grep_mutex.  That way we can stop turning off multi-threading if -p o=
r -W
> is given, as the diff attribute for each file is gotten safely now.
>=20
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
> Goes on top of your patch.  Needs testing..

On a random old linux-2.6 clone at v2.6.37-rc2, I'm seeing (best of 5):

* none of the patches:
  git grep --cached INITRAMFS_ROOT_UID
    2.13user 0.14system 0:02.10elapsed
  git grep --cached -W INITRAMFS_ROOT_UID    # note: broken!
    2.23user 0.18system 0:02.21elapsed=20

* my patch, but not yours:
  git grep --cached INITRAMFS_ROOT_UID
    2.21user 0.21system 0:02.27elapsed
  git grep --cached -W INITRAMFS_ROOT_UID
    3.01user 0.05system 0:03.07elapsed

* my patch + your patch:
  git grep --cached INITRAMFS_ROOT_UID
    2.22user 0.17system 0:02.22elapsed
  git grep --cached -W INITRAMFS_ROOT_UID
    4.45user 0.22system 0:02.67elapsed

So while it ends up being faster overall, it also uses way more CPU
and would presumably be *slower* on a single-processor system.
Apparently those attribute lookups really hurt.

So I had the following idea: if we load attributes only very lazily
(that is, when match_funcname() is first called), we can ask for them
much more rarely.  The revised timings:

* my patch + the new patch at the end:
  git grep --cached INITRAMFS_ROOT_UID
    2.15user 0.16system 0:02.15elapsed 107%CPU
  git grep --cached -W INITRAMFS_ROOT_UID
    2.20user 0.18system 0:02.24elapsed

However, locking on a specific lock relies on the fact that the
attributes are only read from the tree, but never from the object
store.  Perhaps it would be more futureproof to lock on
read_sha1_mutex instead.  Either way the lazy attributes lookup seems
a big win.

------ 8< ------ 8< ------
Subject: [PATCH] grep: fine-grained locking around attributes access

Lazily load the userdiff attributes in match_funcname().  Use a
separate mutex around this loading to protect the (not thread-safe)
attributes machinery.  This lets us re-enable threading with -p and
-W while reducing the overhead caused by looking up attributes.

diff --git a/builtin/grep.c b/builtin/grep.c
index 988ea1d..822b32f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -256,6 +256,7 @@ static void start_threads(struct grep_opt *opt)
=20
 	pthread_mutex_init(&grep_mutex, NULL);
 	pthread_mutex_init(&read_sha1_mutex, NULL);
+	pthread_mutex_init(&grep_attr_mutex, NULL);
 	pthread_cond_init(&cond_add, NULL);
 	pthread_cond_init(&cond_write, NULL);
 	pthread_cond_init(&cond_result, NULL);
@@ -303,6 +304,7 @@ static int wait_all(void)
=20
 	pthread_mutex_destroy(&grep_mutex);
 	pthread_mutex_destroy(&read_sha1_mutex);
+	pthread_mutex_destroy(&grep_attr_mutex);
 	pthread_cond_destroy(&cond_add);
 	pthread_cond_destroy(&cond_write);
 	pthread_cond_destroy(&cond_result);
@@ -1002,9 +1004,13 @@ int cmd_grep(int argc, const char **argv, const =
char *prefix)
 		opt.regflags |=3D REG_ICASE;
=20
 #ifndef NO_PTHREADS
-	if (online_cpus() =3D=3D 1 || !grep_threads_ok(&opt))
+	if (online_cpus() =3D=3D 1)
 		use_threads =3D 0;
+#endif
+
+	opt.use_threads =3D use_threads;
=20
+#ifndef NO_PTHREADS
 	if (use_threads) {
 		if (opt.pre_context || opt.post_context || opt.file_break ||
 		    opt.funcbody)
diff --git a/grep.c b/grep.c
index 7a070e9..e9c3df3 100644
--- a/grep.c
+++ b/grep.c
@@ -2,6 +2,7 @@
 #include "grep.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
+#include "thread-utils.h"
=20
 void append_header_grep_pattern(struct grep_opt *opt, enum grep_header=
_field field, const char *pat)
 {
@@ -806,10 +807,38 @@ static void show_line(struct grep_opt *opt, char =
*bol, char *eol,
 	opt->output(opt, "\n", 1);
 }
=20
-static int match_funcname(struct grep_opt *opt, char *bol, char *eol)
+#ifndef NO_PTHREADS
+pthread_mutex_t grep_attr_mutex;
+
+static inline void grep_attr_lock(struct grep_opt *opt)
+{
+	if (opt->use_threads)
+		pthread_mutex_lock(&grep_attr_mutex);
+}
+
+static inline void grep_attr_unlock(struct grep_opt *opt)
+{
+	if (opt->use_threads)
+		pthread_mutex_unlock(&grep_attr_mutex);
+}
+#endif
+
+static int match_funcname(struct grep_opt *opt, const char *name, char=
 *bol, char *eol)
 {
 	xdemitconf_t *xecfg =3D opt->priv;
-	if (xecfg && xecfg->find_func) {
+	if (xecfg && !xecfg->find_func) {
+		grep_attr_lock(opt);
+		struct userdiff_driver *drv =3D userdiff_find_by_path(name);
+		grep_attr_unlock(opt);
+		if (drv && drv->funcname.pattern) {
+			const struct userdiff_funcname *pe =3D &drv->funcname;
+			xdiff_set_find_func(xecfg, pe->pattern, pe->cflags);
+		} else {
+			xecfg =3D opt->priv =3D NULL;
+		}
+	}
+
+	if (xecfg) {
 		char buf[1];
 		return xecfg->find_func(bol, eol - bol, buf, 1,
 					xecfg->find_func_priv) >=3D 0;
@@ -835,7 +864,7 @@ static void show_funcname_line(struct grep_opt *opt=
, const char *name,
 		if (lno <=3D opt->last_shown)
 			break;
=20
-		if (match_funcname(opt, bol, eol)) {
+		if (match_funcname(opt, name, bol, eol)) {
 			show_line(opt, bol, eol, name, lno, '=3D');
 			break;
 		}
@@ -848,7 +877,7 @@ static void show_pre_context(struct grep_opt *opt, =
const char *name, char *buf,
 	unsigned cur =3D lno, from =3D 1, funcname_lno =3D 0;
 	int funcname_needed =3D !!opt->funcname;
=20
-	if (opt->funcbody && !match_funcname(opt, bol, end))
+	if (opt->funcbody && !match_funcname(opt, name, bol, end))
 		funcname_needed =3D 2;
=20
 	if (opt->pre_context < lno)
@@ -864,7 +893,7 @@ static void show_pre_context(struct grep_opt *opt, =
const char *name, char *buf,
 		while (bol > buf && bol[-1] !=3D '\n')
 			bol--;
 		cur--;
-		if (funcname_needed && match_funcname(opt, bol, eol)) {
+		if (funcname_needed && match_funcname(opt, name, bol, eol)) {
 			funcname_lno =3D cur;
 			funcname_needed =3D 0;
 		}
@@ -942,19 +971,6 @@ static int look_ahead(struct grep_opt *opt,
 	return 0;
 }
=20
-int grep_threads_ok(const struct grep_opt *opt)
-{
-	/* If this condition is true, then we may use the attribute
-	 * machinery in grep_buffer_1. The attribute code is not
-	 * thread safe, so we disable the use of threads.
-	 */
-	if ((opt->funcname || opt->funcbody)
-	    && !opt->unmatch_name_only && !opt->status_only && !opt->name_onl=
y)
-		return 0;
-
-	return 1;
-}
-
 static void std_output(struct grep_opt *opt, const void *buf, size_t s=
ize)
 {
 	fwrite(buf, size, 1, stdout);
@@ -1011,12 +1027,7 @@ static int grep_buffer_1(struct grep_opt *opt, c=
onst char *name,
 	if ((opt->funcname || opt->funcbody)
 	    && !opt->unmatch_name_only && !opt->status_only &&
 	    !opt->name_only && !binary_match_only && !collect_hits) {
-		struct userdiff_driver *drv =3D userdiff_find_by_path(name);
-		if (drv && drv->funcname.pattern) {
-			const struct userdiff_funcname *pe =3D &drv->funcname;
-			xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
-			opt->priv =3D &xecfg;
-		}
+		opt->priv =3D &xecfg;
 	}
 	try_lookahead =3D should_lookahead(opt);
=20
@@ -1093,7 +1104,7 @@ static int grep_buffer_1(struct grep_opt *opt, co=
nst char *name,
 				show_function =3D 1;
 			goto next_line;
 		}
-		if (show_function && match_funcname(opt, bol, eol))
+		if (show_function && match_funcname(opt, name, bol, eol))
 			show_function =3D 0;
 		if (show_function ||
 		    (last_hit && lno <=3D last_hit + opt->post_context)) {
diff --git a/grep.h b/grep.h
index a652800..15d227c 100644
--- a/grep.h
+++ b/grep.h
@@ -115,6 +115,7 @@ struct grep_opt {
 	int show_hunk_mark;
 	int file_break;
 	int heading;
+	int use_threads;
 	void *priv;
=20
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
@@ -131,4 +132,10 @@ struct grep_opt {
 extern struct grep_opt *grep_opt_dup(const struct grep_opt *opt);
 extern int grep_threads_ok(const struct grep_opt *opt);
=20
+#ifndef NO_PTHREADS
+/* Mutex used around access to the attributes machinery if
+ * opt->use_threads.  Must be initialized/destroyed by callers! */
+extern pthread_mutex_t grep_attr_mutex;
+#endif
+
 #endif


--=20
Thomas Rast
trast@{inf,student}.ethz.ch
