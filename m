From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: regression in multi-threaded git-pack-index
Date: Tue, 19 Mar 2013 11:45:56 +0100
Message-ID: <871ubb8y6z.fsf@pctrast.inf.ethz.ch>
References: <20130315224240.50AA340839@wince.sfo.corp.google.com>
	<20130316114118.GA1940@sigill.intra.peff.net>
	<87fvzrajmr.fsf@pctrast.inf.ethz.ch>
	<20130319093034.GA29997@sigill.intra.peff.net>
	<20130319095943.GA6031@sigill.intra.peff.net>
	<20130319100800.GA6341@sigill.intra.peff.net>
	<20130319102422.GB6341@sigill.intra.peff.net>
	<87obef8yy7.fsf@pctrast.inf.ethz.ch>
	<20130319103306.GA9490@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Zager <szager@google.com>, <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 19 11:46:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHu41-0003JY-Op
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 11:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902Ab3CSKqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 06:46:14 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:5635 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773Ab3CSKqO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 06:46:14 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Mar
 2013 11:46:08 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 19 Mar 2013 11:46:11 +0100
In-Reply-To: <20130319103306.GA9490@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 19 Mar 2013 06:33:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218500>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 19, 2013 at 11:29:36AM +0100, Thomas Rast wrote:
>
>> > Ah, indeed. Putting:
>> >
>> >   fprintf(stderr, "%lu\n", base->obj->delta_depth);
>> >
>> > before the conditional reveals that base->obj->delta_depth is
>> > uninitialized, which is the real problem. I'm sure there is some
>> > perfectly logical explanation for why valgrind can't detect its use
>> > during the assignment, but I'm not sure what it is.
>> 
>> That's simply because you would get far too much noise.  It only reports
>> an uninitialized value when it actually gets used in a conditional or
>> for output (syscalls), which is when they matter.
>
> Would it? I would think any computation you start with an undefined
> value would be suspect (and you would want to know about it as soon as
> possible, before the tainted value gets output). I was assuming it was a
> performance issue or something.

Now consider

  // somewhere on the stack
  struct foo {
    char c;
    int i;
  } a, b;
  a.c = a.i = 0;

  memcpy(&b, &a, sizeof(struct foo));

The compiler could legitimately leave the padding between c and i
uninitialized, and with your proposed "early" reporting the memcpy would
complain.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
