From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH/RFC v2 0/16] Introduce index file format version 5
Date: Wed, 8 Aug 2012 11:07:21 +0200
Message-ID: <87628tsqeu.fsf@thomas.inf.ethz.ch>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
	<1344263760-31191-1-git-send-email-pclouds@gmail.com>
	<7vehnjzzfd.fsf@alter.siamese.dyndns.org>
	<87393yz64x.fsf@thomas.inf.ethz.ch>
	<7vboimuvur.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"Thomas Gummerer" <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<mhagger@alum.mit.edu>, <robin.rosenberg@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 11:07:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz2Ey-0004EE-1c
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 11:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757898Ab2HHJHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 05:07:37 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:20690 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757891Ab2HHJHc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 05:07:32 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 8 Aug
 2012 11:07:27 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.211.33) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 8 Aug
 2012 11:07:28 +0200
In-Reply-To: <7vboimuvur.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 7 Aug 2012 16:26:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.211.33]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203069>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> I like the general idea, too, but I think there is a long way ahead, and
>> we shouldn't hold up v5 on this.
>
> We shouldn't rush, only to keep some deadline, and regret it later
> that we butchered the index format without thinking things through.
> When this was added to the GSoC idea page, I already said upfront
> that this was way too big a topic to be a GSoC project, didn't I?

Let me spell out my concern.  There are two v5s here:

* The extent of the GSoC task.

* The eventual implementation of index-v5 that goes into Git mainline.

IMHO this thread is mixing up the two.  There indeed must not be any
rush in the final implementation of index-v5.  However, the GSoC ends in
less than two weeks, and I have to evaluate Thomas on whatever is
finished until then.

AFAIK Thomas is now cleaning up the existing code to be in readable
shape, using your feedback, which is great.  However, the above
suggestion is such a fuzzily-specified task that there is no way to even
find out what needs to be done within the next two weeks.  Perhaps it
makes sense, at this point, to wrap anything that ended up having _v[25]
suffixes in an index_ops like Duy did.  That's a long way from actually
following through on the idea, though.

> [...] "The new on-disk format is different from
> the current one, and as it is different from the current one, we can
> easily enhance it even more by hooking anything interesting to it!"
> does not sound like a valid argument.  
>
>> For example, for v5 it
>> would be far better if conflicted and resolve-undo entries were a
>> property of the normal index entry, instead of something that so happens
>> to be consecutive entries and in a completely different place,
>> respectively.
>
> I am not sure I am convinced.  Conflicts are already expressed by an
> attribute on a normal index entry (it is called "stage"), and
> because we check for "is the index fully merged" fairly often, it
> makes sense to have it in each entry.  Actually having an unmerged
> entry is a rare event (happens only during a mergy operation that
> gave control back to you), so we do not lose much by expressing them
> as consecutive entries.  Resolve-undo is far less often used, and is
> not an essential feature, so it makes perfect sense to have it as an
> optional index extension to allow versions of Git that are unaware
> of it to still use an index file that has it.

I picked this example because in the big picture, the current code goes
to silly contortions to shuffle data around.  Conflicts and resolve-undo
entries are two faces of the same coin, but the code does not express
this at all.  Whenever the user resolves a conflict, it removes the
existing index entries (consecutive in a flat table) and inserts them in
the resolve-undo tree (tree-shaped where every entry has all stages
embedded).  When using 'checkout -m' to recover the conflict, it goes
the other way.

v5 would simplify this: the difference between a conflict and a
resolve-undo entry is only one bit.  But because it needs to maintain v2
compatiblity, it first untangles the mixed conflict/resolve-undo data
and puts them in the right format, then later reassembles them.

So "v5 could do it faster if all the code were written for it" is only
half of it.  v5's data layout would also result in simpler data flow,
but as long as it is not allowed to exploit this, it's actually *more*
layers of complexity.

I think the part you snipped

>> the loops that iterate over the index [...] either
>> skip unmerged entries or specifically look for them.  There are subtle
>> differences between the loops on many points: what do they do when they
>> hit an unmerged entry?  Or a CE_REMOVED or CE_VALID one?

is a symptom of the same general problem: the data structures are sound,
but they are leaking all over the code and now we have lots of
complexity to do even simple operations like "for each unmerged entry".

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
