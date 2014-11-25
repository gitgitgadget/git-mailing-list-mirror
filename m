From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] git-send-email: add --transfer-encoding option
Date: Tue, 25 Nov 2014 15:44:19 -0500
Message-ID: <CAPig+cQ_jm1W3n7KqrRihuj7ie=wGTRMupyAnfLHXqFAAnhv4Q@mail.gmail.com>
References: <1416924027-29862-1-git-send-email-bonzini@gnu.org>
	<1416924027-29862-3-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, lersek@redhat.com,
	Paolo Bonzini <pbonzini@redhat.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Nov 25 21:44:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtMyI-0005AF-OE
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 21:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbaKYUoW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Nov 2014 15:44:22 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:42216 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbaKYUoU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2014 15:44:20 -0500
Received: by mail-yh0-f50.google.com with SMTP id 29so725907yhl.37
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 12:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=RzPw2A6vPpOwDznM0Ak0jfHrrYTP6SZ38voryol2Z6o=;
        b=gakjEKR8Z8z0OME5Grk5VmV+ZRG6q33UQjfPpcryG8TuKsqo39MSq3Z1Hm/ar51kMa
         HnVjX1HApnm1Ufy9VpyHVJcSdjsmuE5R1DIt+PMrWW4q8Ydb9MjtFT3sUQa6pzoMLrCS
         dy9IDDcUuJHd1kzYHRLODd5CVlbesLyWZ44LGhyMN11EYELW3q/GXgFCwgmi6OhAQ2/F
         Gi0/YFlmkV6rWUq9DdfwlN5BXq3G0xcImu51PS1266RVwo975V7jNns8PmJai4un0a/x
         v2IqT2wt6v9Sfx6b+6jULA3NRLaS99dENcfjbkZpaGl8dA3U+aou36/mwJXDdBaIorlM
         4UFg==
X-Received: by 10.236.199.78 with SMTP id w54mr26401659yhn.148.1416948259683;
 Tue, 25 Nov 2014 12:44:19 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Tue, 25 Nov 2014 12:44:19 -0800 (PST)
In-Reply-To: <1416924027-29862-3-git-send-email-bonzini@gnu.org>
X-Google-Sender-Auth: tXnaFpWwEytSRreXr1WP5u2tzi0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260240>

On Tue, Nov 25, 2014 at 9:00 AM, Paolo Bonzini <bonzini@gnu.org> wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
>
> The thread at http://thread.gmane.org/gmane.comp.version-control.git/=
257392
> details problems when applying patches with "git am" in a repository =
with
> CRLF line endings.  In the example in the thread, the repository orig=
inated
> from "git-svn" so it is not possible to use core.eol and friends on i=
t.
>
> Right now, the best option is to use "git am --keep-cr".  However, wh=
en
> a patch create new files, the patch application process will reject t=
he
> new file because it finds a "/dev/null\r" string instead of "/dev/nul=
l".
>
> The problem is that SMTP transport is CRLF-unsafe.  Sending a patch b=
y
> email is the same as passing it through "dos2unix | unix2dos".  The n=
ewly
> introduced CRLFs are normally transparent because git-am strips them.=
 The
> keepcr=3Dtrue setting preserves them, but it is mostly working by cha=
nce
> and it would be very problematic to have a "git am" workflow in a
> repository with mixed LF and CRLF line endings.
>
> The MIME solution to this is the quoted-printable transfer enconding.
> This is not something that we want to enable by default, since it mak=
es
> received emails horrible to look at.  However, it is a very good matc=
h
> for projects that store CRLF line endings in the repository.
>
> The only disadvantage of quoted-printable is that quoted-printable
> patches fail to apply if the maintainer uses "git am --keep-cr".  Thi=
s
> is because the decoded patch will have two carriage returns at the en=
d
> of the line.  Therefore, add support for base64 transfer encoding too=
,
> which makes received emails downright impossible to look at outside
> a MUA, but really just works.
>
> The patch covers all bases, including users that still live in the la=
te
> 80s, by also providing a 7bit content transfer encoding that refuses
> to send emails with non-ASCII character in them.  And finally, "8bit"
> will add a Content-Transfer-Encoding header but otherwise do nothing.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 19a3ced..e5016f4 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1298,6 +1298,163 @@ test_expect_success $PREREQ '--8bit-encoding =
also treats subject' '
>         test_cmp expected actual
>  '
>
> +test_expect_success $PREREQ 'setup expect' '
> +cat >email-using-8bit <<EOF

The test title says "setup expect", but this is creating an 8-bit
email message for input to git-send-email rather than expected output.
Perhaps the test title should be adjusted.

> +From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 20=
01
> +Message-Id: <bogus-message-id@example.com>
> +From: A U Thor <author@example.com>
> +Date: Sat, 12 Jun 2010 15:53:58 +0200
> +Content-Type: text/plain; charset=3DUTF-8
> +Subject: Nothing to see here.
> +
> +Dieser Betreff enth=C3=A4lt auch einen Umlaut!
> +EOF
> +'
> +
> +test_expect_success $PREREQ 'sendemail.transferencoding=3D7bit fails=
 on 8bit data' '
> +       clean_fake_sendmail &&
> +       git config sendemail.transferEncoding 7bit &&

test_config here and elsewhere perhaps?

> +       test_must_fail git send-email \
> +         --transfer-encoding=3D7bit \

Redundant 7bit request.

> +         --smtp-server=3D"$(pwd)/fake.sendmail" \
> +         email-using-8bit \
> +         2>errors >out &&
> +       grep "cannot send message as 7bit" errors &&
> +       test -z "$(ls msgtxt*)"
> +'
> +
> +test_expect_success $PREREQ '--transfer-encoding overrides sendemail=
=2EtransferEncoding' '
> +       clean_fake_sendmail &&
> +       git config sendemail.transferEncoding 8bit

Broken &&-chain.

> +       test_must_fail git send-email \
> +         --transfer-encoding=3D7bit \
> +         --smtp-server=3D"$(pwd)/fake.sendmail" \
> +         email-using-8bit \
> +         2>errors >out &&
> +       grep "cannot send message as 7bit" errors &&
> +       test -z "$(ls msgtxt*)"
> +'
> +
> +test_expect_success $PREREQ 'sendemail.transferencoding=3D8bit' '
> +       clean_fake_sendmail &&
> +       git send-email \
> +         --transfer-encoding=3D8bit \
> +         --smtp-server=3D"$(pwd)/fake.sendmail" \
> +         email-using-8bit \
> +         2>errors >out &&

Is it necessary here to capture stdout and stderr rather than allowing
them to be handled automatically by the testing framework? In the two
prior tests, you do consult 'error' so it makes send to capture it,
but this test does not, nor do any following tests which capture those
streams. (The same question applies to the capture of stdout in the
above two tests. Is it necessary?)

> +       sed '1,/^$/d' msgtxt1 >actual &&
> +       sed '1,/^$/d' email-using-8bit >expected &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success $PREREQ 'setup expect' '
> +cat >expected <<EOF
> +Dieser Betreff enth=3DC3=3DA4lt auch einen Umlaut!
> +EOF

This "expected" file is used only by the following test. It might be
clearer and more robust (in case someone inserts new tests in between
these) to create the "expected" file directly in the test which uses
it. The same comment applies to other "expected" files each used by
only a single test.

> +'
> +
> +test_expect_success $PREREQ '8-bit and sendemail.transferencoding=3D=
quoted-printable' '
> +       clean_fake_sendmail &&
> +       git send-email \
> +         --transfer-encoding=3Dquoted-printable \
> +         --smtp-server=3D"$(pwd)/fake.sendmail" \
> +         email-using-8bit \
> +         2>errors >out &&
> +       sed '1,/^$/d' msgtxt1 >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success $PREREQ 'setup expect' '
> +cat >expected <<EOF
> +RGllc2VyIEJldHJlZmYgZW50aMOkbHQgYXVjaCBlaW5lbiBVbWxhdXQhCg=3D=3D
> +EOF
> +'
> +
> +test_expect_success $PREREQ '8-bit and sendemail.transferencoding=3D=
base64' '
> +       clean_fake_sendmail &&
> +       git send-email \
> +         --transfer-encoding=3Dbase64 \
> +         --smtp-server=3D"$(pwd)/fake.sendmail" \
> +         email-using-8bit \
> +         2>errors >out &&
> +       sed '1,/^$/d' msgtxt1 >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success $PREREQ 'setup expect' '
> +cat >email-using-qp <<EOF

Test title says "setup expect" but it's really setting up a
quoted-printable email.

> +From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 20=
01
> +Message-Id: <bogus-message-id@example.com>
> +From: A U Thor <author@example.com>
> +Date: Sat, 12 Jun 2010 15:53:58 +0200
> +MIME-Version: 1.0
> +Content-Transfer-Encoding: quoted-printable
> +Content-Type: text/plain; charset=3DUTF-8
> +Subject: Nothing to see here.
> +
> +Dieser Betreff enth=3DC3=3DA4lt auch einen Umlaut!
> +EOF
> +'
> +
> +test_expect_success $PREREQ 'convert from quoted-printable to base64=
' '
> +       clean_fake_sendmail &&
> +       git send-email \
> +         --transfer-encoding=3Dbase64 \
> +         --smtp-server=3D"$(pwd)/fake.sendmail" \
> +         email-using-qp \
> +         2>errors >out &&
> +       sed '1,/^$/d' msgtxt1 >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success $PREREQ 'setup expect' "
> +tr -d '\\015' | tr '%' '\\015' > email-using-crlf <<EOF

Ditto: Test title says "setup expect" but it's setting up a CRLF email.

> +From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 20=
01
> +Message-Id: <bogus-message-id@example.com>
> +From: A U Thor <author@example.com>
> +Date: Sat, 12 Jun 2010 15:53:58 +0200
> +Content-Type: text/plain; charset=3DUTF-8
> +Subject: Nothing to see here.
> +
> +Look, I have a CRLF and an =3D sign!%
> +EOF
> +"
> +
> +test_expect_success $PREREQ 'setup expect' '
> +cat >expected <<EOF
> +Look, I have a CRLF and an =3D3D sign!=3D0D
> +EOF
> +'
> +
> +test_expect_success $PREREQ 'CRLF and sendemail.transferencoding=3Dq=
uoted-printable' '
> +       clean_fake_sendmail &&
> +       git send-email \
> +         --transfer-encoding=3Dquoted-printable \
> +         --smtp-server=3D"$(pwd)/fake.sendmail" \
> +         email-using-crlf \
> +         2>errors >out &&
> +       sed '1,/^$/d' msgtxt1 >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success $PREREQ 'setup expect' '
> +cat >expected <<EOF
> +TG9vaywgSSBoYXZlIGEgQ1JMRiBhbmQgYW4gPSBzaWduIQ0K
> +EOF
> +'
> +
> +test_expect_success $PREREQ 'CRLF and sendemail.transferencoding=3Db=
ase64' '
> +       clean_fake_sendmail &&
> +       git send-email \
> +         --transfer-encoding=3Dbase64 \
> +         --smtp-server=3D"$(pwd)/fake.sendmail" \
> +         email-using-crlf \
> +         2>errors >out &&
> +       sed '1,/^$/d' msgtxt1 >actual &&
> +       test_cmp expected actual
> +'
> +
> +
>  # Note that the patches in this test are deliberately out of order; =
we
>  # want to make sure it works even if the cover-letter is not in the
>  # first mail.
> --
> 2.1.0
