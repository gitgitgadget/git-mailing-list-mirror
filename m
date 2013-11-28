From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: How to resume broke clone ?
Date: Thu, 28 Nov 2013 17:17:30 +0700
Message-ID: <CACsJy8Cx_u_w+JoQnf9XA98tt4QVNzJ2zATBpWgk4_N3+dgCrg@mail.gmail.com>
References: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com>
 <5296F343.6050506@gmail.com> <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com>
 <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com>
 <5297004F.4090003@gmail.com> <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
 <211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com> <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
 <20131128092935.GC11444@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: zhifeng hu <zf@ancientrocklab.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 28 11:18:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlyff-0004wY-Ch
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 11:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267Ab3K1KSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 05:18:04 -0500
Received: from mail-qe0-f49.google.com ([209.85.128.49]:45229 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab3K1KSB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 05:18:01 -0500
Received: by mail-qe0-f49.google.com with SMTP id w7so8750626qeb.36
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 02:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=P9TCE6CXWJFaEzrj+lbtl9OGYkuXIqn9bk8fi1XxpdA=;
        b=xOqaxUDuVJ7gvUI/zGt4jlwH3MnNSGUtIEM0KcHctKLVoAkpyjtPoUfpO8S8uZJfLa
         Fzdl4REYyGs140ehEy0l5jTOOfXpXXuD91yv8Fv+kwSh85YcPgb4KTsiLq+ehzO053qA
         1DbJOxsyJqrYenBQNSWldp9BXq3ajkXh5ZV26wCBwOwd5IzblKFdHBbTlk0/TixheSwS
         RR8yK8y8rxd1ba+mSQUzYCPEvzB0eYTwPz6E6ILlKYowk7HFQvK5ELhfcFiAFosjyOeb
         cZRfZQ289IyfIbYEyeFOnzm/gjbTud3wD3XRX+eBVGo03HBSdDtB8R3/3GM3IvaduX31
         ze8w==
X-Received: by 10.224.32.66 with SMTP id b2mr75741105qad.80.1385633880394;
 Thu, 28 Nov 2013 02:18:00 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Thu, 28 Nov 2013 02:17:30 -0800 (PST)
In-Reply-To: <20131128092935.GC11444@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238489>

On Thu, Nov 28, 2013 at 4:29 PM, Jeff King <peff@peff.net> wrote:
>>  - stablize pack order so we can resume downloading a pack
>
> I think stabilizing in all cases (e.g., including ones where the content
> has changed) is hard, but I wonder if it would be enough to handle the
> easy cases, where nothing has changed. If the server does not use
> multiple threads for delta computation, it should generate the same pack
> from the same on-disk deterministically. We just need a way for the
> client to indicate that it has the same partial pack.
>
> I'm thinking that the server would report some opaque hash representing
> the current pack. The client would record that, along with the number of
> pack bytes it received. If the transfer is interrupted, the client comes
> back with the hash/bytes pair. The server starts to generate the pack,
> checks whether the hash matches, and if so, says "here is the same pack,
> resuming at byte X".
>
> What would need to go into such a hash? It would need to represent the
> exact bytes that will go into the pack, but without actually generating
> those bytes. Perhaps a sha1 over the sequence of <object sha1, type,
> base (if applicable), length> for each object would be enough. We should
> know that after calling compute_write_order. If the client has a match,
> we should be able to skip ahead to the correct byte.

Exactly. The hash would include the list of sha-1 and object source,
the git version (so changes in code or default values are covered),
the list of config keys/values that may impact pack generation
algorithm (like window size..), .git/shallow, refs/replace,
.git/graft, all or most of command line options. If we audit the code
carefully I think we can cover all input that influences pack
generation. From then on it's just a matter of protocol extension. It
also opens an opportunity for optional server side caching, just save
the pack and associate it with the hash. Next time the client asks to
resume, the server has everything ready.
-- 
Duy
