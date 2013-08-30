From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Stalled git cloning and possible solutions
Date: Fri, 30 Aug 2013 19:41:45 +0700
Message-ID: <CACsJy8DntFs-exeQ28=tqF3963zd1szTghZybmC6DrTNNF8Lfg@mail.gmail.com>
References: <201308300118.19166.vkrishn4@gmail.com> <20130829211034.GB4110@google.com>
 <CACsJy8CxeZGu-nudeGtAFJdzsYMjyNX01yeVOAcRV1kOjA+dkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "V.Krishn" <vkrishn4@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 14:42:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFO1w-0008BC-Jm
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 14:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756541Ab3H3MmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 08:42:19 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:39237 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874Ab3H3MmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 08:42:16 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so2180143oah.6
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=F0udTvFOTmEBQD5SEyeaxhb5QYQNfetLNflMfUwRXTA=;
        b=JHalDAzD1yF7u8NXXskMqJdUD/NFrYQ6WBFU591pRVFK2AUNij3n+dYIb6/7DBPFP6
         AC0N9WJDzMJ48yCFXe6TdATcrNP8IXPPIyQVtZQsfesL+lWmloqSh8wPkVjcmXKuc5qS
         bzEeIM74Zz9Zngsc5Q867ShnM/NwHVJCBFXZkjQePrzB3FI8eFLHQtfIQXQHylQ9mXqx
         KiGi/FgED1KF6tC764/J9WE1fJDjQ89AywfH/QY7Mn8sO7Fhh5oXk10Wdyt/BAvCOW9+
         V/FM+78pXbYDNWS6LemYoT8+LFd4woUf3lSsho+HY1bola3lEkuebSCJE+JP2D3EnE3A
         76jw==
X-Received: by 10.60.80.167 with SMTP id s7mr6741224oex.38.1377866535781; Fri,
 30 Aug 2013 05:42:15 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Fri, 30 Aug 2013 05:41:45 -0700 (PDT)
In-Reply-To: <CACsJy8CxeZGu-nudeGtAFJdzsYMjyNX01yeVOAcRV1kOjA+dkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233440>

On Fri, Aug 30, 2013 at 7:17 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> OK how about a new capability "resume" to upload-pack. fetch-pack can
> then send capability "resume[=<SHA-1>,<skip>]" to upload-pack. The
> first time it sends "resume" without parameters, and upload-pack will
> send back an SHA-1 to identify the pack being transferred together
> with a full pack as usual. When early disconnection happens, it sends
> the received SHA-1 and the received pack's size so far. It either
> receives the remaining part, or a full pack.
>
> When upload-pack gets "resume", it calculates a checksum of all input
> that may impact pack generation. If the checksum matches the SHA-1
> from fetch-pack, it'll continue to generate the pack as usual, but
> will skip sending the first <skip> bytes (maybe with a fake header so
> that fetch-pack realizes this is a partial pack). If the checksum does
> not match, it sends full pack again. I count on index-pack to spot
> corrupt resumed pack due to bugs.
>
> The input to calculate SHA-1 checksum includes:
>
>  - the result SHA-1 list from rev-list
>  - git version string
>  - .git/shallow
>  - replace object database
>  - pack.* config
>  - maybe some other variables (I haven't checked pack-objects)

should have tested something first before I wrote. --threads adds some
randomness to pack generation so it has to be --threads=1. Not sure if
git repository hosts are happy with it..

> Another Git implementation can generate this SHA-1 in a totally
> different way and may even cache the generated pack.
>
> If at resume time, the load balancer directs the request to another
> upload-pack that generates this SHA-1 differently, ok this won't work
> (i.e. full pack is returned). In a busy repository, some refs may have
> moved so rev-list result at the resume time won't match any more, but
> we can deal with that later by relaxing to allow "want " lines with
> SHA-1 that are reachable from current refs, not just one of the refs
> (pack v4 or reachability bitmaps help).
> --
> Duy



-- 
Duy
