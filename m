From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [git-gui] bug report: "Open existing repository" dialog fails on submodules
Date: Mon, 2 Feb 2015 21:43:08 +1300
Message-ID: <CAFOYHZAz9LOsAG53GbxQtb3Hp4d_zMFCKbp_Z5NViwCCm+cLAg@mail.gmail.com>
References: <CAMto89Dvz-u+at4CPLGQRak4niOJk1trSCn2wQugLUnD1h=Fjw@mail.gmail.com>
	<CAFOYHZBpVf0Dk=aM3hbpVjwc-f_WtZx+Myaja6=V2KXCDijsQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: =?UTF-8?B?UsOpbWkgUmFtcGlu?= <remirampin@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Feb 02 09:43:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YICbC-0008Oe-MG
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 09:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932909AbbBBInL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Feb 2015 03:43:11 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:59788 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932677AbbBBInJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Feb 2015 03:43:09 -0500
Received: by mail-pa0-f50.google.com with SMTP id rd3so79646867pab.9
        for <git@vger.kernel.org>; Mon, 02 Feb 2015 00:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KIXLiQtuMeixTxiTyggH3A4TgWZdSMkgzPu6J3UJXMw=;
        b=z/yXpDOMChVF6JHB3Kb49sOMo0Kyjx/6Jsbsn+bQ/Ma6uK623O1/lP8uTvHY5A+hGT
         4gGA+UffB3En+SrPYN798fu5GXyKsxcRkZqNll1RiZjAbKQf1W3CDlCTmCbXqblcWmQV
         uecMAut0nHU+lE3vKWbcfRghrPZYpKbasZdXv1hbZC+Dd61k3xrK+GZYQWn8La1q0VoX
         wVoiV+h/PI21Hc7NSR0OZaR83n8dVPVTM1/T1qD6ciO3uciqlclpvtOtnPR7sCcn6JHX
         +K9sRzn1B4u2e+lg5bkeYn0CX9nLg9YtKEON9iqd4AoA5RSuzHClPrJRWHdaxbyvRoC8
         hRQQ==
X-Received: by 10.68.202.194 with SMTP id kk2mr27255484pbc.41.1422866588845;
 Mon, 02 Feb 2015 00:43:08 -0800 (PST)
Received: by 10.70.109.199 with HTTP; Mon, 2 Feb 2015 00:43:08 -0800 (PST)
In-Reply-To: <CAFOYHZBpVf0Dk=aM3hbpVjwc-f_WtZx+Myaja6=V2KXCDijsQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263254>

On Mon, Feb 2, 2015 at 9:41 PM, Chris Packham <judge.packham@gmail.com>=
 wrote:
> Hi,
>
> On Sat, Jan 31, 2015 at 10:46 AM, R=C3=A9mi Rampin <remirampin@gmail.=
com> wrote:
>> Hi,
>>
>> This bug report concerns git-gui. Apologies if this is not the right
>> mailing-list.
>>
>> By submodule I mean a repository for which .git is not a regular Git
>> directory, but rather a "gitdir: ..." file.
>> While running "git gui" from such a directory will work fine, trying
>> to open it from the choose_repository window will fail with "Not a G=
it
>> repository". This is because of the simplistic implementation of pro=
c
>> _is_git in lib/choose_repository.tcl.
>>
>> I suggest fixing that function, or using Git directly to perform tha=
t
>> check, for instance checking "git rev-parse --show-toplevel". I'd
>> attempt a patch but my tcl-fu is weak.
>>
>
> I would have thought the following would work
>
> --- 8< ---
> Subject: [PATCH] git-gui: use git rev-parse to validate paths
>
> The current _is_git function to validate a path as a git repository d=
oes
> not handle a gitfiles which have been used for submodules for some ti=
me.
> Instead of using a custom function let's just ask git rev-parse.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  lib/choose_repository.tcl | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
> index 92d6022..944ab50 100644
> --- a/lib/choose_repository.tcl
> +++ b/lib/choose_repository.tcl
> @@ -339,19 +339,12 @@ method _git_init {} {
>  }
>
>  proc _is_git {path} {
> -       if {[file exists [file join $path HEAD]]
> -        && [file exists [file join $path objects]]
> -        && [file exists [file join $path config]]} {
> +       puts $path
> +       if {[catch {exec git rev-parse --resolve-git-dir $path}]} {
> +               return 0
> +       } else {
>                 return 1
>         }
> -       if {[is_Cygwin]} {
> -               if {[file exists [file join $path HEAD]]
> -                && [file exists [file join $path objects.lnk]]
> -                && [file exists [file join $path config.lnk]]} {
> -                       return 1
> -               }
> -       }
> -       return 0
>  }
>
>  proc _objdir {path} {
> --
> 2.3.0.rc2
> --- >8 ---
>
> But it actually looks like git rev-parse --resolve-git-dir $path need=
s
> to be run inside a git repository _any_ git repository, which seems a
> bit backwards to me.
>
>   $ cd
>   $ git rev-parse --resolve-git-dir ~/src/git/.git
>   fatal: Not a git repository (or any parent up to mount point /home)
>   Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM no=
t set).
>
>   $ cd ~/src/git
>   $ git rev-parse --resolve-git-dir ~/src/git-gui/.git
>   /home/chrisp/src/git-gui/.git
>
> So one potential fix git a gui-gui bug, one new(?) bug in git rev-par=
se.

Not a new one. Happens in 1.9.1. Still a bit counter-intuitive IMO.
