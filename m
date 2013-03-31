From: =?ISO-8859-1?Q?Sebastian_G=F6tte?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH v7 4/5] merge/pull Check for untrusted good GPG signatures
Date: Sun, 31 Mar 2013 16:33:57 +0200
Message-ID: <51584955.40007@physik.tu-berlin.de>
References: <20130331133332.GD2286@serenity.lan> <cover.1364738348.git.jaseg@physik-pool.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, trast@inf.ethz.ch, john@keeping.me.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 31 16:35:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMJLa-000876-HW
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 16:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251Ab3CaOee convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 10:34:34 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:54236 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755135Ab3CaOeb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 10:34:31 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-2) with esmtp 
	id 1UMJL1-0004MW-I1; Sun, 31 Mar 2013 16:34:30 +0200
Received: from [94.45.250.108] (unknown [94.45.250.108])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id 0CEEA11404;
	Sun, 31 Mar 2013 16:34:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <cover.1364738348.git.jaseg@physik-pool.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219625>

When --verify-signatures is specified, abort the merge in case a good
GPG signature from an untrusted key is encountered.

Signed-off-by: Sebastian G=F6tte <jaseg@physik-pool.tu-berlin.de>
---
 Documentation/merge-options.txt    |   4 ++--
 builtin/merge.c                    |   2 ++
 commit.c                           |  13 ++++++++-----
 commit.h                           |  10 +++++-----
 gpg-interface.h                    |   1 +
 t/lib-gpg/pubring.gpg              | Bin 1164 -> 2359 bytes
 t/lib-gpg/random_seed              | Bin 600 -> 600 bytes
 t/lib-gpg/secring.gpg              | Bin 1237 -> 3734 bytes
 t/lib-gpg/trustdb.gpg              | Bin 1280 -> 1360 bytes
 t/t7612-merge-verify-signatures.sh |   9 +++++++++
 10 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-opti=
ons.txt
index 31f1067..a0f022b 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -85,8 +85,8 @@ option can be used to override --squash.
=20
 --verify-signatures::
 --no-verify-signatures::
-	Verify that the commits being merged have good GPG signatures and abo=
rt the
-	merge in case they do not.
+	Verify that the commits being merged have good and trusted GPG signat=
ures
+	and abort the merge in case they do not.
=20
 --summary::
 --no-summary::
diff --git a/builtin/merge.c b/builtin/merge.c
index 7a33d03..752e3a9 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1248,6 +1248,8 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 			switch(signature_check.result){
 				case 'G':
 					break;
+				case 'U':
+					die(_("Commit %s has a good, untrusted GPG signature allegedly by=
 %s."), hex, signature_check.signer);
 				case 'B':
 					die(_("Commit %s has a bad GPG signature allegedly by %s."), hex,=
 signature_check.signer);
 				default: /* 'N' */
diff --git a/commit.c b/commit.c
index eda7f90..bb2d9ad 100644
--- a/commit.c
+++ b/commit.c
@@ -1029,6 +1029,8 @@ static struct {
 } sigcheck_gpg_status[] =3D {
 	{ 'G', "[GNUPG:] GOODSIG " },
 	{ 'B', "[GNUPG:] BADSIG " },
+	{ 'U', "[GNUPG:] TRUST_NEVER" },
+	{ 'U', "[GNUPG:] TRUST_UNDEFINED" },
 };
=20
 static void parse_gpg_output(struct signature_check *sigc)
@@ -1050,11 +1052,12 @@ static void parse_gpg_output(struct signature_c=
heck *sigc)
 			found +=3D strlen(sigcheck_gpg_status[i].check);
 		}
 		sigc->result =3D sigcheck_gpg_status[i].result;
-		sigc->key =3D xmemdupz(found, 16);
-		found +=3D 17;
-		next =3D strchrnul(found, '\n');
-		sigc->signer =3D xmemdupz(found, next - found);
-		break;
+		if (sigc->result !=3D 'U') {
+			sigc->key =3D xmemdupz(found, 16);
+			found +=3D 17;
+			next =3D strchrnul(found, '\n');
+			sigc->signer =3D xmemdupz(found, next - found);
+		}
 	}
 }
=20
diff --git a/commit.h b/commit.h
index 8bbcf13..27d9b36 100644
--- a/commit.h
+++ b/commit.h
@@ -232,11 +232,11 @@ extern void print_commit_list(struct commit_list =
*list,
 			      const char *format_last);
=20
 /*
- * Check the signature of the given commit. The result of the check is=
 stored in
- * sig->result, 'G' for a good signature, 'B' for a bad signature and =
'N'
- * for no signature at all.
- * This may allocate memory for sig->gpg_output, sig->gpg_status, sig-=
>signer
- * and sig->key.
+ * Check the signature of the given commit. The result of the check is=
 stored
+ * in sig->check_result, 'G' for a good signature, 'U' for a good sign=
ature
+ * from an untrusted signer, 'B' for a bad signature and 'N' for no si=
gnature
+ * at all.  This may allocate memory for sig->gpg_output, sig->gpg_sta=
tus,
+ * sig->signer and sig->key.
  */
 extern void check_commit_signature(const struct commit* commit, struct=
 signature_check *sigc);
=20
diff --git a/gpg-interface.h b/gpg-interface.h
index 5884aa4..a85cb5b 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -6,6 +6,7 @@ struct signature_check {
 	char *gpg_status;
 	char result; /* 0 (not checked),
 		      * N (checked but no further result),
+		      * U (untrusted good),
 		      * G (good)
 		      * B (bad) */
 	char *signer;
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
index 6ccfbf3..20b3cfb 100755
--- a/t/t7612-merge-verify-signatures.sh
+++ b/t/t7612-merge-verify-signatures.sh
@@ -27,6 +27,10 @@ test_expect_success GPG 'create signed commits' '
 	git hash-object -w -t commit forged >forged.commit &&
 	git checkout initial &&
=20
+	git checkout -b side-untrusted &&
+	echo 3 >baz && git add baz &&
+	test_tick && git commit -SB7227189 -m "untrusted on side"
+
 	git checkout master
 '
=20
@@ -40,6 +44,11 @@ test_expect_success GPG 'merge commit with bad signa=
ture with verification' '
 	test_i18ngrep "has a bad GPG signature" mergeerror
 '
=20
+test_expect_success GPG 'merge commit with untrusted signature with ve=
rification' '
+	test_must_fail git merge --ff-only --verify-signatures side-untrusted=
 2>mergeerror &&
+	test_i18ngrep "has a good, untrusted GPG signature" mergeerror
+'
+
 test_expect_success GPG 'merge signed commit with verification' '
 	git merge --verbose --ff-only --verify-signatures side-signed >mergeo=
utput &&
 	test_i18ngrep "has a good GPG signature" mergeoutput
--=20
1.8.1.5
