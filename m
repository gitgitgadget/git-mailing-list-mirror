From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: fetch unshallow fails to honor dry-run
Date: Sat, 14 Nov 2015 19:19:11 +0100
Message-ID: <CACsJy8ALXN+BiAF497KcbhSM8_gMEt2L4y+6o0DOdU6ZS=BdCQ@mail.gmail.com>
References: <562C9DD0.5040109@gnu.org> <20151109192400.GA31715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tim Janik <timj@gnu.org>, Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 14 19:19:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxfQR-0004In-1c
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 19:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbbKNSTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2015 13:19:43 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35084 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbbKNSTm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2015 13:19:42 -0500
Received: by lbbsy6 with SMTP id sy6so40883815lbb.2
        for <git@vger.kernel.org>; Sat, 14 Nov 2015 10:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5WBwKByCvWEG2vLtcc3Kdea3wHzxOv8AFkybl6Onmuo=;
        b=FUM+sf9PD02piIMGHxOMYNxQrW8ErMFysdBbp7hmARXjcnt1hM2//EcoiCe7+Dvfv6
         Mat8+fzTwi950LOe9MDFMJ4n6M6lJhxCEfcBGYpOOBGvJbXpmEECEJwwLQzYOdQlUzad
         IpFGl9NweNc57jExzb3K3oRqIuJ0SFyoFA9SXt+h/+iM9dIJzjs1pVb2rp0cgku4MN3H
         rpHV0dvQrxvGDdCWehwdvIPlemNyZ0QcscXCyvgGjVSzOaFgNZFZOb6IHOQk1owuEf9k
         Qo38QW7EvPTaYZwtb8LC2Ot8k+1JfzoSa2x+2Q5X3zwSU/l+eHfRzo0oQjeROHJbdSte
         KpjA==
X-Received: by 10.112.124.199 with SMTP id mk7mr13335356lbb.108.1447525180945;
 Sat, 14 Nov 2015 10:19:40 -0800 (PST)
Received: by 10.112.255.229 with HTTP; Sat, 14 Nov 2015 10:19:11 -0800 (PST)
In-Reply-To: <20151109192400.GA31715@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281308>

Thanks for including me. I thought I marked this for reply later but I did not..

On Mon, Nov 9, 2015 at 8:24 PM, Jeff King <peff@peff.net> wrote:
> [+cc Duy for shallow expertise]
>
> On Sun, Oct 25, 2015 at 10:16:00AM +0100, Tim Janik wrote:
>
>> git fetch --dry-run modifies the repository if --unshallow is passed:
>>
>> $ git --version
>> git version 2.1.4
>> $ git fetch --dry-run --unshallow
>> remote: Counting objects: 30603, done.
>> remote: Compressing objects: 100% (6843/6843), done.
>> remote: Total 30603 (delta 24564), reused 29164 (delta 23386)
>> Receiving objects: 100% (30603/30603), 5.42 MiB | 0 bytes/s, done.
>> Resolving deltas: 100% (24564/24564), completed with 317 local objects.
>> remote: Counting objects: 7, done.
>> remote: Compressing objects: 100% (7/7), done.
>> remote: Total 7 (delta 0), reused 6 (delta 0)
>> Unpacking objects: 100% (7/7), done.
>
> Hmm. I think that is because --dry-run is effectively "transfer the
> objects, but do not update refs". So by fetching the objects, we've
> effectively deepened the repository, whether we update the refs or not.
>
> That being said, I suspect nobody has really thought hard about the
> interaction of these two flags. And while obviously we update the
> object database with a dry-run fetch, I can see the reasoning that we
> should not touch the .git/shallow file, even if we have the objects.
>
> Naively, something like this patch might help, but I have no idea if it
> causes other problems.
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 4ce4fa0..24aa331 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -870,7 +870,7 @@ static struct transport *prepare_transport(struct remote *remote)
>                 set_option(transport, TRANS_OPT_KEEP, "yes");
>         if (depth)
>                 set_option(transport, TRANS_OPT_DEPTH, depth);
> -       if (update_shallow)
> +       if (update_shallow && !dry_run)
>                 set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
>         return transport;
>  }

The key is not let shallow.c:update_shallow() do anything to
.git/shallow. --depth (or --unshallow) does not check this
UPDATE_SHALLOW flag and can still change .git/shallow. Other than
that, I don't think it can cause and bad effects. It's probably best
to pass this dry-run flag to transport.c
-- 
Duy
