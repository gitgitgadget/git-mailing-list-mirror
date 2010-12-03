From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH/RFC] git-gui: disable (un)staging for files with
 typechange flags
Date: Fri, 3 Dec 2010 14:34:40 +0100
Message-ID: <AANLkTimz-XZQzTygKxQDJ+E6ZJm1+8aZNuKfZ6-AwQh3@mail.gmail.com>
References: <50fc511f363e8b13b9b1a27db71136d262c95f0d.1291155371.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Dec 03 14:34:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POVmh-0000VY-MR
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 14:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755Ab0LCNem convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 08:34:42 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42042 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab0LCNel convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 08:34:41 -0500
Received: by ywl5 with SMTP id 5so4758760ywl.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 05:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=X4BROhhCcznV0fmgAYWaPkqDJjr4LPff6h6xwG9+M34=;
        b=t5aiZh0hCxL5BuC+JnjsgIC7x5hz6sAeP17FOSOg2Pdv9HQlSmUaR6H0OMRQbyC+FJ
         MuwmzojyvNCdsdiY3NZVV7UtBeVZmjSZJfXQ3/2BKaxg1OMCAe5jvHU4afBxiMXzewsY
         gGyUnxySgQFgwQB7ZAaS5N0A8bdxec0GY5jAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uA+gSd/kqu8leyVDBcwfCBAWgHxGP95TKTDriWtkKVubWgtdEtsAJNdj5cvhoTM2yA
         48EFCNNEDgo+3w8FVQ2WwIeX8ha+2V4EwEQOFdqrPj+WhA15JgtUOdoi3Jkt3u7wNatC
         tU1YNht0FQp1FyjaVi6zGZS/U8qrdPGv9lt8A=
Received: by 10.42.222.200 with SMTP id ih8mr458048icb.23.1291383280507; Fri,
 03 Dec 2010 05:34:40 -0800 (PST)
Received: by 10.42.175.71 with HTTP; Fri, 3 Dec 2010 05:34:40 -0800 (PST)
In-Reply-To: <50fc511f363e8b13b9b1a27db71136d262c95f0d.1291155371.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162799>

[ Adding Gustaf Hendeby, the author of the first patch to support type =
changes ]

On Tue, Nov 30, 2010 at 23:21, Bert Wesarg <bert.wesarg@googlemail.com>=
 wrote:
> This covers also the case for newly added files in the index. Like th=
is:
>
> =C2=A0 =C2=A0echo bar >foo
> =C2=A0 =C2=A0git add foo
> =C2=A0 =C2=A0rm foo
> =C2=A0 =C2=A0ln -s bar foo
>
> This will result in an state of AT. And for cases where the type chan=
ge is
> staged, and the new type was modified after the staging. Like this (c=
ont.):
>
> =C2=A0 =C2=A0git add foo
> =C2=A0 =C2=A0git commit -mfoo
> =C2=A0 =C2=A0rm foo
> =C2=A0 =C2=A0echo bar >foo
> =C2=A0 =C2=A0git add foo
> =C2=A0 =C2=A0echo baz >foo
>
> Will result in an state of TM for foo.
>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
> =C2=A0git-gui.sh | =C2=A0 =C2=A06 ++++--
> =C2=A01 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 38362fa..1bebcf1 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1993,7 +1993,9 @@ foreach i {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{MD {mc "Stage=
d for commit, missing"}}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{_T {mc "File =
type changed, not staged"}}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {AT {mc "File type=
 changed, old type staged for commit"}}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{T_ {mc "File =
type changed, staged"}}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {TM {mc "Staged fi=
le type change, modification not staged"}}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{_O {mc "Untra=
cked, not staged"}}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{A_ {mc "Stage=
d for commit"}}
> @@ -3533,8 +3535,8 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X =
Y} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|| $current_diff_path eq {}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|| {__} eq $state
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|| {_O} eq $state
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 || {_T} eq $state
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 || {T_} eq $state
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 || [string match {?T} $state]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 || [string match {T?} $state]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|| [has_textconv $current_diff_path]} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0set s disabled
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> --
> 1.7.3.2.1200.ge4bf6
>
>
