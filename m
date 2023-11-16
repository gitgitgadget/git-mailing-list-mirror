Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KLFllywr"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4C1D55
	for <git@vger.kernel.org>; Thu, 16 Nov 2023 11:30:36 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5735D1D286;
	Thu, 16 Nov 2023 14:30:36 -0500 (EST)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=6xnqA699C7C+iXDLI3kdAYBQ1
	8JrBhF2S1G+uc1117M=; b=KLFllywrouTUsMSmeQ4XtW/YlMENcy08UY0r/u5N5
	YKIDRDGugwF5Vw49aCJRpJwLjYgi+SDxWQWaVgE5RZoRe6DUsGDCM2Zrdcp6tc/3
	t9QtGSzvCtZ4rZse26LM76926HExaX2epZOgEmlCO4TmmM7YEA0MD/D4njvuR4F0
	cE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F0751D285;
	Thu, 16 Nov 2023 14:30:36 -0500 (EST)
	(envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3E6C01D27B;
	Thu, 16 Nov 2023 14:30:30 -0500 (EST)
	(envelope-from tmz@pobox.com)
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	=?UTF-8?q?Ond=C5=99ej=20Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>
Subject: [PATCH v3 2/2] send-email: avoid duplicate specification warnings
Date: Thu, 16 Nov 2023 14:30:11 -0500
Message-ID: <20231116193014.470420-3-tmz@pobox.com>
X-Mailer: git-send-email 2.43.0.rc2
In-Reply-To: <20231116193014.470420-1-tmz@pobox.com>
References: <20231116193014.470420-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 9B32EF94-84B6-11EE-B3E2-F515D2CDFF5E-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

A warning is issued for options which are specified more than once
beginning with perl-Getopt-Long >=3D 2.55.  In addition to causing users
to see warnings, this results in test failures which compare the output.
An example, from t9001-send-email.37:

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

Remove the duplicate option specs.  These are primarily the explicit
'--no-' prefix opts which were added in f471494303 (git-send-email.perl:
support no- prefix with older GetOptions, 2015-01-30).  This was done
specifically to support perl-5.8.0 which includes Getopt::Long 2.32[1].

Getopt::Long 2.33 added support for the '--no-' prefix natively by
appending '!' to the option specification string, which was included in
perl-5.8.1 and is not present in perl-5.8.0.  The previous commit bumped
the minimum supported Perl version to 5.8.1 so we no longer need to
provide the '--no-' variants for negatable options manually.

Teach `--git-completion-helper` to output the '--no-' options.  They are
not included in the options hash and would otherwise be lost.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 git-send-email.perl | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index d75a4a33dd..f214bd4521 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -119,13 +119,16 @@ sub completion_helper {
=20
 	foreach my $key (keys %$original_opts) {
 		unless (exists $not_for_completion{$key}) {
-			$key =3D~ s/!$//;
+			my $negatable =3D ($key =3D~ s/!$//);
=20
 			if ($key =3D~ /[:=3D][si]$/) {
 				$key =3D~ s/[:=3D][si]$//;
 				push (@send_email_opts, "--$_=3D") foreach (split (/\|/, $key));
 			} else {
 				push (@send_email_opts, "--$_") foreach (split (/\|/, $key));
+				if ($negatable) {
+					push (@send_email_opts, "--no-$_") foreach (split (/\|/, $key));
+				}
 			}
 		}
 	}
@@ -491,7 +494,6 @@ sub config_regexp {
 		    "bcc=3Ds" =3D> \@getopt_bcc,
 		    "no-bcc" =3D> \$no_bcc,
 		    "chain-reply-to!" =3D> \$chain_reply_to,
-		    "no-chain-reply-to" =3D> sub {$chain_reply_to =3D 0},
 		    "sendmail-cmd=3Ds" =3D> \$sendmail_cmd,
 		    "smtp-server=3Ds" =3D> \$smtp_server,
 		    "smtp-server-option=3Ds" =3D> \@smtp_server_options,
@@ -506,36 +508,27 @@ sub config_regexp {
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
 		    "signed-off-cc|signed-off-by-cc!" =3D> \$signed_off_by_cc,
-		    "no-signed-off-cc|no-signed-off-by-cc" =3D> sub {$signed_off_by_cc=
 =3D 0},
-		    "cc-cover|cc-cover!" =3D> \$cover_cc,
-		    "no-cc-cover" =3D> sub {$cover_cc =3D 0},
-		    "to-cover|to-cover!" =3D> \$cover_to,
-		    "no-to-cover" =3D> sub {$cover_to =3D 0},
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
--=20
2.43.0.rc2

