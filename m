From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [RFC/PATCH] Documentation/technical/api-fswatch.txt: start with outline
Date: Mon, 18 Mar 2013 11:07:55 +0100
Message-ID: <87r4jdt404.fsf@pctrast.inf.ethz.ch>
References: <1362946623-23649-1-git-send-email-artagnon@gmail.com>
	<513FB85C.5010106@gmail.com>
	<CACsJy8CBru+Z0+oYVKGdwjiF4DDH3w4vCjunaoCnoDQ6AizwWg@mail.gmail.com>
	<5140BC80.4000201@gmail.com> <7vtxof146d.fsf@alter.siamese.dyndns.org>
	<87ehffv30f.fsf@pctrast.inf.ethz.ch>
	<CALkWK0=0+HYn=bSrGC5sMQOE-53As0h9dG3N9wvUB2=NW3=98A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Jeff King <peff@peff.net>,
	"Erik Faye-Lund" <kusmabite@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 11:08:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHWzS-0006o1-MC
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 11:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115Ab3CRKH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 06:07:59 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:31412 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355Ab3CRKH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 06:07:59 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 18 Mar
 2013 11:07:55 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 18 Mar 2013 11:07:56 +0100
In-Reply-To: <CALkWK0=0+HYn=bSrGC5sMQOE-53As0h9dG3N9wvUB2=NW3=98A@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 18 Mar 2013 13:54:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218401>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Yes, and you would need one inotify per directory but you do not
>> have an infinite supply of outstanding inotify watch (wasn't the
>> limit like 8k per a single uid or something?), so the daemon must be
>> prepared to say "I'll watch this, that and that directories, but the
>> consumers should check other directories themselves."
>>
>> FWIW, I share your suspicion that an effort in the direction this
>> thread suggests may end up duplicating what the caching vfs layer
>> already does, and doing so poorly.
>
> Thomas Rast wrote:
>>   $ cat /proc/sys/fs/inotify/max_user_watches
>>   65536
>>   $ cat /proc/sys/fs/inotify/max_user_instancest
>>   128
>
> From Junio's and Thomas' observations, I'm inclined to think that
> inotify is ill-suited for the problem we are trying to solve.  It is
> designed as a per-directory watch, because VFS can quickly supply the
> inodes for a directory entry.  As such, I think the ideal usecase for
> inotify is to execute something immediately when a change takes place
> in a directory: it's well-suited for solutions like Dropbox (which I
> think is poorly designed to begin with, but that's offtopic).  It
> doesn't substitute of augment VFS caching.  I suspect the VFS cache
> works by caching the inodes in a frequently used directory entry, thus
> optimizing calls like lstat() on them.

I have three objections to changing the kernel to fit us, as opposed to
just using inotify:

* inotify works.  I can watch most of my $HOME with the hack I linked
  earlier[1].  Yes, it's a lot of coding around the problem that it is
  nonrecursive, but we already have a lot of code around the problem
  that we can't ask the VFS for diffs between points in time (namely,
  the whole business with an index and lstat() loops).

* inotify is here today.  Even if you got a hypothetical notifier into
  the kernel today, you'd have to wait months/years until it is
  available in distros, and years until everyone has it.

* I'll bet you a beer that the kernel folks already had the same
  discussion when they made inotify.  There has to be a reason why it's
  better than providing for recursive watches.


[1]  https://github.com/trast/watch

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
