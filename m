From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [cgit PATCH] Close file descriptor on error in readfile()
Date: Sat, 07 Nov 2009 17:14:43 +0100
Message-ID: <m2ocneb9cc.fsf@igel.home>
References: <4AF4D4EC.1040806@pixeltards.com>
	<4AF566C9.5090106@pixeltards.com>
	<8c5c35580911070659h35c44421q713ddba97318e2b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rys Sommefeldt <rys@pixeltards.com>, git@vger.kernel.org,
	steven@uplinklabs.net
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 07 17:14:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6nwF-0000FK-6g
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 17:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbZKGQOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2009 11:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbZKGQOm
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 11:14:42 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:49633 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbZKGQOl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 11:14:41 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 3415F1C00143;
	Sat,  7 Nov 2009 17:14:45 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 1B04E90228;
	Sat,  7 Nov 2009 17:14:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id HXuzRAWmYVDl; Sat,  7 Nov 2009 17:14:44 +0100 (CET)
Received: from igel.home (DSL01.83.171.174.17.ip-pool.NEFkom.net [83.171.174.17])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat,  7 Nov 2009 17:14:44 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id BF19410DB9C; Sat,  7 Nov 2009 17:14:43 +0100 (CET)
X-Yow: Hydraulic pizza oven!!  Guided missile!  Herring sandwich!  Styrofoam!
 Jayne Mansfield!  Aluminum siding!  Borax!  Pedal pushers!  Jukebox!
In-Reply-To: <8c5c35580911070659h35c44421q713ddba97318e2b8@mail.gmail.com>
	(Lars Hjemli's message of "Sat, 7 Nov 2009 15:59:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Hjemli <hjemli@gmail.com> writes:

> diff --git a/shared.c b/shared.c
> index d7b2d5a..a27ab30 100644
> --- a/shared.c
> +++ b/shared.c
> @@ -406,12 +406,17 @@ int readfile(const char *path, char **buf, size_t *size)
>         fd = open(path, O_RDONLY);
>         if (fd == -1)
>                 return errno;
> -       if (fstat(fd, &st))
> +       if (fstat(fd, &st)) {
> +               close(fd);
>                 return errno;

The close call can clobber errno.

> -       if (!S_ISREG(st.st_mode))
> +       }
> +       if (!S_ISREG(st.st_mode)) {
> +               close(fd);
>                 return EISDIR;
> +       }
>         *buf = xmalloc(st.st_size + 1);
>         *size = read_in_full(fd, *buf, st.st_size);
>         (*buf)[*size] = '\0';
> +       close(fd);
>         return (*size == st.st_size ? 0 : errno);

Likewise.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
