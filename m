From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 4/5] Test the format version upgrade code
Date: Sat, 19 May 2007 02:10:07 +0200
Message-ID: <20070519001007.4906.25065.stgit@yoghurt>
References: <20070519000451.4906.87089.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 02:10:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpCWd-0002J4-VK
	for gcvg-git@gmane.org; Sat, 19 May 2007 02:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057AbXESAKS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 May 2007 20:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755323AbXESAKR
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 20:10:17 -0400
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:59791 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755057AbXESAKN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 20:10:13 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:54513 helo=yoghurt)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HpCWP-00024j-9O; Sat, 19 May 2007 02:10:11 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HpCWN-0001KX-9A; Sat, 19 May 2007 02:10:07 +0200
In-Reply-To: <20070519000451.4906.87089.stgit@yoghurt>
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HpCWP-00024j-9O.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1HpCWP-00024j-9O e945246171e6835a57f8b222a22051d1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47689>

This test contains tarballs of repositories created with older
versions of StGIT. It also contains the script used to generate them,
but at some point we will lose the ability to easily run old versions
-- for example, if git changes incompatibly -- so tarballs will be the
only practical option for sufficiently old versions.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 t/t4000-upgrade.sh           |   40 ++++++++++++++++++++++++
 t/t4000-upgrade/.gitignore   |    4 ++
 t/t4000-upgrade/0.12.tar.gz  |  Bin
 t/t4000-upgrade/0.8.tar.gz   |  Bin
 t/t4000-upgrade/make-repo.sh |   71 ++++++++++++++++++++++++++++++++++=
++++++++
 5 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/t/t4000-upgrade.sh b/t/t4000-upgrade.sh
new file mode 100755
index 0000000..8a308fb
--- /dev/null
+++ b/t/t4000-upgrade.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Karl Hasselstr=C3=B6m
+#
+
+test_description=3D'Make sure that we can use old StGIT repositories'
+
+. ./test-lib.sh
+
+for ver in 0.12 0.8; do
+
+    tar zxf ../t4000-upgrade/$ver.tar.gz
+    cd $ver
+
+    test_expect_success \
+        "v$ver: Check the list of applied and unapplied patches" '
+        [ "$(echo $(stg applied))" =3D "p0 p1 p2" ] &&
+        [ "$(echo $(stg unapplied))" =3D "p3 p4" ]
+    '
+
+    test_expect_success \
+        "v$ver: Make sure the 'description' file is no longer there" '
+        [ ! -e .git/patches/master/description ] &&
+        [ "$(echo $(git config branch.master.description))" =3D "cool =
branch" ]
+    '
+
+    test_expect_success \
+        "v$ver: Make sure the 'current' file is no longer there" '
+        [ ! -e .git/patches/master/current ]
+    '
+
+    test_expect_success \
+        "v$ver: Make sure the base ref is no longer there" '
+        ! git show-ref --verify --quiet refs/bases/master
+    '
+
+    cd ..
+done
+
+test_done
diff --git a/t/t4000-upgrade/.gitignore b/t/t4000-upgrade/.gitignore
new file mode 100644
index 0000000..d412eb6
--- /dev/null
+++ b/t/t4000-upgrade/.gitignore
@@ -0,0 +1,4 @@
+/stgit-0.8
+/stgit-0.12
+/0.8
+/0.12
diff --git a/t/t4000-upgrade/0.12.tar.gz b/t/t4000-upgrade/0.12.tar.gz
new file mode 100644
index 0000000000000000000000000000000000000000..b183fcb1983eaa11c1a2eba=
3f0bb47b5c1c845c8
GIT binary patch
literal 11077
zc${r`WmFu|(k&7^NN{%z1or@g1b3I<5InfsAVGo+1b0gyIKeFpE+IGscX#(;`X%>%
z>#c9S_4;2|*Qs5#Yu8!lG)*iz!oV9fIRxZm6V*5dMLlY|&}~9|;}EPUQhgrXYVXB|
zJ(YHca{u!7y;2|V;F*<PyV8nwW?sI!oRr*yVHN$x=3D61Xa6dVr(99qsC1UkAC3_3T2
z&orULp@}U8slq>UUXgs2UH0XopU#9=3D<Wo0eIb4qFERDtaa&7hpaCQ2=3DvS-KEb?m%#
zP(-XVdK0Kym8KOqx-X#1Bd{`|qTKDSr#xrIP^G`jsn#o8_=3D>KE%IBbUhqDa;QV1!5
zfu#HnX@-`|`-&K6vYq>yu*(Zb1__j$p=3DI&@h#OvBUGdLYG5{U<-tNiX(grw2I;3tv
zF|*#ngUDGpjPhR6PID7Oz{<Jg;FWiPe%hZfk9|i8c+*}++o~YPY<(^<tk@9K(dT82
z74PT;e~Cd_g~7*zHVUID_Chv5eSh*&s%v%=3D8hK&HH_8kD2enqh)4uy)ws!^9O8}JY
zPVdc*U^Q0{YZ|{Ez(m`=3DC9{H=3DQ*Knf4om0xOAhu*^2K?lzSY$eX?vtIY<obqqBa~<
z@Oj$g_T@SL#Tswwzo5i%&<w;hYgBzRfP$QmYY>d$3BSip<3%wGf(scrw8G6W8b6Lq
zzo(k}pmMW_sjDN)w^aR6^y9Y=3D`#RHN{jQlNV}MXH=3DOrM=3DCHDA>xB3`(Gy3`&%+$B=
o
zW^<TzxJcc|>c}QnF<X>Z)>x)!L99nKIK{8Z^$gfdp}=3Dc6Wd~AWYj{^s(?{U-P@`zV
zn3Fya(da}&f@RjnTzjfg8LxQW!P%Q8%jU`{z=3Dhdl8>q+!uz7%VI27OAaPY$O+lpp}
zbEAFx?7@6fRY2B?`)tDOq*r_K{+s&izZH|*Lz@W6xcC5yZ$M4huV<h}=3Dx>ZU!T$ts
zXpCzb70o*MA=3DucFc6t!$u-Np?i+|3%t&}ut)!FYGu%^=3D11>Afa^38mJ>i)~{gOa>k
z*#YZsL{f8YndXdBql6RB@8#LlAElyQ4G#WG#Oyfmh6l+0hetR!tGcMkI=3Dw_bOE}{3
z{o{VgpQ-nGj?Ev{!^azP02fx1bznft+IRu5fHx}vW+<&V^_0C+R5nK?AKs&Ws~+SS
zEr^-3Z~PeBT3+7P@SlPnfW}eaZ}3mQ6Xcd`mX5e*1-$Z5byVg&7jv5`MBeo3sA3^W
zR{ZmA1(sf6r-5(NM_Q&H)ZsA5;_H0C0Apus4ZC+s{|e!LcF=3D6+3AA$$_0OUPi;`Z;
zQKAez-?NXy%Hptg!5J2R6*n;g103v5Zc0wjMqAjc6dkQWw8vy8xc+ekB8l^#VN%jx
z61#q{Qzm~Mi6*#x3YJD7`63Z(<=3D>|u4Kb8Fe&srJ66LEo&q65tE9mg9t_PcQUsEV~
z0y|2a<SWvMHt66B?aOVKdR9hm&S7rm8Dv@|m@xHY_p4e0-Xd4L2Y!n!=3D6h->9DW5$
zC+D0`;nI#2jOqJ>Lq&5~>Y1^!nOH<vR3pOv!Ca0UgqYv4l@!~8f49yk(mZlVSV`?8
zctm0lJ1A&{hsX@O=3D_eTSQYv7?63~MfW^a7XK%yN!fYhO*H0`5dYR5&SjuiDCu@Sg>
zwY(atE1ukx9x+(*3?gY}M65B{2g(bZN?>MOcYyx8k#q1lzB`E+CTy76ZCZWAH3|n=3D
z&d!tnxSqDm0|)Vh58odqE{dz8-o{U7LO$-+S9Hc1N8Dv8)zPBVfWUdR+0ULp?6{qb
z&>9*nY?~d*pCW6Lu5md5!pvZg%3}%l4v_dxaB9&V_DB=3D#Y3mb2prfwVmBkZw48Gj|
z38AK3h2GspL58sKWv+HYoccyf(X!*Keuf)aIsO#s4#=3DkbKH4pZJx?X;B)QFHsTI_Q
zQ(1wRI`i7^B8<C~q6aPbqYK0=3D%~v=3Do??c*FG$oQ-RCwN5!J=3D(Do($B_pi*y`vvy$=
{
zUnoyaz>a~4Lsx-P4&&O2^xh0_Vc5TKNbc&uO3SbA+a^@ir+8rLfwG8A(CZ94e)%nw
zipW{D+><$oYOZDa0*p71`NXL{fO4-sU3vjcurK(#+k|kE06e1MQE%yoV)2v}#XKp|
zrB-W&aB>XF)mPH7BbK&%@tjfQ&E)kvh_jA>-cYO!cRyavbFfLH5&&gx<A76i!BiL|
z-K`~at<aIqMdF?r<K+6V7<l6lr*do2Gg^8(Rlh`|ULfoq-+z!s+#D*OK8fONy@?}q
zs>75D<4VT+5Tjf>6eC%CjAm*O8DB9K2gs|8&7CWManpp$^VnR0cJ82+pE!?zb&F0R
z`cgLh0&n5%xf3U*6mAmIkTp2XD8kPv6&(NgL=3DQFQQiJaq!>xY`1jd2%mjKr#*o4pK
z9IQP1Z<OCm1LNb!C>z4qgyXxO1&2EfT}S{L^#}yP-W?eZ34m(~9mJz|;jdj4ri*o+
zpgH%c4Wos4^_Vj-)6@@HsYy!=3D;6=3DZFVBRGgVx`0fDHKgmiE?21OGO*j5Jb8TpIPjw
zwM)Dp>oO3ls$Yw(pP>lj*l(q2DUi&%w@73er4D|%g@A&WC%y<pu8K5|euT__ep!oM
zo5@kiaKF0rbQj$;=3DeeNBM|$gzZ^xSW+JM}DXP9-JED7x$9O1PH;n((#FMa+z$*&!^
zdz;rf@6M+o)E!V&wLx*RuT;e^TB9xchSq2p8TP5dyKP?8;HZW>2rCIIR4aVw&%ob)
z)2D*%jq?=3Di1M5-`Tx1BQnY5NEcT&z%H&s9;zVU_2(@Q?TGQ8`tSf^f`VQPQ3FwE7P
zXgR<G4Vw@^3K0M8Y=3DK#xwKmwNffqA=3DF~Qt*nYg!-r%coWZ4F+enw9-Qt`l_RDqk*H
zBWO0Bt<hU&KodtO`glJ1vzbPWcD5=3DUVf%NxR42-9w<;Y@q0|L8^?d?O*hOqv3QI*3
ziQc%2%6F-VSlc2u4}WZNaz|Uu@Zo1#E}cYP^(YkG;u(9j?}By1M49C+%%p0>lpYIe
z%AfU331#yyz}@Oy+Cpo~TiAm*w`O8HB`hNusNY6M2lV3SN0Ggr`&&GY`u~*Mn<3qD
z4ByNIKK^<CPQuqWmU4Mf%++N!%kSePwQ2g0wPp~n_ST=3DOR#_gBfQr_ZhH31l@N03~
zAiSE`snp+$LKPnL@<ef0wP|`{>@#40JeQ<jFR@-}bI15vWF5#+MipA~RE#byLDrU+
zg0uphb4Oh%QD4ROu41?z*6*XsxUSy>vSjZ1=3D#gs00of=3Ddi%Ei=3DX>1FrQ(`a@9vJx=
q
z(=3DTBXpe)8FWBPuad*lktUZ@E35u%Kve<xx+UG@q)GCuI{#M8AZuNDW9f6`DQe|eHe
z<Kx4Vp=3DigpxjoOh_A+dp_SWmqoU5(8@&<||&)Py2ai>+VNkvJt^zsvBvA5Xa5?vn#
zw-h8iVceoFoe}L5!l1EUP_BMCl4xR|=3DB$6{&B@YeRhG`eLehCeuTsQuCEYPXOK1kx
zE(NiyOh^-516Pj;E$gV|A?^ATw^)B&#;H3QQFrPVS<g58Nz@QyUwL7yP5pP)A;L0{
zXlBHrpEL~g&-+2|M2lzxJL7pz2if>=3Dx#tz$DRy?V9<HVpWJU$MvP!t0xbmZAMG<{}
z>72z_yuxiBC=3Dv8JCN$xbsRRuq9QLtAxVs_?XV@3aQS}MWC)monpaP=3D~VgM5B=3DHxG=
5
zXfiC<j|!LURL5*S>Z88=3DsWL(98o}m)7xs%HkQ*z=3DHsl_2YNEh7d`hfKl9G!=3DgSV2=
e
z1xa%!dZ)KQNVE?#>M+H9pv^anZ20kN#(La!3D10FFXC`9>`-L1EbqNvA(bUdeV53z
zXE}U%%){P~A!2@9gg1jsL=3D)9G;wt;CX9G#-1!TyTmZdQ6v!+GELV>=3DiL)YsbS#6dt
zuen1ul@_^=3D_ag=3DjHO!q0QYpLi@pMbY5uF-=3D^%b+gO0fmSn!7Cqont*cBoZ-8*>oS=
#
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
Ty3
zY)y;#55Ns4=3DNS662AE(3b%5`Jd>?r31D>0~j|*qdi!QKfq0=3D(Z!x(O`&Qo&!Q}5Cp
zaN{zRK4=3DE(R)79OGkXoDfIr%TpPvDEl$jqa9k}d;KC0b^!vCznVM4${%iT{f1pEgM
zX#@p45;Ssk!t!pP!0<cpV>SrBa0cr?>%1ETX{Up)WlDkEMuI)inFMToWN{1#ynO~9
zXMOU6?$Dx6!l6&63!uC>c=3D}Ji(Ae_Br~9t&=3D+PmYVFn49s9~OW0fXFFwRn9f8U%B1
z@5W@~REfI-XJ&Zk^gV=3D{<(V4YKPY1J^@U1GT5IF!5H@Rh(Cui><h_j(CoVE39KYt>
zTiSb}%C|?k3kKV^?)i+Z0BX>42ll%a!Ci64v8c}nrC*WB7$q{!WP9<R0S2NT_*A0b
z2Tq(kb=3D^1ue3pa=3D(m;=3DwNAbhm?CArIO{*~7cun~VsQ?GZyxb#kw8lqR;AJ<;x7`u=
c
z+e0pz^}4q~7cDvgfgU69Vk{%b+Ya~J{SGs(QKe;@ktHM7m4UAwy86j{RJn3zt4=3D;o
zKOMi-<1*uvlZ9UoRH=3DJ;b4YYLIJ+h>cX|%aBr6Ai?!C`9lJ_wFT<%r{c(Zvse|wUt
zHc)GCdyZ^OeYh=3Db=3D?y*9MuTEKiHI;_gHqB~SiE<`J9y37rRTU-TX~Aketj`HutI8o
z59R6c4Q{?k&S@T9a<hnZ%KGdAko&owwJHmCb_dOWbg>(P^>ZRRC3;1*+|bm6wt3}|
z{6z^%iCHNxO_YeN?G>|rYIm0ORb?ppXp5#=3DKCmbmKW>u{5iPJ=3D>CiRNbe58niug3y
zvt&})<oeDH6}e7Lt*E&4|F%+0L4MfpQvaEJ3(Iu7j+j_}NQRy|@UPL0{HdHHH8jss
zbZT5KkNuF%Ci8oQMz4nSYnG!CF%b_xt8<W&^K#{I{kQ|peXfWOp~$>U@QeozPZXpl
zoxo#L-&mzh;oU=3Dn+1Qr&sGHv{<`XNY(ka(qvGIpyVk6Tk>`{E0Gvc%NelaAv+e@a?
z1gArL!ZAsH+DTIZg(s`n*(M1(X%<8*Acr4))@x!P{O$r!f^{(mgVJrz#7>HhCfrm=3D
z-1G0kMive{Y;m#@+s#dDeE0HyqW;!1eLZhKHGR_%K3x6ji?%a`>hjbvj=3D0*}wWraj
z4{NriIqcP0mY<m`>wwCeU_q|JW7Hojyw2XGExjaTd*W)8Ld}n`lKeR)h?t-Qn-F|U
zYj259VtG&OW+_;k<<qFvnow5Y!eE7*#PZR3-Fd~**)5A`$vaN=3D@{XOcI52tkwR>d>
zUG9{&hZdheW+qCRh=3D{$48#A+9N#84`)B`3a`<Tiiuy}mD7t6v=3DH$6uOXmW&nhqy)s
zVkzfaEEn6$pMMr{Z*rFRRFb}t=3Dm}gXB#sxwunVka%dc^qEH)WuUad~NaM)QGD~_R0
z5VpDh_B*~A<G1P3H<@E0dE7g9Hfj2qYU@priil)A(wf~tRiCETb@)+@-=3D@Ah>*&{`
z(@!bmZ)cC&yvtm-!po-LuUzLtdkST9nE8*}9lOI%oEx)<@20t+@lRF`nAtz?Y<6-!
zqI@&^sM)a0+djD1zv@y0V|Lx%kqz?K&CYq~x7CS<9Y2=3D;QD)!rjx$Q1TJx(s(Sa2N
z_5qzq#o~3#?#eOTXlQk$!>ZcbrFjaYzYjJNceJw7jJ{f2@=3D<wcpHL00m#!(?sqrRb
z{aHC}_C5X9?0k9bB5{tTV$klgws(bF7aEMAru-`IR%uoFr3z!9!dZ8V(B}ym4Qn84
zY;8xi?>3j*t>@~Q*YF4#EpF+7qxT~*Rf?BagMHB4zHBPcPA`E+<TlT^TRj<D9RdY2
z%D@!Lhf^FLQpR%CS6UzDD}f=3D0y_?g)@X|n<$9=3DL_vK!R9)L0+OqpM^U6%jqe*fD_D
z^bQq4f@{G?{Rqn}uP3S1jgzdmUbn{@eb65P^R_P92d<6#n*j%eA|5@vJ<8R0qenLW
zVtI-BC>a6oi11VMc2AleVmJp_7T&p8j@?s^7Yn8$!r#ZD=3DZoA{*F`;5j_s3=3DE>>tb
z@t4NLm&gzU+0PoI5nY$`$pV2jUt_GJ`iWADbBjjsX_jk-EZ&b&X#C;y^VAy{d$Z+q
zVSVODLCL_3npMi!RJL$$3jK=3DjJQ<=3D;x=3DKFY@C9<-989)uyJITgJFs)r_aa#}05EX=
x
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
Hi12>^a3NeI

literal 0
Hc$@<O00001

diff --git a/t/t4000-upgrade/0.8.tar.gz b/t/t4000-upgrade/0.8.tar.gz
new file mode 100644
index 0000000000000000000000000000000000000000..7a7d3c2f8d916dc79c55f0f=
0b2426005224aca97
GIT binary patch
literal 8224
zc$@(sAm85~iwFS1Elx%N1MFN2lpED~cFLpGKu-enP)bR-)(Wq*)<_yX_rb2cegMY!
zQ9pRtyIzk*ccke`Gh$}6Yhf=3D<z=3DRY?Q)tts#n3>Sl7vE%HZ(v_9+({3gcj4&LLn!I
zK-v^eo0HQMl2Xz~`v3Rdkw((4*CxAi3cAN@jb`rs?|=3DW-{qBG7C=3DnZsuUO`ifRf8(
z@KecU68=3DxGtWXl!WGbD^<`PM`pG!k^l38xXu+$t^wFy}<T~d!*Z?Wh9PfG&yA1fN}
zavH%&>t9Kvlx$D`-6#$H+f;X!$p}tH|Jhs)^sgjyiJtzuQCjt1qH1C3t>EPSA1;-i
z{<~4;(|<*ETxu_2A5gOC^uqejC~f*rWiqK1B(ZcXEL`5<`lpJTNy2=3Dqr_+OJHJ7A=3D
z5QEdopq|t630lbH@&#HL(lqH*GukW5Qd<4rRg2320#0uJ&tm*fCVTk5E2UNcdDWq(
zcK+x1FPX~r^xu^-pZ-tf{Ll5D%D_i&{_jFb<Ur~PT}>;gLYfW@Wpe3sLZhmhE)3@N
zp&UL_b5!Zg|8LLI@c+E6np$ZYqW@c({}rVd|GQEe`Y&15^fD!YPG0{?8rOe4{V#uM
z)4y7+mg`m3)k<>3DK1qXi_HJooYJQMbSl+b|97SIt&HalGwzh6KB<q4n}i-vE7dY3
zXb;5EY@_ND*CH@AXw$?kQKDIuis6#7RU{SaIBJm+SDmIN$=3D88G(}0L>TNR=3DLMY*CH
zWv_CKb+oJG^-!{E<pT5yBxen`L`=3D(+Z=3DkkCKre31A*v2olo*avGt458<9*mx)izX@
zHdrupf)rHKb&y@hwW>aDW2D)m;UI}}*_x#VtV#>e&^IuTqHdHuW}%X)=3D0PZK$#58z
zD5=3D1h`FE@c1E5;X#Y!<riV^TA*(u2mb!%10rH)JF10)!_eABL}4V!idXX72BqXo&T
zRZ;+H9Jf;Fpt3p`S{s~`hL;MDwfTRuw<V&_`Z&J-D`}YQTm3(k?&bfwQ<lR2!Ar<`
z@F?)7e4UxTsKXrEGAU8*Vy!|=3DH_9lOYK0O@XV>UF(A+JlE-9(bJdWu1-36lskXRsI
zoJ_O;D)YsQWsVkoWVeabKt7Ceo<eWfms%(gmFzT%CN0R8uFD|ZvH{|RXIRlE{+-*_
zjfTP?dNKpnj1gpf_pU3p?U>rMVdK_a<PdRyec2@aPJG`)I5sdg5s3|i;w`j?$%GQG
z_D6tR(WX@*U+<9Mz7UWOLR3<M<j^5PwUPy2*uAkac3WcM97g6@j)u{nI;2pmmJJQX
z-Z=3DyZ#?8WFFi1v$Oqli9zpss<e$lZMAdY3bFpipOTu)@p8xbY_@qK$qU~)jg|Ko-J
z2;=3Di0L{nsSY*mtMI6fZ%W=3D)DTC%qHbxNY&jYB`?wE@2;w;J;+59sj4WdN2NWp`2L!
z$LI_muJItxL##@inx;Vr(re{L;KW)LweVI$;V{{1!6UQyPISdnQs(pjTD1VtatZrb
z#Q#%DuIK-!sGKPNtHS)O+JNLpRn?{;2*7vCF<i^86Wy{&%>hU^Lv0{Zs8#aBwN=3Dxp
z!kq2Al~8~<GN_d*R)MTOKzv3Sgdo9|Nr*D}Em&mP(6MZoy44FCCtKS6-=3D=3DbN3BOc*
zESCRCq&xCI$=3D?1?SIUX{KX{m-*U79v0&3o>vHN*%CFIfq5CFgZ8O;DKYbFQXhWB%v
zOpd>jKa+DxgVsF$ztr%5G5=3D2`(;fIfol$!J-;J`A{(t;DkZCp2Ku%{)2b!LE1X#fT
zfyUBD0Fm5)e@@vbmfUik04y<d14hZ>+qhY<=3D`7g-SjRH^9kQL;I@MgV9YY|B<SNWF
zkh)bPhUwZ?p{7wU=3D$RH~y=3DExFC8Lakn=3DKg-WB_Baw9a_h@ltOHvS8$fSpWg5u3?$=
Y
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
w
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
?
zarNDr#6g@nNMC$o`&WmTjbH2W@%u+2f@qJt`8oC6{b$xxe(s%>*OOSc_SELO?yo-%
za$7fntIzgrJ33U(SZrK`UCa)tsm6MgJT5xRl^a`-IWTwjtc3#$PF)UKKl+#aJip8s
z?)s)Z_1=3DN8895Vs*YvHuR{rSx!u{j=3Dao4L#gNL6O5`8_kBtJ6h7{2{(-FBZ`&fNV_
z5m=3DB_lzjMKccP|z?Y(fl>59C*D|cO8y}7UZ{n4){-R!ULSzF<EcHY&Cm7Iy`{ayC;
z^#v!-g^yV=3DU}x&o3&r289REQ}gOMpO)^4uw2#7hX&OTs_@QlJG|K#$uk7oV93)TTW
z!~75b0`orzXu19Q@t^Y+0@!^1)9m>_%?}A-{D*));EvDr!KqwrhbH~=3Dr!Bdv3|soA
zEZ2W?-39o6NJwH0VJ)mu7Q0#iBAWCs>}qpO8MfB{(U#}GlQP)<fre@PMuF-4cB;np
zAN<w{P0DOGDVg8vH&i(FE1pd->G@Mr`R!;@FD<{qcPMVqH0-a7H^ph<<N31-8a8Ys
zH{K@p-v-#GN&iodauIv|hY<gpRLBYN|4`7Z{e=3DO5Q@;j|`Tr#E|4}ro|3N})?axQ?
zFtU2*lwoW9Pm&h?KO<8>{0AhM38|Tsnkne4+b6B*e^#RNEPze@6PELTGLnJ$KO~rG
zshI)sw_94%zcaUk*zW%si}AmVGXS7}6zKRfjGmm6B6eK>^t7gbGvPcJ&~g8tmMP%*
zFA}V@zt)tJVoGpE8Mf@djI^}>+z;4)6xh4}8#;%!i52~)n9NQp!(sh1Gzrgtk)R}4
zTBFq|bcB+Y(JF>es8mXgj${~8OVflxqgUuutib^KZ<|=3Drztdbm+w(sP3;oLp8v1`E
zG(@RI^PdKOgS4i9-K?Y}Hqkjzz-{ZFwtW5r=3Df5EWp8T|LTJ8Tyapr#%+<SihM+WCV
zA;C)fi!%Qsw7-nI1MEKv!2fICSkb>I^FM<A8A<{1e~_Tlk}@r&QflQ2T1V&!1HtHJ
zD!qo#Dp-|PZqVy#xxqlvp#Qds75$4c|0C#MPEgSQBSDz|A;qo+AQG+WpAy;sgZ1A?
zu+skG`hOJIe-yy@uYF@h|6=3D-oGy&_skzj8S2he}p#ESmK_5Yy%M}px0QDRpE5Q$dx
zPmAUMHSGVD$szt960EepNd6xw_<ykf2MI9#Yu{MWzexTcDfoXd{zC%8GBT}3uF*3J
zos72x22!b2Dh-rg#WE_IBxNd!C1py`f7`^0{zdZtNWuSu{vQc~|3`~m4L~GX)juP$
z{|Ebjkzl3$#r6MS{|^#i{MWv*qJMGyKiL0^1dT?cBN&}du2d3omBK&}dX-8~X;~dh
z^39}^8Cb1cF9ZFzO|0l&T>lUHe<TS0A0u`(0Fh|YzcEqIS`Xv*>}A-{KiMq)3+Dhr
z|Br+S^|)|Mh@B^SH9EAIzt;GQVV)hZbnjyrwj>wB+;0jA3v4kSmb<}ZdXndaagmW2
z9|JFx#0lx}uC-rOmgQ9a(y!A&b5QUmCerhO2!ANhB2D^_H^sT+@OSK4;(w78%>SU_
z>Gp331mpZN9B6+b{s%?TG_*eoT4;YE5Rfy=3Da9IB|&CmZq`@5c2+h6blol}PO@gJ$6
znxFp<&;QUs*a>d$L6LYk9)m|2Q@Ae=3DK163qNN9LFf=3D$yTnB&<&+?8QCNh(w_N-3w6
zcnF`lmvA5cvN6$^V${SB2*cIFJ6!mU)b7&lJ<q_QYO0=3D8Q)+ka_HL_jq#6v-SPi>#
zw|8~dvsJ_H-0gkH;7~Ql#%kD|yS;Or&sGh)b9YIjP>t1aRR2%ef7b+oblm=3Dv3Ifi5
zKmyo*u>WBH!TvXd{ATr`ya(V48)NnP4^3Idf9J#w_8$fPg!tclv*W48lo?^TnPuZy
zJq{0i+XcM-|2K2*qB3mhpORVVpML@j`bWX<jfpHyNE=3D>A;RQ~F1poj50000000000
S0001J1N;{VbU3j97y$r>Aaw))

literal 0
Hc$@<O00001

diff --git a/t/t4000-upgrade/make-repo.sh b/t/t4000-upgrade/make-repo.s=
h
new file mode 100644
index 0000000..98b5020
--- /dev/null
+++ b/t/t4000-upgrade/make-repo.sh
@@ -0,0 +1,71 @@
+# This script makes several versions of a small test repository that
+# can be used for testing the format version upgrade code.
+
+LANG=3DC
+LC_ALL=3DC
+PAGER=3Dcat
+TZ=3DUTC
+export LANG LC_ALL PAGER TZ
+unset AUTHOR_DATE
+unset AUTHOR_EMAIL
+unset AUTHOR_NAME
+unset COMMIT_AUTHOR_EMAIL
+unset COMMIT_AUTHOR_NAME
+unset GIT_ALTERNATE_OBJECT_DIRECTORIES
+unset GIT_AUTHOR_DATE
+GIT_AUTHOR_EMAIL=3Dauthor@example.com
+GIT_AUTHOR_NAME=3D'A U Thor'
+unset GIT_COMMITTER_DATE
+GIT_COMMITTER_EMAIL=3Dcommitter@example.com
+GIT_COMMITTER_NAME=3D'C O Mitter'
+unset GIT_DIFF_OPTS
+unset GIT_DIR
+unset GIT_EXTERNAL_DIFF
+unset GIT_INDEX_FILE
+unset GIT_OBJECT_DIRECTORY
+unset SHA1_FILE_DIRECTORIES
+unset SHA1_FILE_DIRECTORY
+export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
+export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
+
+for ver in 0.12 0.8; do
+    if [ -e $ver.tar.gz ]; then continue; fi
+
+    # Get the required stgit version.
+    (
+        cd ../..
+        git archive --format=3Dtar --prefix=3Dstgit-$ver/ v$ver
+    ) | tar xf -
+
+    # Set up a repository.
+    mkdir $ver
+    cd $ver
+    git init
+    touch foo
+    git add foo
+    git commit -m 'Initial commit'
+
+    # Use the old stgit.
+    (
+        pwd
+        PATH=3D../stgit-$ver:$PATH
+
+        stg --version
+        stg init
+        echo 'cool branch' > .git/patches/master/description
+
+        for i in 0 1 2 3 4; do
+            stg new p$i -m "Patch $i"
+            echo "Line $i" >> foo
+            stg refresh
+        done
+        stg pop -n 2
+    )
+
+    # Reduce the number of small files.
+    git gc
+
+    # Make a tarball.
+    cd ..
+    tar zcf $ver.tar.gz $ver
+done
