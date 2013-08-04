From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] remote-hg: Fix cloning and sharing bug
Date: Sun, 4 Aug 2013 15:59:56 +0200
Message-ID: <CALWbr2zYD-ELajVkybQfbqXTJSu67K=Y1v3SdtTgCPZHaO46BA@mail.gmail.com>
References: <1A5ABD76-D3D9-400E-AC8F-26C0DEF43723@joernhees.de>
	<1375612683-9104-1-git-send-email-apelisse@gmail.com>
	<478CA849-148C-4F73-A64F-9A5829523CC3@joernhees.de>
	<CAMP44s2DhS=B3fTD-FCrkUK=h4hWuBN6n6mqEws2qh=YiBegJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?J=C3=B6rn_Hees?= <dev@joernhees.de>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 04 16:00:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5yqo-0000Ii-Vf
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 16:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab3HDN76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Aug 2013 09:59:58 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:35064 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab3HDN75 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Aug 2013 09:59:57 -0400
Received: by mail-qc0-f175.google.com with SMTP id s11so1201062qcv.34
        for <git@vger.kernel.org>; Sun, 04 Aug 2013 06:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nJ6WJ3zYeCOI/k+HcLLeTDz2SV5Q7a5+ccKw28pV67M=;
        b=stpyvmBkD5A0t8xP9rJ72GUjKW/rS03aupBa3KwGpblr+WnAwHbYKtBEHIlToKWCaS
         7MvVwIPrW6rksYMt4j/At26nwyj3oCvIR1gpD2X/pJVmoEQOSVpQJn8X6AJBNL1lzrVj
         v1ALZsanfilByla66GO0iKWFe+QzS9v2Mr8mSDwGe2zlgRxTJ5ffRBy+fa9hZ17NwOi8
         yiF5vWwXrOGE1lFdygWpj9OZmeObnHcFTCat5R9C0vi8Tuvm/Ag2BB/n5RD/cVyMg9aL
         GKXMxc3iNi1RQYHLKyG40vjrk31NJIrL1TiLhlv5PRe39nEpPgbI8jJdLsH/lDi+HPQy
         FPhg==
X-Received: by 10.49.105.36 with SMTP id gj4mr20524599qeb.56.1375624796924;
 Sun, 04 Aug 2013 06:59:56 -0700 (PDT)
Received: by 10.49.64.67 with HTTP; Sun, 4 Aug 2013 06:59:56 -0700 (PDT)
In-Reply-To: <CAMP44s2DhS=B3fTD-FCrkUK=h4hWuBN6n6mqEws2qh=YiBegJw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231629>

> --- a/contrib/remote-helpers/git-remote-hg.py
> +++ b/contrib/remote-helpers/git-remote-hg.py
> @@ -391,11 +391,22 @@ def get_repo(url, alias):
>              os.makedirs(dirname)
>      else:
>          shared_path = os.path.join(gitdir, 'hg')
> -        if not os.path.exists(shared_path):
> -            try:
> -                hg.clone(myui, {}, url, shared_path, update=False, pull=True)
> -            except:
> -                die('Repository error')
> +
> +        # check and upgrade old organization
> +        hg_path = os.path.join(shared_path, '.hg')
> +        if os.path.exists(shared_path) and not os.path.exists(hg_path):
> +            repos = os.listdir(shared_path)
> +            for x in repos:
> +                local_hg = os.path.join(shared_path, x, 'clone', '.hg')
> +                if not os.path.exists(local_hg):
> +                    continue
> +                shutil.copytree(local_hg, hg_path)
> +
> +        # setup shared repo (if not there)
> +        try:
> +            hg.peer(myui, {}, shared_path, create=True)
> +        except error.RepoError:
> +            pass
>
>          if not os.path.exists(dirname):
>              os.makedirs(dirname)
>
> It should also work in all the cases, but there would not be an extra
> unnecessary clone while upgrading, and it doesn't sneak in any other
> changes.

That's fine with me. Indeed, we can think about "cloning local repos"
in a separate thread if needed. I clearly don't have a strong opinion
about that.

Would you mind squashing your changes into a patch ?

Cheers,
