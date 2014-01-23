From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] read-cache: use get_be32 instead of hand-rolled
 ntoh_l
Date: Thu, 23 Jan 2014 15:34:16 -0800
Message-ID: <20140123233416.GE18964@google.com>
References: <20140123212036.GA21299@sigill.intra.peff.net>
 <20140123212642.GB21705@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 24 00:34:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Tn2-0001oc-Iy
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 00:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbaAWXeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 18:34:23 -0500
Received: from mail-bk0-f43.google.com ([209.85.214.43]:40294 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbaAWXeW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 18:34:22 -0500
Received: by mail-bk0-f43.google.com with SMTP id mx11so749146bkb.16
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 15:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=A/+nfJ3cOGQgtni3w/ciFnjgC09Tdfw5qZf5aqepHKs=;
        b=MBqMG5OnTBcxBYAdDVNNXy293shavLkulbji5utUtilCp3M5ZpgLrJpYuz5KLvb28I
         9E9l7boaRFDl0ixIqTBfznnbB1le5TZDybtkrlAkhGYm64fofpv0JAHTEvdqOBH80SrC
         5NQAXOs8PNoWOLe+HfXGBtp47lO7fBAGGn0bflmFYfC2Qf4g+7eV48z9sW5LQWZK+Q00
         pMvZXO6l0m3fbhHepD4CVNAKfUSbIuOJnStrYt0vuaeXb/pD8cPa7h2bZS7T7Zcu5lws
         cGH/2FsOUV2Gn5z/f56J+IGxNRlRc4NqLbcemAZrRtyRPllE9llkz0IwOzakSuJ0A0Zc
         eS7A==
X-Received: by 10.204.243.9 with SMTP id lk9mr2663163bkb.93.1390520061307;
        Thu, 23 Jan 2014 15:34:21 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id lr9sm676647bkb.2.2014.01.23.15.34.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jan 2014 15:34:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140123212642.GB21705@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240973>

Jeff King wrote:

> This _might_ still suffer from the issue fixed in 5f6a112 (block-sha1:
> avoid pointer conversion that violates alignment constraints,
> 2012-07-22), as we are taking the pointer of a uint32 in a struct.

No conversion, so no issue there.

Line 1484 looks more problematic:

		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);

In v4 indexes, src_offset doesn't have any particular alignment so
this conversion has undefined behavior.

Do you know if any tests exercise this code with paths that don't
have convenient length?

[...]
> I'm inclined to leave it for now, as we haven't made anything worse, and
> nobody has reported a problem.

Yeah, agreed.

Probably the simplest fix would be to take a char *, memcpy into a
new (aligned) buffer and then byteswap in place, but that's
orthogonal to this series.

Thanks,
Jonathan
