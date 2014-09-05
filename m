From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [RFC PATCHv3 1/4] am: avoid re-directing stdin twice
Date: Fri, 5 Sep 2014 16:18:57 -0700
Message-ID: <CALaEz9Xbk_sAAJ0wNCgC9Rzr=E9Ke0H3YEwGr1_4VNgv0AwYhw@mail.gmail.com>
References: <1409911611-20370-1-git-send-email-judge.packham@gmail.com>
 <1409911611-20370-2-git-send-email-judge.packham@gmail.com>
 <540A1C7B.80109@kdbg.org> <CAFOYHZBct1CRA+NumVMvbbuELWTRoGL5FkhBfHD2Wk7QZVe1fA@mail.gmail.com>
 <xmqqoautpw1g.fsf@gitster.dls.corp.google.com> <xmqqk35hpvbg.fsf@gitster.dls.corp.google.com>
 <xmqqfvg5puws.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, GIT <git@vger.kernel.org>,
	Chris Packham <judge.packham@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 01:19:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ2mq-0004yO-Gf
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 01:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbaIEXTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 19:19:15 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:38649 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbaIEXTO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 19:19:14 -0400
Received: by mail-lb0-f182.google.com with SMTP id u10so14074016lbd.41
        for <git@vger.kernel.org>; Fri, 05 Sep 2014 16:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RvKunTYLm/CojsHsKHHspTC7kotsK/G4V72+mtFc72w=;
        b=RFoPmZBfe99Rm3iaorwDF0UiYTCGq9gxWgNVb6RIJ3HB1gC/h+eo/s/h84HLgCWs7Q
         PiHnMG+Yre1QKLGPKvZmJXlac/91AiMgDAJcqRJRSkUUlxhJG4FnL/ShjWpGv7Kt7JVQ
         GqBze7/QOyfk/HVSnY1IKQvFju+cO8yOmetHiPX6aZDHqzYgpUVsqwTFZFFRyoEYC5il
         DtRNYB0C5/FfiVkZuxx7btVnPI9Mr7bDQcqmM3sUQomDkQK4jXR0Svuwob3g1HQTGaKY
         zJz4JxqELXT0eRaXQeVp6uEALVCQw54GPB0aTEwVPkRl0x3HiAIccN3u+4iVgQmixEYj
         bgDQ==
X-Received: by 10.152.21.195 with SMTP id x3mr14854297lae.63.1409959152482;
 Fri, 05 Sep 2014 16:19:12 -0700 (PDT)
Received: by 10.25.212.79 with HTTP; Fri, 5 Sep 2014 16:18:57 -0700 (PDT)
In-Reply-To: <xmqqfvg5puws.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256548>

(replying from webmail interface)

On Fri, Sep 5, 2014 at 3:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Redoing what e3f67d30 (am: fix patch format detection for
>> Thunderbird "Save As" emails, 2010-01-25) tried to do without
>> wasting a fork and a pipe may be a workable improvement.
>>
>> I see Stephen who wrote the original "Thunderbird save-as" is
>> already on the Cc list.  How about doing it this way instead?
>

It was so long ago I can't even remember writing that patch. But I
googled the thread from 4.5 years ago and I see that you suggested we
use tr because \r is not portable[1].

> Not that way, but more like this.
>
>  git-am.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index ee61a77..32e3039 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -250,8 +250,7 @@ check_patch_format () {
>                         # discarding the indented remainder of folded lines,
>                         # and see if it looks like that they all begin with the
>                         # header field names...
> -                       tr -d '\015' <"$1" |
> -                       sed -n -e '/^$/q' -e '/^[       ]/d' -e p |
> +                       sed -n -e 's/\r$//' -e '/^$/q' -e '/^[  ]/d' -e p |
>                         sane_egrep -v '^[!-9;-~]+:' >/dev/null ||
>                         patch_format=mbox
>                 fi

[1] http://git.661346.n2.nabble.com/PATCH-am-fix-patch-format-detection-for-Thunderbird-quot-Save-As-quot-emails-td4184273.html
