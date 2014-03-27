From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] gitweb: gpg signature status indication for commits
Date: Thu, 27 Mar 2014 16:12:48 -0400
Message-ID: <CAPig+cR0_7c8Km3JP_282ENGSa+4nOA=-xi2=V3DoQhTz7kNwA@mail.gmail.com>
References: <1395932180-19454-1-git-send-email-victor.kartashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Victor Kartashov <victor.kartashov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 21:12:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTGfY-0003rk-8j
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 21:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757050AbaC0UMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 16:12:50 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:63836 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756679AbaC0UMt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 16:12:49 -0400
Received: by mail-yh0-f51.google.com with SMTP id f10so4111446yha.24
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=tBjjLw5ArAZMN70VR/6sr76jOta4iB8GiI1Kf/DVNxY=;
        b=uejYEZ1mn6uViiBpSPpyQaqOmYmoWD11bBlM8aGIiH9yFPvpvq+FCpZfzAu9tIrVwW
         z594w8RyQ2cvmpkbdOrOQv+XXhWVDmKz5qZ7SmDMLrbkJtwg4DycDNGSbjStpIuDLO1c
         7yXkvIDwvJJwGt0iP6SycUJW5vToFLez+bO0BV1VL1BIvBNCHaCZ5a6qkEdAPdbZUgrI
         lx4kudLFx338JUHIzpXFH+7rkCUISC3L2hPo/Utgbm3jwVjJYHjdPBvRESKCF3DcNXk1
         xIbtFl/lLrZU4ZBCKkDvgTJ0Et+go0GqUdFnsXqI3xv8P+4jV4XqmVSM76TY2wZOmhLB
         Wjrg==
X-Received: by 10.236.132.48 with SMTP id n36mr3439266yhi.149.1395951168410;
 Thu, 27 Mar 2014 13:12:48 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 27 Mar 2014 13:12:48 -0700 (PDT)
In-Reply-To: <1395932180-19454-1-git-send-email-victor.kartashov@gmail.com>
X-Google-Sender-Auth: APnrRuuAvzg3e809LoxJ5ftNvVY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245323>

On Thu, Mar 27, 2014 at 10:56 AM, Victor Kartashov
<victor.kartashov@gmail.com> wrote:
> shows gpg signature (if any) for commit message in gitweb
> in case of successfully verifying the signature highlights it with green

Write in imperative mood: "Show gpg ... highlight it..."

As a corollary, would it be meaningful to highlight a bad signature with red?

> Signed-off-by: Victor Kartashov <victor.kartashov@gmail.com>
> ---
>  gitweb/gitweb.perl       | 33 ++++++++++++++++++++++++++-------
>  gitweb/static/gitweb.css |  5 +++++
>  2 files changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 79057b7..0b41392 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3430,8 +3430,9 @@ sub parse_commit_text {
>         my ($commit_text, $withparents) = @_;
>         my @commit_lines = split '\n', $commit_text;
>         my %co;
> +       my @signature = ();
>
> -       pop @commit_lines; # Remove '\0'
> +       pop @commit_lines if ($commit_lines[-1] eq "\0"); # Remove '\0'

What is this change about? Is it related to your gpg change or something else?

>         if (! @commit_lines) {
>                 return;
> @@ -3469,6 +3470,10 @@ sub parse_commit_text {
>                                 $co{'committer_name'} = $co{'committer'};
>                         }
>                 }
> +               elsif ($line =~ /^gpg: /)

Inconsistent 'elsif' placement. (Cuddle it with the close-brace.)

> +               {

Inconsistent open-brace placement.

> +                       push @signature, $line;
> +               }
>         }
>         if (!defined $co{'tree'}) {
>                 return;
> @@ -3508,6 +3513,11 @@ sub parse_commit_text {
>         foreach my $line (@commit_lines) {
>                 $line =~ s/^    //;
>         }
> +       push(@commit_lines, "") if(scalar(@signature) > 0);

Missing space after 'if'.

In this Perl file, it would be more consistent to drop the '> 0' and
say merely 'if scalar @signature'.

> +       foreach my $sig (@signature)
> +       {

Brace placement.

> +               push(@commit_lines, $sig);
> +       }
>         $co{'comment'} = \@commit_lines;
>
>         my $age = time - $co{'committer_epoch'};
> @@ -3530,13 +3540,15 @@ sub parse_commit {
>
>         local $/ = "\0";
>
> -       open my $fd, "-|", git_cmd(), "rev-list",
> -               "--parents",
> -               "--header",
> -               "--max-count=1",
> +
> +

Unnecessary two extra blank lines.

> +       open my $fd, "-|", git_cmd(), "show",
> +               "--quiet",
> +               "--date=raw",
> +               "--pretty=format:%H %P%ntree %T%nparent %P%nauthor %an <%ae> %ad%ncommitter %cn <%ce> %cd%n%GG%n%s%n%n%b",
>                 $commit_id,
>                 "--",
> -               or die_error(500, "Open git-rev-list failed");
> +               or die_error(500, "Open git-show failed");
>         %co = parse_commit_text(<$fd>, 1);
>         close $fd;
>
> @@ -4571,7 +4583,14 @@ sub git_print_log {
>         # print log
>         my $skip_blank_line = 0;
>         foreach my $line (@$log) {
> -               if ($line =~ m/^\s*([A-Z][-A-Za-z]*-[Bb]y|C[Cc]): /) {
> +               if ($line =~ m/^gpg:(.)+Good(.)+/) {
> +                       if (! $opts{'-remove_signoff'}) {
> +                               print "<span class=\"good_sign\">" . esc_html($line) . "</span><br/>\n";
> +                               $skip_blank_line = 1;
> +                       }
> +                       next;
> +               }
> +               elsif ($line =~ m/^\s*([A-Z][-A-Za-z]*-[Bb]y|C[Cc]): /) {
>                         if (! $opts{'-remove_signoff'}) {
>                                 print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
>                                 $skip_blank_line = 1;
> diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> index 3212601..0b7479c 100644
> --- a/gitweb/static/gitweb.css
> +++ b/gitweb/static/gitweb.css
> @@ -136,6 +136,11 @@ span.signoff {
>         color: #888888;
>  }
>
> +span.good_sign {
> +       font-weight: bold;
> +       background-color: #aaffaa;
> +}
> +
>  div.log_link {
>         padding: 0px 8px;
>         font-size: 70%;
> --
> 1.8.3.2
