From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 13 Jun 2011 09:08:09 +0200
Message-ID: <4DF5B759.8090401@op5.se>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com> <BANLkTinfVNxYX3kj4DBm1ra=8Ar5ca9UvQ@mail.gmail.com> <BANLkTi=PnYmJVXe8tuqdb9UiYnethf1GSw@mail.gmail.com> <4DF0EC32.40001@gmail.com> <BANLkTimk06eibz99AO_0BwzoL6FWb5pR8A@mail.gmail.com> <4DF1CAC1.7060705@op5.se> <BANLkTi=4zfO5jKKzbncJk7ihcoHX7Rst4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	NAKAMURA Takumi <geek4civic@gmail.com>,
	git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 13 09:08:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW1Fz-0001OX-SG
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 09:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140Ab1FMHIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 03:08:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37443 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132Ab1FMHIN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 03:08:13 -0400
Received: by fxm17 with SMTP id 17so2513003fxm.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 00:08:12 -0700 (PDT)
Received: by 10.223.60.7 with SMTP id n7mr4837529fah.51.1307948892207;
        Mon, 13 Jun 2011 00:08:12 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id q21sm1954252fan.40.2011.06.13.00.08.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Jun 2011 00:08:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10 ThunderGit/0.1a
In-Reply-To: <BANLkTi=4zfO5jKKzbncJk7ihcoHX7Rst4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175687>

On 06/10/2011 09:41 PM, Shawn Pearce wrote:
> On Fri, Jun 10, 2011 at 00:41, Andreas Ericsson<ae@op5.se>  wrote:
>> On 06/09/2011 05:56 PM, Shawn Pearce wrote:
>>>
>>> A lot of operations toss every commit that a reference points at into
>>> the revision walker's LRU queue. If you have a tag pointing to every
>>> commit, then the entire project history enters the LRU queue at once,
>>> up front. That queue is managed with O(N^2) insertion time. And the
>>> entire queue has to be filled before anything can be output.
>>
>> Hmm. Since we're using pre-hashed data with an obvious lookup method
>> we should be able to do much, much better than O(n^2) for insertion
>> and better than O(n) for worst-case lookups. I'm thinking a 1-byte
>> trie, resulting in a depth, lookup and insertion complexity of 20. It
>> would waste some memory but it might be worth it for fixed asymptotic
>> complexity for both insertion and lookup.
> 
> Not really.
> 
> The queue isn't sorting by SHA-1. Its sorting by commit timestamp,
> descending. Those aren't pre-hashed. The O(N^2) insertion is because
> the code is trying to find where this commit belongs in the list of
> commits as sorted by commit timestamp.
> 

Hmm. We should still be able to do better than that, and particularly
for the "tag-each-commit" workflow. Since it's most likely those tags
are generated using incrementing numbers, we could have a cut-off where
we first parse all the refs and make an optimistic assumption that an
alphabetical sort of the refs provides a map of insertion-points for
the commits. Since the best case behaviour is still O(1) for insertion
sort and it's unlikely that thousands of refs are in random order, that
should cause the vast majority of the refs we insert to follow the best
case scenario.

This will fall on its arse when people start doing hg-ref -> git-commit
tags ofcourse, but that doesn't seem to be happening, or at least not to
the same extent as with svn-revisions -> git-gommit mapping.

We're still not improving the asymptotic complexity, but it's a pretty
safe bet that we for a vast majority of cases improve wallclock runtime
by a hefty amount with a relatively minor effort.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
