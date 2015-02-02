From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [git-gui] bug report: "Open existing repository" dialog fails on submodules
Date: Mon, 2 Feb 2015 21:41:16 +1300
Message-ID: <CAFOYHZBpVf0Dk=aM3hbpVjwc-f_WtZx+Myaja6=V2KXCDijsQA@mail.gmail.com>
References: <CAMto89Dvz-u+at4CPLGQRak4niOJk1trSCn2wQugLUnD1h=Fjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: =?UTF-8?B?UsOpbWkgUmFtcGlu?= <remirampin@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Feb 02 09:41:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YICZO-00078x-G5
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 09:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932967AbbBBIlR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Feb 2015 03:41:17 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:54843 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932802AbbBBIlR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Feb 2015 03:41:17 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb1so79856273pad.10
        for <git@vger.kernel.org>; Mon, 02 Feb 2015 00:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ys/WeSmtQeOjMkyujABp/vMptDqS5HRjJf6zxFoVSNc=;
        b=AN0+iwY9a1uzF3iBX+eJHIM84QOpHDbDUUeCWCXDP1jaP2iyYQiVHh8ZgkaJzCh2PC
         ++fns+Gca9ySXEx+y24akh0R23jpNZoCWEjfbewLarNU04KHTQn6XX7N0X3ppZ7JUYCh
         kTf0ah4IbOcTgPkAlepFUBkGCGBJUBibkAUvaje6BxVaV39QN2wxr++z5ZRsnpwvcXH+
         YEGb24Lcs140xOnAgNOo5ZKM2/h1evFsO6imQGPpicT++HOgq1fhPzOwDo9o9+lWMSkP
         iOE71mGfBJZ3ReDiDaHlFG90rh89ACZeIj2mP0HsWSihGsZd0ZHWSDJyhFTHDZEUmik1
         wVSQ==
X-Received: by 10.68.189.167 with SMTP id gj7mr27884367pbc.58.1422866476458;
 Mon, 02 Feb 2015 00:41:16 -0800 (PST)
Received: by 10.70.109.199 with HTTP; Mon, 2 Feb 2015 00:41:16 -0800 (PST)
In-Reply-To: <CAMto89Dvz-u+at4CPLGQRak4niOJk1trSCn2wQugLUnD1h=Fjw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263253>

Hi,

On Sat, Jan 31, 2015 at 10:46 AM, R=C3=A9mi Rampin <remirampin@gmail.co=
m> wrote:
> Hi,
>
> This bug report concerns git-gui. Apologies if this is not the right
> mailing-list.
>
> By submodule I mean a repository for which .git is not a regular Git
> directory, but rather a "gitdir: ..." file.
> While running "git gui" from such a directory will work fine, trying
> to open it from the choose_repository window will fail with "Not a Gi=
t
> repository". This is because of the simplistic implementation of proc
> _is_git in lib/choose_repository.tcl.
>
> I suggest fixing that function, or using Git directly to perform that
> check, for instance checking "git rev-parse --show-toplevel". I'd
> attempt a patch but my tcl-fu is weak.
>

I would have thought the following would work

--- 8< ---
Subject: [PATCH] git-gui: use git rev-parse to validate paths

The current _is_git function to validate a path as a git repository doe=
s
not handle a gitfiles which have been used for submodules for some time=
=2E
Instead of using a custom function let's just ask git rev-parse.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 lib/choose_repository.tcl | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index 92d6022..944ab50 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -339,19 +339,12 @@ method _git_init {} {
 }

 proc _is_git {path} {
-       if {[file exists [file join $path HEAD]]
-        && [file exists [file join $path objects]]
-        && [file exists [file join $path config]]} {
+       puts $path
+       if {[catch {exec git rev-parse --resolve-git-dir $path}]} {
+               return 0
+       } else {
                return 1
        }
-       if {[is_Cygwin]} {
-               if {[file exists [file join $path HEAD]]
-                && [file exists [file join $path objects.lnk]]
-                && [file exists [file join $path config.lnk]]} {
-                       return 1
-               }
-       }
-       return 0
 }

 proc _objdir {path} {
--=20
2.3.0.rc2
--- >8 ---

But it actually looks like git rev-parse --resolve-git-dir $path needs
to be run inside a git repository _any_ git repository, which seems a
bit backwards to me.

  $ cd
  $ git rev-parse --resolve-git-dir ~/src/git/.git
  fatal: Not a git repository (or any parent up to mount point /home)
  Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not =
set).

  $ cd ~/src/git
  $ git rev-parse --resolve-git-dir ~/src/git-gui/.git
  /home/chrisp/src/git-gui/.git

So one potential fix git a gui-gui bug, one new(?) bug in git rev-parse=
=2E
