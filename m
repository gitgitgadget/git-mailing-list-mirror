From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH 2/2] Makes _do_open2 set _gitdir to actual path
Date: Tue, 3 Feb 2015 21:51:31 +1300
Message-ID: <CAFOYHZB_c3U9jpAq=jrGgMU+wMMf8w5D9iqLC9ccGC8S3hhXZg@mail.gmail.com>
References: <CAMto89CHf4OT_S05SaRrVRZvF-PH2_6DrcEpdGiUfaRGutJQHw@mail.gmail.com>
	<1422897883-11036-1-git-send-email-remirampin@gmail.com>
	<1422897883-11036-2-git-send-email-remirampin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: Remi Rampin <remirampin@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 09:51:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIZCq-00066E-TB
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 09:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015AbbBCIvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 03:51:33 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36723 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbbBCIvc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 03:51:32 -0500
Received: by mail-pa0-f47.google.com with SMTP id lj1so93607583pab.6
        for <git@vger.kernel.org>; Tue, 03 Feb 2015 00:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8617SqUl2goGKSFN0JXqkoQhkRz8MYp+LAzUWI1bMYE=;
        b=bf6cb1VjsUJLQI5Zun3rn15ezr1EO15/Ks6HDv7d35VCW3j3mwbXVMIPumCiCL6Nn4
         /6mAQdSwiHEIjXku3Bfg+Ix3BHZj0RhRyC3tveqM6wsn0LjFcF3IoX/fiMuTxLzQnZG2
         rcvM/ZIp0b1xkKb+McAujiC3zK7flAYKsjyG8tnUv+SfAEe2M0HYA5BnPZCURF5Xg6Et
         2gCNvaboIwVNES6bA1jWvpXOKreZrnGK8HrqDKDNMk6+3u4QYhTVcCEeF9SaxL+8UDjj
         nzANKIDgEzLgJubJvO9SYDYoIlzdnAsgSDZtvpapNi7mIeoAuH5Hc0zKSqKe7ijcI7wA
         ISaQ==
X-Received: by 10.66.186.208 with SMTP id fm16mr35735705pac.62.1422953491733;
 Tue, 03 Feb 2015 00:51:31 -0800 (PST)
Received: by 10.70.109.199 with HTTP; Tue, 3 Feb 2015 00:51:31 -0800 (PST)
In-Reply-To: <1422897883-11036-2-git-send-email-remirampin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263313>

On Tue, Feb 3, 2015 at 6:24 AM, Remi Rampin <remirampin@gmail.com> wrote:
> If _is_git had to follow "gitdir: ..." files to reach the actual Git
> directory, we set _gitdir to that final path.
> ---
>  lib/choose_repository.tcl | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
> index 49ff641..641068d 100644
> --- a/lib/choose_repository.tcl
> +++ b/lib/choose_repository.tcl
> @@ -338,13 +338,17 @@ method _git_init {} {
>         return 1
>  }
>
> -proc _is_git {path} {
> +proc _is_git {path {outdir_var ""}} {
> +       if {$outdir_var ne ""} {
> +               upvar 1 $outdir_var outdir
> +       }
>         if {[file isfile $path]} {
>                 set fp [open $path r]
>                 gets $fp line
>                 close $fp
>                 if {[regexp "^gitdir: (.+)$" $line line link_target]} {
> -                       return [_is_git [file join [file dirname $path] $link_target]]
> +                       set link_target_abs [file join [file dirname $path] $link_target]

At this point link_target_abs is something like
sub/../.git/modules/sub. It might be nice to normalize this with 'git
rev-parse --git-dir' or even just (cd $link_target_abs && pwd). I'm
not sure if tcl has anything built in that could do this kind of
normalization.

> +                       return [_is_git $link_target_abs outdir]
>                 }
>                 return 0
>         }
> @@ -352,12 +356,14 @@ proc _is_git {path} {
>         if {[file exists [file join $path HEAD]]
>          && [file exists [file join $path objects]]
>          && [file exists [file join $path config]]} {
> +               set outdir $path
>                 return 1
>         }
>         if {[is_Cygwin]} {
>                 if {[file exists [file join $path HEAD]]
>                  && [file exists [file join $path objects.lnk]]
>                  && [file exists [file join $path config.lnk]]} {
> +                       set outdir $path
>                         return 1
>                 }
>         }
> @@ -1103,7 +1109,7 @@ method _open_local_path {} {
>  }
>
>  method _do_open2 {} {
> -       if {![_is_git [file join $local_path .git]]} {
> +       if {![_is_git [file join $local_path .git] actualgit]} {
>                 error_popup [mc "Not a Git repository: %s" [file tail $local_path]]
>                 return
>         }
> @@ -1116,7 +1122,7 @@ method _do_open2 {} {
>         }
>
>         _append_recentrepos [pwd]
> -       set ::_gitdir .git
> +       set ::_gitdir $actualgit
>         set ::_prefix {}
>         set done 1
>  }
> --
> 1.9.5.msysgit.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
