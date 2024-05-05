Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBFB79FE
	for <git@vger.kernel.org>; Sun,  5 May 2024 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714904412; cv=none; b=JXUZvVLVcHGBd+rkbkFa4Yf9SqWgOw/guevB5NbTchYrry20T8vT335KtX1Rwl1QNSNtOH9E5z+VAzSkg5GennDMzSidGSRWlG9yVfmb+ScgpJuDPpZHD1e3CQzXQMlxCL6WmqV90csrRRq2Vq+reRgnyTVx+o3k1kKBuDn+nzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714904412; c=relaxed/simple;
	bh=KXnhGCTuZRywWGms28GUaOLyMSZgvFGwTEUx7BwZXw4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=ShsQnYCfj6qcgCVxJkjLcUS7j6GgyC9Bfd2CLV2vVoHI1qRBPEA1spk0YeAzwqMKlXWwg5hAQSYoZR4wVzPDvmTMtb/1jzGxMWWKyL+9WAzJagQ0/fKulI7Cb+V3mvYGHJIq7uyMcx2Q9zF3tsKxKOtHvTGgvCZYEsayTvzcNfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=BZBEfWg1; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="BZBEfWg1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714904404; x=1715509204; i=l.s.r@web.de;
	bh=E9iD3qnHno0Pajvq0t4EX+K97QFhtTpFVaF0X2euRQo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BZBEfWg1a37c3UsKjfW48NqFOA239LLmMBhFjyDFvg8f8Lu7HUo5OK3fYmm+6xiS
	 0lxjIHqBuELntH8YTBC3jdlwTGyiYizdkBuFrRiNF8XWesJo/Ps0p9ltDzf40Y6M3
	 vEIgQXphMiNM5ulX041g5Z7vwedpIQ/zE5288cOajTOwHKB7LUjlR+gXFZ6VTN7uk
	 TkHeZWyZiY9HU/PcpZTZc7ScSxDlkDAz3AgWZXMHEf5SltxWdxK/Ib3s/vKHIPa/l
	 FtaQ3OF6V40du2WmwU5EOdwtmojM7g6Sxu1rD2cT8M7rujTDli6MkU+rOG8C3NjaE
	 zgz1ykkNgWryDGFwug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKMA1-1sLM8x0EwB-00KBnw; Sun, 05
 May 2024 12:20:04 +0200
Message-ID: <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
Date: Sun, 5 May 2024 12:20:03 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] diff: fix --exit-code with external diff
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: German Lashevich <german.lashevich@gmail.com>, git@vger.kernel.org
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>
In-Reply-To: <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kVcGjChM3+388TEegDsebmzCiMaKZCQGGVcICo/mfIWa6U2QAyi
 KmDEeL2OEtXD3f0geJ4zoTdyqFl/Fzu2cQzBg7o5F8Px7I0aBLRwR2M8+c9I2gW8lLZnQLG
 MwwqO1F32WE4zGdr6Sa5YqRdUwJMiASdAlFlpC64vtLDKd/fPpluSr4W7wQ+0QoiUhmaRWf
 Cv9ztdvH9O2hembEIt3Jw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ws2yJqjiZ1c=;knThAzhcjpSukBhhcpwwPxGBEVf
 MsOIBQaDmXRoq6IlmznAuF1vCRjq+1sLX8AcVMCBXZzEWW9ac71paCXTzHSM2y6nk+7ZQtSs9
 kYaPbUL4VtkIBr3CuHZPLcffTws2jusjXj4K/nu0NMWzWA5NZUQ8OLuPSU7IAxR2N+2inmnbk
 HhVArlqTKQIH/2d7bqlxM5sy/y4Edm+QBdc1kgrSlnY6W1cuj3FI/wUNQ+GUc5T648d9S14Kx
 y3exeYUnHN3dNXnPpJlX+euu6XT+Iymp73wWuxg/zkm2dPf4cjC02q6KQ80gRWdV14riddGdb
 Oiz1+BFggmiJ2q92l297Svcnf12hv9u1BOQNRr+qrSykJ8XtDY4e/8jpRg1r+trmrZEzHCAE2
 TyxF+j/GewQnwher0/qmByh3rBeiYQA9r79OxWZq4W/q6TUW2bKU0T+zneofinABn/MAXs/qw
 k8+LCqAB67RnSlSUdzflVxLxktmnZ6+eNJmL/Vf4hfWmBMFHc/6SCiXWj8PD5Qp0HeDq5JMiB
 0+bg2IUZnEldy52wWe/Hgu3clMxFzMESSdO5fbwKIX6vpBPklBRSPU4HDicqsEXJFkkDIRG4O
 oCOMHRRfcmBe2q2WSnGId41bVe6vYopQ9plAY7rYXslrSedyPTcI2oiy9PtKjII51JdMZ65xB
 vMsVdlz/0Rh9og3N9bUB6fRpCakXJSVO7TQQc48PL/W98+yWPe/71cXeoYZTOaaA4SJluJSOA
 LG+jtNM8xhnKg6AW8Y4RXBUKMis+8ulBq5tlodyNT9Nl2qV1zfdG7RxBG2xl1IKCAG1spDP5k
 jfuc8AO3gvLOgWN2FMK7cj4ZFpeIybg3qp3/ixcPkDgSM=

You can ask the diff machinery to let the exit code indicate whether
there are changes, e.g. with --exit-code.  It as two ways to calculate
that bit: The quick one assumes blobs with different hashes have
different content, and the more elaborate way actually compares the
contents, possibly applying transformations like ignoring whitespace.

Always use the slower path by setting the flag diff_from_contents,
because any of the files could have an external diff driver set via an
attribute, which might consider binary differences irrelevant, like e.g.
diff -b.

And don't stop walking that path in diff_flush() just because
output_format is unset.  Instead run diff_flush_patch() with output
redirected to /dev/null to get the exit status, like we already do for
DIFF_FORMAT_NO_OUTPUT.  That's consistent with the comments in diff.h:

   /* Same as output_format =3D 0 but we know that -s flag was given
    * and we should not give default value to output_format.
    */
   #define DIFF_FORMAT_NO_OUTPUT	0x0800

An unset output_format is given e.g. by repo_index_has_changes().  We
could set it right there, but there may be other places, so simply let
diff_flush() handle it for all of them consistently.

Finally, capture the output of the external diff and only register a
change by setting found_changes if the program wrote anything.

Reported-by: German Lashevich <german.lashevich@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff.c                   | 33 ++++++++++++++++++++++++++++++---
 t/t4020-diff-external.sh |  8 ++++++++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index ded9ac70df..cd3c8a3978 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -40,6 +40,7 @@
 #include "setup.h"
 #include "strmap.h"
 #include "ws.h"
+#include "write-or-die.h"

 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -4404,8 +4405,33 @@ static void run_external_diff(const char *pgm,
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
 	cmd.use_shell =3D 1;
-	if (run_command(&cmd))
-		die(_("external diff died, stopping at %s"), name);
+	if (o->flags.diff_from_contents) {
+		int got_output =3D 0;
+		cmd.out =3D -1;
+		if (start_command(&cmd))
+			die(_("external diff died, stopping at %s"), name);
+		for (;;) {
+			char buffer[8192];
+			ssize_t len =3D xread(cmd.out, buffer, sizeof(buffer));
+			if (!len)
+				break;
+			if (len < 0)
+				die(_("unable to read from external diff,"
+				      " stopping at %s"), name);
+			got_output =3D 1;
+			if (write_in_full(1, buffer, len) < 0)
+				die(_("unable to write output of external diff,"
+				      " stopping at %s"), name);
+		}
+		close(cmd.out);
+		if (finish_command(&cmd))
+			die(_("external diff died, stopping at %s"), name);
+		if (got_output)
+			o->found_changes =3D 1;
+	} else {
+		if (run_command(&cmd))
+			die(_("external diff died, stopping at %s"), name);
+	}

 	remove_tempfile();
 }
@@ -4852,6 +4878,7 @@ void diff_setup_done(struct diff_options *options)
 	 */

 	if ((options->xdl_opts & XDF_WHITESPACE_FLAGS) ||
+	    options->flags.exit_with_status ||
 	    options->ignore_regex_nr)
 		options->flags.diff_from_contents =3D 1;
 	else
@@ -6742,7 +6769,7 @@ void diff_flush(struct diff_options *options)
 	if (output_format & DIFF_FORMAT_CALLBACK)
 		options->format_callback(q, options, options->format_callback_data);

-	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
+	if ((!output_format || output_format & DIFF_FORMAT_NO_OUTPUT) &&
 	    options->flags.exit_with_status &&
 	    options->flags.diff_from_contents) {
 		/*
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index fdd865f7c3..26430ca66b 100755
=2D-- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -172,6 +172,14 @@ test_expect_success 'no diff with -diff' '
 	grep Binary out
 '

+test_expect_success 'diff.external and --exit-code with output' '
+	test_expect_code 1 git -c diff.external=3Decho diff --exit-code
+'
+
+test_expect_success 'diff.external and --exit-code without output' '
+	git -c diff.external=3Dtrue diff --exit-code
+'
+
 echo NULZbetweenZwords | perl -pe 'y/Z/\000/' > file

 test_expect_success 'force diff with "diff"' '
=2D-
2.45.0
