From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH 1/2] Fixes _is_git
Date: Tue, 3 Feb 2015 21:44:33 +1300
Message-ID: <CAFOYHZBHoXC34gBu_Lx347f=-uUcVM1nHYT87SzxfeMa=KdFgw@mail.gmail.com>
References: <CAMto89CHf4OT_S05SaRrVRZvF-PH2_6DrcEpdGiUfaRGutJQHw@mail.gmail.com>
	<1422897883-11036-1-git-send-email-remirampin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: Remi Rampin <remirampin@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 09:44:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIZ6A-00032p-9u
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 09:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbbBCIoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 03:44:38 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:50130 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933302AbbBCIoe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 03:44:34 -0500
Received: by mail-pa0-f47.google.com with SMTP id lj1so93537425pab.6
        for <git@vger.kernel.org>; Tue, 03 Feb 2015 00:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h5QgdG3KfWHeVeGnm+loB01A1VSOcnj3dIJYOX3dKiM=;
        b=vNQOJD1bXBg2+KCkFAp8MQ6yRxoxm9hP+JEzjB4d7NFo3IodJmVTJxySCd91V8Rryc
         PGWpBQjfgHllTriWoWyGtQjsHbouNquZV+v7g2pI0R3ynOk/s4z0bdzguFJdM16R31kQ
         b7UTL0Uz2RE04QKuUSgocyCBaB3TzIw8g7AE1gygnPkRKfbFf2HrZ8D0pBCmf7+ICuSr
         w4pcB8oriSxOOF9y+nCGYeyEA/rOdY0FFLxJ1NbrMHDycZCNjoj1kCV/EJLVYoU4YFJp
         bl5peb6DphBJaQbxWpVRxivffVU9rMl/ZZ3v6FhXRQF0IYkow+NMAJUG3zQaj+KumDCl
         ocCA==
X-Received: by 10.68.189.167 with SMTP id gj7mr36307516pbc.58.1422953073656;
 Tue, 03 Feb 2015 00:44:33 -0800 (PST)
Received: by 10.70.109.199 with HTTP; Tue, 3 Feb 2015 00:44:33 -0800 (PST)
In-Reply-To: <1422897883-11036-1-git-send-email-remirampin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263312>

Hi Remi,

Added Pat Thoyts the git-gui maintainer.

(Disclaimer, it's been years since I did anything with Tcl).

On Tue, Feb 3, 2015 at 6:24 AM, Remi Rampin <remirampin@gmail.com> wrote:
> Function _git_dir would previously fail to accept a "gitdir: ..." file
> as a valid Git repository.
> ---
>  lib/choose_repository.tcl | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
> index 92d6022..49ff641 100644
> --- a/lib/choose_repository.tcl
> +++ b/lib/choose_repository.tcl
> @@ -339,6 +339,16 @@ method _git_init {} {
>  }
>
>  proc _is_git {path} {
> +       if {[file isfile $path]} {
> +               set fp [open $path r]
> +               gets $fp line
> +               close $fp
> +               if {[regexp "^gitdir: (.+)$" $line line link_target]} {

It might be simpler to use one of the 'string' commands e.g. string
wordend "gitdir: " I also suspect the string functions would be faster
than regexp but that probably doesn't matter.

> +                       return [_is_git [file join [file dirname $path] $link_target]]

Do we want to avoid pathological cases of infinite recursion? Someone
would have to maliciously create such a situation.

> +               }
> +               return 0
> +       }
> +
>         if {[file exists [file join $path HEAD]]
>          && [file exists [file join $path objects]]
>          && [file exists [file join $path config]]} {
> --
> 1.9.5.msysgit.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
