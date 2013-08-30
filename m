From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Stalled git cloning and possible solutions
Date: Fri, 30 Aug 2013 19:17:03 +0700
Message-ID: <CACsJy8CxeZGu-nudeGtAFJdzsYMjyNX01yeVOAcRV1kOjA+dkg@mail.gmail.com>
References: <201308300118.19166.vkrishn4@gmail.com> <20130829211034.GB4110@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "V.Krishn" <vkrishn4@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 14:17:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFNdy-0001Fa-9H
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 14:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874Ab3H3MRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 08:17:34 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:49242 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406Ab3H3MRd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 08:17:33 -0400
Received: by mail-ob0-f180.google.com with SMTP id v19so1762555obq.25
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 05:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7HccAcsVc9c+vZZqs85XFQgVYytgVF61iHmxQwucX2k=;
        b=Iqbz5jRVQiuBZQdDrHq1R4V4ffu70xLL/Qbsr4f/hqgCrNHDB7qDPfMCRdJuPFNUm6
         qucHqgcJm+RDGD6Jzba6lCktLqjBbfGdHvVEmbuVrdgIqoUfVr4yydjgqmBN6CtbNxp3
         FMzdWtXzxedXTM1Y6Zf3GdnCWyIE0NgtHyra8lhaC8KMPhCxW1KM2KVzUHtvQs9DOLP4
         GGFFfW/ejlomUbtreD+ZFWcjC6ZhahZOx7CJuqwPk4SnVJW3oznF3Vt9RwEfFmRgUM/p
         Dtuc/VT0GKye9pM93QGJ5HIZlfELT3Y2MxZDdmSnLCM/DfKh1OdU5R+9YB2QkxZ3/ySZ
         CRkA==
X-Received: by 10.60.56.3 with SMTP id w3mr6674553oep.37.1377865053177; Fri,
 30 Aug 2013 05:17:33 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Fri, 30 Aug 2013 05:17:03 -0700 (PDT)
In-Reply-To: <20130829211034.GB4110@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233438>

On Fri, Aug 30, 2013 at 4:10 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> V.Krishn wrote:
>
>> Quite sometimes when cloning a large repo stalls, hitting Ctrl+c cleans what
>> been downloaded, and process needs re-start.
>>
>> Is there a way to recover or continue from already downloaded files during
>> cloning ?
>
> No, sadly.  The pack sent for a clone is generated dynamically, so
> there's no easy way to support the equivalent of an HTTP Range request
> to resume.  Someone might implement an appropriate protocol extension
> to tackle this (e.g., peff's seed-with-clone.bundle hack) some day,
> but for now it doesn't exist.

OK how about a new capability "resume" to upload-pack. fetch-pack can
then send capability "resume[=<SHA-1>,<skip>]" to upload-pack. The
first time it sends "resume" without parameters, and upload-pack will
send back an SHA-1 to identify the pack being transferred together
with a full pack as usual. When early disconnection happens, it sends
the received SHA-1 and the received pack's size so far. It either
receives the remaining part, or a full pack.

When upload-pack gets "resume", it calculates a checksum of all input
that may impact pack generation. If the checksum matches the SHA-1
from fetch-pack, it'll continue to generate the pack as usual, but
will skip sending the first <skip> bytes (maybe with a fake header so
that fetch-pack realizes this is a partial pack). If the checksum does
not match, it sends full pack again. I count on index-pack to spot
corrupt resumed pack due to bugs.

The input to calculate SHA-1 checksum includes:

 - the result SHA-1 list from rev-list
 - git version string
 - .git/shallow
 - replace object database
 - pack.* config
 - maybe some other variables (I haven't checked pack-objects)

Another Git implementation can generate this SHA-1 in a totally
different way and may even cache the generated pack.

If at resume time, the load balancer directs the request to another
upload-pack that generates this SHA-1 differently, ok this won't work
(i.e. full pack is returned). In a busy repository, some refs may have
moved so rev-list result at the resume time won't match any more, but
we can deal with that later by relaxing to allow "want " lines with
SHA-1 that are reachable from current refs, not just one of the refs
(pack v4 or reachability bitmaps help).
-- 
Duy
