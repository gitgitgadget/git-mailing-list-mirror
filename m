From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 1/2] sendemail: teach git-send-email to list aliases
Date: Tue, 17 Nov 2015 00:25:23 -0800
Message-ID: <CA+P7+xo_ecs6iVK2byF1E7disNvKiKbacBUk4r2eSNWQtR+X-Q@mail.gmail.com>
References: <1447618940-27446-1-git-send-email-jacob.e.keller@intel.com>
 <CAPig+cQ929oAZqQM+X68x3PVQ-opwdi3VzjcQTUsaCfVK3411g@mail.gmail.com>
 <1447717227.23262.10.camel@intel.com> <CAPig+cSMW2UmTzuyvBFpcpr4tF1FRdxHUPH4+wS3vrZSP9AzJA@mail.gmail.com>
 <1447719035.23262.17.camel@intel.com> <20151117072049.GA25414@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"spearce@spearce.org" <spearce@spearce.org>,
	"lee.marlow@gmail.com" <lee.marlow@gmail.com>,
	"felipe.contreras@gmail.com" <felipe.contreras@gmail.com>,
	"szeder@ira.uka.de" <szeder@ira.uka.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 09:25:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZybaG-0002tt-It
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 09:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbbKQIZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 03:25:44 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:34110 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbbKQIZn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 03:25:43 -0500
Received: by ioir85 with SMTP id r85so11334644ioi.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 00:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LafBGQMhroOhQhj4Ond8ahMLCBj9dnxhIn/reiM2rz0=;
        b=o5wJhkVCAvnkv6quwzlbMQHzSeatXydIgJSxyfUrVhglhiuvutGJkmKPlKdFf+kXul
         bXKaLqsVTPw4tsRe5Svyax5PqYPjD6tJvDqP5sYICc8VzCSDpZ4LoMG67A5egzV+Ihb5
         fhiXm/JI1I5iOwYe6jJBmuo7rZmm5QGNdLneYF5DX0fx72edpG1pd8QHXFZ9xWm5dxqX
         jWxOkZXIV2ZxglWOeCsOB+0XByLhZ+MX8Zej4cGyl5MePEh/geVxifBo8Zcek9gLD4/5
         dkG2E0Rncpoj/dVV1O1Dp8aA1rLEFQJwJ1SCXPECKWtGB3tN76vF3lZj7tDTr1GUxbcd
         BhEA==
X-Received: by 10.107.133.204 with SMTP id p73mr40215976ioi.71.1447748743274;
 Tue, 17 Nov 2015 00:25:43 -0800 (PST)
Received: by 10.107.19.227 with HTTP; Tue, 17 Nov 2015 00:25:23 -0800 (PST)
In-Reply-To: <20151117072049.GA25414@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281387>

On Mon, Nov 16, 2015 at 11:20 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Since git-send-email.perl already configures GetOpt::Long with the
> 'pass_through' option, one possibility would be to invoke
> GetOptions() once for --list-aliases (or --dump-aliases), and then
> again for the normal options. Doing so may be a bit ugly; on the
> other hand, it does indicate pretty clearly that --list-aliases is a
> distinct "mode" of operation. On top of your patch, it might look
> something like this:
>
> --- 8< ---
> diff --git a/git-send-email.perl b/git-send-email.perl
> index ee14894..cada5ea 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -296,6 +296,12 @@ $SIG{INT}  = \&signal_handler;
>
>  my $help;
>  my $rc = GetOptions("h" => \$help,
> +                   "list-aliases" => \$list_aliases);
> +usage() unless $rc;
> +die "--list-aliases incompatible with other options\n"
> +       if !$help and $list_aliases and @ARGV;
> +
> +$rc = GetOptions(
>                     "sender|from=s" => \$sender,
>                      "in-reply-to=s" => \$initial_reply_to,
>                     "subject=s" => \$initial_subject,
> @@ -349,7 +355,6 @@ my $rc = GetOptions("h" => \$help,
>                     "force" => \$force,
>                     "xmailer!" => \$use_xmailer,
>                     "no-xmailer" => sub {$use_xmailer = 0},
> -                    "list-aliases" => \$list_aliases,
>          );
>
>  usage() if $help;
> --- 8< ---
>
> Though, it may be overkill for this minor use-case.

I actually really like this approach. I will squash it in.

Regards,
Jake
