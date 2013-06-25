From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 03/16] pack-objects: use a faster hash table
Date: Tue, 25 Jun 2013 16:03:22 +0200
Message-ID: <87a9mdnae3.fsf@linux-k42r.v.cablecom.net>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
	<1372116193-32762-4-git-send-email-tanoku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 23:33:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uraro-0004t4-EF
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 23:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab3FYVda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 17:33:30 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:6734 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751831Ab3FYVd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 17:33:29 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 25 Jun
 2013 23:33:26 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.210.110) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 25 Jun 2013 23:33:26 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.210.110]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228995>

Vicent Marti <tanoku@gmail.com> writes:

> This commit brings `khash.h`, a header only hash table implementation
> that while remaining rather simple (uses quadratic probing and a
> standard hashing scheme) and self-contained, offers a significant
> performance improvement in both insertion and lookup times.
>
> `khash` is a generic hash table implementation that can be 'templated'
> for any given type while maintaining good performance by using preprocessor
> macros. This specific version has been modified to define by default a
> `khash_sha1` type, a map of SHA1s (const unsigned char[20]) to void *
> pointers.
>
> When replacing the old hash table implementation in `pack-objects` with
> the khash_sha1 table, the insertion time is greatly reduced:
>
> 	kh_put_sha1 :: 284.011ms
> 	add_object_entry_1 : 36.06ms
> 	hashcmp :: 24.045ms
>
> This reduction of more than 50% in the insertion and lookup times,
> although nice, is not particularly noticeable for normal `pack-objects`
> operation: `pack-objects` performs massive batch insertions and
> relatively few lookups, so `khash` doesn't get a chance to shine here.
>
> The big win here, however, is in the massively reduced amount of hash
> collisions (as you can see from the huge reduction of time spent in
> `hashcmp` after the change). These greatly improved lookup times
> will result critical once we implement the writing algorithm for bitmap
> indxes in a later patch of this series.

Is that reduction in collisions purely because it uses quadratic
probing, or is there some other magic trick involved?  Is the same also
applicable to the other users of the "big" object hash table?  (I assume
Peff has already tried applying it there, but I'm still curious...)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
