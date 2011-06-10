From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Fri, 10 Jun 2011 12:41:39 -0700
Message-ID: <BANLkTi=4zfO5jKKzbncJk7ihcoHX7Rst4Q@mail.gmail.com>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
 <BANLkTinfVNxYX3kj4DBm1ra=8Ar5ca9UvQ@mail.gmail.com> <BANLkTi=PnYmJVXe8tuqdb9UiYnethf1GSw@mail.gmail.com>
 <4DF0EC32.40001@gmail.com> <BANLkTimk06eibz99AO_0BwzoL6FWb5pR8A@mail.gmail.com>
 <4DF1CAC1.7060705@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	NAKAMURA Takumi <geek4civic@gmail.com>,
	git <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Jun 10 21:42:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV7ao-0000XM-VG
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 21:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757705Ab1FJTmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 15:42:00 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63371 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682Ab1FJTl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 15:41:59 -0400
Received: by gxk21 with SMTP id 21so2000454gxk.19
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 12:41:59 -0700 (PDT)
Received: by 10.236.44.39 with SMTP id m27mr3179976yhb.92.1307734919078; Fri,
 10 Jun 2011 12:41:59 -0700 (PDT)
Received: by 10.147.182.11 with HTTP; Fri, 10 Jun 2011 12:41:39 -0700 (PDT)
In-Reply-To: <4DF1CAC1.7060705@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175616>

On Fri, Jun 10, 2011 at 00:41, Andreas Ericsson <ae@op5.se> wrote:
> On 06/09/2011 05:56 PM, Shawn Pearce wrote:
>>
>> A lot of operations toss every commit that a reference points at into
>> the revision walker's LRU queue. If you have a tag pointing to every
>> commit, then the entire project history enters the LRU queue at once,
>> up front. That queue is managed with O(N^2) insertion time. And the
>> entire queue has to be filled before anything can be output.
>
> Hmm. Since we're using pre-hashed data with an obvious lookup method
> we should be able to do much, much better than O(n^2) for insertion
> and better than O(n) for worst-case lookups. I'm thinking a 1-byte
> trie, resulting in a depth, lookup and insertion complexity of 20. It
> would waste some memory but it might be worth it for fixed asymptotic
> complexity for both insertion and lookup.

Not really.

The queue isn't sorting by SHA-1. Its sorting by commit timestamp,
descending. Those aren't pre-hashed. The O(N^2) insertion is because
the code is trying to find where this commit belongs in the list of
commits as sorted by commit timestamp.

There are some priority queue datastructures designed for this sort of
work, e.g. a calendar queue might help. But its not as simple as a 1
byte trie.

-- 
Shawn.
