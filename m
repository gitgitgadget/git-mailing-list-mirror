From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: (bug?) Inconsistent workdir file timestamps after initial clone.
Date: Tue, 11 Dec 2012 17:07:00 -0500
Message-ID: <50C7AE84.2060400@xiplink.com>
References: <50C79D1F.1080709@xiplink.com> <7vy5h47003.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 23:07:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiXya-0005DP-Mg
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 23:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127Ab2LKWGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 17:06:40 -0500
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:45627 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627Ab2LKWGj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 17:06:39 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp18.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 7A673302C5;
	Tue, 11 Dec 2012 17:06:38 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp18.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id D42853029A;
	Tue, 11 Dec 2012 17:06:37 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vy5h47003.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211302>

On 12-12-11 04:27 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> Occasionally when doing a fresh clone of a repo, if the clock ticks at just
>> the wrong time the checked-out files end up with different timestamps.
>>
>> The effect of this can be that, when "make" is run in the workdir it'll
>> decide that some files are out of date and try to rebuild them.
>>
>> (In our particular case, our automated build-bot cloned a submodule of some
>> third-party (i.e. not our) code, where a Makefile.in got an earlier timestamp
>> than its dependent Makefile.am, so "configure && make" then tried to rebuild
>> Makefile.in and the build failed because our build environment has the wrong
>> version of automake.)
> 
> Even if you somehow arrange Makefile.in and Makefile.am to have the
> same timestamp, wouldn't it be up to your "make" to decide which one
> is newer?  Certainly Makefile.in is not newer than Makefile.am, and
> it is free to try rebuilding it.

Well, the makes I've used don't rebuild anything after a "touch *".  I think
it would surprise a lot of people if their make did rebuild files when their
timestamps matched.

> Also if you do this after any operation:
> 
>     $ rm Makefile.am
>     $ git checkout Makefile.am
> 
> you will have Makefile.am that is newer than your Makefile.in and
> you will end up attempting to rebuild it.

Yes, of course.  I would never expect otherwise.

> The timestamp of a working tree file records the time at which it
> was created in your working tree.  It does not have any relation to
> the commit or author timestamp of the commit you check it out of.
> If this command:
> 
>     $ git checkout @{1.dacade.ago} Makefile.am
> 
> gave your Makefile.am an ancient timestamp, it will break your
> build.

Yes, I agree.

My point is that the initial checkout into an empty working directory should
create all files with the same timestamp.

Or, to be a bit more precise, whenever git-checkout *creates* files in the
work dir, *all* the created files should have the *same* timestamp (i.e. the
current time measured at the start of the checkout's execution, not some
bizarro other time specified by some arcane heuristic).

The more I think about it, the more I think it's sloppy for git-checkout to
just let the filesystem assign the exact current time to created files.  A
checkout theoretically should be atomic -- you really shouldn't try to play
with any of the files in your workdir while a checkout is underway.  It's
impractical to really make checkouts atomic, but I think the end result of a
checkout should as much as possible look like the checkout happened all at
one time.

> While not including files that can be rebuilt from the source may be
> the ideal solution, I've seen projects hide rules to rebuild such a
> "generated but needs special tools to build" and/or a "generated but
> normal developers do not have any business rebuilding" file (in your
> case, Makefile.in) in their Makefiles from the normal targets (like
> "make all") for this exact reason, when they choose to distribute
> such files by including in their commits.

I prefer to use the third-party code as-is, without hacking it, to have
smooth upgrades in the future.

		M.
