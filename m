From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1] send-email: provide whitelist of SMTP AUTH mechanisms
Date: Sat, 1 Aug 2015 05:33:28 -0400
Message-ID: <CAPig+cT842GAFFM-wfjSU1ZiOevDCOPNDWxux6-vqtdr=3F4qw@mail.gmail.com>
References: <1438385617-29159-1-git-send-email-viktorin@rehivetech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jan Viktorin <viktorin@rehivetech.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 11:33:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLTAq-0007Vf-7f
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 11:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbbHAJdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2015 05:33:31 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34678 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbbHAJd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2015 05:33:29 -0400
Received: by ykax123 with SMTP id x123so77240609yka.1
        for <git@vger.kernel.org>; Sat, 01 Aug 2015 02:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TkpZW8q5Q4kiaVAtEhSfmVcLfx7jhV+0GZ2beXVm4HY=;
        b=IeNFcQsMkVdN3c67qhHEGr0Xr1VE/mMWei+WNiHyyb4bjxSuF2gyEDDL2XK3rF8Ibs
         ehERg3VXN+2WwQSxTFlCyg/NL89znML8DB4bcOZdbkrSe1wgy0dnra/XTbcfYa+y7GZI
         6enNqYJyrNIjcWgbagoI0np4MSDXnugd1lz8RJgKInBg+gWh1r7B2s/DAvOvAggS5dhX
         BrPwHCwHFhMthBDuXyg7UQ/CP3K55mj/X8qJ58Pr8448A1gENa0y4bMhsTV9RJzD/eYb
         LY12ZYjk/qNZ3zyLhHSW7tEIwVuVV4ZZzW6cQiWFmXSSQ2wmxnktYx2odQyG8MbFhg2A
         Vr+w==
X-Received: by 10.170.97.9 with SMTP id o9mr8786596yka.84.1438421608897; Sat,
 01 Aug 2015 02:33:28 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 1 Aug 2015 02:33:28 -0700 (PDT)
In-Reply-To: <1438385617-29159-1-git-send-email-viktorin@rehivetech.com>
X-Google-Sender-Auth: MgqFawRa0x5HCLKNZ20IBHVWLaA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275117>

On Fri, Jul 31, 2015 at 7:33 PM, Jan Viktorin <viktorin@rehivetech.com> wrote:
> When sending an e-mail, the client and server must
> agree on an authentication mechanism. Some servers
> (due to misconfiguration or a bug) denies valid

s/denies/deny/

> credentials for certain mechanisms. In this patch,
> a new option --smtp-auth and configuration entry
> smtpauth are introduced.
>
> If smtp_auth is defined, it works as a whitelist
> of allowed mechanisms for authentication. There
> are four mechanisms supported: PLAIN, LOGIN,
> CRAM-MD5, DIGEST-MD5. However, their availability
> depends on the installed SASL library.
>
> Signed-off-by: Jan Viktorin <viktorin@rehivetech.com>
> ---
>  git-send-email.perl | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)

At the very least, you will also want to update the documentation
(Documentation/git-send-email.txt) and, if possible, add new tests
(t/t9001-send-email.sh).

More below.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index ae9f869..b00ed9d 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1129,6 +1134,16 @@ sub smtp_auth_maybe {
>                 return 1;
>         }
>
> +       # Do not allow arbitrary strings.

Can you explain why this restriction is needed. What are the
consequences of not limiting the input to this "approved" list?

> +       my ($filtered_auth) = "";

Style: unnecessary parentheses

> +       foreach ("PLAIN", "LOGIN", "CRAM-MD5", "DIGEST-MD5") {

This might read more nicely and be easier to maintain if written as:

    foreach (qw/PLAIN LOGIN CRAM-MD5 DIGEST-MD5/) {

> +               if($smtp_auth && $smtp_auth =~ /\b\Q$_\E\b/i) {

Style: space after 'if'

Also, why not lift the 'if ($smtp_auth)' check outside the loop since
its value never changes and there's no need to iterate over the list
if $smtp_auth is empty.

> +                       $filtered_auth .= $_ . " ";

Style question: Would this be more naturally expressed with
'filtered_auth' as an array onto which items are pushed, rather than
as a string? At the point of use, the string can be recreated via
join().

Not a big deal; just wondering.

> +               }
> +       }
> +
> +       die "Invalid SMTP AUTH." if length $smtp_auth && !length $filtered_auth;

Style: drop capitalization: "invalid..."
Style: drop period at end
Style: add "\n" at end in order to suppress printing of the
    perl line number and input line number which aren't
    very meaningful for a user error

(Existing style in the script is not very consistent, but new code
probably should adhere the above suggestions.)

Also, don't you want to warn the user about tokens that don't match
one of the accepted (PLAIN, LOGIN, CRAM-MD5, DIGEST-MD5), rather than
dropping them silently?

>         # Workaround AUTH PLAIN/LOGIN interaction defect
>         # with Authen::SASL::Cyrus
>         eval {
> @@ -1148,6 +1163,20 @@ sub smtp_auth_maybe {
>                 'password' => $smtp_authpass
>         }, sub {
>                 my $cred = shift;
> +
> +               if($filtered_auth) {

Style: space after 'if'

> +                       my $sasl = Authen::SASL->new(
> +                               mechanism => $filtered_auth,
> +                               callback => {
> +                                       user => $cred->{'username'},
> +                                       pass => $cred->{'password'},
> +                                       authname => $cred->{'username'},
> +                               }
> +                       );
> +
> +                       return !!$smtp->auth($sasl);
> +               }
> +
>                 return !!$smtp->auth($cred->{'username'}, $cred->{'password'});
>         });
>
> --
> 2.5.0
