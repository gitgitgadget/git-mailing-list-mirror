From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] Hold an 'unsigned long' chunk of the sha1 in obj_hash
Date: Thu, 25 Apr 2013 23:09:33 +0200
Message-ID: <87bo92gvw2.fsf@hexa.v.cablecom.net>
References: <6c2b67a2f0b67ee796c7676e3febe4c61ab85d4a.1366912627.git.trast@inf.ethz.ch>
	<7vobd22wto.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 23:09:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVTQD-000066-9q
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 23:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068Ab3DYVJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 17:09:37 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:27619 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756707Ab3DYVJg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 17:09:36 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 25 Apr
 2013 23:09:31 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 25 Apr
 2013 23:09:33 +0200
In-Reply-To: <7vobd22wto.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 25 Apr 2013 13:13:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222448>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> So we take a slightly different approach, and trade some memory for
>> better cache locality.
>
> Interesting.  It feels somewhat bait-and-switch to reveal that the
> above "some" turns out to be "double" later, but the resulting code
> does not look too bad, and the numbers do not look insignificant.

Oh, that wasn't the intent.  I was too lazy to gather some memory
numbers, so here's an estimate on the local effect and some measurements
on the global one.

struct object is at least 24 bytes (flags etc. and sha1).  We grow the
hash by 2x whenever it reaches 50% load, so it is always at least 25%
loaded.

A 25% loaded hash-table used to consist of 75% pointers (8 bytes) and
25% pointers-to-struct-object (32 bytes), for 14 bytes per average slot.
Now it's 22 bytes (one more unsigned long) per slot, i.e., a 60%
increase for the data managed by the hash table.

But that's using the crudest estimates I could think of.  If we assume
that an average blob and tree is at least as big as the smallest
possible commit, we'd guess that objects are at least ~240 bytes (this
is still somewhat of an estimate and assumes that you don't go and
handcraft commits with single-digit timestamps).  So the numbers above
go up by 25% * 240 per average slot, and work out to an about 11%
overall increase.

Here are some real numbers from /usr/bin/time git rev-list --all --objects:

before:

  2.30user 0.02system 0:02.33elapsed 99%CPU (0avgtext+0avgdata 247760maxresident)k
  0inputs+0outputs (0major+17844minor)pagefaults 0swaps

after:

  2.18user 0.02system 0:02.21elapsed 99%CPU (0avgtext+0avgdata 261936maxresident)k                       
  0inputs+0outputs (0major+18202minor)pagefaults 0swaps

So that would be about 14MB or 5.7% of extra memory.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
