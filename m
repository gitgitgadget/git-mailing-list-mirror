From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: another packed-refs race
Date: Tue, 07 May 2013 10:03:06 +0200
Message-ID: <5188B53A.3090106@alum.mit.edu>
References: <20130503083847.GA16542@sigill.intra.peff.net> <51879C1C.5000407@alum.mit.edu> <20130506184122.GA23568@sigill.intra.peff.net> <518883CC.7050609@alum.mit.edu> <20130507044456.GA29757@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 07 10:03:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZcro-00061I-Iu
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 10:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757356Ab3EGIDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 04:03:12 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:53122 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754068Ab3EGIDJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 May 2013 04:03:09 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-31-5188b53c710c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 55.B2.02295.C35B8815; Tue,  7 May 2013 04:03:09 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r47836Vx026158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 May 2013 04:03:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130507044456.GA29757@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqGu7tSPQYMU+RouuK91MFvPu7mKy
	+NHSw+zA7HHp5Xc2j2e9exg9Pm+SC2CO4rZJSiwpC85Mz9O3S+DO6Np8jrFgtVTF78sPWBoY
	/4h0MXJySAiYSHTd3cIOYYtJXLi3nq2LkYtDSOAyo8TUp9tYIJxjTBLfNz9gBKniFdCW+Hfx
	FBOIzSKgKnFk8W+wbjYBXYlFPc1gcVGBMIlV65cxQ9QLSpyc+YQFxBYRkJX4fngj2BxmASuJ
	VVfaWEFsYaA5E5dNYIdYdoNRovn1caAGDg5OAWuJk83yICazgLrE+nlCEK3yEtvfzmGewCgw
	C8mGWQhVs5BULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6iXm1mil5pSuokREro8Oxi/
	rZM5xCjAwajEw6twqj1QiDWxrLgy9xCjJAeTkijv4o0dgUJ8SfkplRmJxRnxRaU5qcWHGCU4
	mJVEeKW1gXK8KYmVValF+TApaQ4WJXFe1SXqfkIC6YklqdmpqQWpRTBZGQ4OJQlezi1AjYJF
	qempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgOI0vBkYqSIoHaK8BSDtvcUFiLlAUovUU
	oy7HyitPXjMKseTl56VKifNu3QxUJABSlFGaB7cClqheMYoDfSzMKwIyigeY5OAmvQJawgS0
	JIGvHWRJSSJCSqqBMd4tTmgDf6qQxKb8ff8mGHBHSq3lOPU3QXR2cvZPXv0VRukly7Y9+n1x
	amOSC8OSZgaTDhmHs3+VqpX1Jk/JSs2I7dNL+rKlsnZWoZe6R6+rkFZ4dc/bfKva 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223567>

On 05/07/2013 06:44 AM, Jeff King wrote:
> On Tue, May 07, 2013 at 06:32:12AM +0200, Michael Haggerty wrote:
> 
>> Another potential problem caused by the non-atomicity of loose reference
>> reading could be to confuse reachability tests if process 1 is reading
>> loose references while process 2 is renaming a reference:
>>
>> 1. Process 1 looks for refs/heads/aaaaa and finds it missing.
>>
>> 2. Process 2 renames zzzzz -> aaaaa
>>
>> 3. Process 1 looks for refs/heads/zzzzz and finds it missing.
>>
>> Process 2 would think that any objects pointed to by aaaaa (formerly
>> zzzzz) are unreachable.  This would be unfortunate if it is doing an
>> upload-pack and very bad if it is doing a gc.  I wonder if this could be
>> a problem in practice?  (Gee, wouldn't it be nice to keep reflogs for
>> deleted refs? :-) )
> 
> Ugh. Yeah, that is definitely a possible race, and it could be quite
> disastrous for prune.
> 
> I am really starting to think that we need a pluggable refs
> architecture, and that busy servers can use something like sqlite to
> keep the ref storage. That would require bumping repositoryformatversion,
> of course, but it would be OK for a server accessible only by git
> protocols.

That would be a fun project.  I like the idea of not burdening people's
local mostly-one-user-at-a-time repositories with code that is hardened
against server-level pounding.

> I also wonder if we can spend extra time to get more reliable results
> for prune, like checking refs, coming up with a prune list, and then
> checking again. I have a feeling it's a 2-generals sort of problem where
> we can always miss a ref that keeps bouncing around, but we could bound
> the probability. I haven't thought that hard about it. Perhaps this will
> give us something to talk about on Thursday. :)

It's not 100% solvable without big changes; there could always be a
malign Dijkstra running around your system, renaming references right
before you read them.  But I guess it would be pretty safe if pack would
keep the union of objects reachable from the references read at the
beginning of the run and objects reachable from the references read at
(aka near) the end of the run.

>> * Preloading the whole tree of loose references before starting an
>> iteration.  As I recall, this was a performance *win*.  It was on my
>> to-do list of things to pursue when I have some free time (ha, ha).  I
>> mostly wanted to check first that there are not callers who abort the
>> iteration soon after starting it.  For example, imagine a caller who
>> tries to determine "are there any tags at all" by iterating over
>> "refs/tags" with a callback that just returns 1; such a caller would
>> suffer the cost of reading all of the loose references in "refs/tags".
> 
> Well, you can measure my patches, because that's what they do. :) I
> didn't really consider an early termination from the iteration.
> Certainly something like:
> 
>   git for-each-ref refs/tags | head -1
> 
> would take longer. Though if you have that many refs that the latency is
> a big problem, you should probably consider packing them (it can't
> possibly bite you with a race condition, right?).

No, I don't see a correctness issue.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
