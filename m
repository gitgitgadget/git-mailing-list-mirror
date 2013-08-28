From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2 1/5] replace: forbid replacing an object with one of a different type
Date: Wed, 28 Aug 2013 09:31:21 +0200
Message-ID: <878uzmclva.fsf@linux-k42r.v.cablecom.net>
References: <20130827194022.11172.56453.chriscool@tuxfamily.org>
	<20130827194828.11172.73829.chriscool@tuxfamily.org>
	<xmqqk3j6c1x0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <chriscool@tuxfamily.org>, <git@vger.kernel.org>,
	"Philip Oakley" <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 09:31:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEaDy-000245-1m
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 09:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388Ab3H1Hb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 03:31:26 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:12927 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752347Ab3H1HbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 03:31:25 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 28 Aug
 2013 09:31:17 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 28 Aug 2013 09:31:21 +0200
In-Reply-To: <xmqqk3j6c1x0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 27 Aug 2013 13:30:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233178>

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> Users replacing an object with one of a different type were not
>> prevented to do so, even if it was obvious, and stated in the doc,
>> that bad things would result from doing that.
>>
>> To avoid mistakes, it is better to just forbid that though.
>>
>> There is no case where one object can be replaced with one of a
>> different type while keeping the history valid, because:
>>
>> * Annotated tags contain the type of the tagged object.
>
> If you replace the tagged object and the tag at the same time,
> wouldn't that make the resulting history valid again?
>
> Granted, there may not be a strong reason to reuse the object name
> of the tagged object in such a case, but this "there may not be" is
> merely "I do not think of offhand", so I am not sure what workflow
> of other people we are breaking with this change.  A light-weight
> tag may already point at the tagged object (in other words, the
> object name of the tagged object is known to the outside world) and
> that could be a reason why you would need to reuse the object name
> of that object while changing its type.
>
> I dunno.

Hrm, you're right, that's a flaw in my logic.  You could do the same in
all other cases too, e.g. replace a tree so that an entry is of a
different type and at the same time change the type of the object
itself.  You however have to carefully go through all objects that refer
to the one that was replaced, and fix the type in all of them.

It still seems an extremely unsafe thing to do with trees: especially
for small trees there is a small probability that you will generate the
same tree again in the future (by having the same blobs in the directory
again) and record it as a subtree or the 'tree' field of a commit.  The
history would then again be invalid.

Should we add a --force flag of some sort to allow the user to do this,
while keeping the normal safety checks?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
