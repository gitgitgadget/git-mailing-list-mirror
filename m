From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 27 Sep 2011 00:26:55 +0100
Message-ID: <ece30e6a1b74bcddde5634003408f61f@quantumfyre.co.uk>
References: <4DF6A8B6.9030301@op5.se>
 <9ae990f15489d7b51a172d08e63ca458@quantumfyre.co.uk>
 <201109261539.33437.mfick@codeaurora.org>
 <201109261552.04946.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Sep 27 01:27:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8KZi-0004Uv-LU
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 01:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396Ab1IZX06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 19:26:58 -0400
Received: from neutrino.quantumfyre.co.uk ([93.93.128.23]:49793 "EHLO
	neutrino.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750755Ab1IZX05 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 19:26:57 -0400
Received: from reaper.quantumfyre.co.uk (quantumfyre-1-pt.tunnel.tserv5.lon1.ipv6.he.net [IPv6:2001:470:1f08:1724::2])
	by neutrino.quantumfyre.co.uk (Postfix) with ESMTP id CF680C0602;
	Tue, 27 Sep 2011 00:26:56 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id AB76B36A825;
	Tue, 27 Sep 2011 00:26:56 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id be0A-FINI-Wu; Tue, 27 Sep 2011 00:26:56 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id EF8EA36A6DD;
	Tue, 27 Sep 2011 00:26:55 +0100 (BST)
In-Reply-To: <201109261552.04946.mfick@codeaurora.org>
X-Sender: julian@quantumfyre.co.uk
User-Agent: Roundcube Webmail/0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182189>

On Mon, 26 Sep 2011 15:52:04 -0600, Martin Fick wrote:
> On Monday, September 26, 2011 03:39:33 pm Martin Fick wrote:
>> On Monday, September 26, 2011 02:28:53 pm Julian Phillips
>> wrote:
>> > >> Random thought.  What happens to the with
>> > >> compression case if you leave the commit in, but
>> > >> add a sleep(15) to the end of sort_refs_list?
>> > >
>> > > Why, what are you thinking?  Hmm, I am trying this on
>> > > the non gced repo and it doesn't seem to be
>> > > completing (no cpu usage)!  It appears that perhaps
>> > > it is being called many times (the sleeping would
>> > > explain no cpu usage)?!?  This could be a real
>> > > problem, this should only get called once right?
>> >
>> > I was just wondering if the time taken to get the refs
>> > was changing the interaction with something else.  Not
>> > very likely, but ...
>> >
>> > I added a print statement, and it was called four times
>> > when I had unpacked refs, and once with packed.  So,
>> > maybe you are hitting some nasty case with unpacked
>> > refs.  If you use a print statement instead of a sleep,
>> > how many times does sort_refs_lists get called in your
>> > unpacked case?  It may well also be worth calculating
>> > the time taken to do the sort.
>>
>> In my case it was called 18785 times!  Any other tests I
>> should run?
>
> Gerrit stores the changes in directories under refs/changes
> named after the last 2 digits of the change.  Then under
> each change it stores each patchset.  So it looks like this:
> refs/changes/dd/change_num/ps_num
>
> I noticed that:
>
>  ls refs/changes/* | wc -l
>  -> 18876
>
> somewhat close, but not super close to 18785,  I am not sure
> if that is a clue.  It's almost like each change is causing
> a re-sort,

basically, it is ...

Back when I made that change, I failed to notice that get_ref_dir was 
recursive for subdirectories ... sorry ...

Hopefully this should speed things up.  My test repo went from ~17m 
user time, to ~2.5s.
Packing still make things much faster of course.

diff --git a/refs.c b/refs.c
index a615043..212e7ec 100644
--- a/refs.c
+++ b/refs.c
@@ -319,7 +319,7 @@ static struct ref_list *get_ref_dir(const char 
*submodule, c
                 free(ref);
                 closedir(dir);
         }
-       return sort_ref_list(list);
+       return list;
  }

  struct warn_if_dangling_data {
@@ -361,11 +361,13 @@ static struct ref_list *get_loose_refs(const char 
*submodu
         if (submodule) {
                 free_ref_list(submodule_refs.loose);
                 submodule_refs.loose = get_ref_dir(submodule, "refs", 
NULL);
+               submodule_refs.loose = 
sort_refs_list(submodule_refs.loose);
                 return submodule_refs.loose;
         }

         if (!cached_refs.did_loose) {
                 cached_refs.loose = get_ref_dir(NULL, "refs", NULL);
+               cached_refs.loose = sort_refs_list(cached_refs.loose);
                 cached_refs.did_loose = 1;
         }
         return cached_refs.loose;



>
>
> -Martin

-- 
Julian
