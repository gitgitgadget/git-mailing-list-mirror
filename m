From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 10/24] make sure partially read index is not changed
Date: Sun, 18 Aug 2013 17:06:39 -0400
Message-ID: <CAPig+cTJQrVm+r77utWzduU3KqC5WPX_b4Vbvxyjezd0Wc4LZw@mail.gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
	<1376854933-31241-11-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Robin Rosenberg <robin.rosenberg@dewire.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 18 23:06:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBABS-0002to-5B
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 23:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727Ab3HRVGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 17:06:42 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:36356 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490Ab3HRVGl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 17:06:41 -0400
Received: by mail-la0-f50.google.com with SMTP id ek20so2786545lab.23
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 14:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/2Kn8+naC9eYQ9uY9AGe0YegX7KFInIE71oGczPXYFU=;
        b=i7C3wfXCHwuqqm42rpuigFTwUCYDJW+xxnhh8RTX87RRrrMbS1anuepaZSQpi1TqKE
         riZM66aryv7brA8vF2V57NmkBsN1WULk7iZ0zaMD/D+7dDyRDrn+EQQl5ArfVIDDlgO0
         YniHlOBW8szKADDlZdsi7YTN++ptACLTaUV3uQrRD3Z33XvSQw9Y6Lt3XGpdKGeiWFyD
         S+GihRPC7biZ09bmbWLEPxX1qAE19nJGqMOb7cscX8Np5vv7IR0UnZwouP93x2V5F8Oa
         7Rg3V/cXVVGDJD59qDOGqqDE/WVNCbVywcRV3nxEd6sTO1+DqjxbAdN11WitE3Pe2VEl
         3U3g==
X-Received: by 10.152.8.115 with SMTP id q19mr9108054laa.16.1376859999498;
 Sun, 18 Aug 2013 14:06:39 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 18 Aug 2013 14:06:39 -0700 (PDT)
In-Reply-To: <1376854933-31241-11-git-send-email-t.gummerer@gmail.com>
X-Google-Sender-Auth: JybLUAki_IFpXE2Ph1WtiNaCTYI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232518>

On Sun, Aug 18, 2013 at 3:41 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> A partially read index file currently cannot be written to disk.  Make
> sure that never happens, by erroring out when a caller tries to write a

s/,//

> partially read index.  Do the same when trying to re-read a partially
> read index without having discarded it first to avoid loosing any

s/loosing/losing/

> information.
>
> Forcing the caller to load the right part of the index file instead of
> re-reading it when changing it, gives a bit of a performance advantage,

s/it,/it/  (or s/file instead/file, instead/)
s/advantage,/advantage/

> by avoiding to read parts of the index twice.

/to read/reading/

More below...

>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  read-cache.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/read-cache.c b/read-cache.c
> index 38b9a04..7a27f9b 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1332,6 +1332,8 @@ int read_index_filtered_from(struct index_state *istate, const char *path,
>         void *mmap;
>         size_t mmap_size;
>
> +       if (istate->filter_opts)
> +               die("BUG: Can't re-read partially read index");
>         errno = EBUSY;
>         if (istate->initialized)
>                 return istate->cache_nr;
> @@ -1455,6 +1457,8 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
>
>  int write_index(struct index_state *istate, int newfd)
>  {
> +       if (istate->filter_opts)
> +               die("BUG: index: cannot write a partially read index");

Consistency nit:

In the preceding hunk, the error message starts "BUG: Can't...", but
in this hunk we have "BUG: index: cannot...".

So, "BUG:" is the prefix of one, but "BUG: index:" is the prefix of the other.

Spelling difference: "Can't" vs. "cannot".

Capitalization difference: "Can't" vs. "cannot".

>         return istate->ops->write_index(istate, newfd);
>  }
>
> --
> 1.8.3.4.1231.g9fbf354.dirty
>
