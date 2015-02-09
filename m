From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: low memory system to clone larger repo
Date: Mon, 9 Feb 2015 17:40:49 +0700
Message-ID: <CACsJy8Cx6K3Qdq4hq7T_vxsOR-UJv7+mz9AFSiAeKd3YZxqYHg@mail.gmail.com>
References: <CAHKF-AspyE84_0CVMz2OjFLt3Q62qKDfTkbUk3-+RQ_EZ=0JGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: matthew sporleder <msporleder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 11:41:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKlmT-0001Pm-OS
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 11:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760490AbbBIKlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 05:41:20 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36770 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759674AbbBIKlT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 05:41:19 -0500
Received: by ierx19 with SMTP id x19so8955410ier.3
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 02:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ooIlTZAczLfvs+U8T1qnz/5BJlXxBbcrRC26VKKHS9Q=;
        b=SWZr5wOtg5wFOY8Guic9fUGiwKxeyR0FHactYD5ufCzEYYkLEvgQd9eh9inB2VhU5A
         7j7LAquFSGnYsnMaJvMDMP6R8wpIubWtxYrk6uTzujENIuj72xx4U2Sek8JEIpNtMti2
         QOrds3ueq9vCaOv6yUDqGtGWUUiBUPpwfv8Q6qCg8QO4uDivZ5TAgvmPObM6LEmsODH7
         uoP/W65AasaaVEa2/Jmecs20Ny+WTTvEsG8YBqzLZcLF9S6baO5ER5OaymiQQRKvRHoI
         8tqyeCacEgr5pFdWXCuBn5iIjcfa470azk+uXXYZZjz+QaimD3KBa9wyvTihow8kDuFe
         GuCA==
X-Received: by 10.42.62.71 with SMTP id x7mr24048356ich.61.1423478479325; Mon,
 09 Feb 2015 02:41:19 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Mon, 9 Feb 2015 02:40:49 -0800 (PST)
In-Reply-To: <CAHKF-AspyE84_0CVMz2OjFLt3Q62qKDfTkbUk3-+RQ_EZ=0JGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263561>

On Thu, Jan 8, 2015 at 11:10 PM, matthew sporleder <msporleder@gmail.com> wrote:
> I am attempting to clone this repo: https://github.com/jsonn/src/
>
> and have been successful on some lower memory systems, but i'm
> interested in continuing to push down the limit.
>
> I am getting more success running clone via https:// than git:// or
> ssh (which is confusing to me) and the smallest system that works is a
> raspberry pi with 256 RAM + 256 swap.
>
> I seem to run out of memory consistently around 16% into Resolving
> deltas phase but I don't notice an RSS jump so that's another
> confusing spot.

Sorry for a really late reply. The command that's running when you run
out of memory is index-pack. I guess it's verifying the delta chain. I
think it needs enough memory for two uncompressed objects (or files)
in a delta chain. I haven't finished cloning this repo yet so I don't
know what these delta chains look like.

What does it say when it runs out of memory? I'm thinking maybe we
could force a core dump, then look at how memory is used.

What if you "git init", then do "git fetch https://..." manually?
There's an optimization for git-clone that may make index-pack use a
bit more memory (and push it over the edge)

> My config is below and I'd appreciate any more suggestions of getting
> that down to working on a 128MB box (or smaller).

I suppose it's ~/.gitconfig or /etc/gitconfig, it's not added after
the clone is complete, correct? Sounds interesting, let me profile its
memory usage..

> [pack]
>         windowMemory = 1m
>         packSizeLimit = 1m
>         deltaCacheSize = 1m
>         deltaCacheLimit = 10
>         packSizeLimit = 1m

I think many of these only affect the server side. If you clone from
github, then they are useless. You may want to provide your own server
side with these settings and see if things change. Also play with
pack.depth (affecting server side)

>         threads = 1
-- 
Duy
