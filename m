From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/5] fix pack-refs pruning of refs/foo
Date: Sat, 23 Aug 2014 09:29:36 +0200
Message-ID: <53F842E0.8000603@alum.mit.edu>
References: <20140823052334.GA17813@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 09:29:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XL5li-0008La-Hh
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 09:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbaHWH3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 03:29:40 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:48232 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752333AbaHWH3j (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Aug 2014 03:29:39 -0400
X-AuditID: 1207440e-f79da6d0000002fc-2a-53f842e2d7c4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 7E.6E.00764.2E248F35; Sat, 23 Aug 2014 03:29:38 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB170C.dip0.t-ipconnect.de [93.219.23.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s7N7TaT7002034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 23 Aug 2014 03:29:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <20140823052334.GA17813@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqPvI6UewwYsDKhZdV7qZLH609DBb
	/JtQ48DssWBTqcez3j2MHp83yQUwR3HbJCWWlAVnpufp2yVwZ+zcPIetYIt4xeJNP5kbGK8K
	dTFyckgImEis/72AFcIWk7hwbz1bFyMXh5DAZUaJG8eOMUM455gkGvu2s4FU8QpoSzQ862EC
	sVkEVCV6thwG62YT0JVY1NMMFhcVCJKY/XkeO0S9oMTJmU9YQGwRASOJGx++gc1hFtCU2LTh
	BVivsICVxLmzb8DqhYDmrF5/FWwOp4CexJ1XG4BsDqB6dYn184QgWuUltr+dwzyBUWAWkg2z
	EKpmIalawMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXWC83s0QvNaV0EyMkbPl2MLavlznE
	KMDBqMTDe8L8e7AQa2JZcWXuIUZJDiYlUd7vFj+ChfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw
	5l8FKudNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfCKAuNTSLAoNT21
	Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4Up/HFwEgFSfEA7bUDaectLkjMBYpCtJ5i1OWY
	tPF9L5MQS15+XqqUOK+mI1CRAEhRRmke3ApYknrFKA70sTCvC8goHmCCg5v0CmgJE9CS6TO+
	giwpSURISTUwaq+6kWwiLN2edOR6hI5I2NGKtCsaCatKn3s0TfX5OvOqadaxwO7Xji22kVdv
	Gquw/pm6sLD2ROV09ctqezpjuz59izL9d2+LauuZxoy57z5WhGdkKRw+5Glrs1nu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255738>

On 08/23/2014 07:23 AM, Jeff King wrote:
> I noticed that "git pack-refs --all" will pack a top-level ref like
> "refs/foo", but will not actually prune "$GIT_DIR/refs/foo". I do not
> see the point in having a policy not to pack "refs/foo" if "--all" is
> given. But even if we did have such a policy, this seems broken; we
> should either pack and prune, or leave them untouched. I don't see any
> indication that the existing behavior was intentional.
> 
> The problem is that pack-refs's prune_ref calls lock_ref_sha1, which
> enforces this "no toplevel" behavior. I am not sure there is any real
> point to this, given that most callers use lock_any_ref_for_update,
> which is exactly equivalent but without the toplevel check.
> 
> The first two patches deal with this by switching pack-refs to use
> lock_any_ref_for_update. This will conflict slightly with Ronnie's
> ref-transaction work, as he gets rid of lock_ref_sha1 entirely, and
> moves the code directly into prune_ref. This can be trivially resolved
> in favor of my patch, I think.
> 
> The third patch is a cleanup I noticed while looking around, and I think
> should not conflict with anyone (and is a good thing to do).
> 
> The last two are trickier. I wondered if we could get rid of
> lock_ref_sha1 entirely. After pack-refs, there are two callers:
> fast-import.c and walker.c. After converting the first, it occurred to
> me that Ronnie might be touching the same areas, and I see that yes,
> indeed, there's quite a bit of conflict (and he reaches the same end
> goal of dropping it entirely).
> 
> So in that sense I do not mind dropping the final two patches. Ronnie's
> endpoint is much better, moving to a ref_transaction. However, there is
> actually a buffer overflow in the existing code. Ronnie's series fixes
> it in a similar way (moving to a strbuf), and I'm fine with that
> endpoint. But given that the ref transaction code is not yet merged (and
> would certainly never be maint-track), I think it is worth applying the
> buffer overflow fix separately.
> 
> I think the final patch can probably be dropped, then. It is a clean-up,
> but one that we can just get when Ronnie's series is merged.
> 
>   [1/5]: git-prompt: do not look for refs/stash in $GIT_DIR
>   [2/5]: pack-refs: prune top-level refs like "refs/foo"
>   [3/5]: fast-import: clean up pack_data pointer in end_packfile
>   [4/5]: fast-import: fix buffer overflow in dump_tags
>   [5/5]: fast-import: stop using lock_ref_sha1

+1 on patches 1 and 2
Patch 3 is outside of my area of competence
+1 on patch 4, which looks trivially correct.
+1 on patch 5, though I agree with peff that it can be omitted in
deference to Ronnie's work.

By the way, while cleaning up in patch 5 you might take the chance to
rename the local variable ref_name to refname to be consistent with most
of our code, but this is by no means required.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
