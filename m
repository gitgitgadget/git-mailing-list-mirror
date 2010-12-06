From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH/RFC] git-gui: disable (un)staging for files with
 typechange flags
Date: Mon, 6 Dec 2010 23:17:40 +0100
Message-ID: <AANLkTikTY-KsB6zgf0MZJDDr8dCMB1VUQh4pvrvgSLud@mail.gmail.com>
References: <50fc511f363e8b13b9b1a27db71136d262c95f0d.1291155371.git.bert.wesarg@googlemail.com>
	<87aakiy3lt.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Dec 06 23:18:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPjNn-0008Hs-RF
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 23:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807Ab0LFWRp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 17:17:45 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46588 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806Ab0LFWRl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 17:17:41 -0500
Received: by gyb11 with SMTP id 11so6324801gyb.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 14:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=B+Isp6nr9SM8T+gEbl1jpWglsK4hspjTq2PLdRzNxSE=;
        b=gscth6hrcU04B5FPx7nCIoIw64qAT9Fth3H6o8Nk7zeHlh+TdVnb6nhqW4Xvu8v9B0
         vDPzrqlpTE7rsUYGh2k+opDzck/8Ee0qITnGaQTGPcYjNANT2xIgo6G7qmgS5QB4Pg0N
         fkcgS9T0HxuJzimNEwi+dqs5vsveT4O7lMg7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SJD9JLZaVVAgxzR/Qt5E9qt/wjT/Mrh16O29QuSa/sp17j4QvdeQUW70lhYWxfLH7k
         yWrrpPDoS86o3pbZiB2ZbTsfRNAcMrdB9+5Xh0tAwfHopxV4IIrGgOi36rvZCj7CbCMo
         zJp8ROFphE64Uxxaz0bDnx3wXNS9DVJ4DUea4=
Received: by 10.42.166.67 with SMTP id n3mr978252icy.291.1291673860465; Mon,
 06 Dec 2010 14:17:40 -0800 (PST)
Received: by 10.42.172.193 with HTTP; Mon, 6 Dec 2010 14:17:40 -0800 (PST)
In-Reply-To: <87aakiy3lt.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163032>

On Mon, Dec 6, 2010 at 22:48, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>>This covers also the case for newly added files in the index. Like th=
is:
>>
>> =C2=A0 =C2=A0echo bar >foo
>> =C2=A0 =C2=A0git add foo
>> =C2=A0 =C2=A0rm foo
>> =C2=A0 =C2=A0ln -s bar foo
>>
>>This will result in an state of AT. And for cases where the type chan=
ge is
>>staged, and the new type was modified after the staging. Like this (c=
ont.):
>>
>> =C2=A0 =C2=A0git add foo
>> =C2=A0 =C2=A0git commit -mfoo
>> =C2=A0 =C2=A0rm foo
>> =C2=A0 =C2=A0echo bar >foo
>> =C2=A0 =C2=A0git add foo
>> =C2=A0 =C2=A0echo baz >foo
>>
>>Will result in an state of TM for foo.
>>
>>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>---
>> git-gui.sh | =C2=A0 =C2=A06 ++++--
>> 1 files changed, 4 insertions(+), 2 deletions(-)
>>
>>diff --git a/git-gui.sh b/git-gui.sh
>>index 38362fa..1bebcf1 100755
>>--- a/git-gui.sh
>>+++ b/git-gui.sh
>>@@ -1993,7 +1993,9 @@ foreach i {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {MD {mc "Staged for=
 commit, missing"}}
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {_T {mc "File type =
changed, not staged"}}
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{AT {mc "File type =
changed, old type staged for commit"}}
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {T_ {mc "File type =
changed, staged"}}
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{TM {mc "Staged fil=
e type change, modification not staged"}}
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {_O {mc "Untracked,=
 not staged"}}
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {A_ {mc "Staged for=
 commit"}}
>>@@ -3533,8 +3535,8 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X =
Y} {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 || $current_diff_path eq {}
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 || {__} eq $state
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 || {_O} eq $state
>>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|| {_T} eq $state
>>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|| {T_} eq $state
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|| [string match {?T} $state]
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|| [string match {T?} $state]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 || [has_textconv $current_diff_path]} {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 set s disabled
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>
> This seems fine. We do get a warning about an 'unhandled 2 way diff
> marker' when it bumps into the second 'diff --git a/foo b/foo' sectio=
n
> but I'm not sure anything can be safely done about that.

We had this before, and you have proposed a fix for that ("git-gui:
handle symlink replaced by file"). But as I wrote I have a better and
nicer solution to that specific problem.

Bert

> --
> Pat Thoyts =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0http://www.patthoyts.tk/
> PGP fingerprint 2C 6E 98 07 2C 59 C8 97 =C2=A010 CE 11 E6 04 E0 B9 DD
>
>
