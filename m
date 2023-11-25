Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Greylist: delayed 382 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Nov 2023 01:52:05 PST
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a10:de80:1:4092:b9e9:2292:0:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F229F10D2
	for <git@vger.kernel.org>; Sat, 25 Nov 2023 01:52:05 -0800 (PST)
Received: from smtp.freedom.nl (c04cst-smtp-frd01.int.sover.in [10.10.4.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4Scn5x5P5MzHB;
	Sat, 25 Nov 2023 09:45:41 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [10.10.4.107]) by freedom.nl (Postfix) with ESMTPSA id 4Scn5x2Ykkz1g;
	Sat, 25 Nov 2023 09:45:41 +0000 (UTC)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freedom.nl;
	s=default; t=1700905541;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KhJHI6tr592TC2QR8PjsLNa16qpnTd/Lkrl41OEeznE=;
	b=PGm/RT31CdJZ2tflv24p0b+epDTtzCJojXTyXxjNxkuCfmUYED7EyYmRpuh3re60A34dz1
	RhkzUdnwfoR6xsmmoZ1VFgvjfeeaGpl8nKw/lQLUv4Z+Ps28kZgFayDTyHvQQUMMhF24sK
	+lQclGAKWqkreoCUKnkpEvosNbYoKkE=
ARC-Seal: i=1; s=default; d=freedom.nl; t=1700905541; a=rsa-sha256;
	cv=none;
	b=ySZX7nk8P7tPaHsR2CFrJA/boSEGkjaXFlXm9aiLwZZqU5syG+THRp8+jZHoJqIJ4Czdxf
	NrZvCuGofcDzpl8IbNn8az3t3t8uGi8rT2wscxpvdkMasGPvFDjCrPLDuKMxAXoZBrr5jp
	mHAuYGAHDZtjLUp88xetBEMFh0XPRxY=
ARC-Authentication-Results: i=1;
	smtp.freedom.nl;
	auth=pass smtp.mailfrom=merijn@tux.freedom.nl
Received: by tux (Postfix, from userid 203)
	id 4A03D8CACD8CC; Sat, 25 Nov 2023 10:45:41 +0100 (CET)
X-Soverin-Authenticated: true
From: "H.Merijn Brand - Tux" <linux@tux.freedom.nl>
To: git@vger.kernel.org
Cc: "H.Merijn Brand - Tux" <linux@tux.freedom.nl>
Subject: [PATCH 1/1] git-send-email causes failures because of wrong option specifications
Date: Sat, 25 Nov 2023 10:44:29 +0100
Message-ID: <20231125094429.12025-2-linux@tux.freedom.nl>
In-Reply-To: <20231125094429.12025-1-linux@tux.freedom.nl>
References: <20231125094429.12025-1-linux@tux.freedom.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From the Getopt::Long changes:
```
Changes in version 2.55
-----------------------
* Fix long standing bug that duplicate options were not detected when
  the options differ in case while ignore_case is in effect.
  This will now yield a warning and become a fatal error in a future
  release.
```

Current version is 2.57

```
git-2.43.0 🐧 perl -Iperl git-send-email.perl --help
Duplicate specification "cc-cover|cc-cover!" for option "cc-cover"
Duplicate specification "no-cc-cover" for option "no-cc-cover"
Duplicate specification "to-cover|to-cover!" for option "to-cover"
Duplicate specification "no-annotate" for option "no-annotate"
Duplicate specification "no-format-patch" for option "no-format-patch"
Duplicate specification "no-signed-off-cc|no-signed-off-by-cc" for option "no-signed-off-cc"
Duplicate specification "no-signed-off-cc|no-signed-off-by-cc" for option "no-signed-off-by-cc"
Duplicate specification "no-validate" for option "no-validate"
Duplicate specification "no-chain-reply-to" for option "no-chain-reply-to"
```

`"option!" => \$value`

*automatically* supports both `--option` and `--no-option` and `--nooption`

See the docs for Getopt::Long:
```
 The argument specification can be

 !   The option does not take an argument and may be negated by
     prefixing it with "no" or "no-". E.g. "foo!" will allow "--foo" (a
     value of 1 will be assigned) as well as "--nofoo" and "--no-foo" (a
     value of 0 will be assigned). If the option has aliases, this
     applies to the aliases as well.

     Using negation on a single letter option when bundling is in effect
     is pointless and will result in a warning.
```

Signed-off-by: H.Merijn Brand - Tux <linux@tux.freedom.nl>
---
 git-send-email.perl | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index d24e981d61..125f49cd08 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -491,7 +491,6 @@ sub config_regexp {
 		    "bcc=s" => \@getopt_bcc,
 		    "no-bcc" => \$no_bcc,
 		    "chain-reply-to!" => \$chain_reply_to,
-		    "no-chain-reply-to" => sub {$chain_reply_to = 0},
 		    "sendmail-cmd=s" => \$sendmail_cmd,
 		    "smtp-server=s" => \$smtp_server,
 		    "smtp-server-option=s" => \@smtp_server_options,
@@ -506,36 +505,27 @@ sub config_regexp {
 		    "smtp-auth=s" => \$smtp_auth,
 		    "no-smtp-auth" => sub {$smtp_auth = 'none'},
 		    "annotate!" => \$annotate,
-		    "no-annotate" => sub {$annotate = 0},
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
 		    "header-cmd=s" => \$header_cmd,
 		    "no-header-cmd" => \$no_header_cmd,
 		    "suppress-from!" => \$suppress_from,
-		    "no-suppress-from" => sub {$suppress_from = 0},
 		    "suppress-cc=s" => \@suppress_cc,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
-		    "no-signed-off-cc|no-signed-off-by-cc" => sub {$signed_off_by_cc = 0},
-		    "cc-cover|cc-cover!" => \$cover_cc,
-		    "no-cc-cover" => sub {$cover_cc = 0},
-		    "to-cover|to-cover!" => \$cover_to,
-		    "no-to-cover" => sub {$cover_to = 0},
+		    "cc-cover!" => \$cover_cc,
+		    "to-cover!" => \$cover_to,
 		    "confirm=s" => \$confirm,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
 		    "thread!" => \$thread,
-		    "no-thread" => sub {$thread = 0},
 		    "validate!" => \$validate,
-		    "no-validate" => sub {$validate = 0},
 		    "transfer-encoding=s" => \$target_xfer_encoding,
 		    "format-patch!" => \$format_patch,
-		    "no-format-patch" => sub {$format_patch = 0},
 		    "8bit-encoding=s" => \$auto_8bit_encoding,
 		    "compose-encoding=s" => \$compose_encoding,
 		    "force" => \$force,
 		    "xmailer!" => \$use_xmailer,
-		    "no-xmailer" => sub {$use_xmailer = 0},
 		    "batch-size=i" => \$batch_size,
 		    "relogin-delay=i" => \$relogin_delay,
 		    "git-completion-helper" => \$git_completion_helper,
-- 
2.42.1

