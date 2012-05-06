From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 1/4] help.c::uniq: plug a leak
Date: Sun, 6 May 2012 23:54:20 +0800
Message-ID: <CALUzUxqtKGd9REqwyZLVnr4zcd20GmSREeNL7tDpA8kYaTtWBg@mail.gmail.com>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
	<1336287330-7215-2-git-send-email-rctay89@gmail.com>
	<20120506081213.GA27878@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 06 17:54:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR3n1-0004o0-Kr
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 17:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882Ab2EFPyW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 11:54:22 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:33820 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab2EFPyW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2012 11:54:22 -0400
Received: by werb10 with SMTP id b10so812516wer.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=0zoWIatTFPgrgiGUAZN8A918rrbT0Wo15pAxu8jDF9c=;
        b=o+9R+XogTTeFK2+gytCGffkpOhjaZwOE7vwm7hyhy/50EepJBASSIusTo08KgXjGbO
         qXcSMQ5Y9zo0a0ECKHg11dFrb2RoytMwjsZ0V++0J3MBPUmEs2/XKrIBQMB+5U0ScNqR
         9SIgkgbC16ZrbOixXuFc7tMCoqkx/+nxigPnOjhsUQUGEa7DyTp8KPIYkJ6aMn0eeJ6o
         P7fkijlxfGzreTm2GsdwXoATXKi14AwUq2ACUjaG1h4xFX4EHEvarkZVpfpBLSNJei/b
         I0dgXb2EQext0EcZ9fx7GHtu9BaWd+wz5SZIXRkMUqunPyHyxE5YTPf2i+Y+GKkr6+Wu
         NGcg==
Received: by 10.180.101.136 with SMTP id fg8mr28304422wib.4.1336319660957;
 Sun, 06 May 2012 08:54:20 -0700 (PDT)
Received: by 10.223.156.136 with HTTP; Sun, 6 May 2012 08:54:20 -0700 (PDT)
In-Reply-To: <20120506081213.GA27878@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197197>

On Sun, May 6, 2012 at 4:12 PM, Jeff King <peff@peff.net> wrote:
> So this shorter patch should be sufficient (though I didn't actually
> test it):

Tested and works fine.

> diff --git a/help.c b/help.c
> index 69d483d..d3868b3 100644
> --- a/help.c
> +++ b/help.c
> @@ -43,9 +43,12 @@ static void uniq(struct cmdnames *cmds)
> =A0 =A0 =A0 =A0if (!cmds->cnt)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> - =A0 =A0 =A0 for (i =3D j =3D 1; i < cmds->cnt; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (strcmp(cmds->names[i]->name, cmds->=
names[i-1]->name))
> + =A0 =A0 =A0 for (i =3D j =3D 1; i < cmds->cnt; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(cmds->names[i]->name, cmds-=
>names[j-1]->name))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free(cmds->names[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmds->names[j++] =3D c=
mds->names[i];
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0cmds->cnt =3D j;
> =A0}

Not only is this better than mine in terms of readability, it is
better than the original code.

--=20
Cheers,
Ray Chuan
