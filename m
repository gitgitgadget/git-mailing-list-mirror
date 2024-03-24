Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA46928E7
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711279286; cv=none; b=F2+PRkCA9DCRcneivh+gEbDbSZEGrAdioHXpoYkBzx3PSBcCgZpunD0zD40yJZC17xgY+uxZBIJcgGhrMcvuO8ow5r3C9Q26viphShVjafaC5Li0bCYz/rHQ2u+jL+qORHOqC9vXTrDPA/YdCWGg3g1m5c9eD1G1O5yKI5sglGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711279286; c=relaxed/simple;
	bh=KA7wZqU5i23ElsYPwQnSYv0NRwO/wUXarjhmXSLCHUg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=f/o58UBeQjVy6TPNKv+6weN7e0rnqfmEHrtpLGwsGm/NIvoiBqYrTOG0sfppQm2gWsuXXh4y3KRvL1gVLhTNWKIQuEnmIBttVq4GeYUmaTT04xAvbG+b/8HC0xK9ssyU5Htid5clbrn94Xw/GNCm6B9ehK3J9u5wadnbUPAIWWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=j8UAVnyf; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="j8UAVnyf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711279276; x=1711884076; i=l.s.r@web.de;
	bh=OAuwuF8NUXDIIDm6R0oEGUoTUFSF6z7eycIblSMacDk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=j8UAVnyfdawRhJJNcvvzWWZ4G3dW2JqtzfIcoO6Yr2QVhhlqG5K8HYneZAnC8rHq
	 cyMTdWw3SLnjillMH0tea4/wOGQi/GBfUiH5tR8+b76LXmMacCqVbnn5tsOFBQtZb
	 B5dG9UgZCSwwWYRz+NenIzPn8MWNRhvXXKdnZ/lnOQ0u9clZczNl5xDRYS8xlu9/E
	 9V5xpRpg4oZNi+WyNrEkswmB4qNv/ybh6/1HSD9txRjT04n7rmHOSV3Sxc4ZbwlaW
	 fEiDkIOQhaDeNl0nWUZDMnc1eAdYGIdHAAOGk9rvwuXUOeLJYCUqjI2CFiU2zbUuv
	 anwtZIBSu+gKk7yLjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPdr-1sAiHy4B9N-00MNOg for
 <git@vger.kernel.org>; Sun, 24 Mar 2024 12:21:16 +0100
Message-ID: <c6f915a9-0788-4492-b71a-37171a8bb13b@web.de>
Date: Sun, 24 Mar 2024 12:21:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/2] cat-file: use strbuf_expand_bad_format()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <27cdcde7-74bc-4ee8-bc84-9a6046292cae@web.de>
Content-Language: en-US
In-Reply-To: <27cdcde7-74bc-4ee8-bc84-9a6046292cae@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xVqiHagLpygPv8l0HHn6sSA8m0dIPsGOejx3xt2xBQ61ux0smre
 NfU6me/0PKDG0FtqwRt5goHskx6a6pM1+QDONpNyundMWOVVp07KJ0xQOhuzGQFaqDDpyd1
 Kddn1f3+C3qLg0sKfiILEGv1tGIQwoBCtR2jJBKtoFSE7zVQnuPPCXPCvxFqPiQhyWm6j1v
 4qn0BwSTcBVd2fdEwO/QQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C/yzvgTxFR8=;jdLXaJlAdGUzPL321QMw1lJPatp
 ryE20MPS+eZjWdSNUq8ox2y6OvUvNtTsq+1RytsPgDJsx1HS+Ad3yy2tem+F0iaAMeoiNPEFg
 H6lzZFvX/Mnc8rm4/7f90I16VKfoSG1xjNY49ZZ5GVWtG90TuGKP28jHQPheSkuyxOZ3ZPtjo
 2SQH3ZEAaWBFobva3dQ3RkXF7R3K8ZtHcbBoZQgYjIfAYKl+Fc6gzdtvqYUL4NBY0UwkbyBMU
 HIyj1gyWn+7HEeigcCqmPOHoNMnURDcE4RZDB52ne7bnV03iu/ImxbxZji/+CPBYxQamRK3BA
 moAW2hSV+iFeA+YEnwu+8LDJ/1kgXkzYQ/phkI5QeUGUJ9ramFDtx7j16vdBoFLfQHTbwcRnv
 iKrixo5/BAlwe2b8re80tHp4bgdwlW9JLZzCxsJd0isBNbXdeTJasL6CevsgEfpCryGmmPPmK
 WILiuumo+tGyw7EkNGA+LU7r5ua+Op7Hqr5niM1AznLdpf8yRXiOgRClQ5wGbCpeg9bHfoUhI
 kKWiLuWw7F8iNxxdYMcOTKw96EKbBV+FtSd/qwTwQ47plCnxfHokkMOsrak9KdlGuS8yJKiDW
 PlzLqo4JfViFYsk6+vn49YPPluMFyZDBm+c3ozltdoqkbmEe0JrBQsg9LB8/S6HtrxFRrU9kw
 Pgyi689qFw/Qw5car4aZz5v4Ed2VllY+bx5ZT5g9Xaux5IwAmdS4GQTi8oRabLydVh7qBzujY
 kuJBU/Wi4Sr0lYsLnUykh6Sqg7bqTBkBTsctIr2Rzz472Wf35FFUDD0xq1otcBg1iDBo4hFsi
 cCNRwBUsAtKuzdF5tmlEhjI/yMTUPj+F7SVr8KjCkYfUQ=

Report unknown format elements and missing closing parentheses with
consistent and translated messages by calling strbuf_expand_bad_format()
at the very end of the combined if/else chain of expand_format() and
expand_atom().

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Same as v1.

 builtin/cat-file.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index bbf851138e..fadf2da2f0 100644
=2D-- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -310,8 +310,8 @@ static int is_atom(const char *atom, const char *s, in=
t slen)
 	return alen =3D=3D slen && !memcmp(atom, s, alen);
 }

-static void expand_atom(struct strbuf *sb, const char *atom, int len,
-			struct expand_data *data)
+static int expand_atom(struct strbuf *sb, const char *atom, int len,
+		       struct expand_data *data)
 {
 	if (is_atom("objectname", atom, len)) {
 		if (!data->mark_query)
@@ -343,7 +343,8 @@ static void expand_atom(struct strbuf *sb, const char =
*atom, int len,
 			strbuf_addstr(sb,
 				      oid_to_hex(&data->delta_base_oid));
 	} else
-		die("unknown format element: %.*s", len, atom);
+		return 0;
+	return 1;
 }

 static void expand_format(struct strbuf *sb, const char *start,
@@ -354,12 +355,11 @@ static void expand_format(struct strbuf *sb, const c=
har *start,

 		if (skip_prefix(start, "%", &start) || *start !=3D '(')
 			strbuf_addch(sb, '%');
-		else if (!(end =3D strchr(start + 1, ')')))
-			die("format element '%s' does not end in ')'", start);
-		else {
-			expand_atom(sb, start + 1, end - start - 1, data);
+		else if ((end =3D strchr(start + 1, ')')) &&
+			 expand_atom(sb, start + 1, end - start - 1, data))
 			start =3D end + 1;
-		}
+		else
+			strbuf_expand_bad_format(start, "cat-file");
 	}
 }

=2D-
2.44.0
