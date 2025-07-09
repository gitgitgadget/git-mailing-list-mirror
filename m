Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168711DE2B4
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054258; cv=none; b=j67wUsL65Z/4d4SjyYIW3bEOFf9iN3ZlJ9e9vuksDbYdbAdyx80aPcY+HsBa4N1vh1cYi2ecN3ufiR8TXUSVdlOaSrmIy3D8G0gIAeonHpnje3pN4vGVGIarMDGXmZTtKWLP5ZZWEaS1oOS9XlKFwWjzPMakh0t+7MNy1SUPptw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054258; c=relaxed/simple;
	bh=8YdvYLoZc+dyJYpAVS9ShRBCbjvHkPLCsbxoi9tE0BY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P7CuvSQEOQ8gCOMBJJJMYpUM4jQmcUSq/Fdpak/lHJ3EW3bSkO1ow95/Bpz5YeBzO4QJPAVsatYgyZmRrBrAZd12w6W2zCOBWbQpBxR+iH/qHY062agQRdFYV+EDSLCUBatQGFDlAwdQgXGWvhZFOD39dvxlXfUHOeW8TGH0mAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=qptxHMhI; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="qptxHMhI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752054250; x=1752659050; i=l.s.r@web.de;
	bh=le+QvtTcVJXIrMiZkpF5men/dqk5+7VYxMNBEiNUVoU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qptxHMhIcvzjP7hJYU0JhWMdN3U83snD0bFmL/tgn3Ac47JpZHTVOXwpbr9t1OiX
	 REymteO7LS9HZFE3+i6tAtrPw+xcu/9zzfUyPJqgelvVckipOvofSL1NcR5V1s7oq
	 +OhAYB1912pa8tZAHW8HIN7bjyOnHwpUgFiUJbf6EZeJ57rRztLlTQTS3wfqJmB0W
	 HHzO4QUoBOJjI1YwNnk8PJbgA4tHuAlQXLDDpzaXMRA8cDeGe+n/hUAm0NZtCdkye
	 TTiokobrB1w9zovrnauiw7yWFGFd43KTCPlBsJsLeTFe96SVLU0vMFVjtZd3/UgCn
	 jIgB1ycXy43eldhhlA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MmQcl-1v0DNL10i1-00b8zd; Wed, 09
 Jul 2025 11:44:10 +0200
Message-ID: <4d91754b-00a4-47ab-86eb-0da201e7889d@web.de>
Date: Wed, 9 Jul 2025 11:44:09 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/7] parse-options: require PARSE_OPT_NOARG for
 OPTION_BITOP
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
Content-Language: en-US
In-Reply-To: <802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xXYgOa4kIhAhjwxzvEfVlk0c1/2hFQlyLSxSKlRXTcrIDB2skYN
 P5dPe/hl4+ScWD8JMtKyWYvBuafoL6hmetOk1lVy0Mi3ylQx3H4XorF0kJ2OFgdFQBE7Brn
 zZnqApyu+2kH7ybb5wBCD84wtyqe7f8ITndsPzdyode9rehu4QocFMDiBNF+g6WLYXHriv4
 5wbpWRiPFFYVqNsu6R3hA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ikGs5gzg1+8=;qHKfMC06Zen6xMRYcRpe5Ib1dr3
 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
 qwXGNkCH0dw==

OPTION_BITOP options don't take arguments.  Make sure they are declared
that way using the flag PARSE_OPT_NOARG.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/parse-options.c b/parse-options.c
index a9a39ecaef..68ff494492 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -591,6 +591,7 @@ static void parse_options_check(const struct option *o=
pts)
 		case OPTION_NEGBIT:
 		case OPTION_SET_INT:
 		case OPTION_NUMBER:
+		case OPTION_BITOP:
 			if ((opts->flags & PARSE_OPT_OPTARG) ||
 			    !(opts->flags & PARSE_OPT_NOARG))
 				optbug(opts, "should not accept an argument");
=2D-=20
2.50.0
