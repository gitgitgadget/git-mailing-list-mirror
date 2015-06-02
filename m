From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/WIP PATCH 00/11] Protocol version 2, again!
Date: Tue, 2 Jun 2015 17:10:41 +0700
Message-ID: <CACsJy8CGW-Kaq6hkox03w5bQS2=tVNMzShKUBgC6wKX9dkMQGw@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
 <20150527061818.GA885@peff.net> <20150527070838.GA6873@peff.net> <CAGZ79kZxFnkneixquUijd2yfKBh6+XnYiYzCh8L9Mkourh64Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 12:11:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzjAD-0000Gr-Lh
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 12:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbbFBKLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 06:11:14 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35098 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437AbbFBKLM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 06:11:12 -0400
Received: by iesa3 with SMTP id a3so129321200ies.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 03:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=saA6gxi1207YITYJnpgFWHafGCa0849QEZz+rDmfm4c=;
        b=a9Fcz/7/IUsXCEia0sCcEXTjIJq0XYTlQoA304iAmxe1AiSAmg9ZpDFv8TaN2jle88
         D9hugwTp8PXC/r4eTlq0eHxm5KH2ptEFLYSzxIYmwJJKfC5CPVjgyjhgEJ+59CkauJTz
         5qpEXF16HUvEcuXe+j5+AO93FuKXVre6GHMSdumszu+D8N/lGgC996lZSUEb9zoLZr1U
         TLRxP2zs+WXB17GZcesenCFee1UzHg6Yqfm5dDLzUzdPAgEDKft3Y9+D0soruxyRUfNb
         LWnfWmsKhinYKkJhbbMHWvVd8ahaAO+48sN+DI11eO5G8noKzx0kloYNiUZCnQ8h3zAZ
         wQ5w==
X-Received: by 10.50.4.66 with SMTP id i2mr19400994igi.40.1433239871605; Tue,
 02 Jun 2015 03:11:11 -0700 (PDT)
Received: by 10.107.6.9 with HTTP; Tue, 2 Jun 2015 03:10:41 -0700 (PDT)
In-Reply-To: <CAGZ79kZxFnkneixquUijd2yfKBh6+XnYiYzCh8L9Mkourh64Fw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270517>

On Tue, Jun 2, 2015 at 12:49 AM, Stefan Beller <sbeller@google.com> wrote:
> However the client side with builtin/fetch, builtin/fetch-pack, fetch-pack
> is a bit of a mystery to me, as I cannot fully grasp the difference between
>  * connect.{h,c}
>  * remote.{h.c}
>  * transport.{h.c}
> there. All of it seems to be doing network related stuff, but I have trouble
> getting the big picture. I am assuming all of these 3 are rather a low level,
> used like a library, though there must be even more hierarchy in there,
> connect is most low level judging from the header file and used by
> the other two.
> transport.h seems to provide the most toplevel library stuff as it includes
> remote.h in its header?

I think transport.c is there to support non-native protocols (and
later on, smart http). So yeah it's basically the API for fetches and
pushes. git-log over those files may reveal their purposes, especially
the few first versions of them.

> The problem I am currently trying to tackle, is passing the options through all
> the layers early on. so in a few places we have code like
>
>     switch (version) {
>     case 2: /* first talk about capabilities, then get the heads */
>         get_remote_capabilities(data->fd[0], NULL, 0);
>         select_capabilities();
>         request_capabilities(data->fd[1]);
>         /* fall through */
>     case 1:
>         get_remote_heads(data->fd[0], NULL, 0, &refs,
>                  for_push ? REF_NORMAL : 0,
>                  &data->extra_have,
>                  &data->shallow);
>         break;
>     default:
>         die("BUG: Transport version %d not supported", version);
>         break;
>     }
>
> and the issue I am concerned about is the select_capabilities as well as
> the request_capabilities function here. The select_capabilities functionality
> is currently residing in the high level parts of the code as it both depends on
> the advertised server capabilities and on the user input (--use-frotz or config
> options), so the capability selection is done in fetchpack.c
>
> So there are 2 routes to go: Either we leave the select_capabilities in the
> upper layers (near the actual high level command, fetch, fetchpack) or we put
> it into the transport layer and just passing in a struct what the user desires.
> And when the users desire doesn't meet the server capabilities we die deep down
> in the transport layer.

I read the latest re-roll and I think the placement makes sense. You
can't put protocol specific at transport level because "pack protocol"
is just one of the supported protocols. There is smart-http (which
shares a bunch of code, but from transport perspective is a separate
protocol), and then user-defined protocols that know nothing about
this v2.
-- 
Duy
