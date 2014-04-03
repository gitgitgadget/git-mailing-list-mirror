From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/2] git-send-email: two new options: to-cover, cc-cover
Date: Thu, 3 Apr 2014 17:24:23 -0400
Message-ID: <CAPig+cQB4iTH8W-4HFrRk5KQe5OrBaz0WN24iYWqRrHCq5u4rA@mail.gmail.com>
References: <1396548814-27278-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 23:24:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVp7h-0006fP-Ju
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 23:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbaDCVY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 17:24:26 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:61182 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbaDCVYY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2014 17:24:24 -0400
Received: by mail-yk0-f173.google.com with SMTP id 10so2143392ykt.18
        for <git@vger.kernel.org>; Thu, 03 Apr 2014 14:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0cll6roG1MZigCx3ObPSNCmi/xQo7coYIW225QAJPaE=;
        b=fXwPluykBV8v+rcIOYk/yMPs0Y674eH0ZSkNvS3mtSn2hvbpkWI8O/sXBXJNtmqRfd
         oSNABE5OmLS/Ig2U1TTMpJqIrIQzE9wwJIE/G5zDMK/PWJ+OaVAgAHcj3dioF8AKz89H
         FVrNhci2ea1xaewj1XwJa9cpX5sIgqlb6UGLS16VY3tS8Xfw2ZumuPtayShBtuNIWvet
         mThpimYDwo3q/NoW39vqE01Wxh67k/dcf0N+78gjcITDJwosCdii6p5eitqRXdDorAfO
         5XBHuDP6hY+w1z7ZYj+7ImbEaXNO9M1cBgLhia6O1un0ZHovCkspRjskR3RRZupdO6++
         VBow==
X-Received: by 10.236.88.193 with SMTP id a41mr11677983yhf.22.1396560263910;
 Thu, 03 Apr 2014 14:24:23 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 3 Apr 2014 14:24:23 -0700 (PDT)
In-Reply-To: <1396548814-27278-1-git-send-email-mst@redhat.com>
X-Google-Sender-Auth: 5jCVKUfWckK46ya9OmCBEHsRVRA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245752>

On Thu, Apr 3, 2014 at 2:14 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> Allow extracting To/Cc addresses from cover letter.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  Documentation/git-send-email.txt | 12 ++++++++++++
>  git-send-email.perl              | 16 ++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index f0e57a5..1733664 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -248,6 +248,18 @@ Automating
>         cc list. Default is the value of 'sendemail.signedoffbycc' configuration
>         value; if that is unspecified, default to --signed-off-by-cc.
>
> +--[no-]cc-cover::
> +       If this is set, emails found in Cc: headers in the cover letter are
> +       added to the cc list for each email set. Default is the value of

s/email set/email sent/

> +       'sendemail.cccover' configuration value; if that is unspecified,
> +       default to --no-cc-cover.
> +
> +--[no-]to-cover::
> +       If this is set, emails found in To: headers in the cover letter are
> +       added to the to list for each email set. Default is the value of

Ditto.

> +       'sendemail.tocover' configuration value; if that is unspecified,
> +       default to --no-to-cover.
> +
>  --suppress-cc=<category>::
>         Specify an additional category of recipients to suppress the
>         auto-cc of:
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 8bbfb84..11d9a46 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -80,6 +80,8 @@ git send-email [options] <file | directory | rev-list options >
>      --to-cmd                <str>  * Email To: via `<str> \$patch_path`
>      --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
>      --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.
> +    --[no-]cc-cover                * Email Cc: addresses in the cover letter.
> +    --[no-]to-cover                * Email To: addresses in the cover letter.
>      --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses. Default on.
>      --[no-]suppress-from           * Send to self. Default off.
>      --[no-]chain-reply-to          * Chain In-Reply-To: fields. Default off.
> @@ -195,6 +197,7 @@ sub do_edit {
>
>  # Variables with corresponding config settings
>  my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc);
> +my ($cover_cc, $cover_to);
>  my ($to_cmd, $cc_cmd);
>  my ($smtp_server, $smtp_server_port, @smtp_server_options);
>  my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
> @@ -211,6 +214,8 @@ my %config_bool_settings = (
>      "chainreplyto" => [\$chain_reply_to, 0],
>      "suppressfrom" => [\$suppress_from, undef],
>      "signedoffbycc" => [\$signed_off_by_cc, undef],
> +    "cccover" => [\$cover_cc, undef],
> +    "tocover" => [\$cover_to, undef],
>      "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
>      "validate" => [\$validate, 1],
>      "multiedit" => [\$multiedit, undef],
> @@ -302,6 +307,8 @@ my $rc = GetOptions("h" => \$help,
>                     "suppress-from!" => \$suppress_from,
>                     "suppress-cc=s" => \@suppress_cc,
>                     "signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
> +                   "cc-cover|cc-cover!" => \$cover_cc,
> +                   "to-cover|to-cover!" => \$cover_to,
>                     "confirm=s" => \$confirm,
>                     "dry-run" => \$dry_run,
>                     "envelope-sender=s" => \$envelope_sender,
> @@ -1468,6 +1475,15 @@ foreach my $t (@files) {
>         @to = (@initial_to, @to);
>         @cc = (@initial_cc, @cc);
>
> +       if ($message_num == 1) {
> +               if (defined $cover_cc and $cover_cc) {
> +                       @initial_cc = @cc;
> +               }
> +               if (defined $cover_to and $cover_to) {
> +                       @initial_to = @to;
> +               }
> +       }
> +
>         my $message_was_sent = send_message();
>
>         # set up for the next message
> --
> MST
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
