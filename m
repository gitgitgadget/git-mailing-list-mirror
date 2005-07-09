From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] rev-list: add "--full-objects" flag.
Date: Sat, 09 Jul 2005 15:09:02 -0600
Message-ID: <m1pstrr8k1.fsf@ebiederm.dsl.xmission.com>
References: <20050703234629.GF13848@pasky.ji.cz>
	<42CBC822.30701@didntduck.org> <20050707144501.GG19781@pasky.ji.cz>
	<7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
	<20050707221443.GB7151@pasky.ji.cz>
	<Pine.LNX.4.58.0507071549330.25104@g5.osdl.org>
	<7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
	<7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071657140.25104@g5.osdl.org>
	<7vvf3mds9c.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071841010.25104@g5.osdl.org>
	<7vy88ica8e.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071928220.25104@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 23:09:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrMa1-0003vO-EU
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 23:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVGIVJl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 17:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVGIVJl
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 17:09:41 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11455 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261731AbVGIVJk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2005 17:09:40 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j69L93M3011323;
	Sat, 9 Jul 2005 15:09:03 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j69L92Hi011322;
	Sat, 9 Jul 2005 15:09:02 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507071928220.25104@g5.osdl.org> (Linus
 Torvalds's message of "Thu, 7 Jul 2005 19:39:23 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 7 Jul 2005, Junio C Hamano wrote:
>> 
>> However it does not automatically mean that the avenue I have
>> been pursuing would not work; the server side preparation needs
>> to be a bit more careful than what I sent, which unconditionally
>> runs "prune-packed".  It instead should leave the files that
>> "--whole-trees" would have packed as plain SHA1 files, so that
>> the bulk is obtained by statically generated packs and the rest
>> can be handled in the commit-chain walker as before.

> The "fetch one object, parse it, fetch the next one, parse that.." 
> approach is just horrible.

Agreed.  That does not cover up latency at all and depending on the 
parsing cost can potentially even keep you from having anything on
your network connection for a noticeable amount of time.

> I ended up preferring the "rsync" thing even though rsync sucked badly on
> big object stores too, if only because when rsync got working, it at least
> nicely pipelined the transfers, and would transfer things ten times faster
> than git-ssh-pull did (maybe I'm exaggerating, but I don't think so, it
> really felt that way).

This feels to me like an implementation issue (no pipelining) rather
than a design issue (pipelining is impossible).

> And the thing is, if you purely follow one tree (which is likely the
> common case for a lot of users), then you are actually always likely
> better off with the "mirror it" model. Which is _not_ a good model for
> developers (for example, me rsync'ing from Jeff's kernel repository always
> got me hundreds of useless objects), but it's fine for somebody who
> actually just wants to track somebody else.

I assume the problem with the mirror it model was simply there were
to many objects?

> And then you really can use just rsync or wget or ncftpget or anything
> else that has a "fetch recursively, optimizing existing objects" mode.

Sane.  But with an intelligent fetcher and a little extra information
a dumb server should still be able to not fetch branches we care
nothing about.  I think that extra information is simply commit
object graph and which packs those commit objects are in.  I assume
the commit graph information will be fairly modest.

Once you have that extra information you can generate incremental
packs whenever you upload to the server, and you can make the
incremental packs per branch.

That should allow an dumb fetcher to look at the list of commits
and just fetch those packs it cares about, and since it only has
to look one place first it should be fairly sane.

The core idea is that if the dumb-server-preparation can anticipate
common access patterns (mirror a branch) and give enough information
so that can be done cheaply and pipelined I don't expect it to be much
worse than an intelligent fetcher.

The current intelligent fetch currently has a problem that it cannot
be used to bootstrap a repository.  If you don't have an ancestor
of what you are fetching you can't fetch it.

Eric
