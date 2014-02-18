From: David Kastrup <dak@gnu.org>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Tue, 18 Feb 2014 09:55:23 +0100
Message-ID: <87r470ssuc.fsf@fencepost.gnu.org>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christian Jaeger <chrjae@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 10:36:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFh6R-0007t2-Pu
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 10:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735AbaBRJg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 04:36:27 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:60884 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754621AbaBRJgY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 04:36:24 -0500
Received: from localhost ([127.0.0.1]:59925 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WFh6F-00018G-KV; Tue, 18 Feb 2014 04:36:23 -0500
Received: by lola (Postfix, from userid 1000)
	id A3AC5E0487; Tue, 18 Feb 2014 09:55:23 +0100 (CET)
In-Reply-To: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
	(Christian Jaeger's message of "Tue, 18 Feb 2014 07:25:10 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242290>

Christian Jaeger <chrjae@gmail.com> writes:

> I've got a repository where "git log --raw > _somefile" took a few
> seconds in the past, but after an attempt at merging some commits that
> were collected in a clone of the same repo that was created about a
> year ago, I noticed that this command was now taking 3 minutes 7
> seconds. "git gc", "git fsck", "git clone file:///the/repo/.git" also
> now each took between ~4-10 minutes, also "git log --raw somefile" got
> equally unusably slow. With the help of the people on the IRC, I
> tracked it down to my recent use of "git gc --aggressive" in this
> repo. Running "git repack -a -d -f" solved it, now it's again taking
> 4-5 seconds. After running "git gc --aggressive" again for
> confirmation, "git log --raw > _somefile" was again slowed down,
> although now 'only' to 1 minute 34 seconds;

[...]

> I've now learned to avoid "git gc --aggressive". Perhaps there are
> some other conclusions to be drawn, I don't know.

I've seen the same with my ongoing work on git-blame with the current
Emacs Git mirror.  Aggressive packing reduces the repository size to
about a quarter, but it blows up the system time (mainly I/O)
significantly, quite reducing the total benefits of my algorithmic
improvements there.

There is also some quite visible additional time spent in zlib, so a
wild guess would be that zlib is not really suited to the massive amount
of directory entries of a Git object store.  Since the system time still
dominates, this guess would only make sense if Git over zlib kept
rereading the directory section of whatever compressed file we are
talking about.  But that's really a rather handwavy wild guess without
anything better than a hunch to back it up.  I don't even know what kind
of compression and/or packs are used: I've only ever messed myself with
the delta coding of the normal "unpacked" operation (there are a few
older commits from me on that).

-- 
David Kastrup
