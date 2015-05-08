From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 04/12] remote.c: provide per-branch pushremote name
Date: Fri, 8 May 2015 12:13:50 -0400
Message-ID: <CAPig+cTZsUYAY_1f+0ieBuaRw9A-wSAKmpJ9Wj1kUuo=QBCNNw@mail.gmail.com>
References: <20150501224414.GA25551@peff.net>
	<20150501224644.GD1534@peff.net>
	<CAPig+cT7pSxZahd1hmcwCW8ifZfvQ4YW6L7xXUrD7dTJt76srQ@mail.gmail.com>
	<20150505193339.GF10463@peff.net>
	<CAPig+cQ+AbgTXAWKaN4obdGLWFDxjfr4yAaJZgvnLLzzoqdPRQ@mail.gmail.com>
	<20150507093836.GB14524@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 08 18:13:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqkuS-0006bm-C6
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 18:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbbEHQNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 12:13:52 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37505 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522AbbEHQNv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 12:13:51 -0400
Received: by igbsb11 with SMTP id sb11so25436046igb.0
        for <git@vger.kernel.org>; Fri, 08 May 2015 09:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=3YJ+aIMdnDNQCABp32MHb3kILs0EVaNwhmBrjSZMCCI=;
        b=C7ShF3CGL13QcPoamHziFHpR0SqGndhG++KjQw1FtQT0XzITpQaq5/p5bSJouUeKXT
         vUtekVjicbmaP16oF1ff0A4IMUYyvXGwXpuAJmT0rsJ8bwsQtmVTiPan4AtRsuB9q/H8
         9S2dGrXSi0Aa4kpkDilQ1UjLak9UWV4DQpfWTQR8hsF+zUj6HuiwFW65tBQAbSGtrOfa
         mH/iwHVPPdSZ6b/2EWvq2PNTnwXXp0N510IzPlG16bkrh75RhfnxlCOeilVoCJV4gNnd
         jFjI0LJyoVOBx6nh1ioZsvUYxI5qMAVHNCNKaNRTL+excaHjp3mUMIvHU5hy4SsctfYE
         dYSw==
X-Received: by 10.107.169.74 with SMTP id s71mr5949714ioe.46.1431101630917;
 Fri, 08 May 2015 09:13:50 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 8 May 2015 09:13:50 -0700 (PDT)
In-Reply-To: <20150507093836.GB14524@peff.net>
X-Google-Sender-Auth: 8jjM88R-C0Ov822X4jCy8dnx_k8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268621>

On Thu, May 7, 2015 at 5:38 AM, Jeff King <peff@peff.net> wrote:
> On Tue, May 05, 2015 at 03:48:29PM -0400, Eric Sunshine wrote:
>
>> > Yeah, it's just that it goes in the opposite direction I was trying for,
>> > which is to have as little code as possible in the wrapper functions (in
>> > fact, I think after my changes you could even bump the read_config()
>> > call into remote_get_1; before my changes, it depended on the pushremote
>> > config being set before the call).
>>
>> I also noticed that read_config() could be moved into remote_get_1().
>> In fact, with that change, then the wrappers really do collapse nicely
>> to 1-liners, so the "clever" function pointer approach probably is
>> cleaner; and it's nicely generalized over the previous round with the
>> boolean argument to remote_get_1().
>
> I ended up with this patch, which will go right after the one we're
> discussing:

Nice, I like it.

> -- >8 --
> Subject: remote.c: hoist read_config into remote_get_1
>
> Before the previous commit, we had to make sure that
> read_config() was called before entering remote_get_1,
> because we needed to pass pushremote_name by value. But now
> that we pass a function, we can let remote_get_1 handle
> loading the config itself, turning our wrappers into true
> one-liners.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  remote.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index a91d063..e6b29b3 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -718,6 +718,8 @@ static struct remote *remote_get_1(const char *name,
>         struct remote *ret;
>         int name_given = 0;
>
> +       read_config();
> +
>         if (name)
>                 name_given = 1;
>         else
> @@ -741,13 +743,11 @@ static struct remote *remote_get_1(const char *name,
>
>  struct remote *remote_get(const char *name)
>  {
> -       read_config();
>         return remote_get_1(name, remote_for_branch);
>  }
>
>  struct remote *pushremote_get(const char *name)
>  {
> -       read_config();
>         return remote_get_1(name, pushremote_for_branch);
>  }
>
> --
> 2.4.0.488.gf55b16a
