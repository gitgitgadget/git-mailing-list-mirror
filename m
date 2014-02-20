From: David Kastrup <dak@gnu.org>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Thu, 20 Feb 2014 19:07:54 +0100
Message-ID: <87ppmhr72d.fsf@fencepost.gnu.org>
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
	<8738jdspbe.fsf@fencepost.gnu.org> <87y515r9wb.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 23:53:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGcUU-0008Mg-Bd
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 23:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbaBTWwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 17:52:46 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:54575 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbaBTWwp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 17:52:45 -0500
Received: from localhost ([127.0.0.1]:53611 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WGcU0-00022p-NY; Thu, 20 Feb 2014 17:52:44 -0500
Received: by lola (Postfix, from userid 1000)
	id C8DF8E067D; Thu, 20 Feb 2014 19:07:54 +0100 (CET)
In-Reply-To: <87y515r9wb.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Thu, 20 Feb 2014 18:06:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242450>

David Kastrup <dak@gnu.org> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>> Something's _really_ fishy about that cache behavior.  Note that the
>> _system_ time goes up considerably, not just user time.  Since the
>> packs are zlib-packed, it's reasonable that more I/O time is also
>> associated with more user time and it is well possible that the user
>> time increase is entirely explainable by the larger amount of
>> compressed data to access.
>>
>> But this stinks.
>
> And an obvious contender for the stinking is that the "LRU" scheme used
> here is _strictly_ freeing memory based on which cache entry has been
> _created_ the longest time ago, not which cache entry has been
> _accessed_ the longest time ago.  Which means a pure round-robin
> strategy for freeing memory rather than LRU.
>
> Let's see what happens when changing this.

Not much.  With any cache size, using a "true" LRU scheme does not buy
more than 2%.  On the other hand, increasing core.deltaBaseCacheLimit
from its default of 16m to 128m in the config file results in the
following difference (with default #define MAX_DELTA_CACHE (256)):

dak@lola:/usr/local/tmp/emacs$ time ../git/git blame src/xdisp.c >/dev/null

real	1m17.446s
user	0m30.696s
sys	0m46.332s
dak@lola:/usr/local/tmp/emacs$ time ../git/git blame src/xdisp.c >/dev/null

real	0m27.519s
user	0m20.248s
sys	0m7.156s

So it would seem that the default available cache slots are not utilized
anyway when operating on this file (about 1MB in size) with the default
of core.deltaBaseCacheLimit.

It is still irritating that the performance drops quite a bit with a
considerably larger number of cache slots.

-- 
David Kastrup
