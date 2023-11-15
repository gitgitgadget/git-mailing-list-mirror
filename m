Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WDCZDcyq"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1E3D56
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 09:40:20 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 942A51CC638;
	Wed, 15 Nov 2023 12:40:19 -0500 (EST)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=+PGzBwUoqonGS226ODvxKLQIX
	SwVoAq9MoE5OyFTrZQ=; b=WDCZDcyqdwQWYODWhrQNywehRT/SkyUxVPXggwTHw
	SqoXRCWNtiBFZ8HRRMoPZ0NAJjc3nXQ3OeL21bAHw6y29WPu6y0aRHsp77+S2TQn
	DCtexjPh69ETBigm5i/Jsx0+h5V2gs4jJJ4RullEeZIS76KwAYzV4c5jFOqbbRlH
	Yk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8CD621CC637;
	Wed, 15 Nov 2023 12:40:19 -0500 (EST)
	(envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A4E781CC636;
	Wed, 15 Nov 2023 12:40:17 -0500 (EST)
	(envelope-from tmz@pobox.com)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	=?UTF-8?q?Ond=C5=99ej=20Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>
Subject: [RFC PATCH v2 1/2] send-email: avoid duplicate specification warnings
Date: Wed, 15 Nov 2023 12:39:43 -0500
Message-ID: <20231115173952.339303-2-tmz@pobox.com>
X-Mailer: git-send-email 2.43.0.rc2
In-Reply-To: <20231115173952.339303-1-tmz@pobox.com>
References: <20231115173952.339303-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 0B42E8E0-83DE-11EE-A2E0-25B3960A682E-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

With perl-Getopt-Long >=3D 2.55 a warning is issued for options which are
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

Teach `--git-completion-helper` to output the '--no-' options.  They are
not included in the options hash and would otherwise be lost.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
I compared the output from

    git send-email --git-completion-helper | tr ' ' ' '\n' | sort

before and after the change to ensure no options were lost (or added).

I also confirmed that each of the options changed did not result in any
error.  Unrecognized options result in an error from `git format-patch`,
e.g.:

    $ git send-email --foo
    fatal: unrecognized argument: --foo
    format-patch -o /tmp/PaqtbH3jCw --foo: command returned error: 128

A little history:

  Support for the '--no-' prefix was added in Getopt::Long >=3D 2.33, in
  commit 8ca8b48 (Negatable options (with "!") now also support the
  "no-" prefix., 2003-04-04).  Getopt::Long 2.34 was included in
  perl-5.8.1 (2003-09-25), per Module::CoreList[1].
 =20
  We list perl-5.8 as the minimum version in INSTALL.  This would leave
  users with perl-5.8.0 (2002-07-18) with non-working arguments for
  options where we're removing the explicit 'no-' variant.
 =20
  The explicit 'no-' opts were added in f471494303 (git-send-email.perl:
  support no- prefix with older GetOptions, 2015-01-30), specifically to
  support perl-5.8.0 which includes the older Getopt::Long.
   =20
It may be time to bump the Perl requirement to 5.8.1 (2003-09-25) or
even 5.10.0 (2007-12-18).  We last bumped the requirement from 5.6 to
5.8 in d48b284183 (perl: bump the required Perl version to 5.8 from
5.6.[21], 2010-09-24).

Another option to avoid the warning from Getopt::Long >=3D 2.55 would be
to remove the '!' negation, but that would drop support for the 'no'
prefix variants (e.g.: `--nocc-cover`).  While these are not documented
(and I don't think they ever were[2]), they have worked for a long, long
time.  Odds are good that some scripts rely on them and we don't want
anyone yelling at Junio.

I lean toward dropping support for the 21-year-old 5.8.0.

If there is a way to have our cake without any consequence, I'm happy to
hear it.  If not, I'll add a commit which bumps the requirement in
general or notes that some git-send-email requires perl >=3D 5.8.1 and
adjusts the 'use' line there to `use 5.008001;`.

[1] http://perlpunks.de/corelist/mversion?module=3DGetopt%3A%3ALong

[2] The 'no-' opts were added in f471494303 (git-send-email.perl:
    support no- prefix with older GetOptions, 2015-01-30).  The commit
    message says "the help only mentions the 'no-' prefix and not the
    'no' prefix, add explicit support for the 'no-' prefix to support
    older GetOptions versions."

 git-send-email.perl | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index cacdbd6bb2..94046e0fb7 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -119,13 +119,16 @@ sub completion_helper {
=20
 	foreach my $key (keys %$original_opts) {
 		unless (exists $not_for_completion{$key}) {
-			$key =3D~ s/!$//;
+			my $negate =3D ($key =3D~ s/!$//);
=20
 			if ($key =3D~ /[:=3D][si]$/) {
 				$key =3D~ s/[:=3D][si]$//;
 				push (@send_email_opts, "--$_=3D") foreach (split (/\|/, $key));
 			} else {
 				push (@send_email_opts, "--$_") foreach (split (/\|/, $key));
+				if ($negate) {
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

