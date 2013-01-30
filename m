From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC 0/6] commit caching
Date: Wed, 30 Jan 2013 10:31:43 +0700
Message-ID: <CACsJy8BE3LdxbZzdQXuvEJop23KnnLbCTgPos9CywKV7EY2q9g@mail.gmail.com>
References: <20130129091434.GA6975@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 30 04:32:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0OPc-0000fN-8b
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 04:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598Ab3A3DcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 22:32:15 -0500
Received: from mail-ob0-f170.google.com ([209.85.214.170]:36045 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab3A3DcO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 22:32:14 -0500
Received: by mail-ob0-f170.google.com with SMTP id wc20so1216659obb.1
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 19:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ptWNMPT63yXptjQ6v1ZKjVmzEOyU6SGyJEvhVOU3rOs=;
        b=dyQZna2+2MeFF6nhwGk3C+LYf20ZQTJMDadkuBL6DdaJtHVSLIBb8gd9/vyBjKkiOr
         bBm+p+dCfFdAOXuA9Pfzub2g+W0LlAuJhmx+LyIwIpDv6ROLnGy/vjZdOVfbIweNO8Rw
         lbLZJBVY4kDTIzyzjwmzPa8QqmM0lbgMhyc2xbEvmOGZsAhdr7On0J92U2WljPmDuBg/
         yxh0NvMKg0XyNoSjw2Ujq4c6O03EUbT7Mz72l1L6wJGBvoU3S1Yi322bEc2CJ+ZjehgI
         pMtj/5zPjyrkbCNsZgyzNghSM6CTUZbXlsYQHOmfrdehzoSlMO3IkCe98cWZtki5aPFz
         yvOg==
X-Received: by 10.60.154.169 with SMTP id vp9mr2523766oeb.109.1359516733880;
 Tue, 29 Jan 2013 19:32:13 -0800 (PST)
Received: by 10.182.118.229 with HTTP; Tue, 29 Jan 2013 19:31:43 -0800 (PST)
In-Reply-To: <20130129091434.GA6975@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214990>

On Tue, Jan 29, 2013 at 4:14 PM, Jeff King <peff@peff.net> wrote:
> The timings from this one are roughly similar to what I posted earlier.
> Unlike the earlier version, this one keeps the data for a single commit
> together for better cache locality (though I don't think it made a big
> difference in my tests, since my cold-cache timing test ends up touching
> every commit anyway).  The short of it is that for an extra 31M of disk
> space (~4%), I get a warm-cache speedup for "git rev-list --all" of
> ~4.2s to ~0.66s.

Some data point on caching 1-parent vs 2-parent commits on webkit
repo, 26k commits. With your changes (caching 2-parent commits), the
.commits file takes 2241600 bytes. "rev-list --all --quiet":

0.06user 0.00system 0:00.08elapsed 95%CPU (0avgtext+0avgdata 26288maxresident)k
0inputs+0outputs (0major+2094minor)pagefaults 0swaps

With caching 1-parent commits only, the .commits file takes 1707900
bytes (30% less), the same rev-list command:

0.07user 0.00system 0:00.07elapsed 96%CPU (0avgtext+0avgdata 24144maxresident)k
0inputs+0outputs (0major+1960minor)pagefaults 0swaps

Compared to the timing without caching at all:

0.72user 0.02system 0:00.76elapsed 98%CPU (0avgtext+0avgdata 108976maxresident)k
0inputs+0outputs (0major+7272minor)pagefaults 0swaps

The performance loss in 1-parent case is not significant while disk
saving is (although it'll be less impressive after you do Shawn's
suggestion not storing SHA-1 directly)
-- 
Duy
