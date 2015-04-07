From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC] connect.c: Ignore extra colon after hostname
Date: Tue, 7 Apr 2015 13:57:50 -0400
Message-ID: <CAPig+cQZDPRa=2Oaur71OufeP2ECjOFK3JEwdRQNUYs49SySNg@mail.gmail.com>
References: <55238C42.7020402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, reidw@rawsound.com
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 07 19:57:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfXl8-0007Rw-8V
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 19:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbbDGR5x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2015 13:57:53 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35534 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbbDGR5w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2015 13:57:52 -0400
Received: by lbbuc2 with SMTP id uc2so45325292lbb.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=SjKKlIGkau7L/Ceu9IE3HPWEaaf0HnQV4zPy6Gfe77A=;
        b=YaRITeDCZcrPtaHRqljyNCHBB7uVkSKuEDkFLUaEW5p8KWZBvmNbW+7so/AqaBL1n9
         CIclVCqEfXVl6gFWwTcg8MrgabhNZC4FxBNJxFgrcshLnUifj59VxeLkgg/w4NIAWLGP
         k4KrDihr0RzQ8ykDEM7qS59aDTPMxh9vDVfkztvv92jnlwsHw+KQtnCDDxzfpdlIaFhS
         90yXGHPc+Gr2dTd2nQq3n0+LfcqswT5nuvuDXTGIbcivI3houjsjD2R8CPVl5YNomCxt
         ecoH7r4xOu79dd9C5lbflt0h6TYSo3bB3Q4w+Apwf2tcfK8KbIDQbdhMGSp8MC0eMx4L
         a5wQ==
X-Received: by 10.152.219.2 with SMTP id pk2mr19135211lac.107.1428429470709;
 Tue, 07 Apr 2015 10:57:50 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Tue, 7 Apr 2015 10:57:50 -0700 (PDT)
In-Reply-To: <55238C42.7020402@web.de>
X-Google-Sender-Auth: 82Wu2TXBa9xXkD563q4TrdW07Uo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266930>

On Tue, Apr 7, 2015 at 3:50 AM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> Ignore an extra ':' at the end of the hostname in URL's like
> "ssh://example.com:/path/to/repo"
>
> The colon is ment to separate a port number from the hostname.

s/ment/meant/

More below.

> If the port is empty, the colon should be ignored, see RFC 3986.
>
> It had been working for URLs with ssh:// scheme, but was unintentiona=
lly
> broken in 86ceb3, "allow ssh://user@[2001:db8::1]/repo.git"
>
> Reported-by: Reid Woodbury Jr. <reidw@rawsound.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 02b40b1..1f67bdd 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -387,14 +387,18 @@ do
>  done
>
>  #with ssh:// scheme
> -test_expect_success 'clone ssh://host.xz/home/user/repo' '
> -       test_clone_url "ssh://host.xz/home/user/repo" host.xz "/home/=
user/repo"
> -'
> -
> -# from home directory
> -test_expect_success 'clone ssh://host.xz/~repo' '
> -       test_clone_url "ssh://host.xz/~repo" host.xz "~repo"
> +#ignore trailing colon
> +for tcol in "" :
> +do
> +       test_expect_success "clone ssh://host.xz$tcol/home/user/repo"=
 '
> +               test_clone_url "ssh://host.xz$tcol/home/user/repo" ho=
st.xz /home/user/repo
> +       '
> +       # from home directory
> +       test_expect_success "clone ssh://host.xz$tcol/~repo" '
> +       test_clone_url "ssh://host.xz$tcol/~repo" host.xz "~repo"
>  '
> +done
> +test_done

Unwanted test_done crept in?

>  # with port number
>  test_expect_success 'clone ssh://host.xz:22/home/user/repo' '
