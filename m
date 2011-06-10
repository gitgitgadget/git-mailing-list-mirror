From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git is not scalable with too many refs/*
Date: Fri, 10 Jun 2011 09:41:53 +0200
Message-ID: <4DF1CAC1.7060705@op5.se>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com> <BANLkTinfVNxYX3kj4DBm1ra=8Ar5ca9UvQ@mail.gmail.com> <BANLkTi=PnYmJVXe8tuqdb9UiYnethf1GSw@mail.gmail.com> <4DF0EC32.40001@gmail.com> <BANLkTimk06eibz99AO_0BwzoL6FWb5pR8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	NAKAMURA Takumi <geek4civic@gmail.com>,
	git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 10 09:42:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUwLy-0003zT-CT
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 09:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570Ab1FJHl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 03:41:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42819 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab1FJHl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 03:41:57 -0400
Received: by bwz15 with SMTP id 15so1969707bwz.19
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 00:41:55 -0700 (PDT)
Received: by 10.204.153.20 with SMTP id i20mr1473744bkw.208.1307691715549;
        Fri, 10 Jun 2011 00:41:55 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id a28sm112904fak.1.2011.06.10.00.41.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Jun 2011 00:41:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10 ThunderGit/0.1a
In-Reply-To: <BANLkTimk06eibz99AO_0BwzoL6FWb5pR8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175600>

On 06/09/2011 05:56 PM, Shawn Pearce wrote:
> On Thu, Jun 9, 2011 at 08:52, A Large Angry SCM<gitzilla@gmail.com>  wrote:
>> On 06/09/2011 11:23 AM, Shawn Pearce wrote:
>>> Having a reference to every commit in the repository is horrifically
>>> slow. We run into this with Gerrit Code Review and I need to find
>>> another solution. Git just wasn't meant to process repositories like
>>> this.
>>
>> Assuming a very large number of refs, what is it that makes git so
>> horrifically slow? Is there a design or implementation lesson here?
> 
> A few things.
> 
> Git does a sequential scan of all references when it first needs to
> access references for an operation. This requires reading the entire
> packed-refs file, and the recursive scan of the "refs/" subdirectory
> for any loose refs that might override the packed-refs file.
> 
> A lot of operations toss every commit that a reference points at into
> the revision walker's LRU queue. If you have a tag pointing to every
> commit, then the entire project history enters the LRU queue at once,
> up front. That queue is managed with O(N^2) insertion time. And the
> entire queue has to be filled before anything can be output.
> 

Hmm. Since we're using pre-hashed data with an obvious lookup method
we should be able to do much, much better than O(n^2) for insertion
and better than O(n) for worst-case lookups. I'm thinking a 1-byte
trie, resulting in a depth, lookup and insertion complexity of 20. It
would waste some memory but it might be worth it for fixed asymptotic
complexity for both insertion and lookup.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
