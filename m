Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35194179A4
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ifbv1ryw"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7310112
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 08:39:20 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C8F71C38A1;
	Tue, 14 Nov 2023 11:39:20 -0500 (EST)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=9gMUXykxzqCNL9ueJXrdFICNCt+T7kd5TMJRWnvotJ0=; b=Ifbv
	1rywQFDGrNc3Pt+sdY3D7KTIUQZYSeyoDot66kZA0ZPbfW3ErNMfKNd+RGw5kccA
	3uXiZAdNR/OuHQOfCzXpUVeHv21cUrIF/SWpgd94KuCjGeh5/YW5Dnilm5RwKR6i
	yq0RSHidAOtxsnp6b8kPMgQRKLIuj2vKY5IuZP8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 034511C389F;
	Tue, 14 Nov 2023 11:39:20 -0500 (EST)
	(envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 213F81C389C;
	Tue, 14 Nov 2023 11:39:19 -0500 (EST)
	(envelope-from tmz@pobox.com)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Ond=C5=99ej=20Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>
Subject: [PATCH] send-email: avoid duplicate specification warnings
Date: Tue, 14 Nov 2023 11:38:19 -0500
Message-ID: <20231114163826.207267-1-tmz@pobox.com>
X-Mailer: git-send-email 2.43.0.rc1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 5B86FF26-830C-11EE-868F-78DCEB2EC81B-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

With perl-Getopt-Long >=3D 2.55, a warning is issued for options which ar=
e
specified more than once.  In addition to causing users to see warnings,
this results in test failures which compare the output.  An example,
from t9001-send-email.37:

  | +++ diff -u expect actual
  | --- expect      2023-11-14 10:38:23.854346488 +0000
  | +++ actual      2023-11-14 10:38:23.848346466 +0000
  | @@ -1,2 +1,7 @@
  | +Duplicate specification "no-chain-reply-to" for option "no-chain-rep=
ly-to"
  | +Duplicate specification "to-cover|to-cover!" for option "to-cover"
  | +Duplicate specification "cc-cover|cc-cover!" for option "cc-cover"
  | +Duplicate specification "no-thread" for option "no-thread"
  | +Duplicate specification "no-to-cover" for option "no-to-cover"
  |  fatal: longline.patch:35 is longer than 998 characters
  |  warning: no patches were sent
  | error: last command exited with $?=3D1
  | not ok 37 - reject long lines

Remove the duplicate option specs.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

I've run this through the full test suite.  I also compared the output of
--help to ensure it only differs in the removal of the "Duplicate
specification" warnings.  I _think_ that's a good sign that no other chan=
ges
will result.  But I would be grateful to anyone who can confirm or reject=
 that
theory.

 git-send-email.perl | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index cacdbd6bb2..13d9c47fe5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -491,7 +491,6 @@ sub config_regexp {
 		    "bcc=3Ds" =3D> \@getopt_bcc,
 		    "no-bcc" =3D> \$no_bcc,
 		    "chain-reply-to!" =3D> \$chain_reply_to,
-		    "no-chain-reply-to" =3D> sub {$chain_reply_to =3D 0},
 		    "sendmail-cmd=3Ds" =3D> \$sendmail_cmd,
 		    "smtp-server=3Ds" =3D> \$smtp_server,
 		    "smtp-server-option=3Ds" =3D> \@smtp_server_options,
@@ -506,36 +505,27 @@ sub config_regexp {
 		    "smtp-auth=3Ds" =3D> \$smtp_auth,
 		    "no-smtp-auth" =3D> sub {$smtp_auth =3D 'none'},
 		    "annotate!" =3D> \$annotate,
-		    "no-annotate" =3D> sub {$annotate =3D 0},
 		    "compose" =3D> \$compose,
 		    "quiet" =3D> \$quiet,
 		    "cc-cmd=3Ds" =3D> \$cc_cmd,
 		    "header-cmd=3Ds" =3D> \$header_cmd,
 		    "no-header-cmd" =3D> \$no_header_cmd,
 		    "suppress-from!" =3D> \$suppress_from,
-		    "no-suppress-from" =3D> sub {$suppress_from =3D 0},
 		    "suppress-cc=3Ds" =3D> \@suppress_cc,
-		    "signed-off-cc|signed-off-by-cc!" =3D> \$signed_off_by_cc,
-		    "no-signed-off-cc|no-signed-off-by-cc" =3D> sub {$signed_off_by_cc=
 =3D 0},
-		    "cc-cover|cc-cover!" =3D> \$cover_cc,
-		    "no-cc-cover" =3D> sub {$cover_cc =3D 0},
-		    "to-cover|to-cover!" =3D> \$cover_to,
-		    "no-to-cover" =3D> sub {$cover_to =3D 0},
+		    "signed-off-by-cc!" =3D> \$signed_off_by_cc,
+		    "cc-cover!" =3D> \$cover_cc,
+		    "to-cover!" =3D> \$cover_to,
 		    "confirm=3Ds" =3D> \$confirm,
 		    "dry-run" =3D> \$dry_run,
 		    "envelope-sender=3Ds" =3D> \$envelope_sender,
 		    "thread!" =3D> \$thread,
-		    "no-thread" =3D> sub {$thread =3D 0},
 		    "validate!" =3D> \$validate,
-		    "no-validate" =3D> sub {$validate =3D 0},
 		    "transfer-encoding=3Ds" =3D> \$target_xfer_encoding,
 		    "format-patch!" =3D> \$format_patch,
-		    "no-format-patch" =3D> sub {$format_patch =3D 0},
 		    "8bit-encoding=3Ds" =3D> \$auto_8bit_encoding,
 		    "compose-encoding=3Ds" =3D> \$compose_encoding,
 		    "force" =3D> \$force,
 		    "xmailer!" =3D> \$use_xmailer,
-		    "no-xmailer" =3D> sub {$use_xmailer =3D 0},
 		    "batch-size=3Di" =3D> \$batch_size,
 		    "relogin-delay=3Di" =3D> \$relogin_delay,
 		    "git-completion-helper" =3D> \$git_completion_helper,
