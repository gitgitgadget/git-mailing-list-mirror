From: Tobias Preuss <tobias.preuss@googlemail.com>
Subject: Re: [PATCH] git-gui: allow "\ No newline at end of file" for linewise staging
Date: Fri, 10 May 2013 21:09:53 +0200
Message-ID: <CADEaiE_ddTLO0kYL5siN4rmycibuzHA3R1dz9mKyueYd0y_atw@mail.gmail.com>
References: <CADEaiE-J4nEwyK4WSiH=zzaH6cb85mw15O3wxrWrTXJtZfJixQ@mail.gmail.com>
 <CADEaiE8GKfSQ5u+0bb8qtBe-3OTYJThGb-UFLU_pM-T9ZqvkiA@mail.gmail.com>
 <7vzk0qw8ts.fsf@alter.siamese.dyndns.org> <87vcb6bee5.fsf@fox.patthoyts.tk> <20130509163002.GA3630@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri May 10 21:10:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uashx-0004ix-SL
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 21:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444Ab3EJTKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 15:10:15 -0400
Received: from mail-ea0-f178.google.com ([209.85.215.178]:40304 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089Ab3EJTKO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 15:10:14 -0400
Received: by mail-ea0-f178.google.com with SMTP id q15so494512ead.9
        for <git@vger.kernel.org>; Fri, 10 May 2013 12:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ly+owVh5CV0HrZRYBTXmmPUxbA2NyaY5QQrydBQmHbQ=;
        b=fyB/PUXuCsSwLIRd+jKRXl2n5YikdInhCDLa96R93yeCiUSUPPwhajQTY6f/q/Opf5
         O8lrIRdNg1SlXJHjxvbNcDtj5UWac0upgvnllh3AiZZpNC0aGV78qWELxgLfy7fY9em6
         jWp2W4M3+PI234VAS1p0IKj9mRv3U/OfwWPSp/8Hb1JzTopjoWQgDigEJ7b9YsHhfD+G
         rm6FRArpjoWTvrOdZCpNN2hCLgMEcxH+AS08dLwMz1COXqG8ctWrFoc1zpgBklDCNQD5
         OLIioROgQH396YsL68FmptgMjV9Wssp7yikVXa0aONcSvkewy0b6REz9HJvpgSAK+hA1
         2jRQ==
X-Received: by 10.14.100.1 with SMTP id y1mr44806678eef.9.1368213013164; Fri,
 10 May 2013 12:10:13 -0700 (PDT)
Received: by 10.14.117.76 with HTTP; Fri, 10 May 2013 12:09:53 -0700 (PDT)
In-Reply-To: <20130509163002.GA3630@book-mint>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223895>

I tested the patch as I am the same person that bothered about the
behavior a while ago. Please merge.
- Sorry for sending an HTML formatted mail before.

On Thu, May 9, 2013 at 6:30 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> Counting of lines did not skip this line when generating the hunk
> header.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
> Here is an attempt at fixing the no newline issue. I would appreciate
> another pair of eyes though.
>
>  git-gui/lib/diff.tcl | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
> index ec44055..30d9a79 100644
> --- a/git-gui/lib/diff.tcl
> +++ b/git-gui/lib/diff.tcl
> @@ -764,8 +764,15 @@ proc apply_range_or_line {x y} {
>                                 # context line
>                                 set ln [$ui_diff get $i_l $next_l]
>                                 set patch "$patch$pre_context$ln"
> -                               set n [expr $n+1]
> -                               set m [expr $m+1]
> +                               # Skip the "\ No newline at end of
> +                               # file". Depending on the locale setting
> +                               # we don't know what this line looks
> +                               # like exactly. The only thing we do
> +                               # know is that it starts with "\ "
> +                               if {![string match {\\ *} $ln]} {
> +                                       set n [expr $n+1]
> +                                       set m [expr $m+1]
> +                               }
>                                 set pre_context {}
>                         } elseif {$c1 eq $to_context} {
>                                 # turn change line into context line
> --
> 1.8.3.rc1.40.gba374ae
>
