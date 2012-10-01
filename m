From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Commit cache to speed up rev-list and merge
Date: Mon, 1 Oct 2012 09:05:48 +0700
Message-ID: <CACsJy8BY2DFhgqdwQdm58+rCuwDj8-7xtqUV9S5cbErU36+zPQ@mail.gmail.com>
References: <CAJo=hJtoqYEL5YiKawCt_SsSUqfCeYEQzY8Ntyb91cNfNS1w_Q@mail.gmail.com>
 <CACsJy8APNsDrTH+hUxgcB=MY0eECCGktm6P1feEEpz2427OQqg@mail.gmail.com> <CAJo=hJtweVTOUT84U1=ONnjQXz5Rt_sDYD2BjUP9tOQ4HDj6Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 01 04:07:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIVPb-0005ag-6q
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 04:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549Ab2JACGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 22:06:20 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51294 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413Ab2JACGU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 22:06:20 -0400
Received: by ieak13 with SMTP id k13so11092930iea.19
        for <git@vger.kernel.org>; Sun, 30 Sep 2012 19:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3TQVOVb2pbKGMpmH9HM+ePzfTEBIYkFG3kcN6z1BMgg=;
        b=Aw8KYl7CS9CK27Y6XvHi8BKtbIghuYNBuyUbXx03qTayU9OENCQTS8PVWkWHV8TJQn
         GlbU5CJgr9uSzZE7ZrFaBolyTrawMYm5aPSslTW2/ERYQRnow1+8E/CJ8gHkLg/umzyP
         IFNYk+I2cJlEnKLZzCqd2xaq2HE1xqcY0d3+w3bcLOcLOEqWcxRUsfMPyymQLnr7hWmM
         aBIUDj061g2bVoHIJoSScHYvu/09QpJYJW2Rhi/6sgUfoJwSsfscSDSt+8Xg1F69VwgS
         a/SAY12xE2d7/D59Iqa52L6b7lIB3pdxWmGk8SxaOsUEroxUO/xpPwXzwE7sk/mHley5
         0+Wg==
Received: by 10.50.53.199 with SMTP id d7mr4399693igp.47.1349057179507; Sun,
 30 Sep 2012 19:06:19 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Sun, 30 Sep 2012 19:05:48 -0700 (PDT)
In-Reply-To: <CAJo=hJtweVTOUT84U1=ONnjQXz5Rt_sDYD2BjUP9tOQ4HDj6Kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206706>

On Mon, Oct 1, 2012 at 8:49 AM, Shawn Pearce <spearce@spearce.org> wrote:
> On Thu, Sep 27, 2012 at 7:14 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> On Thu, Sep 27, 2012 at 10:51 PM, Shawn Pearce <spearce@spearce.org> wrote:
>>> In Linus' Linux kernel tree there are currently about 323,178 commits.
>>> If we store just the pre-parsed commit time as an int32 field this is
>>> an additional 1.2 MiB of data in the pack-*.idx file, assuming we can
>>> use additional data like pack offset position to correlate commit to
>>> the parsed int. If we stored parent pointers in a similar way you
>>> probably need at least 3.6 MiB of additional disk space on the index.
>>> For example, use 12 bytes for each commit to store enough of the
>>> parsed commit time to sort commits, and up to 2 parent pointers per
>>> commit.... with a reserved magic value for octopus merges to mean the
>>> commit itself has to be parsed to get the graph structure correct.
>>
>> This is much better than my naive approach (storing sha-1 and
>> timestamps). We could use less space by storing parent pointer of
>> non-merge commits only. Merge commits linux-2.6 is 6% the number of
>> commits. git.git has higher percentage, 21%. I bet many projects do
>> not merge as much and the number of merge commits is less than 5%.
>
> Some projects merge quite often. Android's frameworks/base repository
> has a very large number of merges. Out of 79905 commits reachable from
> the master branch, 65.3% are merges. So actually there are more merge
> commits in the Android history than there are code commits. A cache of
> only non-merges may be worthless on such a history.

The good thing about these cache is it's configurable. Merge-preferred
projects can choose to cache the first two parents. Non-merge projects
can choose to cache just the first parent. We don't need a fixed
format for both.
-- 
Duy
