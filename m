From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Wed, 4 Jun 2008 02:11:28 +0200
Message-ID: <200806040211.29430.jnareb@gmail.com>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com> <200806032224.08714.jnareb@gmail.com> <4845CF9F.10604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 02:12:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3gcC-0001Kf-Kl
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 02:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbYFDALk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 20:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753547AbYFDALj
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 20:11:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:47240 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbYFDALi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 20:11:38 -0400
Received: by nf-out-0910.google.com with SMTP id d3so701832nfc.21
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 17:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=elC25w40lPGqufhR2zb8HKHUYXl2+q1lOrsYRxl6Rsw=;
        b=grE4smh8mN1T9sNA4ZslZk+4Sc3RygxMS0olvF6m2NIlJunWQhSTP0Sn12rxKFf/RQBSpy/7weE89ZKF/AbSJTB0qxUQLPe5hCEL+4pVDo/A7cr+LPpg4qhnBFBrBIjgTqLl66CcM0yam5tPA+wrDiEjilj3+/l48NIX7ML+Z0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Rk5eYv8tWn9VbgE3LPAiBaxKqPtcvw9yQkXhmsfOSWQCJ6vSvu170iQ55xOq+hxGZRtb4WfJVvuYwz6Axl+6jKn+XXLm/EtSUP1okl4MRJeVBP6Q15yTxudqaLPfDtrfCQIUATiP7gXqhSRaTTakhwA7Osu/ZZNalTVzCzH7p/A=
Received: by 10.210.25.20 with SMTP id 20mr236362eby.46.1212538297036;
        Tue, 03 Jun 2008 17:11:37 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.251.199])
        by mx.google.com with ESMTPS id c4sm4486564nfi.13.2008.06.03.17.11.33
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 17:11:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4845CF9F.10604@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83734>

Lea Wiemann wrote:
> Jakub Narebski wrote:
>>
>> I don't think %parent_commits hash is suitable for caching; it is only
>> intermediate step, reducing number of git command calls (and forks) [...]
>> 
>> ATTENTION! This example shows where caching [parsed] data have problems 
>> compared to front-end caching (caching output).
> 
> ATTENTION!  Could we please stop having this discussion?!

Yeah, yeah, I know.  "Talk is cheap, show me the code" (or at least
pseudocode).

> Your argument  
> is completely bogus.  If the parent commit hashes are in cache, it's an 
> almost zero-time cache lookup.

You have cut a bit too much (quoted a bit too little) for me to decide
if I made myself clear wrt. saving %parent_commits hash into cache.

What I wanted to say that in caching intermediate data for 'blame' view
you have to save to cache something like @blocks (or @lines) array.
This array can contain parents of blamed commits, so there is no need
for saving %parent_commits separately: it would be duplication of
information.  This hash is needed to reduce number of calls to
git-rev-parse, and is used to generate parsed info, which info in turn
(I think) can be cached.

> The only difference it might make  
> compared front-end caching is the CPU time it takes to generate the 
> page, and *I want to see benchmarks before I even start thinking about 
> CPU*.  Okay?  Good, thanks.

The only place where I think front-end caching could be better is
'blob' view with syntax highlighting (using some external filter, like
GNU Source Highlight)... which is not implemented yet.

I thought that snapshots (if enabled) would fall in this category, but
this is the case where data cache is almost identical to output cache
(the same happens for [almost] all "raw" / *_plain views).

> Sorry I'm a little indignant, but you seem to be somehow trying to tell 
> me what to implement, and that gets annoying after a while.  I don't 
> mind your input, but at some point the discussion just doesn't go any 
> further.
> 
>> Problems occur when we try to cache page with _streaming_ output, such 
>> as blob view, blame view, diff part of commitdiff etc.
> 
> We can still stream backend-cache-backed data, though it's a little 
> harder.  It's mostly a memory, not a performance issue though -- the 
> only point where I think it actually would be performance-relevant is 
> blame, and blame doesn't stream anyway (see below).

And snapshots.  We certainly want to stream snapshots, as they can be
quite large.

Also blob_plain view might be difficult, if there are extremely large
binary files in the repository (it should not happen often, but it can
happen).

[...]
>>> 2) Major point: You're still forking a lot.  The Right Thing is to
>>> condense everything into a single call
>> 
>> This is not a good solution for 'blame' view, which is generated "on the 
>> fly", by streaming git-blame output via filter.
> 
> No, whether you have your "while <$fd>" loop or not doesn't make a 
> difference.

It perhaps makes no difference performance wise (solution with
"git rev-list --parents --no-walk" has one fork more), but it might
make code unnecessarily more complicated.  In the rev-list solution
you have to browse git-blame output to gather all blamed commits one
want to find parents of; in the case of extending git-blame you can
just process block after block of code.

> Blame first calculates the whole blame and then dumps it  
> out in zero-time, unless you use --incremental.

There is some code in the mailing list archive (and perhaps used by
repo's gitweb, but I might be mistaken), which adds
git_blame_incremental and use AJAX together with "git blame --incremental"
to reduce latency.  It was done by having JavaScript check if browser
is AJAX-capable, and if it was rewriting 'blame' links to
'blame_incremental'.  But if there exist cached blame, I think it would
be as fast (in terms of latency) to generate 'blame' from cache as to
generate 'blame_incremental'.

> So there's no  
> performance difference in getting all blame output and then dumping it 
> out vs. reading and outputting it line-by-line.

Performance wise, perhaps not.  Memory wise, perhaps yes; better not
to use more memory than needed, especially if memcached is to share
machine.

> And regarding memory,  
> if your blame output doesn't fit into your RAM, you have different kinds 
> of issues.

True.

> JFTR, I don't have any opinion about extending the porcelain output of 
> git-blame (apart from the fact that happens to not be useful for gitweb 
> for the reason I outlined in the previous paragraph).

It would be/might be (I haven't examined corner cases yet) important in
the case of file history which both contains evil merges, and it's
simplified history is different than full history.
-- 
Jakub Narebski
Poland
