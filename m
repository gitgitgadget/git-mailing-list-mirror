From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Commit cache to speed up rev-list and merge
Date: Sun, 30 Sep 2012 18:49:24 -0700
Message-ID: <CAJo=hJtweVTOUT84U1=ONnjQXz5Rt_sDYD2BjUP9tOQ4HDj6Kg@mail.gmail.com>
References: <CAJo=hJtoqYEL5YiKawCt_SsSUqfCeYEQzY8Ntyb91cNfNS1w_Q@mail.gmail.com>
 <CACsJy8APNsDrTH+hUxgcB=MY0eECCGktm6P1feEEpz2427OQqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 03:49:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIV8v-0001S2-5E
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 03:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528Ab2JABtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 21:49:46 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:52513 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400Ab2JABtp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 21:49:45 -0400
Received: by qaas11 with SMTP id s11so1166307qaa.19
        for <git@vger.kernel.org>; Sun, 30 Sep 2012 18:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=X8xoLSoGw7u9/Mejo6ac58aHJlezAhXUu4m0QndYwFU=;
        b=QBa0zTGh1tlkmsSEfjbE2+wVtfzb3ic+b9wqCFxYfhJVboA/dbsrrRqHcCNIsVVest
         qtLv6cwYqcx+FSPFlLm/S1vops2exsQcZGuM16LFfHnZATjqnsz7xJ1YF/jeU/7Hjt3w
         PsTPH5cIq6XPgaY+WhQNC1JJdo87CiToNDxOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=X8xoLSoGw7u9/Mejo6ac58aHJlezAhXUu4m0QndYwFU=;
        b=mlONWWZHDbpYOopjPAtWo/fOQ944SR4sk5R1dL0gQKUy+XuDVdBa2cRhgQlQTUAmXP
         gh96jPwuaLj9amvsKOulDWbVi7nCGfkuen/ME0DWSPlUBHWcRE5kBxcVU1nv/2RxOOXF
         wnfGVn9b9U0FIxGHxJJCFkvmNKeOMIt6mh/RI0t5xNDJsPfJp3xWP/HntAZzSq+nyeuJ
         YCrUXkLZq9w/gxC1SdQLd706TxYw9OPIBDV/ZRQ0AH4j14yzSJC2/zi2Yg2NKc42YElV
         6Mx9a1wFTBfjWjJWiXc520lzC/3l/LyEyjp7aGXzeUPEQbwVRVFMwqS8Zfl2ImbVOcDA
         wkOA==
Received: by 10.229.178.193 with SMTP id bn1mr1923195qcb.80.1349056184943;
 Sun, 30 Sep 2012 18:49:44 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Sun, 30 Sep 2012 18:49:24 -0700 (PDT)
In-Reply-To: <CACsJy8APNsDrTH+hUxgcB=MY0eECCGktm6P1feEEpz2427OQqg@mail.gmail.com>
X-Gm-Message-State: ALoCoQmHz0qMrXllE2ec0QBotpXCXUXfAmXg0Os4IGFa4/JVAlTp26fk1lZiZPsja1wMlSpokJEP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206704>

On Thu, Sep 27, 2012 at 7:14 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Thu, Sep 27, 2012 at 10:51 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> In Linus' Linux kernel tree there are currently about 323,178 commits.
>> If we store just the pre-parsed commit time as an int32 field this is
>> an additional 1.2 MiB of data in the pack-*.idx file, assuming we can
>> use additional data like pack offset position to correlate commit to
>> the parsed int. If we stored parent pointers in a similar way you
>> probably need at least 3.6 MiB of additional disk space on the index.
>> For example, use 12 bytes for each commit to store enough of the
>> parsed commit time to sort commits, and up to 2 parent pointers per
>> commit.... with a reserved magic value for octopus merges to mean the
>> commit itself has to be parsed to get the graph structure correct.
>
> This is much better than my naive approach (storing sha-1 and
> timestamps). We could use less space by storing parent pointer of
> non-merge commits only. Merge commits linux-2.6 is 6% the number of
> commits. git.git has higher percentage, 21%. I bet many projects do
> not merge as much and the number of merge commits is less than 5%.

Some projects merge quite often. Android's frameworks/base repository
has a very large number of merges. Out of 79905 commits reachable from
the master branch, 65.3% are merges. So actually there are more merge
commits in the Android history than there are code commits. A cache of
only non-merges may be worthless on such a history.
