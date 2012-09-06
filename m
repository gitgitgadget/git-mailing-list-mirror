From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] send-email: validate & reconfirm interactive responses
Date: Thu, 6 Sep 2012 11:31:11 -0700
Message-ID: <CALaEz9W_RR70KEzxk7GxjOu1_yv4UudckcsKAP2C_39Nc2yLbw@mail.gmail.com>
References: <CAOeW2eGZm7PLRaktjQQdDJm2BqAihS0pzsY2GUNFUO83s8qBPQ@mail.gmail.com>
 <1344983132-22578-1-git-send-email-gitster@pobox.com> <CALaEz9WVCj0gu-CbUJgydik1bC7z7JCcveKTdyxgrTWokXq5JA@mail.gmail.com>
 <7vsjav6d85.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 20:31:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9grX-0003RT-Lc
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 20:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932966Ab2IFSb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 14:31:28 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61509 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932373Ab2IFSb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 14:31:27 -0400
Received: by iahk25 with SMTP id k25so2368915iah.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=I8u7dxRkmDB+MyFyM3GnSFx9ZZkxhGRTEL6kSvqVrfc=;
        b=IW9EEwFL0mT4/UHli+OjELJaL3yrM3sfdfcpq1IkyH97CtZPGAEhKI4ihpC0jKrjbe
         IOX2ZU1nFo+J+FPPZFl8OEg7smwT6XY1w82+J5UYOuVSxLvDsBilwKu0Pc0Fqg7U1XAd
         oTavRttoOdkLwBbWK73PUMtI+XygkbDpj2pRjPKd9Fs+JpaZ92sGVE1ans8nxE6AGI/j
         bzTBRUOYSiEVN9KK+5h/SP6ouKHRnbE1Cwo7imMwr6dVRq1mra5LGXcBr74NW+HeWK6Q
         /7pWWLPQ1+7KsU3XKDRyXCwsz6Gfy8r6fUx7u95PtTrn19wFA4DRgg02gnJUusbHv8yv
         ySKg==
Received: by 10.50.169.70 with SMTP id ac6mr4434812igc.12.1346956286691; Thu,
 06 Sep 2012 11:31:26 -0700 (PDT)
Received: by 10.64.64.33 with HTTP; Thu, 6 Sep 2012 11:31:11 -0700 (PDT)
In-Reply-To: <7vsjav6d85.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204913>

(Sorry sending this from web interface)

On Wed, Sep 5, 2012 at 8:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stephen Boyd <bebarino@gmail.com> writes:
>> This is now bugging me if I just hit enter and don't want to specify
>> anything for
>> these headers (I want the defaults or what's in the files already).
>> Can we allow
>> the empty string to be valid as well so I don't have to go through
>> these prompts?
>
> That indeed was the intention, and if it is not behaving, you found
> a bug.
>
> The relevant code in "sub ask" does this:
>
>                 ...
>                 $resp = $term->readline($prompt);
>                 if (!defined $resp) { # EOF
>                         print "\n";
>                         return defined $default ? $default : undef;
>                 }
>                 if ($resp eq '' and defined $default) {
>                         return $default;
>                 }
>                 if (!defined $valid_re or $resp =~ /$valid_re/) {
>                         return $resp;
>                 }
>
> I am scratching my head wondering why your "just hit enter" does not
> trigger the "if response is empty and we have default, just return it"
> codepath we can see above.  It shouldn't even trigger the regexp
> based validation codepath in the first place.
>

It works fine for "Who should the emails appear to be from?" but
beyond that we have "Who should the emails be sent to?" and
"Message-ID to be used as In-Reply-To for the first email?" which I
typically just hit enter to. It seems that they have no "default"
argument so that second if fails. I suppose we can add a default => ""
to these two asks?

----8<-----
diff --git a/git-send-email.perl b/git-send-email.perl
index 607137b..13d813e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -760,6 +760,7 @@ if (!defined $sender) {

 if (!@initial_to && !defined $to_cmd) {
        my $to = ask("Who should the emails be sent to? ",
+                    default => "",
                     valid_re => qr/\@.*\./, confirm_only => 1);
        push @initial_to, parse_address_line($to) if defined $to; #
sanitized/validated later
        $prompting++;
@@ -787,6 +788,7 @@ sub expand_one_alias {
 if ($thread && !defined $initial_reply_to && $prompting) {
        $initial_reply_to = ask(
                "Message-ID to be used as In-Reply-To for the first email? ",
+               default => "",
                valid_re => qr/\@.*\./, confirm_only => 1);
 }
 if (defined $initial_reply_to) {
