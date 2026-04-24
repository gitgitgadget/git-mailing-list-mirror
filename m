Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43FB3254A2
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777064984; cv=none; b=Gr9C30gkdX/iZlBXETE4MiBMJ6qV/0WpQifieeGagaeqCYUQSuj3H97LD/iM8MNjHcE1t5VFh6jMZCduAVWf7Z2FbTX86oBTMm8kGQLv282Y2Dr1MUzfOJrH9E3GPCv6bEHb7xnmav+vSWYnDREujgZHPyAbntUvNUW3DLBlXL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777064984; c=relaxed/simple;
	bh=+Iiox5CpsZ8isdlfRPIhRjqk9km/w5X9Z0PG324VN3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WeYGJzUmENOQ0hWJLNDKSfWeNGrIIZ3lUD8wINHuX7LuQqJ1TPtkuvYZZevTTB6ZChrdQOQ4S4YMXV2NKPo/hQEOeyQG0/uh5kAdtQHktEumJ8ZAMJLbv0Zx9aSwcHnbEZs6evMI2lqDTLhRmjY6exPtmjxPgYgGXhhwJYiLbW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Fx+RgFMQ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Fx+RgFMQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1777064980; x=1777669780; i=l.s.r@web.de;
	bh=TUjhRJVmPqCoP2z6pVIvuVxF3NoHZMukV0HuzsakEjQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Fx+RgFMQpJtKXo0jTceDNzAn4ZgmXTFElzH5p0q7pOvhB1DSfKRdEczLjRFqCJOg
	 VGDA3Ki+eOGlIUCl3/O4Uv2K/d3UwTfIJk6O77tEZs22cnRY5bG8DuWd42IW++jZA
	 GiD5xvaDs/EozjoKDsKYK3LJZLLt/rNvRAoLQdLh/ovEWmdaLgIs21h9No0Int4WA
	 TcV2ztDWQ2UcFX4hynHilPl8HAXgypO/QWIoo9PsatSNZHvQPN4lpRPPPY5ZphJPV
	 P4xLuvk0PPoxaBeE8X+RcrWECCpYEv6a6icr/C15NQJ2Z6MS7e+FUJbIxyi0Y6KFR
	 3WrBAJD6gAZNhOu4pQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mo6Nt-1vZd1r12FP-00b059; Fri, 24
 Apr 2026 23:04:28 +0200
Message-ID: <9bd69678-f04b-41d2-ad74-a386820d34c8@web.de>
Date: Fri, 24 Apr 2026 23:04:27 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] grep: fix --column --only-match for 2nd and later matches
To: Brandon Chinn <brandonchinn178@gmail.com>, git@vger.kernel.org
References: <CAGANf=dkRgFp+bEkB5f8QBeiR3m+3WE8sKqT9vKstkGHqbxA3A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAGANf=dkRgFp+bEkB5f8QBeiR3m+3WE8sKqT9vKstkGHqbxA3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:axo7X7Lvcoj4mBxqCtv8qjnQQHH8GuVYIe2UWrlwZ1gfr2HduxD
 FUjNB7nEx9QxR+kmxYdjNLPpblUe3DHQVrWzgN4sJSfdBqFAhx+kCEsereunrirdIPis6ST
 IdbePBr8EYHLsnI+Otdo5H6pIp0ci5J4OT1FEX1NCHwGaseA1dwvdga/oB8pgYYFjPzxTJ2
 7VzVkHCoypGn53V+QZx/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DHb2/0CoIlg=;w8MpnPR7O48KD37nBAQ/zMoEg2I
 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

"git grep --column --only-match" shows the 1-based column number of the
first match on each line, but confusing numbers for further matches.
Example:

   $ echo 123456789012345678901234567890 >file
   $ for d in 1 2 3 4 5 6 7 8 9 0
     do
       git grep --no-index --column --only-matching $d file |
       awk -v FS=3D: -v l=3D$d: '{l =3D l sprintf("%3s", $2)} END {print l=
}'
     done
   1:  1  2 12
   2:  2  4 14
   3:  3  6 16
   4:  4  8 18
   5:  5 10 20
   6:  6 12 22
   7:  7 14 24
   8:  8 16 26
   9:  9 18 28
   0: 10 20 30

Report the column number of each match instead:

   $ for d in 1 2 3 4 5 6 7 8 9 0
     do
       ./git grep --no-index --column --only-matching $d file |
       awk -v FS=3D: -v l=3D$d: '{l =3D l sprintf("%3s", $2)} END {print l=
}'
     done
   1:  1 11 21
   2:  2 12 22
   3:  3 13 23
   4:  4 14 24
   5:  5 15 25
   6:  6 16 26
   7:  7 17 27
   8:  8 18 28
   9:  9 19 29
   0: 10 20 30

We need to adjust the test in t7810 as well.  The file it uses has the
following five lines; I add a line highlighting the matches and a ruler
at the bottom here, to make it easier to see that the second "mmap"
indeed starts at column 14:

foo mmap bar
foo_mmap bar
foo_mmap bar mmap
foo mmap bar_mmap
foo_mmap bar mmap baz
    =3D=3D=3D=3D     =3D=3D=3D=3D
123456789 123456789 1

Reported-by: Brandon Chinn <brandonchinn178@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 grep.c          | 3 ++-
 t/t7810-grep.sh | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index c7e1dc1e0e..a54e5d86a9 100644
=2D-- a/grep.c
+++ b/grep.c
@@ -1267,6 +1267,7 @@ static void show_line(struct grep_opt *opt,
 		regmatch_t match;
 		enum grep_context ctx =3D GREP_CONTEXT_BODY;
 		int eflags =3D 0;
+		const char *start =3D bol;
=20
 		if (want_color(opt->color)) {
 			if (sign =3D=3D ':')
@@ -1285,6 +1286,7 @@ static void show_line(struct grep_opt *opt,
 			if (match.rm_so =3D=3D match.rm_eo)
 				break;
=20
+			cno =3D bol - start + match.rm_so + 1;
 			if (opt->only_matching)
 				show_line_header(opt, name, lno, cno, sign);
 			else
@@ -1294,7 +1296,6 @@ static void show_line(struct grep_opt *opt,
 			if (opt->only_matching)
 				opt->output(opt, "\n", 1);
 			bol +=3D match.rm_eo;
-			cno +=3D match.rm_eo;
 			rest -=3D match.rm_eo;
 			eflags =3D REG_NOTBOL;
 		}
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 64ac4f04ee..bd439563d6 100755
=2D-- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -322,11 +322,11 @@ do
 		${HC}file:1:5:mmap
 		${HC}file:2:5:mmap
 		${HC}file:3:5:mmap
-		${HC}file:3:13:mmap
+		${HC}file:3:14:mmap
 		${HC}file:4:5:mmap
-		${HC}file:4:13:mmap
+		${HC}file:4:14:mmap
 		${HC}file:5:5:mmap
-		${HC}file:5:13:mmap
+		${HC}file:5:14:mmap
 		EOF
 		git grep --column -n -o -e mmap $H >actual &&
 		test_cmp expected actual
=2D-=20
2.54.0
