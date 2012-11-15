From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCHv2 8/8] send-email: do not prompt for explicit repo ident
Date: Thu, 15 Nov 2012 03:08:42 +0100
Message-ID: <CAMP44s0d+g7bXCnOf55jZNNFS6uJ+4BDowx5uYxWBP4xA+-0zA@mail.gmail.com>
References: <20121115003029.GA17550@sigill.intra.peff.net>
	<20121115003640.GH17819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 03:09:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYosz-00047q-DM
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 03:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933144Ab2KOCIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 21:08:43 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:43607 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467Ab2KOCIn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 21:08:43 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so1199121oag.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 18:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wGVGKgFAva1p8oo/Uv/7ASmLs/gr6NOQIJRIFsUsNGM=;
        b=PzJBZOzBHNDqG1TZ5vHINaGm1XouPCrQF1YWUPkglpWCqGCZsBi5jGj2vpL/aS9blK
         vKxkoYyqe+PfXc986yXowppMiSn/aSEoKZ0O5DyrMG/YQ3Q39bGjcH04vICxFKabPn4P
         nCmH5AGQoDeiej71fjMvxZvRh7SUPuT+0bMegHlJs2hBinQbBMdQIRoAjzn2W4iDms5I
         CDxWvBKaYFfQRPsP1kpDF1VZR8Pv5C6FinJ8Yu/QDa6yxsbsIOjuiIpS/0CM8EICy39i
         pEawx0QWAc/hTHarCXP+6h/FsGQOzyrhe5CerOAz0yIZCMRE7qtTYn0zJsiu6C8Cbwog
         3M1A==
Received: by 10.60.26.234 with SMTP id o10mr21560004oeg.85.1352945322775; Wed,
 14 Nov 2012 18:08:42 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Wed, 14 Nov 2012 18:08:42 -0800 (PST)
In-Reply-To: <20121115003640.GH17819@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209791>

On Thu, Nov 15, 2012 at 1:36 AM, Jeff King <peff@peff.net> wrote:

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 5a7c29d..0c49b32 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -436,9 +436,8 @@ if (0) {
>         }
>  }
>
> -my ($repoauthor, $repocommitter);
> -($repoauthor) = Git::ident_person(@repo, 'author');
> -($repocommitter) = Git::ident_person(@repo, 'committer');
> +my ($repoauthor, $author_explicit) = Git::ident_person(@repo, 'author');
> +my ($repocommitter, $committer_explicit) = Git::ident_person(@repo, 'committer');
>
>  # Verify the user input
>
> @@ -755,12 +754,17 @@ if (!$force) {
>
>  my $prompting = 0;
>  if (!defined $sender) {
> -       $sender = $repoauthor || $repocommitter || '';
> -       $sender = ask("Who should the emails appear to be from? [$sender] ",
> -                     default => $sender,
> -                     valid_re => qr/\@.*\./, confirm_only => 1);
> -       print "Emails will be sent from: ", $sender, "\n";
> -       $prompting++;
> +       ($sender, my $explicit) =
> +               defined $repoauthor ? ($repoauthor, $author_explicit) :
> +               defined $repocommitter ? ($repocommitter, $committer_explicit) :
> +               ('', 0);
> +       if (!$explicit) {
> +               $sender = ask("Who should the emails appear to be from? [$sender] ",
> +                             default => $sender,
> +                             valid_re => qr/\@.*\./, confirm_only => 1);
> +               print "Emails will be sent from: ", $sender, "\n";
> +               $prompting++;
> +       }
>  }
>
>  if (!@initial_to && !defined $to_cmd) {

I don't think there's any need for all that, this does the trick:

diff --git a/git-send-email.perl b/git-send-email.perl
index aea66a0..503e551 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -748,16 +748,11 @@ if (!$force) {
        }
 }

-my $prompting = 0;
 if (!defined $sender) {
        $sender = $repoauthor || $repocommitter || '';
-       $sender = ask("Who should the emails appear to be from? [$sender] ",
-                     default => $sender,
-                     valid_re => qr/\@.*\./, confirm_only => 1);
-       print "Emails will be sent from: ", $sender, "\n";
-       $prompting++;
 }

+my $prompting = 0;

This passes all the current tests and the ones you added.

Which kind of user will get the prompt with your patch, that would
miss it with mine?

Cheers.

-- 
Felipe Contreras
