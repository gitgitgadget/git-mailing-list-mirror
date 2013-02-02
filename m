From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Sat, 2 Feb 2013 16:49:17 +0700
Message-ID: <CACsJy8COq-A2KJ8rNCxB23s4SMYA4Gqpr53NzqMv=i=sswV_0Q@mail.gmail.com>
References: <20130129091434.GA6975@sigill.intra.peff.net> <20130129091610.GD9999@sigill.intra.peff.net>
 <20130130135607.GA23154@lanh> <CACsJy8Bqg6knVtddwaGSqtiXzVDgbO1JjbFOPMbF_RqrxM2rFQ@mail.gmail.com>
 <20130131110656.GA28093@lanh> <20130201101503.GG30644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 10:50:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1Zjh-0007VN-R0
	for gcvg-git-2@plane.gmane.org; Sat, 02 Feb 2013 10:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678Ab3BBJtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2013 04:49:50 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:62750 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab3BBJts (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2013 04:49:48 -0500
Received: by mail-ob0-f175.google.com with SMTP id uz6so4850674obc.6
        for <git@vger.kernel.org>; Sat, 02 Feb 2013 01:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+lw6wu9kMGGaxwtanhpvHCYtaM+5e7V5M+QjF1YmVQ8=;
        b=gFAgzeXBOwKsYDPJaJMx65ohew2RP0rxcFYxC4HrfJAE9f13FVeqOyRcvBe2OyITNf
         cZLDM0StrAwiLy3xTeN6zIOuE2isGvsfrKmO/QxAqCNS8wuW49lJzT2HCFBuOhcU9i+W
         PPyuGaagrndI5Vej1VC58tD/6kNbyvH/vKtCWJCpWQl2gaRcVY30oWBoZo53GqKRYrXe
         evAx0HfnpdvKf9y4+j5UCBwIG9TvhvMS+OJnVU/rnwpPdGoKGaFNQl2z0S6CdtfX4gLy
         ZSYG5+swSsPLK0NZCxxEM2fkpBrNOEwV0oCAUA1+HEvsl3ShUGmb4sWnt0OJ5VIoujJN
         QeEg==
X-Received: by 10.182.2.132 with SMTP id 4mr11063162obu.42.1359798587662; Sat,
 02 Feb 2013 01:49:47 -0800 (PST)
Received: by 10.182.118.229 with HTTP; Sat, 2 Feb 2013 01:49:17 -0800 (PST)
In-Reply-To: <20130201101503.GG30644@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215286>

On Fri, Feb 1, 2013 at 5:15 PM, Jeff King <peff@peff.net> wrote:
> The short-sha1 is a clever idea. Looks like it saves us on the order of
> 4MB for linux-2.6 (versus the full 20-byte sha1). Not as big as the
> savings we get from dropping the other 3 sha1's to uint32_t, but still
> not bad.

We could save another 4 bytes per commit by using 3 bytes for storing
.idx offsets. linux-2.6 only has 3M objects. It'll take many years for
big projects to reach 16M objects and need the fourth byte in
uint32_t.


> I guess the next steps in iterating on this would be:
>
>   1. splitting out the refactoring here into separate patches
>
>   2. squashing the cleaned-up bits into my patch 4/6
>
>   3. deciding whether this should go into a separate file or as part of
>      index v3. Your offsets depend on the .idx file having a sorted sha1
>      list. That is not likely to change, but it would still be nice to
>      make sure they cannot get out of sync. I'm still curious what the
>      performance impact is for mmap-ing N versus N+8MB.

4. Print some cache statistics in "count-objects -v"


>> The length of SHA-1 is chosen to be able to unambiguously identify any
>> cached commits. Full SHA-1 check is done after to catch false
>> positives.
>
> Just to be clear, these false positives come because the abbreviation is
> unambiguous within the packfile, but we might be looking for a commit
> that is not even in our pack, right?

It may even be ambiguous within the pack, say an octopus (i.e. not
cached) commit that shares the same sha-1 prefix with one of the
cached commits.
-- 
Duy
