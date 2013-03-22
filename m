From: =?UTF-8?B?U2ViYXN0aWFuIEfDtnR0ZQ==?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH] merge/pull: verify GPG signatures of commits being merged
Date: Fri, 22 Mar 2013 22:51:40 +0100
Message-ID: <514CD26C.2070702@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 22 23:12:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJAC1-0001Wa-PC
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 23:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423045Ab3CVWLm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Mar 2013 18:11:42 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:50612 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422662Ab3CVWLj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 18:11:39 -0400
X-Greylist: delayed 1188 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Mar 2013 18:11:39 EDT
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-3) with esmtp 
	id 1UJ9sh-0000tu-Da; Fri, 22 Mar 2013 22:52:11 +0100
Received: from [192.168.0.103] (cable-124-189.zeelandnet.nl [82.176.124.189])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id C39A711402;
	Fri, 22 Mar 2013 22:51:42 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218855>

git merge/pull:
When --verify-signatures is specified on the command-line of git-merge
or git-pull, check whether the commits being merged have good gpg
signatures and abort the merge in case they do not. This allows e.g.
auto-deployment from untrusted repo hosts.

pretty printing:
Tell about an "untrusted good signature" in addition to the previous
"good signature" and "bad signature". In case of a missing signature,
expand the pretty format string "%G?" to "N" in since this eases the
wirting of anything parsing git-log output.

Signed-off-by: Sebastian G=C3=B6tte <jaseg@physik-pool.tu-berlin.de>
---
I moved the commit signature verification code from pretty.c to commit.=
c
because it is used from pretty.c and builtin/merge.c. I include that pr=
etty
printing change here because I needed to add the good/untrusted check f=
or the
merge --verify-signatures option to really make sense.

Those new %G? options are implicitly tested by t7612-merge-verify-signa=
tures.sh
because %G? is just replaced by the passed-through output of the commit
verification function.

 Documentation/merge-options.txt    |   4 +++
 Documentation/pretty-formats.txt   |   2 +-
 builtin/merge.c                    |  33 +++++++++++++++++-
 commit.c                           |  55 +++++++++++++++++++++++++++++
 commit.h                           |   9 +++++
 git-pull.sh                        |  10 ++++--
 gpg-interface.h                    |   6 ++++
 pretty.c                           |  69 ++++-------------------------=
--------
 t/lib-gpg/pubring.gpg              | Bin 1164 -> 2359 bytes
 t/lib-gpg/random_seed              | Bin 600 -> 600 bytes
 t/lib-gpg/secring.gpg              | Bin 1237 -> 3734 bytes
 t/lib-gpg/trustdb.gpg              | Bin 1280 -> 1360 bytes
 t/t7612-merge-verify-signatures.sh |  61 +++++++++++++++++++++++++++++=
+++
 13 files changed, 183 insertions(+), 66 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-opti=
ons.txt
index 0bcbe0a..2f76ab5 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -83,6 +83,10 @@ option can be used to override --squash.
 	Pass merge strategy specific option through to the merge
 	strategy.
=20
+--verify-signatures::
+--no-verify-signatures::
+	Verify that the commits being merged have good trusted GPG signatures
+
 --summary::
 --no-summary::
 	Synonyms to --stat and --no-stat; these are deprecated and will be
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index 105f18a..7297b1b 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -131,7 +131,7 @@ The placeholders are:
 - '%B': raw body (unwrapped subject and body)
 - '%N': commit notes
 - '%GG': raw verification message from GPG for a signed commit
-- '%G?': show either "G" for Good or "B" for Bad for a signed commit
+- '%G?': show "G" for a Good signature, "B" for a Bad signature, "U" f=
or a good, untrusted signature and "N" for no signature
 - '%GS': show the name of the signer for a signed commit
 - '%gD': reflog selector, e.g., `refs/stash@{1}`
 - '%gd': shortened reflog selector, e.g., `stash@{1}`
diff --git a/builtin/merge.c b/builtin/merge.c
index 7c8922c..37ece3d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -49,7 +49,7 @@ static const char * const builtin_merge_usage[] =3D {
 static int show_diffstat =3D 1, shortlog_len =3D -1, squash;
 static int option_commit =3D 1, allow_fast_forward =3D 1;
 static int fast_forward_only, option_edit =3D -1;
-static int allow_trivial =3D 1, have_message;
+static int allow_trivial =3D 1, have_message, verify_signatures =3D 0;
 static int overwrite_ignore =3D 1;
 static struct strbuf merge_msg =3D STRBUF_INIT;
 static struct strategy **use_strategies;
@@ -199,6 +199,8 @@ static struct option builtin_merge_options[] =3D {
 	OPT_BOOLEAN(0, "ff-only", &fast_forward_only,
 		N_("abort if fast-forward is not possible")),
 	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
+	OPT_BOOLEAN(0, "verify-signatures", &verify_signatures,
+		N_("Verify that the named commit has a valid GPG signature")),
 	OPT_CALLBACK('s', "strategy", &use_strategies, N_("strategy"),
 		N_("merge strategy to use"), option_parse_strategy),
 	OPT_CALLBACK('X', "strategy-option", &xopts, N_("option=3Dvalue"),
@@ -1233,6 +1235,35 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
 		usage_with_options(builtin_merge_usage,
 			builtin_merge_options);
=20
+	if (verify_signatures) {
+		//Verify the commit signatures
+		for (p =3D remoteheads; p; p =3D p->next) {
+			struct commit *commit =3D p->item;
+			struct signature signature;
+			signature.check_result =3D 0;
+
+			check_commit_signature(commit, &signature);
+		=09
+			char hex[41];
+			strcpy(hex, find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV)=
);
+			switch(signature.check_result){
+				case 'G':
+					if (verbosity >=3D 0)
+						printf(_("Commit %s has a good GPG signature by %s\n"), hex, sig=
nature.signer);
+					break;
+				case 'U':
+					die(_("Commmit %s has a good GPG signature allegedly by %s, albei=
t from an untrusted key."), hex, signature.signer);
+				case 'B':
+					die(_("Commmit %s has a bad GPG signature allegedly by %s."), hex=
, signature.signer);
+				default: //'N'
+					die(_("Commmit %s does not have a good GPG signature. In fact, co=
mmit %s does not have a GPG signature at all."), hex, hex);
+			}
+
+			free(signature.gpg_output);
+			free(signature.signer);
+		}
+	}
+
 	strbuf_addstr(&buf, "merge");
 	for (p =3D remoteheads; p; p =3D p->next)
 		strbuf_addf(&buf, " %s", merge_remote_util(p->item)->name);
diff --git a/commit.c b/commit.c
index e8eb0ae..300cf98 100644
--- a/commit.c
+++ b/commit.c
@@ -1023,6 +1023,61 @@ free_return:
 	free(buf);
 }
=20
+static struct {
+	char result;
+	const char *check;
+} signature_check[] =3D {
+	{ 'U', ": WARNING: This key is not certified with a trusted signature=
!" },
+	{ 'G', ": Good signature from " },
+	{ 'B', ": BAD signature from " },
+};
+
+static void parse_signature_lines(struct signature *sig)
+{
+	const char *buf =3D sig->gpg_output;
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(signature_check); i++) {
+		const char *found =3D strstr(buf, signature_check[i].check);
+		const char *next;
+		if (!found)
+			continue;
+		sig->check_result =3D signature_check[i].result;
+		found +=3D strlen(signature_check[i].check);
+		next =3D strchrnul(found, '\n');
+		sig->signer =3D xmemdupz(found, next - found);
+		break;
+	}
+}
+
+void check_commit_signature(const struct commit* commit, struct signat=
ure *sig)
+{
+	struct strbuf payload =3D STRBUF_INIT;
+	struct strbuf signature =3D STRBUF_INIT;
+	struct strbuf gpg_output =3D STRBUF_INIT;
+	int status;
+
+	sig->check_result =3D 'N';
+
+	if (parse_signed_commit(commit->object.sha1,
+				&payload, &signature) <=3D 0)
+		goto out;
+	status =3D verify_signed_buffer(payload.buf, payload.len,
+				      signature.buf, signature.len,
+				      &gpg_output);
+	if (status && !gpg_output.len)
+		goto out;
+	sig->gpg_output =3D strbuf_detach(&gpg_output, NULL);
+	parse_signature_lines(sig);
+
+ out:
+	strbuf_release(&gpg_output);
+	strbuf_release(&payload);
+	strbuf_release(&signature);
+}
+
+
+
 void append_merge_tag_headers(struct commit_list *parents,
 			      struct commit_extra_header ***tail)
 {
diff --git a/commit.h b/commit.h
index 4138bb4..2189eb6 100644
--- a/commit.h
+++ b/commit.h
@@ -5,6 +5,7 @@
 #include "tree.h"
 #include "strbuf.h"
 #include "decorate.h"
+#include "gpg-interface.h"
=20
 struct commit_list {
 	struct commit *item;
@@ -230,4 +231,12 @@ extern void print_commit_list(struct commit_list *=
list,
 			      const char *format_cur,
 			      const char *format_last);
=20
+/*
+ * Check the signature of the given commit. The result of the check is=
 stored in
+ * sig->check_result, 'G' for a good signature, 'U' for a good signatu=
re from an
+ * untrusted signer, 'B' for a bad signature and 'N' for no signature =
at all.
+ * This may allocate memory for sig->gpg_output and sig->signer.
+ */
+extern void check_commit_signature(const struct commit* commit, struct=
 signature *sig);
+
 #endif /* COMMIT_H */
diff --git a/git-pull.sh b/git-pull.sh
index 266e682..705940d 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -39,7 +39,7 @@ test -z "$(git ls-files -u)" || die_conflict
 test -f "$GIT_DIR/MERGE_HEAD" && die_merge
=20
 strategy_args=3D diffstat=3D no_commit=3D squash=3D no_ff=3D ff_only=3D
-log_arg=3D verbosity=3D progress=3D recurse_submodules=3D
+log_arg=3D verbosity=3D progress=3D recurse_submodules=3D verify_signa=
tures=3D
 merge_args=3D edit=3D
 curr_branch=3D$(git symbolic-ref -q HEAD)
 curr_branch_short=3D"${curr_branch#refs/heads/}"
@@ -125,6 +125,12 @@ do
 	--no-recurse-submodules)
 		recurse_submodules=3D--no-recurse-submodules
 		;;
+	--verify-signatures)
+		verify_signatures=3D--verify-signatures
+		;;
+	--no-verify-signatures)
+		verify_signatures=3D--no-verify-signatures
+		;;
 	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
 		dry_run=3D--dry-run
 		;;
@@ -283,7 +289,7 @@ true)
 	eval=3D"$eval --onto $merge_head ${oldremoteref:-$merge_head}"
 	;;
 *)
-	eval=3D"git-merge $diffstat $no_commit $edit $squash $no_ff $ff_only"
+	eval=3D"git-merge $diffstat $no_commit $verify_signatures $edit $squa=
sh $no_ff $ff_only"
 	eval=3D"$eval  $log_arg $strategy_args $merge_args $verbosity $progre=
ss"
 	eval=3D"$eval \"\$merge_name\" HEAD $merge_head"
 	;;
diff --git a/gpg-interface.h b/gpg-interface.h
index b9c3608..3895b2f 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -1,6 +1,12 @@
 #ifndef GPG_INTERFACE_H
 #define GPG_INTERFACE_H
=20
+struct signature {
+	char *gpg_output;
+	char check_result; // 0 (not checked), N (checked but no further resu=
lt), U (untrusted, good), G (good) or B (bad)
+	char *signer;
+};
+
 extern int sign_buffer(struct strbuf *buffer, struct strbuf *signature=
, const char *signing_key);
 extern int verify_signed_buffer(const char *payload, size_t payload_si=
ze, const char *signature, size_t signature_size, struct strbuf *gpg_ou=
tput);
 extern int git_gpg_config(const char *, const char *, void *);
diff --git a/pretty.c b/pretty.c
index eae57ad..875a1db 100644
--- a/pretty.c
+++ b/pretty.c
@@ -756,12 +756,7 @@ struct format_commit_context {
 	const struct pretty_print_context *pretty_ctx;
 	unsigned commit_header_parsed:1;
 	unsigned commit_message_parsed:1;
-	unsigned commit_signature_parsed:1;
-	struct {
-		char *gpg_output;
-		char good_bad;
-		char *signer;
-	} signature;
+	struct signature signature;
 	char *message;
 	size_t width, indent1, indent2;
=20
@@ -944,58 +939,6 @@ static void rewrap_message_tail(struct strbuf *sb,
 	c->indent2 =3D new_indent2;
 }
=20
-static struct {
-	char result;
-	const char *check;
-} signature_check[] =3D {
-	{ 'G', ": Good signature from " },
-	{ 'B', ": BAD signature from " },
-};
-
-static void parse_signature_lines(struct format_commit_context *ctx)
-{
-	const char *buf =3D ctx->signature.gpg_output;
-	int i;
-
-	for (i =3D 0; i < ARRAY_SIZE(signature_check); i++) {
-		const char *found =3D strstr(buf, signature_check[i].check);
-		const char *next;
-		if (!found)
-			continue;
-		ctx->signature.good_bad =3D signature_check[i].result;
-		found +=3D strlen(signature_check[i].check);
-		next =3D strchrnul(found, '\n');
-		ctx->signature.signer =3D xmemdupz(found, next - found);
-		break;
-	}
-}
-
-static void parse_commit_signature(struct format_commit_context *ctx)
-{
-	struct strbuf payload =3D STRBUF_INIT;
-	struct strbuf signature =3D STRBUF_INIT;
-	struct strbuf gpg_output =3D STRBUF_INIT;
-	int status;
-
-	ctx->commit_signature_parsed =3D 1;
-
-	if (parse_signed_commit(ctx->commit->object.sha1,
-				&payload, &signature) <=3D 0)
-		goto out;
-	status =3D verify_signed_buffer(payload.buf, payload.len,
-				      signature.buf, signature.len,
-				      &gpg_output);
-	if (status && !gpg_output.len)
-		goto out;
-	ctx->signature.gpg_output =3D strbuf_detach(&gpg_output, NULL);
-	parse_signature_lines(ctx);
-
- out:
-	strbuf_release(&gpg_output);
-	strbuf_release(&payload);
-	strbuf_release(&signature);
-}
-
=20
 static int format_reflog_person(struct strbuf *sb,
 				char part,
@@ -1182,18 +1125,20 @@ static size_t format_commit_one(struct strbuf *=
sb, const char *placeholder,
 	}
=20
 	if (placeholder[0] =3D=3D 'G') {
-		if (!c->commit_signature_parsed)
-			parse_commit_signature(c);
+		if (!c->signature.check_result)
+			check_commit_signature(c->commit, &(c->signature));
 		switch (placeholder[1]) {
 		case 'G':
 			if (c->signature.gpg_output)
 				strbuf_addstr(sb, c->signature.gpg_output);
 			break;
 		case '?':
-			switch (c->signature.good_bad) {
+			switch (c->signature.check_result) {
 			case 'G':
 			case 'B':
-				strbuf_addch(sb, c->signature.good_bad);
+			case 'U':
+			case 'N':
+				strbuf_addch(sb, c->signature.check_result);
 			}
 			break;
 		case 'S':
diff --git a/t/lib-gpg/pubring.gpg b/t/lib-gpg/pubring.gpg
index 83855fa4e1c6c37afe550c17afa1e7971042ded5..1a3c2d487c2fda9169751a3=
068fa51e853a1e519 100644
GIT binary patch
delta 1212
zcmV;t1Vj6b3AYlkj0As~0SyFEOqNFh2mr~8{AU1PG9!Ku9w|}@vpZJPg*#s86v-*O
zhafj(DL&&lF<A0)`tvC$E@WHJ2r~0{0ZCh1kHo$b9ih^aD*~)oVvK&yC1(yi)6x_y
zF8V3JpbIY^ZYQ&<Uk#j*ja0`;jw^J+5~!h3qc)ej%g1;Wb0U8cXSuLKdXkx2PUtB4
z>zqQ>O;r+6Qa<VFd?Z<kA#8Ch(&2p+QaoKR;K0{BU;l_DqGU2YCt6Fr4psgB*tPou
z8C@tnj=3DCqkffSLs=3Da-5G+h;Y8bkw<s-iIgT{$f^j!)l`hmkz}$nZPxBoPmwU;zIH^
zLN~K=3DbO>hGBes9{Fcqzh%Wj2h^{ZjI01*KI0kkAVa%poQL}_zlZ*pX5VIVwYX>((5
za%4bdcwudDY-KKPWpqA?0XPH`0RjLb1p-k_mPY~`0|pBT2nPcK1{DYb2?`4Y76JnS
z0v-VZ7k~f?2@qikE`_%uafw)?2m1%-{uDP0Rs1|(F{OVhOSKoH$k!o)x3CO5Z^@El
zxGq=3D+xQGR&r@3$S<0@SUu@@UuxUH%pD3Q-D`?37Vg*xmo<%+KD)(U~k>XU^b+=3D70V
zFr?b3DvlFq^B*d%lz=3Dlr!ch6nQbvcwWCD}n2DT3`r?RDkq=3D7r}qFvEh<dfApA7yR;
z8`OB;$TEKm@jkwG=3D8vlcKFd>rcM8+9eP66QueaUSz6NhphD3O@E(iX7T@2kxV(dXd
zxG_$z;qqdh<Np6*{J!OD7<b;8M6otxRi0UUN|OngZ4NdYbeU0hneiVEwY2h5xZ4z{
zsXL4>UkGxJ?Pc}MK(e<Q>lV@oumS)Bxd9CXQA~f9M*#=3D`sXI><#Mh|Ll%uxJqK}<$
zc)VOU|M7H$nU~Bd&(!9WlLk)V)&z>UY~vSc_rVFe1JAY7ThlG1IzE9z6>ly;9W<Ie
zrW&+EU|2KpxZ$0rq-Jn9T{vsi6Qh0j42I3_PLQ5$)qa$}3etj89nJkr^3#KD!xh9*
z4BvmZ0TM||zk);(8@JN=3Dfad9d4hK=3DHf1{&&J5DP=3D<J9wW0IGZ_*p$xvH=3DWZu8h=
1r#
z-&1Cjfqp9S1m|b%7<S$7Du_^GfwyFyObC4EMw~6<SwH1<W45gXD*OLAz9x~@tJ8<?
z^Jtn;2$K^0SUY?f@Cu@)V5#TJ_yB~Qw!nY4S8m<?1+xGV0RRDs0Urby0RjLC1p-k_
zmPY~`3;+rV5Mc=3D}g|{MciR^I*0LA1n{v0`JrvmHmaVfVdlHi8rqLbHhetm3X@&@Ir
zXeh6;re%LlP-QWig+n`!Ae0mFQrnvwOO!ZC8%_&sj-2tVNM{p{WTNusbkj>Mdd`2^
zgn2IBiSf%lm^DyQau7lg)pfK8(7<}-iih0<Mm(k9C_6rNl4sE(`#Aa}K2LGjw*;6_
zqt%Wq<wPe#N15ysVyQhrRmcBJ^&Q!GEW&Mp#@%c+q~S#5UAR4_eeRejBs87Xv&Yt)
zg^u)$-LG%(tX4KA^%L!j<@*Z_A!anKyx}t&F6RX0yYXc)&KtB~l*=3DnGq9`cf<aD`r
a9*zs=3DxM)EjeiKg!$s4>o369jT0ssS^s3f2O

delta 7
Ocmdlk)Wf-<hXnu&fC8TY

diff --git a/t/lib-gpg/random_seed b/t/lib-gpg/random_seed
index 8fed1339ed0a744e5663f4a5e6b6ac9bae3d8524..95d249f15fce980f0e8c1a8=
a18b085b3885708aa 100644
GIT binary patch
literal 600
zcmV-e0;m1ccZd+x>>TST*Lrq1x^ggx^+ymwieO!6X=3DU~ZH@{avIgxdn#ai{)Ou@Qw
za}Z!boffEq^fn)n?c=3DIEnDpt59Lnc)aR*;8Z;k>gh_NW;ka;7Mt@v#sG(!Y9SSXWv
zQxd3WlyBr#4ltW6uKOoa6(r3df1VX$cG4`Om6hD-ckaX+Hb_yI?{f`hJQY&k!1cM-
zoGeY~(Z7aYn$W06djh?W|CMs>W=3Dk@jgf=3DP2D1UA1T%vz0oE|<O<lIacG0xioPtS&U
zNd#}P%YpJr-H65~J^RdqA!YV9BEvh7Gw^CdXg+Hp?kj=3DKGW|+|&g$4?`trWWGuy$9
zv-|;8Y4(NRHWPyJ{epd{4%FHQKk5j}?0FFDAJ;0kIItZ4y<JS?DIG4~0!#x~;X`!P
zO%+va?@`?yQnhjrP@&#yjY$YO_0yk|1ddhc8V&ru7d%ytet)mF<ZIUbPB3bvhHQ41
zNmnYeFxUMu=3Dm$K5&s=3D5_F&JSR#oU3Y#X{(q7HTp-VYJ)%JjihbZ@R#GeqmU{>0C4Q
zc}hUG+ighB{7XSaNw_h;=3DYtqacQ<B(Cg$e)^NTDD-oMD+T`O#-^|-ib>j!<pxHg+(
zlC$%zE836|E*F*((=3D>O{Nn@K$taZO}!>$t>GMgsw?!=3Dn_#(%X9Ha|$b=3DH@VstWYe=
;
zPUQ<L$$#9HTcOLoyEd6*A4TOEe3}c}GiW*^P1Lt{nHYUEAB`Qx7*wizaEyM$?AjVN
mb-6m)4=3D6PVqdR>h+D!{<c#q1!T9b(}OW7hrrT@nJcBO(OGA4ll

literal 600
zcmV-e0;m1=3Dh9nBV>1C6QsKJEiEJaD@Q3F8s5u<$E+<2(By)JAZSxviTsXg(wKC+O%
zzvV{Z>W3*k?r7~pgmmkbw8-x{Am!eeN)z?cwIHcT2jqgiA(SXo<iO=3DE?cY80`p#w8
z)O-&?SnwsJ=3D1VJ-?26&*g88Nr8E=3Dg2onRW^(c+2nJlX)?dmK)tPO0EY-!B!vMCv1)
z-AOW(3WuF+7IdSxMnzrDgnMqVU=3D|+YFxlY|VeR+Fg<%C@0Xupi0<S7QYJyFTR$}FQ
zzoSAbU>CoCKWKX;!3@L_U=3DaFUm!M<>ILG}$`bfnadAkLQbI-upV7Qwf^OE&N45Pz<
zk~^KlzNC6)d@QGv=3DK5-At&A8FS&MQSR`LB}@R1?A3K1p(vM>7CK}EfFhmBJd&cH^-
z(3Ih^`VuoVBB|w~p!Q^#DY%V2A2FhXu<Bp*L)lSCUdqRyI5wxMG&E1sL$)E$Zo&pJ
zgy#;fENqHImgN>LL2!7DhfZ}&;BSAyz=3DT0#S?2+NET5St@16L?YI?5Io%<uD|2}hl
zx0xsuefz1+bM^-ZIgtKs=3D)&VAI8(MfytvM>t>%~nsXUb~*EkptHiN?W{=3DDRu_s;2u
ziHh{2&>;CQO7;>{$DN33_Ef}g+;b<2hIF^p(Y>^riLBb*Y2Xw>F8)jp49&oLKJOic
z+V{Lt!_`eKGhyk5Edie{-^#n!TFlsfux*QBRZEh^4SVePPmb{BvF|>sKd2cYg@vKp
mVI8jcB1(k(tlt^Kr<{EMs>|b*d70nyVMQcc%xEnE(#Uq3d^-35

diff --git a/t/lib-gpg/secring.gpg b/t/lib-gpg/secring.gpg
index d831cd9eb3eee613d3c0e1a71093ae01ea7347e3..82dca8f80bf170fde570586=
2c3eeb9d994725042 100644
GIT binary patch
delta 2524
zcmV<22_yE^36>qO)dYW)1DFI+OqNFh2mr~8{AU1PG9!Ku9w|}@vpZJPg*#s86v-*O
zhafj(DL&&lF<A0)`tvC$E@WHJ2r~0{0ZCh1kHo$b9ih^aD*~)oVvK&yC1(yi)6x_y
zF8V3JpbIY^ZYQ&<Uk#j*ja0`;jw^J+5~!h3qc)ej%g1;Wb0U8cXSuLKdXkx2PUtB4
z>zqQ>O;r+6Qa<VFd?Z<kA#8Ch(&2p+QaoKR;K0{BU;l_DqGU2YCt6Fr4psgB*tPou
z8C@tnj=3DCqkffSLs=3Da-5G+h;Y8bkw<s-iIgT{$f^j!)l`hmkz}$nZPxBoPmwU;zIH^
zLN~K=3DbO>hGBes9{Fcqzh%Wj2h^{ZjI01*KI0RRX53ySR8{-GbgP@j*nP|DC3r#)Dp
z2P<&T`Q0~>LK@q=3Dho0q=3DMufLQlPWFqR35mR(rI(F6VS0oDeH{{JBhX`H?i{4>$Q*u
z&_I~xRn!+usmdp{rtX6{g@{eDP>MBoKG*I*d^QGyiP?Xlz51%C2er?Dt=3DV~1^&sxy
zetDYbNX(~=3DkPU(<3T*pC)6mLR)lRiRIK?piia9BQez}5M84jlVCxjJ&H-v~F$|l4w
ziha_;v%#nwK}ABv*)ke2v#@)oM~Wth^P23u1(H;3=3D$$}!Ax(JiL-t5A6>~P%VM4#0
zG=3D|5fS<`<4?)8@f$wTkOQ8JR~c0Yv{9#+1ba?u0;%q^?jemepqkdacyZmo)76UH}e
zM%)gY^8)T;PmuQJo!C4xgE?^b0Hp0dHB12&ZNJNKk+=3DZKW~dG8$<M>BnuM^iXx$c$
z7{10Z_BDH9{l>#E_hGGBoo)6dWGm^#{HemU0_lGM549PQT%l89fxI0yx5-Kzw$gBQ
z(_vbx%LD-Yvs7ORhmJ40qRG-g0K8w=3DATZ%9_0g#931r}y9~c4k>>)_qE$(i{l@Z)?
z-HbCjK>SGAglxQ)Yp|L98R>KeRMK#Jktf@InR{wDPi_K%GRBqLE7}dxUZTDx<>H-P
z_tAfoM5MDA%V+)%*3`(jzZT8wMhEtTabU%Q$C3aG1OU9|f1drO*;1H1hC~98s^<Qh
zJ{8<W8PsJ)aqw94tTzRfL$Rb{3fB#ePvvm_0B2QOZ;g>NsO0i;>=3D4vk?zi^EuGu~P
z6Y73N>2I%-u?Fv?XciKcv}R|3VxkOXTEBl8Hx)nff5}R%J@8^A^xY;yxt%Fm`7RbB
zMiVEj0529tKC~o7a%poQL}_zlZ*pX5VIVwYX>((5a%4bdcwudDY-KKPWpqA?0XPH`
z0RjLb1p-k_mPY~`0|pBT2nPcK1{DYb2?`4Y76JnS0v-VZ7k~f?2@qikE`_%uafyFe
zqX+v3=3Dl&Eo3sw9)UooXBOSKoH$k!o)x3CO5Z^@ElxGq=3D+xQGR&r@3$S<0@SUu@@Uu
zxUH%pD3Q-D`?37Vg*xmo<%+KD)(U~k>XU^b+=3D70VFr?b3DvlFq^B*d%lz=3Dlr!ch6n
zQbvcwWCD}n2DT3`r?RDkq=3D7r}qFsN{S>%(|Iv-_j02|bJ-^elx@jkwG=3D8vlcKFd>r
zcM8+9eP66QueaUSz6NhphD3O@E(iX7T@2kxV(dXdxG_$z;qqdh<Np6*{J!OD7<b;8
zM6otxRi0UUN|OngZ4NdYbeU0hneiVEwY2h5xZ4z{sXL4>UkGxJ?Pc}MK(c?g8tWF)
z2(SVG0G$Jv1W`<uM*#=3D`sXI><#Mh|Ll%uxJqK}<$c)VOU|M7H$nU~Bd&(!9WlLk)V
z)&z>UY~vSc_rVFe1JAY7ThlG1IzE9z6>ly;9W<IerW&+EU|2KpxZ$0rq-Jn9T{vsi
z6Qh0j42I3_PLQ5$)qa$}3etaqQytCyO!Cu%ZNnABQVid>0TM||zk);(8@JN=3Dfad9d
z4hK=3DHf1{&&J5DP=3D<J9wW0IGZ_*p$xvH=3DWZu8h1r#-&1Cjfqp9S1m|b%7<S$7Du_^=
G
zfwyFyObC4EMw~6<SwH1<W45gXD*OLAz9x~@tJ8<?^Jtn;2$K^0SUZ1w8So0CreLY(
z%lH6<oVLKXS8m<?1+xGV0RRC22mB4mS|I@6JkDfdjq>@0PopUU*HmnhWEQ1Zn|4r(
z9GSoTgp!+A)nPv6r8B9{T^D^-|BnxB{mbG$(^CGu2K<a9i|8Ws3;As@;!<zuS!$iv
z29IFy#=3DssBbfd3{kKcbeAxQSqtg}0L3p+T#HP*}B0Aw|t?fC~{D;t7`)z-+$L&n%Z
z_M36)TxVi(5kG{bkVKh5$EgnbZ8)lo-<8j)H8@#p5FEykPnIF60ER?1=3DeiWF7zKOi
zdI}!qcpvZT^<N<rtS**b*Uj#8grb70U$O|>8`J7JzzI64FAjfq0ZGU=3Ds`^$G;3P~9
z(R=3DKHJx6vNd3{)4(><-E1Td4?1OUatS$RONQUKrzEb0;m>?=3D9CcP<9};$2%xy_?!>
z9-#GIV%_bM#N+3aOII<H(qb9GjdW@m4?!)185PspjMros2;fAlQggqL_@Y;x9pNEO
zq*4B1MHw1?kz{}K*a*MO+LU*2{`fW&d&oGMR0-&l^w)*qzJzCJC)4r4{bk(*0NWBT
zy%rhRpK)3iC=3DX*4m|BI+EJ$vMX7dhnw(M~x;Rd3_o)?a8Mymw>fcrQlmZBf}#=3D>gL
z3|=3D=3DC=3DV_;x+hN?EQChz2a<mI4)>k6@_qv1p=3DKLj4k9>c0k87cVv^tWe8;DI7nm=
}?0
zf>hOGoe5#N567YGQ6Cg$o@X21$j<}&1RU^%Y_NtoAbuSKO2__If2C;^fB2viTOml8
zqZbjENa<ld%X3WIbHu0~*ke8Qp<WWRV(|kDmLLHkGS$Od7{v*2Y_0%_@F585<AGAa
z6C@*Y5=3Deh}+rL<c(*RW^OzD>69&A7!vDQ@2P~2r@U+LvZ4@Y5V5c&>*yIwtJ^*B_C
z0Urby0RjLC1p-k_mPY~`3;+rV5Mc=3D}g|{MciR^I*0LA1n{v0`JrvmHmaVfVdlHi8r
zqLbHhetm3X@&@IrXeh6;re%LlP-QWig+n`!Ae4U-@lxBH8%vZpNgGZJY>u4qtVm}Q
zj%1?p=3D5*6bEqcz{gn2IBiSf%lm^DyQau7lg)pfK8(7<}-iih0<Mm(k9C_6rNl4sE(
z`#Aa}K2LGjw*;6_qt%Wq<wPe#N15ysVyQhrRmcBJ^&Q!GEW&Mp#@%c+q~S#5UAR4_
zeeP74C?qtU)w9ReoQ00`jNPwq@T^ugCiN5Ti{<+Z4IyT&yx}t&F6RX0yYXc)&KtB~
ml*=3DnGq9`cf<aD`r9*zs=3DxM)EjeiKg!$s4>o369jT0ssIhKC9;d

delta 7
OcmbOxdzEv;RTcmY+5;N^

diff --git a/t/lib-gpg/trustdb.gpg b/t/lib-gpg/trustdb.gpg
index abace962b8bf84be688a6f27e4ebd0ee7052f210..4879ae9a84650a93a4d15bd=
6560c5d1b89eb4c2f 100644
GIT binary patch
delta 133
zcmZqRy1*sEm|l?1%*@Ej$i%=3D9=3Dre5@0|Nu&L_y(=3D>YJDu6*k{umSl_t3LyXw!<Bt=
X
zhEkV><>GE>E=3DlCnYu&C?*vSl0pomb%%dj-dsEA)Mq*Svt$mH(j_twWhW_@KtD1fp6
DE~Fa=3D

delta 52
zcmcb>)xagdm|l?1%*@Ej$iTqhmVVlAqM`Uk^-atZ9rz~(oS3|U#hLd&3{VON0Ad;p
ADF6Tf

diff --git a/t/t7612-merge-verify-signatures.sh b/t/t7612-merge-verify-=
signatures.sh
new file mode 100755
index 0000000..47a4f80
--- /dev/null
+++ b/t/t7612-merge-verify-signatures.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+
+test_description=3D'merge signature verification tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+test_expect_success GPG 'create signed commits' '
+	echo 1 >file && git add file &&
+	test_tick && git commit -m initial &&
+	git tag initial &&
+
+	git checkout -b side-signed &&
+	echo 3 >elif && git add elif &&
+	test_tick && git commit -S -m "signed on side" &&
+	git checkout initial &&
+
+	git checkout -b side-unsigned &&
+	echo 3 >foo && git add foo &&
+	test_tick && git commit -m "unsigned on side" &&
+	git checkout initial &&
+
+	git checkout -b side-bad &&
+	echo 3 >bar && git add bar &&
+	test_tick && git commit -S -m "bad on side" &&
+	git cat-file commit side-bad >raw &&
+	sed -e "s/bad/forged bad/" raw >forged &&
+	git hash-object -w -t commit forged >forged.commit &&
+	git checkout initial &&
+
+	git checkout -b side-untrusted &&
+	echo 3 >baz && git add baz &&
+	test_tick && git commit -SB7227189 -m "untrusted on side"
+
+	git checkout master
+'
+
+test_expect_success GPG 'merge unsigned commit with verification' '
+	test_must_fail git merge --ff-only --verify-signatures side-unsigned =
2> mergeerror &&
+	grep "does not have a GPG signature" mergeerror
+'
+
+test_expect_success GPG 'merge commit with bad signature with verifica=
tion' '
+	test_must_fail git merge --ff-only --verify-signatures $(cat forged.c=
ommit) 2> mergeerror &&
+	grep "has a bad GPG signature" mergeerror
+'
+
+test_expect_success GPG 'merge  commit with untrusted signature with v=
erification' '
+	test_must_fail git merge --ff-only --verify-signatures side-untrusted=
 2> mergeerror &&
+	grep "from an untrusted key" mergeerror
+'
+
+test_expect_success GPG 'merge signed commit with verification' '
+	git merge -v --ff-only --verify-signatures side-signed > mergeoutput =
&&
+	grep "has a good GPG signature" mergeoutput
+'
+
+test_expect_success GPG 'merge commit with bad signature without verif=
ication' '
+	git merge $(cat forged.commit)
+'
+
+test_done
--=20
1.8.1.5
