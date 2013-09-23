From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 15/16] contrib/git-credential-gnome-keyring.c: support
 ancient gnome-keyring
Date: Mon, 23 Sep 2013 15:14:09 -0500
Message-ID: <CAMP44s0AnN4t9xuWQy9e09=m1quRegyCtGtizTjP_Ovw62Lycg@mail.gmail.com>
References: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
	<1379962157-1338-16-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, John Szakmeister <john@szakmeister.net>,
	pah@qo.cx, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Mon Sep 23 22:14:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOCWN-00036A-VJ
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 22:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab3IWUOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 16:14:12 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:61457 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649Ab3IWUOL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 16:14:11 -0400
Received: by mail-lb0-f182.google.com with SMTP id c11so3158155lbj.27
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 13:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=K3EWeisPZejbkoN6sCyrasvNHRZJ4In+3iTXhStWlVM=;
        b=HV91SFFYOukFR54ES6BlIyjmCVKHh4iY5awSZ0F1rwNeSpCE7dUt16Lwu2xrp+RKT0
         MPcSkcW1v44hdocLbZGf1lUvO9Jp4z1q5pzox+GBYPA5eVMj2jPzu6M2fEWcTAb2HnRT
         5j1CZ6XFzZWK8OW1SryB1RMvrAe++9zDy9ABmH1IoyTqR4xWwMThTF2JRuTPfGVy48/H
         6qe31PkMfjQ5inTZ0Mhwr45v+j0L3Fe5f+Q4VzaAnzjqYuvr0eboefdiLYB/uHoFolHU
         Ai0j2eYDjSJzcObAT/obz+79IOsIMF+dQQMmEdtoV2rI5EK63nuxtASzah721Y+p7vD4
         YWDg==
X-Received: by 10.152.37.166 with SMTP id z6mr4020242laj.25.1379967249834;
 Mon, 23 Sep 2013 13:14:09 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Mon, 23 Sep 2013 13:14:09 -0700 (PDT)
In-Reply-To: <1379962157-1338-16-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235237>

On Mon, Sep 23, 2013 at 1:49 PM, Brandon Casey <bcasey@nvidia.com> wrote:
> From: Brandon Casey <drafnel@gmail.com>
>
> The gnome-keyring lib distributed with RHEL 5.X is ancient and does
> not provide a few of the functions/defines that more recent versions
> do, but mostly the API is the same.  Let's provide the missing bits
> via macro definitions and function implementation.
>
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> ---
>  .../gnome-keyring/git-credential-gnome-keyring.c   | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
> index 447e9aa..e1bc3fa 100644
> --- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
> +++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
> @@ -28,8 +28,66 @@
>  #include <stdlib.h>
>  #include <glib.h>
>  #include <gnome-keyring.h>
> +
> +#ifdef GNOME_KEYRING_DEFAULT
> +
> +   /* Modern gnome-keyring */
> +
>  #include <gnome-keyring-memory.h>
>
> +#else
> +
> +   /*
> +    * Support ancient gnome-keyring, circ. RHEL 5.X.
> +    * GNOME_KEYRING_DEFAULT seems to have been introduced with Gnome 2.22,
> +    * and the other features roughly around Gnome 2.20, 6 months before.
> +    * Ubuntu 8.04 used Gnome 2.22 (I think).  Not sure any distro used 2.20.
> +    * So the existence/non-existence of GNOME_KEYRING_DEFAULT seems like
> +    * a decent thing to use as an indicator.
> +    */
> +
> +#define GNOME_KEYRING_DEFAULT NULL
> +
> +/*
> + * ancient gnome-keyring returns DENIED when an entry is not found.
> + * Setting NO_MATCH to DENIED will prevent us from reporting DENIED
> + * errors during get and erase operations, but we will still report
> + * DENIED errors during a store.
> + */
> +#define GNOME_KEYRING_RESULT_NO_MATCH GNOME_KEYRING_RESULT_DENIED
> +
> +#define gnome_keyring_memory_alloc g_malloc
> +#define gnome_keyring_memory_free gnome_keyring_free_password
> +#define gnome_keyring_memory_strdup g_strdup
> +
> +static const char* gnome_keyring_result_to_message(GnomeKeyringResult result)

The style is:
static const char *gnome_keyring_result_to_message

There might not be a need to reroll, depending on what Junio says.

-- 
Felipe Contreras
