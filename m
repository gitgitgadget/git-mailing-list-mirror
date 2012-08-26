From: Iain Paton <ipaton0@gmail.com>
Subject: Re: git no longer prompting for password
Date: Sun, 26 Aug 2012 15:18:11 +0100
Message-ID: <503A3023.6000103@gmail.com>
References: <5037E1D0.6030900@gmail.com> <20120824212501.GA16285@sigill.intra.peff.net> <5038E781.1090008@gmail.com> <20120825203904.GA10470@sigill.intra.peff.net> <5039F327.9010003@gmail.com> <20120826101341.GA12566@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 16:19:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5dgZ-0003mt-MT
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 16:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab2HZOSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Aug 2012 10:18:43 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:52841 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab2HZOSm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2012 10:18:42 -0400
Received: by wibhq12 with SMTP id hq12so4676912wib.1
        for <git@vger.kernel.org>; Sun, 26 Aug 2012 07:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+adnGFz/OTSPSjESccwPS01uav7Ix6pimQGyx8sADWQ=;
        b=Yjy1R7fZSffruwifePT5jjdiNkE8WL6SIHdRizRuT2Nktpt742CatSL81rP6WlPiqf
         //22DUd/YlctMfcsUA/IJjiOVKZuICclKt8Zu6vMSNLauXwYvATjCECudVK8XqrT2sLZ
         THs/DeCpDl25Tmu8i7kZtXX2beJSAGQL0ScMWh0VAKO2drReNV8T7fwyLF5evYUskXoR
         Yymax/t3JIhrTMUVzteWmSWPlJlj85rhYWdMm0mysE/qxQsYE49t8BwenW5FHIRYkAv2
         I2CgArm8ggcuS1XHTPkl2JGhLPkbgSMcJXj14S8LYSl768vqXbWn9am31HSQgsfyIzAj
         6A+g==
Received: by 10.180.100.37 with SMTP id ev5mr18770559wib.5.1345990720479;
        Sun, 26 Aug 2012 07:18:40 -0700 (PDT)
Received: from [10.44.16.58] (hades.darkvoyage.org.uk. [81.187.177.1])
        by mx.google.com with ESMTPS id cl8sm9626267wib.10.2012.08.26.07.18.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 26 Aug 2012 07:18:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <20120826101341.GA12566@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204298>

On 26/08/12 11:13, Jeff King wrote:

> Yeah, I'm surprised it took this long to come up, too. Perhaps most
> people just do anonymous http, and then rely on ssh for pushing to
> achieve the same effect. Or maybe my analysis of the problem is wrong.
> :)

I'd be using ssh to push too, but the simple fact is that the http way 
works through a proxy and so essentially works from anywhere. The same 
isn't true for ssh or git protocols. Well that's my reason anyway :)

> Yeah, I think that will work. It feels a little weird and hacky. E.g.,

Yeah, it does. I couldn't find a simple way though, most stuff like 
LocationMatch specifically excludes the query string which makes it 
rather more difficult.

> I don't know enough about Apache to know off-hand if there is a cleaner
> way. I'll investigate a bit more before doing my documentation patch.

I'm not an apache expert either. What I could find was using mod_rewrite to 
set an env var based on something in the query string, but not actually do 
any rewrite. Then looking at how to check the env var and do something based 
on that got me the example of simply using If with an expression to match 
directly on the query string.

> I think that would be cleaner. It would be even nicer if you could
> really just match "service=" as a query parameter, but I don't know that
> apache parses that at all. I also don't know if Apache does any
> canonicalization of the QUERY_STRING. When matching, you'd want to make

>From what I can tell apache really doesn't care much about the query string 
at all, it seems to just pass it through unless you start messing with it 
using mod_rewrite, but even then you're still regex based. I couldn't find 
anything that parsed out individual parameters. Of course I could just be 
looking in all the wrong places :) 

> sure there is no way of a client sneaking in a parameter that git would
> understand to mean a push, but that your pattern would not notice (so,
> e.g., just matching "git-receive-pack$" would not be sufficient, as I

yep, and matching on THE_REQUEST gets you the whole string, including the 
HTTP/1.1 on the end. I tried putting the $ on the end of the regex and it 
didn't work. 
It should be possible to combine the original regex from the LocationMatch 
example and something like /[?&]service=git-receive-pack/ though, which 
should make it somewhat safer.

> No problem. I'll probably be a day or two on the patches, as the http
> tests are in need of some refactoring before adding more tests. But in
> the meantime, I think your config change is a sane work-around.

Works-For-Me is all I need right now :)  I'll be interested if you come 
up with something better though.

Iain
