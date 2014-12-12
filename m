From: Christian Hesse <mail@eworm.de>
Subject: [PATCH 3/3] replace binary keyrings with armored keys
Date: Fri, 12 Dec 2014 21:42:19 +0100
Message-ID: <1418416939-22171-1-git-send-email-mail@eworm.de>
References: <xmqq1to4d8bh.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, Christian Hesse <mail@eworm.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 21:42:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzX2v-000619-LO
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 21:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbaLLUmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 15:42:37 -0500
Received: from mx.mylinuxtime.de ([148.251.109.235]:52022 "EHLO
	mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932917AbaLLUmg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 15:42:36 -0500
Received: from leda.eworm.de (unknown [10.10.1.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id A2A7721FBD;
	Fri, 12 Dec 2014 21:42:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.9.2 mx.mylinuxtime.de A2A7721FBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
	t=1418416954; bh=rs+UFuRaZ7vZ6ZrzgSlqKqYANqIhKazUwupNt3LUkiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=czhwaf1rThKRKp+HnfnsU5o29dJNJEWSkwlx/Eyq9/D0KOI3U+S8vABM9+o3CIoZl
	 JChn7BWq/LpOir8ot9R78FNSiJKtdkKuqY+ksKCodiYX9LK0+HQw3ms/IGEqqZSJbz
	 fBhRN9+65NTaQW5Xb6k2pDSfejnVb8EuAjGvn/fA=
Received: by leda.eworm.de (Postfix, from userid 1000)
	id 3ABE010346A; Fri, 12 Dec 2014 21:42:29 +0100 (CET)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <xmqq1to4d8bh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261369>

Importing PGP key public and security ring works, but this is supposed
for runtime. As name suggests we prefer exported format for import.

The extra benefit is that we do not have all secret keys in one binary
blob and all public keys in another. Instead public and secret keys for
one key pair are bundled.

By using armored format (which is plain ASCII) we can just concatenate
the key pairs in one file. (First block is 0xCDDE430D, second block is
0xB7227189.) The individual key pairs can be added and/or removed with
simple text editor. Last but not least git and patch can handle this a
lot better.

Signed-off-by: Christian Hesse <mail@eworm.de>
---
 t/lib-gpg.sh          |   3 +-
 t/lib-gpg/keyring.gpg |  88 ++++++++++++++++++++++++++++++++++++++++++++++++++
 t/lib-gpg/pubring.gpg | Bin 2359 -> 0 bytes
 t/lib-gpg/secring.gpg | Bin 3734 -> 0 bytes
 4 files changed, 89 insertions(+), 2 deletions(-)
 create mode 100644 t/lib-gpg/keyring.gpg
 delete mode 100644 t/lib-gpg/pubring.gpg
 delete mode 100644 t/lib-gpg/secring.gpg

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index b0138ad..03c2dd3 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -21,8 +21,7 @@ else
                GNUPGHOME="$(pwd)/gpghome"
                export GNUPGHOME
                gpg --homedir "${GNUPGHOME}" --import \
-                       "$TEST_DIRECTORY"/lib-gpg/pubring.gpg \
-                       "$TEST_DIRECTORY"/lib-gpg/secring.gpg
+                       "$TEST_DIRECTORY"/lib-gpg/keyring.gpg
                gpg --homedir "${GNUPGHOME}" --import-ownertrust \
                        "$TEST_DIRECTORY"/lib-gpg/ownertrust
                test_set_prereq GPG
diff --git a/t/lib-gpg/keyring.gpg b/t/lib-gpg/keyring.gpg
new file mode 100644
index 0000000..fb1f048
--- /dev/null
+++ b/t/lib-gpg/keyring.gpg
@@ -0,0 +1,88 @@
+-----BEGIN PGP PRIVATE KEY BLOCK-----
+Version: GnuPG v1
+
+lQG7BEZnyykRBACzCPjIpTYNL7Y2tQqlEGTTDlvZcWNLjF5f7ZzuyOqNOidLUgFD
+36qch1LZLSZkShdR3Gae+bsolyjxrlFuFP0eXRPMtqK20aLw7WZvPFpEV1ThMne+
+PRJjYrvghWw3L0VVIAIZ8GXwrVBuU99uEjHEI0ojYloOvFc2jVPgSaoBvwCg48Tj
+fol2foSoJa7XUu9yAL8szg8D/RUsTzNF+I9hSRHl7MYKFMYoKEY9BDgrgAujp7YY
+8qdGsiUb0Ggyzp2kRjZFt4lpcvKhGfHn5GEjmtk+fRbD5qPfMqKFW+T0NPfYlYmL
+JJ4fs4qZ8Lx7x6iG6X51u+YNwsQuIGjMCC3CeNi3F7or651kkNYASbaQ1NROkCIN
+NudyA/0aasvoZUoNJAc2cP5Ifs6WhXMWLfMR2p2XbfKwKNYneec60usnSComcKqh
+sJVk0Gytvr3FOYVhRkXnKAbx+0W2urFP8OFVBTEKO6Ts2VygWGgneQYoHnqzwlUE
+yjOjlr+lyf7u2s/KAxpKA6jnttEdRZAmzWkhuox1wwAUkr27/QAAn3TEzKR1pxxR
++R3dHuFpnnfatMIDC5O0IkMgTyBNaXR0ZXIgPGNvbW1pdHRlckBleGFtcGxlLmNv
+bT6IXgQTEQIAHgUCRmfLKQIbAwYLCQgHAwIDFQIDAxYCAQIeAQIXgAAKCRATtvUe
+zd5DDXQdAKC92f+wOrTkbmPEf+u+qA/Gv6BxQwCfQ128JXCi3MpMB8tI2Kmo15tY
+gnmdAj0ERmfLThAIAM65eT9T6+gg0fJn+Qxhs3FFDPjxK6AOBS3SieWWmXO6stZZ
+plvb7r2+sXYp8HMHntnOX3TRPolIx1dsdkv3W3w8yUzf9Lmo2XMPsZ3/isWdEbOI
+A0rO3B1xwbQO7vEoWHeB7uyYIF6YsIH0pMqxkImciwB1tnJPB9OxqPHlD/HyyHr2
+voj6nmEGaPQWj8/dkfyenXm6XmNZUZL/slk6tRhNwv4cW3QQLh39nbiz9rqvZMKF
+XX8wkY4FdQkJjCGwqzG+7yJcyHvem29/iq//jRLZgdiN8BwV3MCTJyDp8/Wb/d9y
+jZcUm1RdtwRiwfhfQ+zmpyspm7OxINfH65rf7f8ABA0IALRiMRs/eOD59jrYXmPS
+ZQUbiALlbJJtuP2c9N3WZ5OgrhDiAW+SDIN+hgDynJ9b7C2dE3xNaud4zaXAAF44
+J4J0bAo2ZtZoJajw+GXwaZfh4Z7nPNHwEcbFD4/uXPCj9jPkcLOJqGmUY1aXdygo
+t3Hn5U/zo8JxPQ83YbJQhkzAOZ/HGowLNqKgGkLLHn1X9qay0CxlfTQeEN5RZyl3
+b4qRzGgGALFvoheyZIUw1TbjRpbn3kqlJooEQY02VwXFXfLI/LwzglilH6sSckvs
+0WHKLZ+0L6b3CgJHN2RsZ7QxwCBi1aemsvr65FeEXp/AYxaG5duUbsugG8PgoJ06
+bsEAAVQNQO3cXWpuiJ/nNLLnWuPunBKJUlurkBdf2GD+m+muF0VpwDchhqqbTO4e
+FqOISQQYEQIACQUCRmfLTgIbDAAKCRATtvUezd5DDcHsAKDQcoAtDWJFupVRqleB
+Cezx4Q2khACcCs+/LtE8Lb9hC+2cvr3uH5p82AI=
+=aEiU
+-----END PGP PRIVATE KEY BLOCK-----
+-----BEGIN PGP PRIVATE KEY BLOCK-----
+Version: GnuPG v1
+
+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
+=hieJ
+-----END PGP PRIVATE KEY BLOCK-----
diff --git a/t/lib-gpg/pubring.gpg b/t/lib-gpg/pubring.gpg
deleted file mode 100644
index 1a3c2d487c2fda9169751a3068fa51e853a1e519..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 2359
zcmYk+dpy(oAHebNE||IBWzo{b+(V5FmD>sBRzgB-b2$ggOmwlLCX+jdlu4Ugy0}c6
zOCb?b<WA)lvmBSUNy+t8=kfcU^WXdN`SbmGzTUYYI@C6>Q&R>CFkvh0MQ90q7WxUi
zNE+8C=`|9Lbx88@UC3K(|0~&4!@(6~HC~o?!*xV=FV0@c<wHRJ_j*(givQRpOnyVn
zTkbWB&g!A_76J%nr>)&jP8vovn9E}Q>nA87#`-pHNboiup7+Q(?8JDOtU=2z`(6I0
zC7-&ZlTS?8m4O<8f~l4%GW9(9dg-3WL$05RK%-8V6l6m|$H~ZMCDqSPhBN;XF8>mR
zvNeaAXkQg$l(3WqCAL+25O0GFyJ&^BXd5;)m?*fnjnAF-+jV=yB1ZAW3}f7oPVt)l
zvj5xgpVXVX^LH>4b9qlMwUx%tk|XP9B$`|FkU_6uy3NtUY^6HwIT|i)5U^vV_4hlb
zsY{@_M97B9@139U_7b~A(C0RflDo1g5sJD?GVf?Pp@It3pvDERY44oIQLVk_%I;PC
ziF+IJsNq@bL5iQP4HqTMU$bG=RXXt|-GmI_n8NvyGX)+&8W)67Y8RQ!ZqQdojO@mu
zj?Kk)-LD`j_K;F8t4Gx)ZSR}lopni(F97+BXZ0J^>Q+c6<ndq<2~R|tVF{t3zsAG(
zXur^NA$YwXFBS<tP&pYepe6+V`JG?{L|9A|CISIN6u=OOA{Yc#1A&#U0&r1jIo7h;
zn=va1k}7c5ZkFm<TjKJ`((uoT)i(3GS%U37prG+X_RD5(0@H?;pYj>|F&2f+I$Hq-
zAhlqLpI98FVL(^yg+nLiJ|TMqf#1dbnBg|!D}3z&Ng>@{DknQPqONMtv)JqX;<JXz
z^P0Q}k^GS^Us8_+^=O-W$a#lvUYE@}j*Wk*EggxFs-$ftw$fyn2@w0P531qMt0fot
zD37Sv#ra!EpIa5NUkYDUrcv{50+B4DlSp4>DW4<77qnme+K{lC?<XAeMKQH|G<`jv
zcA?G(>*<oQRpn{=MEQ90=5{ZVw4Uk)t%muvt{m4)@xHPzJw+%|R5WR4#RG$e&+2E|
zFOA(HTuCh7N|qgo9Zu$LSNPDBseznbTE4R}PE5{`zjM-?4fTJ%;%hZOQ=+YThgpdn
zYMZ+~zOV&AC160czX9S<^u+hCro%qiUc3+@0n7=>2(8)3`!YHhm|5^x`Xh*tA%2Y<
z4+!$^dd=(7<Srloog4k8s0r{f(TF33z|jGNL3>JhD|lXT&g5i1*Q|#p^RiVcb@2?3
z@zrSh9FtlaoP|A=6NN&t!?_%%B}Q|&xs<VAm2>>Drh|9eRFcHd^a2&jPPG{Kuf<hw
zb?`C!)uhK<0yU!uiRrI{gn>!|U8xF3**Acmvd!j>*%$3igdRyoy9>2?3)<J88pU}O
z?RX$dbeQk)d!>7~TEF-k9Q>OxE+nwppb6<eP*PmAx;pKC-REu-RxzIQJ}a!V0P$j?
zfMy!@Ji!jC{KK5+FLRDyg!q4XJ)Z{(Zg1OCKV@H$<Ld-$mc#AH+sId~0Ge{^r$%w&
zvpc!&5m>3TSMa#gN40<Q$^}V4U5;h{27&<{H`fCJU&CEwDK$-3Q6}b89|hy{Nxnm~
z{sz(*r)e>D(7;1LTwT&c>EXP(VTMc5AUiLw)RqQW)qA}e+Te#C{z>GnJ%N&DeZBHJ
zdaIgE1!DSYVH(UbUx~c*<dbc7DcYoF+0uJ140KL?XIr#<gt|;%ZH48<j9f3rPpI#6
zd6omm-DF){EoNsg@Ajnb3<=lios5xpHS^Y=Xc{u}-AdR)#~E5^oOXC7>9(;s{A3NX
z%^PK&Qm64ORzAI!o0BN~KJY*)slPU1?1sklrvItP7r!&0Ig+hfxlIQy<;5nqeY6yy
zEsdE(5-eb77wg+Tg-6MqVU$0XANbV*G9Um{z1xNu9D%eBj=&O#xL`k|8SbC)|KW$>
zNfuO)2~-XQ2GoVXKbQA!`N9e?uqa#%stAVsr+z<CJqlYroa(_4Srg%I${UNht(*B8
z6lpm;QDU?Y?Tlkrh+_yH8Q2;<50RP#q2iKS!t#`sH>^?#akA!7nK~-HTW_s$y@O&p
zzmJpncwrD8+xb@}W#@-Da`wK$ccoe>azRTwv>s<&HL`4W{@&$kd!q#h&YToxN$HnV
z6<sTg#qjCgJ)YB<1ExFhVF02(dc56GjBn9!ekSz+)S~l5Tok;I8RPp9Q_db8Y!D`#
zjJJ-i))U!`@fIJo^PfL*q{hIpd{W?_Kef5#zuv(4Lpf?J*SZpobIbR<WS=Q|D^wDV
zAmzH8&*krsd{QlNt$8nBdLNUd?+YWQEZ~=4AFg7n%qjN5e%-Wx(cQ;5DYOigc4skI
zUG!Aix#*{7jJNot>$y3vHM{#~vNDAoCkLU4H6c?<!QY;X)<L?T^m+B^7MfbbS}73p
z4y*3JZC0#OZFSbeh+i{FD=7>(XX0)0$ABCoW<@;y&7xyke&_%>s}bHCcS7~e#xX(P
zwa^y|Ew19@Y>=#-Lt~t^EP~zp{p!r@RY?(-vMUV6C5)r?;i>+m2%zjTYB;NF-I&&A
zsuE=rG=3r=GnTByhjIfKl+TZT)=F^pk7eWXkHIc;ZS!=eJP&aqv8+c>t+lO#4SUlE
zAN1Y$ycBfX1(qqh?t!_yjR&U}pS{oRTmi1<v6|TKVWS&D%wOoJpdC=<ADn(f{ST*K
zQU6cPd^ikfoi^CqelWNMJoh<VldY985znD#4iU*QAy|Ph=Rpvvys8*~#nBmWaGPR<
zNkwMK@m=5FK{#ZY*dZLnLQ?Yh503`QrQqm-8B(8v?!~Tm*DvUeQTd(bw+=YF5Tz}p
z2O_IsZ<{W15^sz`ZOw`%P#BBIjKCiCHIvod7Ea;AZ0Id##z2Y=$6CYcx7>L-|NG`g
z+}gGrmQ_chb(%wCUyg<xD4evO_O3B6j#<2g+P$APz-$}LqojOE8Z9UA9-cz)U6xz8
z$ypPV*ctHX>7)@tj|=70^YI2<i0ZRho!a_z6l!9cR2!w1BF3!=I)Wt2Il(#*Pcfn?
I{Xf<G4artTjQ{`u

diff --git a/t/lib-gpg/secring.gpg b/t/lib-gpg/secring.gpg
deleted file mode 100644
index 82dca8f80bf170fde5705862c3eeb9d994725042..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 3734
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
b1#l&j<67Nr^MulyK!({nR7ex2{s`<}t0L{v

-- 
2.2.0
