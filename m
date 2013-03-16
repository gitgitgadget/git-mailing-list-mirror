From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC/PATCH] Documentation/technical/api-fswatch.txt: start with outline
Date: Sat, 16 Mar 2013 15:21:52 +0100
Message-ID: <87ehffv30f.fsf@pctrast.inf.ethz.ch>
References: <1362946623-23649-1-git-send-email-artagnon@gmail.com>
	<513FB85C.5010106@gmail.com>
	<CACsJy8CBru+Z0+oYVKGdwjiF4DDH3w4vCjunaoCnoDQ6AizwWg@mail.gmail.com>
	<5140BC80.4000201@gmail.com> <7vtxof146d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 16 15:23:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGs0o-0005AT-6h
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 15:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459Ab3CPOW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 10:22:29 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:18631 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755669Ab3CPOW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 10:22:27 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 16 Mar
 2013 15:22:22 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (213.55.184.218) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 16 Mar
 2013 15:22:09 +0100
In-Reply-To: <7vtxof146d.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 13 Mar 2013 12:38:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [213.55.184.218]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218307>

Junio C Hamano <gitster@pobox.com> writes:

> Karsten Blees <karsten.blees@gmail.com> writes:
>
>> However, AFAIK inotify doesn't work recursively, so the daemon
>> would at least have to track the directory structure to be able to
>> register / unregister inotify handlers as directories come and go.
>
> Yes, and you would need one inotify per directory but you do not
> have an infinite supply of outstanding inotify watch (wasn't the
> limit like 8k per a single uid or something?), so the daemon must be
> prepared to say "I'll watch this, that and that directories, but the
> consumers should check other directories themselves."

Those are tunable limits though.  For example I run this silly hack

  https://github.com/trast/watch

with the shell snippets to be able to quickly cd a shell to where
something recently happened.  I am able to watch most of my "working
set" even under default limits, which here (opensuse tumbleweed, kernel
3.8.x, x86_64) are

  $ cat /proc/sys/fs/inotify/max_user_watches 
  65536
  $ cat /proc/sys/fs/inotify/max_user_instances 
  128

I'm not sure if other distros impose tighter limits by default, but as
it stands you're not very likely to hit the 65k watches limit in any
given repo.  It seems more likely that you might hit the 128 instances
limit if we go with a design that uses one daemon per repo, if you run a
script that accesses many repos.  For example, in an android tree I have
lying around,

  $ repo list | wc -l
  297

That alone might indicate it would be a good idea to have one "global"
git-agent that starts on demand, rather than a per-repo daemon.
Otherwise we'd have to find a way to discover "old" daemons and tell
them to quit when we hit max_user_instances.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
