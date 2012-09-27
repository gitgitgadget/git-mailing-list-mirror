From: David Michael Barr <b@rr-dav.id.au>
Subject: Re: Using bitmaps to accelerate fetch and clone
Date: Fri, 28 Sep 2012 05:47:46 +1000
Message-ID: <CACPE+fsErzT3MyQdQj5XEvvMwnBam7LBU4XeNVZ+-zG+XYN0cA@mail.gmail.com>
References: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
	<CACsJy8D0vkyEArNChXE0igUkanH6PwjmPitq22a9sudfmWF4kA@mail.gmail.com>
	<20120927172037.GB1547@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>,
	Colby Ranger <cranger@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 21:47:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THK3y-0007mU-27
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 21:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046Ab2I0Trs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 15:47:48 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:39957 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287Ab2I0Trs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 15:47:48 -0400
Received: by qadc26 with SMTP id c26so4177045qad.19
        for <git@vger.kernel.org>; Thu, 27 Sep 2012 12:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=kJcqOGOeLN1sJYsJFb+y6bgmGvUOXXhYC+05e1eIyJY=;
        b=QimU5gyzWHC0nhQhwvjTOf+CPnlS24kOASrgyYbGHBXYkelBAj+DDQkU1/1t9+AaMJ
         G/69Btmc87jBELBmAO/LXT5ZXeQi6pgZZQ3f9+GpOMH9CVCqpjbC/G8evAWXkg5CFBGe
         gVbrkanWsIH4+l6lfHSNxk4BpW8Ryn5pKqJXrfaM7O7jAeISYAFPFylCegdQSuP8Lct2
         b75JWrnvCB0cWvfpBC9dG920iiDSA+6PJVHHxC8OUaQ/Tnc48DMlN6VvGPTdj4MmTPS9
         0e2IMqgjO6urC9Q+FPWi++DYl/4IhYFKqUGb1jx+cMJ7r149dCiSk6oPtPInjcFQ6M50
         MOHA==
Received: by 10.224.44.135 with SMTP id a7mr11863705qaf.84.1348775266811; Thu,
 27 Sep 2012 12:47:46 -0700 (PDT)
Received: by 10.49.72.200 with HTTP; Thu, 27 Sep 2012 12:47:46 -0700 (PDT)
X-Originating-IP: [122.107.58.35]
In-Reply-To: <20120927172037.GB1547@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQmor4dfc1RlnZXPnUEjb5bk/oYc8ynVfWx2QdGJTsOvy0DCwkihG7R3XR9iap8MrUckzc/Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206513>

Hi all,

On Fri, Sep 28, 2012 at 3:20 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 27, 2012 at 07:17:42PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> > Operation                   Index V2               Index VE003
>> > Clone                       37530ms (524.06 MiB)     82ms (524.06 MiB)
>> > Fetch (1 commit back)          75ms                 107ms
>> > Fetch (10 commits back)       456ms (269.51 KiB)    341ms (265.19 KiB)
>> > Fetch (100 commits back)      449ms (269.91 KiB)    337ms (267.28 KiB)
>> > Fetch (1000 commits back)    2229ms ( 14.75 MiB)    189ms ( 14.42 MiB)
>> > Fetch (10000 commits back)   2177ms ( 16.30 MiB)    254ms ( 15.88 MiB)
>> > Fetch (100000 commits back) 14340ms (185.83 MiB)   1655ms (189.39 MiB)
>>
>> Beautiful. And curious, why do 100->1000 and 10000->10000 have such
>> big leaps in time (V2)?
>
> Agreed. I'm very excited about these numbers.

+1

>> Definitely :-). I have shown my interest in this topic before. So I
>> should probably say that I'm going to work on this on C Git, but
>> sllloooowwwly. As this benefits the server side greatly, perhaps a
>> GitHubber ;-) might want to work on this on C Git, for GitHub itself
>> of course, and, as a side effect, make the rest of us happy?
>
> Yeah, GitHub is definitely interested in this. I may take a shot at it,
> but I know David Barr (cc'd) is also interested in such things.

Yeah, I'm definitely interested, I love this stuff.

--
David Michael Barr
