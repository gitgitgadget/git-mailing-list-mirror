From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC 0/6] commit caching
Date: Wed, 30 Jan 2013 15:32:44 +0700
Message-ID: <CACsJy8BEyha1QdQmRH9o-h_3JLPmMemoc4ucSaQ_nrOMzQ64AQ@mail.gmail.com>
References: <20130129091434.GA6975@sigill.intra.peff.net> <CACsJy8BE3LdxbZzdQXuvEJop23KnnLbCTgPos9CywKV7EY2q9g@mail.gmail.com>
 <20130130071839.GF11147@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 30 09:33:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0T6u-0007eg-VC
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 09:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766Ab3A3IdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 03:33:15 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:44301 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab3A3IdO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 03:33:14 -0500
Received: by mail-ob0-f181.google.com with SMTP id ni5so1344592obc.26
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 00:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=UzsIjeSbDfK8Sai1yHeu8YKWKabE0C3489WpZQzx8kg=;
        b=Ete5F0ERgri0MMfU0TTKQgN8MXz2J1m8H9MaGCmgVSD7oJnKiHQaHuIBBB093tnoBm
         eSQKoY9DSirQj7nO8X13kIBISYfbUfncGKwMO68f2zjMWCFxPfR4n/v4xyocHMnVae1+
         o/J/LyMPYK5giZOrP/DeEr3jXo1rIPhlwrjyMoGBPiqdM7ngLHUAT1WoArukAkNpeVSN
         gOKYa4sFqnPZTU8wz5H2Weo7Fr7D4Vko6/ufNf6Ys52AQ0FaGA8W15CBPW/LvOIJB8qj
         vQbmWDuAfjUWTrdmMBOdo2E1eJxP3oXYMlB5GeXNCtNm8yxWCPwph6vjgdgtYUaMB1a5
         6GRQ==
X-Received: by 10.60.22.164 with SMTP id e4mr2978992oef.87.1359534794055; Wed,
 30 Jan 2013 00:33:14 -0800 (PST)
Received: by 10.182.118.229 with HTTP; Wed, 30 Jan 2013 00:32:44 -0800 (PST)
In-Reply-To: <20130130071839.GF11147@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215006>

On Wed, Jan 30, 2013 at 2:18 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 30, 2013 at 10:31:43AM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> On Tue, Jan 29, 2013 at 4:14 PM, Jeff King <peff@peff.net> wrote:
>> > The timings from this one are roughly similar to what I posted earlier.
>> > Unlike the earlier version, this one keeps the data for a single commit
>> > together for better cache locality (though I don't think it made a big
>> > difference in my tests, since my cold-cache timing test ends up touching
>> > every commit anyway).  The short of it is that for an extra 31M of disk
>> > space (~4%), I get a warm-cache speedup for "git rev-list --all" of
>> > ~4.2s to ~0.66s.
>>
>> Some data point on caching 1-parent vs 2-parent commits on webkit
>> repo, 26k commits. With your changes (caching 2-parent commits), the
>> .commits file takes 2241600 bytes. "rev-list --all --quiet":
>
> Hmm. My webkit repo has zero merges in it (though it is the older
> svn-based one). What percentage of the one you have are merges? How does
> your 1-parent cache perform on something like git.git, where about 25%
> of all commits are merges?

git.git performs worse with 1-parent cache. But the point is it should
be customizable.

>> The performance loss in 1-parent case is not significant while disk
>> saving is (although it'll be less impressive after you do Shawn's
>> suggestion not storing SHA-1 directly)
>
> Yeah, I think moving to offsets instead of sha1s is going to be a big
> enough win that it won't matter anymore.

Yeah, if we use uint32_t instead of sha-1, the cache is just about
400k 2 parents for webkit, 312k for 1 parent. The total size is so
small that reduction does not really matter anymore.
-- 
Duy
