From: "George Spelvin" <linux@horizon.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: 6 Aug 2009 03:03:12 -0400
Message-ID: <20090806070312.13791.qmail@science.horizon.com>
References: <4A7A67C5.8060109@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, linux@horizon.com,
	nico@cam.org
To: art.08.09@gmail.com, torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Thu Aug 06 09:03:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYx0o-0000js-5U
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 09:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbZHFHDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 03:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbZHFHDN
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 03:03:13 -0400
Received: from science.horizon.com ([71.41.210.146]:33751 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751858AbZHFHDN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 03:03:13 -0400
Received: (qmail 13792 invoked by uid 1000); 6 Aug 2009 03:03:12 -0400
In-Reply-To: <4A7A67C5.8060109@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125047>

> On Thu, 6 Aug 2009, Artur Skawina wrote:
>> #             TIME[s] SPEED[MB/s]
>> rfc3174         1.357       44.99
>> rfc3174         1.352       45.13
>> mozilla         1.509       40.44
>> mozillaas       1.133       53.87
>> linus          0.5818       104.9

> #Initializing... Rounds: 1000000, size: 62500K, time: 1.421s, speed: 42.97MB/s
> #             TIME[s] SPEED[MB/s]
> rfc3174         1.403        43.5
> # New hash result: b747042d9f4f1fdabd2ac53076f8f830dea7fe0f
> rfc3174         1.403       43.51
> linus          0.5891       103.6
> linusas        0.5337       114.4
> mozilla         1.535       39.76
> mozillaas       1.128       54.13

I'm trying to absorb what you're learning about P4 performance, but
I'm getting confused... what is what in these benchmarks?

The major architectural decisions I see are:

1) Three possible ways to compute the W[] array for rounds 16..79:
	1a) Compute W[16..79] in a loop beforehand (you noted that unrolling
	    two copies helped significantly.)
	1b) Compute W[16..79] as part of hash rounds 16..79.
	1c) Compute W[0..15] in-place as part of hash rounds 16..79

2) The main hashing can be rolled up or unrolled:
	2a) Four 20-round loops.  (In case of options 1b and 1c, the
	    first one might be split into a 16 and a 4.)
	2b) Four 4-round loops, each unrolled 5x.  (See the ARM assembly.)
	2c) all 80 rounds unrolled.

As Linus noted, 1c is not friends with options 2a and 2b, because the
W() indexing math is not longer a compile-time constant.

Linus has posted 1a+2c and 1c+2c.  You posted some code that could be
2a or 2c depending on an UNROLL preprocessor #define.  Which combinations
are your "linus" and "linusas" code?

You talk about "and my atom seems to like the compact loops too", but
I'm not sure which loops those are.

Thanks.
