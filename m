From: David Kastrup <dak@gnu.org>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Thu, 20 Feb 2014 17:48:21 +0100
Message-ID: <8738jdspbe.fsf@fencepost.gnu.org>
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
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 17:48:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGWni-0005EL-34
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 17:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbaBTQsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 11:48:37 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:48117 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868AbaBTQsh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 11:48:37 -0500
Received: from localhost ([127.0.0.1]:47157 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WGWnb-0004Ou-Jn; Thu, 20 Feb 2014 11:48:36 -0500
Received: by lola (Postfix, from userid 1000)
	id 850D7E067D; Thu, 20 Feb 2014 17:48:21 +0100 (CET)
In-Reply-To: <CACsJy8DsC9X=13iEpONcT6bw6qTw_O586_vZ2W_3O42ajEPF4A@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 19 Feb 2014 17:14:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242435>

Duy Nguyen <pclouds@gmail.com> writes:

> I can think of two improvements we could make, either increase cache
> size dynamically (within limits) or make it configurable. If we have N
> entries in worktree (both trees and blobs) and depth M, then we might
> need to cache N*M objects for it to be effective. Christian, if you
> want to experiment this, update MAX_DELTA_CACHE in sha1_file.c and
> rebuild.

Well, my optimized "git-blame" code is considerably hit by an
aggressively packed Emacs repository so I took a look at it with the
MAX_DELTA_CACHE value set to the default 256, and then 512, 1024, 2048.

Here are the results:

dak@lola:/usr/local/tmp/emacs$ time ../git/git blame src/xdisp.c >/dev/null

real	1m17.496s
user	0m30.552s
sys	0m46.496s
dak@lola:/usr/local/tmp/emacs$ time ../git/git blame src/xdisp.c >/dev/null

real	1m13.888s
user	0m30.060s
sys	0m43.420s
dak@lola:/usr/local/tmp/emacs$ time ../git/git blame src/xdisp.c >/dev/null

real	1m16.415s
user	0m31.436s
sys	0m44.564s
dak@lola:/usr/local/tmp/emacs$ time ../git/git blame src/xdisp.c >/dev/null

real	1m24.732s
user	0m34.416s
sys	0m49.808s

So using a value of 512 helps a bit (7% or so), but further increases
already cause a hit.  My machine has 4G of memory (32bit x86), so it is
unlikely that memory is running out.  I have no idea why this would be
so: either memory locality plays a role here, or the cache for some
reason gets reinitialized or scanned/copied/accessed as a whole
repeatedly, defeating the idea of a cache.  Or the access pattern are
such that it's entirely useless as a cache even at this size.

Trying with 16384:
dak@lola:/usr/local/tmp/emacs$ time ../git/git blame src/xdisp.c >/dev/null

real	2m8.000s
user	0m54.968s
sys	1m12.624s

And memory consumption did not exceed about 200m all the while, so is
far lower than what would have been available.

Something's _really_ fishy about that cache behavior.  Note that the
_system_ time goes up considerably, not just user time.  Since the packs
are zlib-packed, it's reasonable that more I/O time is also associated
with more user time and it is well possible that the user time increase
is entirely explainable by the larger amount of compressed data to
access.

But this stinks.  I doubt that the additional time is spent in memory
allocation: most of that would register only as user time.  And the
total allocated memory is not large enough that one can explain this
away with fewer available disk buffers for the kernel: the aggressively
packed repo takes about 300m so it would fine into memory together with
the git process.

-- 
David Kastrup
