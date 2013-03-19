From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: regression in multi-threaded git-pack-index
Date: Tue, 19 Mar 2013 11:29:36 +0100
Message-ID: <87obef8yy7.fsf@pctrast.inf.ethz.ch>
References: <20130315224240.50AA340839@wince.sfo.corp.google.com>
	<20130316114118.GA1940@sigill.intra.peff.net>
	<87fvzrajmr.fsf@pctrast.inf.ethz.ch>
	<20130319093034.GA29997@sigill.intra.peff.net>
	<20130319095943.GA6031@sigill.intra.peff.net>
	<20130319100800.GA6341@sigill.intra.peff.net>
	<20130319102422.GB6341@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Rast <trast@student.ethz.ch>,
	Stefan Zager <szager@google.com>, <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 19 11:30:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHto0-00076K-5P
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 11:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab3CSK3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 06:29:40 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:4522 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753935Ab3CSK3j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 06:29:39 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Mar
 2013 11:29:32 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 19 Mar 2013 11:29:36 +0100
In-Reply-To: <20130319102422.GB6341@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 19 Mar 2013 06:24:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218496>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 19, 2013 at 06:08:00AM -0400, Jeff King wrote:
>
>> @@ -538,6 +539,8 @@ static void resolve_delta(struct object_entry *delta_obj,
>>  
>>  	delta_obj->real_type = base->obj->real_type;
>>  	delta_obj->delta_depth = base->obj->delta_depth + 1;
>> +	if (deepest_delta < delta_obj->delta_depth)
>> +		deepest_delta = delta_obj->delta_depth;
>>  	delta_obj->base_object_no = base->obj - objects;
>>  	delta_data = get_data_from_pack(delta_obj);
>>  	base_data = get_base_data(base);
>> 
>> and valgrind reports an uninitialized value in the conditional. But we
>> can see that deepest_delta is static, and therefore always has some
>> value. And delta_obj->delta_depth is set in the line above. So both
>> should have some known value, unless they are computed from unknown
>> values. In that case, shouldn't valgrind have previously noticed when we
>> accessed those unknown values?
>
> Ah, indeed. Putting:
>
>   fprintf(stderr, "%lu\n", base->obj->delta_depth);
>
> before the conditional reveals that base->obj->delta_depth is
> uninitialized, which is the real problem. I'm sure there is some
> perfectly logical explanation for why valgrind can't detect its use
> during the assignment, but I'm not sure what it is.

That's simply because you would get far too much noise.  It only reports
an uninitialized value when it actually gets used in a conditional or
for output (syscalls), which is when they matter.

You can use --track-origins=yes to see where the undefined value came
from, but it's veeeery slow.

> It looks like the delta_depth value was
> introduced in 38a4556 (index-pack: start learning to emulate
> "verify-pack -v", 2011-06-03), and it used only for showing the chain
> depths with --verify-stat. So it is almost certainly not related to
> Stefan's original problem, but it does mean we've probably been
> computing bogus chain lengths.

Nice catch!

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
