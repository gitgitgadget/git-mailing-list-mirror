From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 0/16] Introduce index file format version 5
Date: Tue, 07 Aug 2012 18:38:04 -0700
Message-ID: <7v7gtaups3.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344263760-31191-1-git-send-email-pclouds@gmail.com>
 <7vehnjzzfd.fsf@alter.siamese.dyndns.org>
 <CACsJy8CepAQr4r-c_hzwgT2-_bpFV-=VmOsFaBcDZqBpG52reQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	trast@student.ethz.ch, mhagger@alum.mit.edu,
	robin.rosenberg@dewire.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 03:38:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyvEV-0007y4-0J
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 03:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209Ab2HHBiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 21:38:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50614 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121Ab2HHBiH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 21:38:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9B5C44B1;
	Tue,  7 Aug 2012 21:38:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aDfY/LqakF4LSCkud5veq0S+R1A=; b=WZHNFf
	zg9vGqIbJXWE7Jurcc0sn/UvQfRFWm1ZdnXdeNIX7I+r9Pw61bUw65Ht9vBQLocZ
	ILUWDbTe7DkaaPdTVzh077H2FOVk0jP/rc8wcKXITqkRdaqgdae4qNB14NQ6VRVF
	O8s4x/oTwLUC5l9gGiW/k3W2QMgdaDLGlPLUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P20V432KOa+Zz9IeTZdChFvMD+IiOmg6
	fsFG9d44z9vh+pY9XQz10O3RZkBGo8saXTVUq3ifBYyclQ/+xNHYQTiX8MWW6lSJ
	4g6unvO13SOouFJfFzVNSNUOMh8V/36oiP3CFtbwo4ogGcgSn4NvkxFLnydzSRAB
	0vS701x2hVY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6E5C44B0;
	Tue,  7 Aug 2012 21:38:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB22644AF; Tue,  7 Aug 2012
 21:38:05 -0400 (EDT)
In-Reply-To: <CACsJy8CepAQr4r-c_hzwgT2-_bpFV-=VmOsFaBcDZqBpG52reQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 7 Aug 2012 19:16:25 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B36F4638-E0F9-11E1-ABD5-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203059>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> add_to_index and remove_index_entry_at seem good places for the cut.
> But do we need to redefine the location?

That is one of the things we need to think about carefully.  Of
course, if add_to_index() just takes a pathname out of the ce the
caller wants to add, you can define remove_from_index() that takes a
pathname (and possibly a stage), finds the ce with that pathname in
the index and removes it.  But that would unnecessrily penalize the
callers that follow "see if there is such an entry (i.e. "locate"),
optionally inspect the entry and then decide to remove", especially
if the "locate" is expensive.  If a nonsignificant number of callers
follow such a pattern, then having a separate "locate" API that can
return a "location" that is expressed either as the number of
entries to skip from the beginning (in a flat in-core array) or a
pair of in-core "directory" structure and the index in the directory
to let the caller find the entry quickly, and then later pass it to
"remove", would be more appropriate.  add_index_entry_at() may also
not a bad thing to have if many callers turn out to follow a similar
access pattern (i.e. locate, decide to or not to replace when there
already is one, and then add it).

>  - for 3-5 years since v5 is released, we support v2 and v5 in
> parallel. Other code can take advantage of v5, but it must neither
> sacrifice v2 performance, compatibility nor maintainability
>  - after that, we deprecate v2. v2 is automatically converted to v5 in
> memory. v2 perf may suffer but at that point we don't care any more as
> the majority of users should have been migrated to v5 (*)

As long as the performance of Git on a working tree that used to get
certain performance back when it was using v2 does not degrade when
it is converted to v5 or later, I think the above is a good way
forward.

> If the long term plan is actually that, we will need to stick to flat
> array implementation for forseeable future as moving from it most
> likely impacts v2 performance.

I do not see why we need to "stick to"; I do not see why it is
necessarily a bad thing if we end up choosing to "stick to" if the
reason we choose it is because the flat in-core performs better.

If the workload we _care_ about is served better by using an API
that works over an in-core tree-shaped index data structure, I do
not think it is unreasonable to read the v2 on-disk format and
represent it as a tree-shaped index while we read it.  Of course,
there are things that are not as effective when reading from the
flat v2 on-disk format (e.g. path limited reading will have to at
least _scan_ the whole thing, even though it may process only the
entries that match the pathspec) compared to reading from a
tree-shaped on-disk format, but I doubt that the difference between
the cost of reading into a flat array and the cost of reading and
forming whatever non-flat data structure you seem to think is better
is so big that it would negate the benefit of using a better in-core
structure.

> This might not be the best way forward as v2 incompatible features
> (like keeping empty directories in index, what else?) may never come
> until v2 is deprecated.

I do not think "empty directories" matter to begin with, but even if
it did, I do not think v2 is inherently incapable of being enhanced
to record one if you really wanted to.  Either you come up with a
new "mode" bits and add it as a regular cache entry, or record the
fact that there is a directory in a new index extension.

The real issue to solve is to decide what semantics you want
(e.g. What to do when you earlier have added an empty directory,
added a file in it and then removed the file, making it empty again?
What if that happened during a merge?), to verify the semantics you
define are sane, to add "keep_empty_directory()" function to
read-cache.c, and to sprinkle callers to the API function as needed.

These have to be done regardless of the actual on-disk format.
