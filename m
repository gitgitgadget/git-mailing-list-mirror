From: David Kastrup <dak@gnu.org>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Thu, 20 Feb 2014 18:06:44 +0100
Message-ID: <87y515r9wb.fsf@fencepost.gnu.org>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
	<87r470ssuc.fsf@fencepost.gnu.org>
	<CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
	<87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com>
	<xmqqzjlocf28.fsf@gitster.dls.corp.google.com>
	<CACsJy8AEXP45K+r3gGVTWbn4uuPLeHOkf-an20rj77QSfG1-ew@mail.gmail.com>
	<xmqq4n3warni.fsf@gitster.dls.corp.google.com>
	<CACsJy8C+wGd9WxnsML6-_G_S5GtN2pCPf09kcFtBVu-SDfP8YA@mail.gmail.com>
	<CAGK7Mr4wpwUK6UF6vTmgszX4sajPDvQazY2QagFfH9BEJx_9Ow@mail.gmail.com>
	<CACsJy8DsC9X=13iEpONcT6bw6qTw_O586_vZ2W_3O42ajEPF4A@mail.gmail.com>
	<8738jdspbe.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 18:06:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGX5M-0000XY-0v
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 18:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431AbaBTRGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 12:06:52 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:48428 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592AbaBTRGv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 12:06:51 -0500
Received: from localhost ([127.0.0.1]:47467 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WGX5G-0001dj-MM; Thu, 20 Feb 2014 12:06:50 -0500
Received: by lola (Postfix, from userid 1000)
	id D50A7E067D; Thu, 20 Feb 2014 18:06:44 +0100 (CET)
In-Reply-To: <8738jdspbe.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Thu, 20 Feb 2014 17:48:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242436>

David Kastrup <dak@gnu.org> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> I can think of two improvements we could make, either increase cache
>> size dynamically (within limits) or make it configurable. If we have N
>> entries in worktree (both trees and blobs) and depth M, then we might
>> need to cache N*M objects for it to be effective. Christian, if you
>> want to experiment this, update MAX_DELTA_CACHE in sha1_file.c and
>> rebuild.
>
> Well, my optimized "git-blame" code is considerably hit by an
> aggressively packed Emacs repository so I took a look at it with the
> MAX_DELTA_CACHE value set to the default 256, and then 512, 1024, 2048.

[...]

> Trying with 16384:
> dak@lola:/usr/local/tmp/emacs$ time ../git/git blame src/xdisp.c >/dev/null
>
> real	2m8.000s
> user	0m54.968s
> sys	1m12.624s
>
> And memory consumption did not exceed about 200m all the while, so is
> far lower than what would have been available.

Of course, this has to do with delta_base_cache_limit defaulting to 16m.

> Something's _really_ fishy about that cache behavior.  Note that the
> _system_ time goes up considerably, not just user time.  Since the
> packs are zlib-packed, it's reasonable that more I/O time is also
> associated with more user time and it is well possible that the user
> time increase is entirely explainable by the larger amount of
> compressed data to access.
>
> But this stinks.

And an obvious contender for the stinking is that the "LRU" scheme used
here is _strictly_ freeing memory based on which cache entry has been
_created_ the longest time ago, not which cache entry has been
_accessed_ the longest time ago.  Which means a pure round-robin
strategy for freeing memory rather than LRU.

Let's see what happens when changing this.

-- 
David Kastrup
