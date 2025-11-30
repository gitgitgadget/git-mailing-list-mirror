Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2262220F2A
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764503573; cv=none; b=M4iLICi8q4CoyLoUsmZNGmfJf2j+WxxjB22UYCeNHInkFQAU4ieWDQPj9KxvUa792+ufOLpd0PDucaQEmEyn6aYRCiaeYwoiBEmnfsVzGzEp4oXk9ebRFIqETHE+pCEPZshgCR9+PKKVmMXaPpCLA+O0+hK+oSCRFg3+E1zxYec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764503573; c=relaxed/simple;
	bh=pqIRee2LKIDpRjhDHNS2btxB0JdxeGyej2kk9ObG8vs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YDaJBSYCy1yvKZxLfaMJDyFWIIS4EKXJBdwRB3WiPwJsdmiaY3ss8mFQLw4IR6FgMeOQAv5bXRnPZJbXf6lIPjc4cWpFy6C18ErYqKw14/YlE/w0sUa3jawjsPtjTak9RneKTN3TSiOvpc/IasydIo6U1NdX9xjLd9fgemjpO3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=xBMqfw04; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="xBMqfw04"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764503563; x=1765108363; i=l.s.r@web.de;
	bh=A4lDqAfGhcKhOed7tvvKlnMa18YCFYb/R6tNHysBH+I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=xBMqfw04k/3rpuMgnGYNxgOiV7XGnTGWH+689JWNqcI2Rv4W1wNqHzpbwtXlgOKt
	 d9mv6eM77fo2ahTt3bvxkxqBXQLgslLsx2ARHtqntBPlA7tNMbgDsnlYsZ0InpX4f
	 XtKVgD2ve5am9xRjn68BLrQ9pq2L3KuvApz5Lb9GH8p/BTd/G9p6w2tjKbOuvFKQo
	 CI9IHUqQOFQer06t7GrpmJ2lGqbE37ODQFtkRsQSWIXwW7/y0Rp+IQ2ov3SpXq+8Q
	 SRgiyQfRlFq4rYE6zrfFeytWhm9Ub2/vj/Bw5ItkPBMqq4dgP/jZWPnJevpJfmzcD
	 uQcFXSyQmpKNV9PyJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.23.3]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqZQS-1vuaoQ17VQ-00pqQG; Sun, 30
 Nov 2025 12:47:18 +0100
Message-ID: <aa28974b-ec73-4562-bfc8-4745ad58b55a@web.de>
Date: Sun, 30 Nov 2025 12:47:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Jeff King <peff@peff.net>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Junio C Hamano <gitster@pobox.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2] diff-index: don't queue unchanged filepairs with
 diff_change()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m8UZ3M9g9EEvlzlQwMr5dEKVm8e5VxTg8HVcfbQr6CtBPcmxmhT
 Q5nsM6hUvtfL1xAdVVSwZz5Dl0ru2TZhjaJMrsHRKH0X7DDgA/xd6klR3LO3jrXqhzBSZKQ
 lRMzUswQDtY2VNJ5HrdRaC8Ce64ICQ241Is2Ta4BMJkA03EM+mP1Kjzq4rHWAvWdH3h5T/R
 O3hUb0WMgFdy/+pONEDqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f7/eTOuJduA=;1llI58zDqbzSty1tT3cCFrRxxUa
 M38T0ac7SlHNzT+gf/sO0cBIr7v8tHXenfMan9YLVNeNAvf3cCxP9wxfuwXXJsyTeeFwfIcXQ
 YKMgHV7uO3Hgy0C3BHVsWn2ilkrEKlGT+wrmFVXPoJZMlzVFk3X7oUaxerzf/kWdbwAPXTrlx
 6oYQ6kF+YuZe+5DJ6B1G2/JD+g9v+VrCUf25G1uOtSmN0OxH0QeOzhWUbucZhH0kOVK60gFr7
 9OM01Czl/Qe8Quwo3K7XXt19vZmCgnkDbRzrvaEPogDPSq5hED1aYk/Ei/2UNhv8YRS7YUM5x
 0yApYEgrpJ640rXri8D0zZJCQ9yLzldUTWeOAb4VilsWvMP1USOMcI2Z6qryoTrRVo5U5ZMO4
 WhviZcvsUf47+wV1W2X4qpal/QoG2JzhpTDVn2aI6s+8T8888Ov+QE5rVJ/MQwv+rgPShGuA9
 MBOLgY0URdIc5iVS5GIYD0trXSO9BHhG5yUBxo8SPn6Puu/HFFXYzCC7vcKpkw7xAF8PZa/oC
 Bk1mlbMoAzvEgL8KK7bM5wfuCK9wiAkuWO/Ocg7gLpCqb6bfFnTpo6ZUJbFGLOtbeWcWcfAox
 3YtZQtESW9GKAE0zKCSPXuuJoh+yA1MZ+OEG1KH+S8awiGTqC+Ynx4P3WNtCwd5tfiLnvLi46
 QQQkLjeAGVHitbO9Gab0zpt+blXIHRe2nCn9eskKNaU4VPYEC9h1Miinko7GyKWmiMfUOMPep
 iBC0rIPh0L31CFK/SOxMxVqkYcJhjJ87sc0dDPW9InfWgvieaDhF4yHMYbf/On3BNvc05qzmu
 ua21KNqiIN1US96y1KmpTUMLPRuISpQH7j7HnMX27G7ag8foQmBMxEuhZ/5l7TH0HpGCs92By
 K87yB1+LnBtxhi2fO1C0q+J7qUbIPrZsGeSiJdw0848vxWRkbKNw/yuZ7GbHkLZgIYKocckhW
 dTZBI0rxW7e5x3O1uRxgyGiaDYlA4m97r2m0lnTRO3HMhjf7Ou/GBtCmgSm69QclhR/S11+nh
 45eE5h2fQGuC4crmsHlCbhfETelB8IKjxer8NMHreH5VF3wPvVcompxECutqusIGutFS0PHVj
 NjpobceaUfspaJQTaiEf9j11QQLDaI3POGjbVH3d4Wynw9wtnd7wPYXjuedWqKDsXJQZP4ccU
 QyGEEM8AQxahhUqJCUNEtvZz/4rDMDVjgJx+Rp3pCnN4Hyx4AP7zTtKh+1uHSvBDCb21Q2CjC
 EpreuJEIaJ71hl9THoca3YUmi9oHOsr/dk1KJEJK1fppOGa18HbnMm8ideGZb+h+Taxj2pJ1O
 1pUdORwfkle77z+96eMsFV2YiVcSp2PdxAwQKOHLN8L5sT0n9RcBG3TTAqJvqgXjOstQqZheD
 FZWQ+y0GHnrMuThvlMxIfJKgXXHv8VvalblU6KETr3fKT/wInpIjempz15H52/zgr8vjJszOp
 jNP7khGc8MjfjxSBNy1rmkPCOMQQYdaVYv6lPPUvRa3RdXvqtRXr/bUwmsZQaIic85wycMKpX
 eGTA0fpQznZgTA1J7sWmLNUyFz7EEgIRmr83Kf9+QmlI4JomFHjWA3sMV4XzXJGiOAcyxbL9I
 igyJQzkaNcjpfKlB2e31ChNrlx4ocI4Rgy/H/YCx+TPGH1fBRwU+ftN1STxLOC1GWQTWsxxDe
 LKc/q/LNwbEQQwps2qM4JChCBTxip4MFurcxzEpKuoVFMLeccacDIoJ2hP80KRYwE2K11AqYp
 EwElScLxyLLnWh1/4zGGNAB2HvHr0GSmh5h6zFnKI121DsFkmk5BK7VPr/fPUb7dgTjhjTI3J
 CWOKXDjbvJKDWB8T1wlP8qqcUvFiDoizbWN5lRONa5r93Z1RThCzXn7r0ks7ug3E4NmodrdDF
 dPcxrYZkfUJUwlInVy5hy3ZNH8vFH61kYTJjzJ3pdtnqDa7T6ZEOETRlGa+CZZMm7rXX39lab
 OXmjkgQxyWoDy53OIDH4OenP/P2semMx3bymxRr12sWdKZu1ShueD70pPOt7W87hp/XshuQAE
 N/Kjh3uyj5gkccbkx3UUDeXw4eUckBievHGVr2l8QoAuokCQx7ruISF2DGyoRPO16Qh31ZJJW
 PH7U88z5HtKjcJ03UHdmi+D+hSeE4Mmu8zQi+fWv+uUd80rMuaNlDkj81ejYf54/D7X713amj
 Na0Iu/Grg20cwhVJzXBr/LUr4qBpm+wCbwSR2imCAKEMs8C3TzOJsBiO57KkAY1c0t2kIToH+
 qiU0F1zZKP0F0gjyKVSSl8zZAn5bscSF/5lRmfqj4gFlPIvdTj1pbZS/pkFOnOjvtJMNI7SD0
 Pz7cSbjavgQ8cqfpeFbKYcrwa7BPcnB+IOxyeCvrdbKn7+Y3Wj+ye2mAXnY3ouuwX99f2l93O
 o34sVWFipFe4DCMeVJOpKaxrpTL3qWRxaoDWtkPsdTIGSwvOWk5I0ZAlD9WUdHBUBIXyice2N
 ilPPEtmQUr4/WxQa/WKaRVuiWS0W1Vdn74uTGC/ZQs5NCbEFiD2BKyzKZ7S9TtnGG5y5LU9Ds
 0HWdfrJxgzVS6DGejlpmywBlLM4KpPTwr4bcpzKtrCju8S+XVowd0AEZjPDl6K/JtTr0yT8Be
 Hkun3nqSTMiXUgkcIgjxgFf/e5SP9Ly9Lu/XPa9werRISlo55C/oqhtuTNj+iScs6pjNJEopQ
 AAXk+Jhb/T321gYTQe3zquamdCLjCjgu0ONya2f2zPNZUOronZ5Q7VTSMah013ajfPUKlWbsg
 14ql6G6uF2/oHz1X+XS8GN286yJ0qA5bphpk587fU6yDhgKHrYtvwoiXcaPj+LwRMXbKNp/01
 nn/V52+SuSh8HMwNBA5su+kYDAnaSVDNoTl35hhf6U1zOWuw3kvieQ0zk7VdIW6yxouxR3xiu
 YHiLAHmPSs5OxbuI9+piiIByCXjHnMSswE0P9zYJUqIk6rtzDLXTXr7exwrwqyIyBYq4UT1Gg
 CQr2mkAvP6/u4uUL7rglH7Jmi+G+m1ztTjO9RIbNo2gr3tOb6ovQ6jMoA58+mwYEskzcUq079
 gSWOAY/MLsTM+kT8K01GSRPsS3RqyAyheubgmcLD4Ya0DkgaGqUu16fUYMXyTl8p571we01Us
 hqPzuqY3ZMFF8ho3O0fyQCRUcST6mux7ZHOJKYlrMGiNorc6Ocu2/o6EwOsh8XdVu71fioNJV
 Ecf4B7gJErSoSXtjEWbT+KIS4ujEDvtWnyBdNNUG+gSSRiXaydqZPEbB6CVPizTdknC+dy/yO
 vggk83mUHXxbKUjH9DyO0YGcozoB3ggD60kuYXhRXnVxE6t3dIhQGUtFePUV2zN7LFuWxTqyG
 Id2uV8v1d0DZgtYHFdotezYsslk3hT9SoJ3M88nN/skVq2g0FlSbe7LfDDp9R+JPD9qeiAQ1v
 F/i12W4vB5X57gdoRSp6M/qATNEOzqBL1L0BqKKwKXpBNG6Zjyc/vtDA9gXVSBkQzNUJVudRV
 jrGZzdAtmk1TwoXm15gjuuIQznMSVNvqKynZkwMn/Jg/otYg/H9EGU1LfdzvhfNqZc7KK6vKp
 Tv9cnHe3MK2y9dw4ZBSGHn6i0gmYDiLljQak+sc2LD2b2yAYJqnjPy/ZVLHi69iFxhOtclhDk
 IKdob5qZNzWru+WNcr3FZDi635B4Xn3zUitlZXzl9WndKasMPKYEyDPXmQDsNSaSxXYyW5PXC
 mYsOLIVNqUSyEbuxqs7kZ/Sumg5enC1LxTicpjNbCBcp7uASMYx1ueC5Jy4NUOzCPZBvfl7XM
 9EHLPan3jcGVQivPfxzMZXkBkoPQCStUALqu3ULd+rgndCpzGa65sxApxveYctWdnnOSx3aUj
 vPbKqsu0kHt/h9LfF2fpelWkNYVKKV5hmgXIMeo1hrvRn0jsfsBpWbOs1DEQ8E6P3vj0gu7EB
 y+JVqngHICeZHdFTVkYr0kHfJwXGuc4GBwNKCj/XqR1XBMvfu2nVxH0iqvp6AU8CBrLGPXl8s
 DhkaBElRGavHZXJ3JOdRUfZU8CxHHnEV9H7wssbrTOs8vgV3JofjJbK8QBoAi/6n7JUpgJbri
 US2P+1tfTQLsRD1/oiGlxdyJ3EDrKSDjGJUh02TaClmoDLyAtSr0wyLia8H+sj3N0019kCNHD
 Z/IUlzlthW60g1AbUFo8OPLxXv3ClWjQphLKJ+CBpQwXcoR9qRrN6YIKdlIdkxn/nfzveLWs9
 r2REd6J5fSZdgX7C8Hf1Q9iCjU+atp3PVOSr+1tR4VTyxWD52gMWOzw3A3ZpWrLHV7B6vkEUy
 uGpSsZdeKEt99J/d0DxLIDMtKQldJZI5VTAmcBUxDNhI11YKwIjoqTQgIXZVNDlO16xoXSje3
 bvoyCudRuUSWVDTWDkRjCbmgV97F06SO/zeflvtRfrVEEVA5mb06iM1upOkQnLZK6iPQitP8N
 6MZHwrmG9n6DlnpZP9/GUhp8L39wIQXhfGidWlyp5kes1qqfbewNPpMDLt4CRQtP81FDdjG0w
 j+XwNFgS2bf9pDlfMyd9G9RLPQz8Q0mY2aY3APB1zVa60b1n3n2K6UbcAGQ5wR5L0gGVIFHZI
 ggQp53083fCdn3fe+EwCF6aPjb87B2HRjGwK8wEwVHInG6BkiFqHG1L4+/q7nFbFn9JzKX32I
 wEoQA0LtsesanDqdjeyiQeIKukNOgMNVCOIeLtQhXsXlfbrqfxlFp5fsonmWTYp5xeWUa3Mvo
 NLU9rzCRD/oVGkReC+vWQjbCL5g1BJaRYwJY1kcSN3k6KOGeNoQGi9S5pnKlpMx5bgbzo3uMq
 GJ+337QSbA3tC2enCTIelCHhYRLAk04BbmnkaOcCWsGBO+hLGclVWyZaRgayusCZcUWy9GV64
 ShczL/VRgkIJlaBu0eGq5Zh65B0OIeqN+pd5yujYaL8fbg/n5/eWAeCf3t1t3HM7ZCVNGqMcw
 xJZCNDbqK9XIQXUefqoHAnzKgc12dL5nlFOn4BDo+R8CzctZsdYRUgFQtL5SwhPnNKbeQuTBM
 SA2zHbLGGB91KiCrxXzJsH+JsxR8Ab4ZIwfhE65a7VWlSFwCr9Ja3JJybQBX0mqm00T/7o9YJ
 9e1+iiPoFlgLRNIxiyUKauLcOUcu3413jqw1rojhRRX/y0OfAafZT9od082aMTcRKlZAw==

diff_cache() queues unchanged filepairs if the flag find_copies_harder
is set, and uses diff_change() for that.  This function allocates a
filespec for each side, does a few other things that are unnecessary for
unchanged filepairs and always sets the diff_flag has_changes, which is
simply misleading in this case.

Add a new streamlined function for queuing unchanged filepairs and
use it in show_modified(), which is called by diff_cache() via
oneway_diff() and do_oneway_diff().  It allocates only a single filespec
for each filepair and uses it twice with reference counting.  This has a
measurable effect if there are a lot of them, like in the Linux repo:

Benchmark 1: ./git_v2.52.0 -C ../linux diff --cached --find-copies-harder
  Time (mean =C2=B1 =CF=83):      31.8 ms =C2=B1   0.2 ms    [User: 24.2 m=
s, System: 6.3 ms]
  Range (min =E2=80=A6 max):    31.5 ms =E2=80=A6  32.3 ms    85 runs

Benchmark 2: ./git -C ../linux diff --cached --find-copies-harder
  Time (mean =C2=B1 =CF=83):      23.9 ms =C2=B1   0.2 ms    [User: 18.1 m=
s, System: 4.6 ms]
  Range (min =E2=80=A6 max):    23.5 ms =E2=80=A6  24.4 ms    111 runs

Summary
  ./git -C ../linux diff --cached --find-copies-harder ran
    1.33 =C2=B1 0.01 times faster than ./git_v2.52.0 -C ../linux diff --ca=
ched --find-copies-harder

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v1:
- Clearer description of memory usage in the commit message.

 diff-lib.c | 13 ++++++-------
 diff.c     | 20 ++++++++++++++++++++
 diff.h     |  5 +++++
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index b8f8f3bc31..8e624f38c6 100644
=2D-- a/diff-lib.c
+++ b/diff-lib.c
@@ -418,13 +418,12 @@ static int show_modified(struct rev_info *revs,
 	}
=20
 	oldmode =3D old_entry->ce_mode;
-	if (mode =3D=3D oldmode && oideq(oid, &old_entry->oid) && !dirty_submodu=
le &&
-	    !revs->diffopt.flags.find_copies_harder)
-		return 0;
-
-	diff_change(&revs->diffopt, oldmode, mode,
-		    &old_entry->oid, oid, 1, !is_null_oid(oid),
-		    old_entry->name, 0, dirty_submodule);
+	if (mode !=3D oldmode || !oideq(oid, &old_entry->oid) || dirty_submodule=
)
+		diff_change(&revs->diffopt, oldmode, mode,
+			    &old_entry->oid, oid, 1, !is_null_oid(oid),
+			    old_entry->name, 0, dirty_submodule);
+	else if (revs->diffopt.flags.find_copies_harder)
+		diff_same(&revs->diffopt, mode, oid, old_entry->name);
 	return 0;
 }
=20
diff --git a/diff.c b/diff.c
index 915317025f..63d33251cd 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -7348,6 +7348,26 @@ void diff_change(struct diff_options *options,
 			  concatpath, old_dirty_submodule, new_dirty_submodule);
 }
=20
+void diff_same(struct diff_options *options,
+	       unsigned mode,
+	       const struct object_id *oid,
+	       const char *concatpath)
+{
+	struct diff_filespec *one;
+
+	if (S_ISGITLINK(mode) && is_submodule_ignored(concatpath, options))
+		return;
+
+	if (options->prefix &&
+	    strncmp(concatpath, options->prefix, options->prefix_length))
+		return;
+
+	one =3D alloc_filespec(concatpath);
+	fill_filespec(one, oid, 1, mode);
+	one->count++;
+	diff_queue(&diff_queued_diff, one, one);
+}
+
 struct diff_filepair *diff_unmerge(struct diff_options *options, const ch=
ar *path)
 {
 	struct diff_filepair *pair;
diff --git a/diff.h b/diff.h
index 31eedd5c0c..e80503aebb 100644
=2D-- a/diff.h
+++ b/diff.h
@@ -572,6 +572,11 @@ void diff_change(struct diff_options *,
 		 const char *fullpath,
 		 unsigned dirty_submodule1, unsigned dirty_submodule2);
=20
+void diff_same(struct diff_options *,
+	       unsigned mode,
+	       const struct object_id *oid,
+	       const char *fullpath);
+
 struct diff_filepair *diff_unmerge(struct diff_options *, const char *pat=
h);
=20
 void compute_diffstat(struct diff_options *options, struct diffstat_t *di=
ffstat,
=2D-=20
2.52.0
