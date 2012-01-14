From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 2/2] git-gui: fix applying line/ranges when the selection
 ends at the begin of a line
Date: Sat, 14 Jan 2012 13:08:37 +0100
Message-ID: <CAKPyHN1CQ4nHDSgsd2862_AugsDR6m1BcZ+rgOkPJr4E6eYaEA@mail.gmail.com>
References: <cccd6193cf3bfe170e14270204d735a842bb8563.1326116492.git.bert.wesarg@googlemail.com>
	<37339be035746797fcec7634e3560ffcd5b26cf3.1326116492.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Jan 14 13:08:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rm2Pc-0006xv-1l
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 13:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030Ab2ANMIj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jan 2012 07:08:39 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51523 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab2ANMIi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jan 2012 07:08:38 -0500
Received: by wgbds12 with SMTP id ds12so3951430wgb.1
        for <git@vger.kernel.org>; Sat, 14 Jan 2012 04:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Ip8LJAhd/wcR6kSUZd2Rcibie8mR1KVwrLbsiML6dEE=;
        b=Hswq5Ka/W1gp2oURhZ7uOTjniizn3Wmz4lNl4mNK0XZaaVZIKRfYSPMmuiHdgtE3JS
         BzOMJ2RRgherNkq7Ygg/UfXJa4PkYmuxSQWHRw4O965C2qCFAcsT+OmQFYIBgFgo1YJU
         fvEal/No5DmI9jtgU9NyNkXxN4uFOdDRBq8QA=
Received: by 10.180.99.225 with SMTP id et1mr8156807wib.2.1326542917306; Sat,
 14 Jan 2012 04:08:37 -0800 (PST)
Received: by 10.223.118.10 with HTTP; Sat, 14 Jan 2012 04:08:37 -0800 (PST)
In-Reply-To: <37339be035746797fcec7634e3560ffcd5b26cf3.1326116492.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188562>

On Mon, Jan 9, 2012 at 14:43, Bert Wesarg <bert.wesarg@googlemail.com> =
wrote:
> Selecting also the trailing newline of a line for staging/unstaging w=
ould
> have resulted in also staging/unstaging of the next line.

The fix is not complete, this logic should only be applied if we have
actually a range. I will send a replacement patch in the coming days.

Bert

>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
> =C2=A0lib/diff.tcl | =C2=A0 =C2=A08 +++++++-
> =C2=A01 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/lib/diff.tcl b/lib/diff.tcl
> index 63f8742..a750ea7 100644
> --- a/lib/diff.tcl
> +++ b/lib/diff.tcl
> @@ -632,7 +632,13 @@ proc apply_range_or_line {x y} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set first_l [$ui_diff index "$first linest=
art"]
> - =C2=A0 =C2=A0 =C2=A0 set last_l [$ui_diff index "$last lineend"]
> + =C2=A0 =C2=A0 =C2=A0 # don't include the next line if $last points =
to the start of a line
> + =C2=A0 =C2=A0 =C2=A0 # ie. <lno>.0
> + =C2=A0 =C2=A0 =C2=A0 if {[lindex [split $last .] 1] =3D=3D 0} {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set last_l [$ui_di=
ff index "$last -1 line lineend"]
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set last_l [$ui_di=
ff index "$last lineend"]
> + =C2=A0 =C2=A0 =C2=A0 }
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if {$current_diff_path eq {} || $current_d=
iff_header eq {}} return
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if {![lock_index apply_hunk]} return
> --
> 1.7.8.1.873.gfea665
>
