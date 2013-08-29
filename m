From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Add testcase for needless objects during a shallow fetch
Date: Thu, 29 Aug 2013 16:50:40 +0700
Message-ID: <CACsJy8BDxkpFG=nfVENeAHMyhdokwvbpxu26m0RtHou_WK2Mkw@mail.gmail.com>
References: <20130828153638.GF10217@login.drsnuggles.stderr.nl> <1377705722-17053-1-git-send-email-matthijs@stdin.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Thu Aug 29 11:51:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEysm-0003AO-K2
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 11:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011Ab3H2JvM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Aug 2013 05:51:12 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:62104 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296Ab3H2JvL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 05:51:11 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so204845obc.20
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 02:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+/dWoAt6zpt9Yg5ldQAMbwdhCEfgIbc/+OgYDJzB7GM=;
        b=vZWe89v33qtql6/kbzgTAzYzbsfc1EVThO2rvJosrNq7mgXAQYAQIDwWqTk/9pWiil
         A2x2YfdnNCSoS86glf1yLAOXJjmXL1+lRpq8+llPKcSrYBXTbFWWvtgR+hETQLOO1gcI
         +8sR0vkXESZmxMTQkGyT9Ox0Ntqz9HupTQXEpjI9r9aJqbvxo2Dn6x8tmfR+quMa0h6J
         0nMTqNQEO8JdTChsHJKncxWR22dd3ybo1GYIvZjlt40FRdHukCH3lnPqmlH9/YM2y1C7
         D2iW8j5pkz02R+zNtddL+ZLjBFsZZWrSO3mPuW8qnGlNKGQaP3/C8mxGHVhUmtqqRpBh
         Ce9w==
X-Received: by 10.60.80.167 with SMTP id s7mr1821489oex.38.1377769870606; Thu,
 29 Aug 2013 02:51:10 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Thu, 29 Aug 2013 02:50:40 -0700 (PDT)
In-Reply-To: <1377705722-17053-1-git-send-email-matthijs@stdin.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233247>

On Wed, Aug 28, 2013 at 11:02 PM, Matthijs Kooijman <matthijs@stdin.nl>=
 wrote:
> This is a testcase that checks for a problem where, during a specific
> shallow fetch where the client does not have any commits that are a
> successor of the new shallow root (i.e., the fetch creates a new
> detached piece of history), the server would simply send over _all_
> objects, instead of taking into account the objects already present i=
n
> the client.

Thanks. This reminds me I should add a test case in the 4/6 to
demonstrate the regression and let it verify again in 6/6 that the
temporary regression is gone. Will reroll the series with your patch
included.

>
> The actual problem was fixed by a recent patch series by Nguy=E1=BB=85=
n Th=C3=A1i
> Ng=E1=BB=8Dc Duy already.
>
> Signed-off-by: Matthijs Kooijman <matthijs@stdin.nl>
> ---
>  t/t5500-fetch-pack.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index fd2598e..a022d65 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -393,6 +393,17 @@ test_expect_success 'fetch in shallow repo unrea=
chable shallow objects' '
>                 git fsck --no-dangling
>         )
>  '
> +test_expect_success 'fetch creating new shallow root' '
> +       (
> +               git clone "file://$(pwd)/." shallow10 &&
> +               git commit --allow-empty -m empty &&
> +               cd shallow10 &&
> +               git fetch --depth=3D1 --progress 2> actual &&
> +               # This should fetch only the empty commit, no tree or
> +               # blob objects
> +               grep "remote: Total 1" actual
> +       )
> +'
>
>  test_expect_success 'setup tests for the --stdin parameter' '
>         for head in C D E F
> --
> 1.8.4.rc1
>



--=20
Duy
