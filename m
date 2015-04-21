From: Stefan Saasen <ssaasen@atlassian.com>
Subject: Re: [PATCH 1/2] sha1_file: freshen pack objects before loose
Date: Tue, 21 Apr 2015 10:46:25 +1000
Message-ID: <CADoxLGPNEjDWBjsYn30acapCUj6TfMw5z34W6f_9OjhXySFMLQ@mail.gmail.com>
References: <20150420195337.GA15447@peff.net> <20150420195403.GA15760@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 21 02:47:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkMLI-0006Zn-Im
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 02:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbbDUArI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 20:47:08 -0400
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:41636 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751764AbbDUArG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2015 20:47:06 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]) (using TLSv1) by na3sys009aob131.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVTWeCkBJeXPm0sVaAXws5JqqpDKyfV7S@postini.com; Mon, 20 Apr 2015 17:47:06 PDT
Received: by igbyr2 with SMTP id yr2so74732774igb.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 17:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=mhHnLKkG8xuDFXZfLoMirog0djiQxwGOpg9MlhO2pA4=;
        b=KY9bnI6zs/d2mB7Bs55WON3FhnZvWUutw7zoduszilYlaJzXY7ZOyCObjQU0hGI0lx
         zqBxwVzU4TeKeLiWz5/hrxpX4k/deB+w0yvERR5QPRvLe/CEXe5qJzMMrRY21beMOQiF
         Ge7ZMHKZX+7zXLhTC2MWW+dM/D0vqTKqfSz0+1sFK7pHqmvxrpDzF3ko2manuF2NSWWY
         clopGNhMbz3yj4JPh4KUykC6A1ysexTgZsw66jke0VA0avAYTJXSgwBnu+qvEcXfwX70
         Rq2bBSczrzETNNhHCtlhis7WXciRIhlLRi4D1TqScOScytRxw7nP5OTUm3Hr9zRudjzZ
         2z5g==
X-Gm-Message-State: ALoCoQkKSuPXTSdMA3tT3nNfeeyC9/zvC9PlfBKEgJgLTLJvqx8DmoYULNOH33gAhkB5Ec0chXkUJ/ms3a7eTZM95k+hvqCcg6t0tN87LP7fDi1PvlEAPMWfH4y0+9Q9L08oAlnx2rOSDG8zxN5C3PPKHOa2wiTv0Q==
X-Received: by 10.50.45.103 with SMTP id l7mr614300igm.41.1429577225713;
        Mon, 20 Apr 2015 17:47:05 -0700 (PDT)
X-Received: by 10.50.45.103 with SMTP id l7mr614297igm.41.1429577225639; Mon,
 20 Apr 2015 17:47:05 -0700 (PDT)
Received: by 10.36.118.133 with HTTP; Mon, 20 Apr 2015 17:46:25 -0700 (PDT)
In-Reply-To: <20150420195403.GA15760@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267516>

I didn't expect anything else (as the patch is the same as the
previous one) but I verified that applying this patch has the desired
effect (https://bitbucket.org/snippets/ssaasen/9AXg).

Thanks for the fix Jeff.

On 21 April 2015 at 05:54, Jeff King <peff@peff.net> wrote:
> When writing out an object file, we first check whether it
> already exists and if so optimize out the write. Prior to
> 33d4221, we did this by calling has_sha1_file(), which will
> check for packed objects followed by loose. Since that
> commit, we check loose objects first.
>
> For the common case of a repository whose objects are mostly
> packed, this means we will make a lot of extra access()
> system calls checking for loose objects. We should follow
> the same packed-then-loose order that all of our other
> lookups use.
>
> Reported-by: Stefan Saasen <ssaasen@atlassian.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  sha1_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 88f06ba..822aaef 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -3014,7 +3014,7 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
>         write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
>         if (returnsha1)
>                 hashcpy(returnsha1, sha1);
> -       if (freshen_loose_object(sha1) || freshen_packed_object(sha1))
> +       if (freshen_packed_object(sha1) || freshen_loose_object(sha1))
>                 return 0;
>         return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
>  }
> --
> 2.4.0.rc2.384.g7297a4a
>
