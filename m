From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 6/6] fetch-pack: fix deepen shallow over smart http with
 no-done cap
Date: Thu, 6 Feb 2014 14:35:58 -0500
Message-ID: <CAPig+cSXEc_A3KUMvbFsuVZGfsXt1eU9kHO078LLp1HjL5ZkiQ@mail.gmail.com>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
	<1391699439-22781-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 20:36:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBUk1-0006Fb-Cd
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 20:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbaBFTgA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 14:36:00 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:64441 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736AbaBFTf7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Feb 2014 14:35:59 -0500
Received: by mail-lb0-f182.google.com with SMTP id w7so1870691lbi.13
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 11:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=FdV81bxM+npsQLrU9DUkbZvzAbG/s7Bdp96sl8XjnYg=;
        b=rPCh05r/x/MIVMYmJVHCPCnk0x9KNaVfGNNbMq/Dfn4i9cxh4N6o9VcxgriyUIUs3l
         782Mx9p6sA+Om0TrZaNqTfcpdIyvjMl8VfQmXBGc1L9Hct+vzvgxULteye8HFmv9Jjt4
         JwUEeCxpGnUo2KOrT8xrvtsV4ezSLt4tQbTZiXCPaBqEkfYaOy4Kiu1gG4mxWUIICSZb
         1q+rlU3GOAJobpsO0i8otmbDed/KaPILW9t1uCLAtVDnBhq8TRtX4+rBvID93+SU28jb
         708YHfYUGBuiNi7CezvvF1WRbYPupp/lGPlWhztskdPg98DC/IaWUJoQuOU2xuafcgyO
         H/bQ==
X-Received: by 10.152.170.135 with SMTP id am7mr6899132lac.23.1391715358253;
 Thu, 06 Feb 2014 11:35:58 -0800 (PST)
Received: by 10.114.181.228 with HTTP; Thu, 6 Feb 2014 11:35:58 -0800 (PST)
In-Reply-To: <1391699439-22781-7-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: f6AinM_MC6GHmbCSaq1xYlcU1Mw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241716>

On Thu, Feb 6, 2014 at 10:10 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> index b0fa738..fb11073 100755
> --- a/t/t5537-fetch-shallow.sh
> +++ b/t/t5537-fetch-shallow.sh
> @@ -200,5 +200,29 @@ EOF
>         )
>  '
>
> +# This test is tricky. We need large enough "have"s that fetch-pack
> +# will put pkt-flush in between. Then we need a "have" the the serve=
r

s/the the/that the/

> +# does not have, it'll send "ACK %s ready"
> +test_expect_success 'add more commits' '
> +       (
> +       cd shallow &&
> +       for i in $(seq 10); do

Do you want to use test_seq here?

> +       git checkout --orphan unrelated$i &&
> +       test_commit unrelated$i >/dev/null &&
> +       git push -q "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" refs/heads/u=
nrelated$i:refs/heads/unrelated$i
> +       git push -q ../clone/.git refs/heads/unrelated$i:refs/heads/u=
nrelated$i
> +       done &&
> +       git checkout master &&
> +       test_commit new &&
> +       git push  "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" master
> +       ) &&
> +       (
> +       cd clone &&
> +       git checkout --orphan newnew &&
> +       test_commit new-too &&
> +       git fetch --depth=3D2
> +       )
> +'
> +
>  stop_httpd
>  test_done
> --
> 1.8.5.2.240.g8478abd
