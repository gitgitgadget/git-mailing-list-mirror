From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Large Object Support Proposal
Date: Thu, 19 Mar 2009 17:11:22 -0700
Message-ID: <7vtz5p59zp.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0903191514n1e524ebava5895d708a2927c4@mail.gmail.com>
 <7veiwt6t6a.fsf@gitster.siamese.dyndns.org>
 <d411cc4a0903191618x503db946n62d3132eece69175@mail.gmail.com>
 <7vzlfh5b7y.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.10.0903191650160.16753@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Mar 20 01:13:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkSM8-00039h-Ju
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 01:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759261AbZCTALb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 20:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758796AbZCTALb
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 20:11:31 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50863 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613AbZCTALa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 20:11:30 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 896B86052;
	Thu, 19 Mar 2009 20:11:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AAEA5604D; Thu,
 19 Mar 2009 20:11:24 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.10.0903191650160.16753@asgard.lang.hm>
 (david@lang.hm's message of "Thu, 19 Mar 2009 16:52:19 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A88B5E9A-14E3-11DE-A20C-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113869>

david@lang.hm writes:

> On Thu, 19 Mar 2009, Junio C Hamano wrote:
>
>> Scott Chacon <schacon@gmail.com> writes:
>>
>>> The point is that we don't keep this data as 'blob's - we don't try to
>>> compress them or add the header to them, they're too big and already
>>> compressed, it's a waste of time and often outside the memory
>>> tolerance of many systems. We keep only the stub in our db and stream
>>> the large media content directly to and from disk.  If we do a
>>> 'checkout' or something that would switch it out, we could store the
>>> data in '.git/media' or the equivalent until it's uploaded elsewhere.
>>
>> Aha, that sounds like you can just maintain a set of out-of-tree symbolic
>> links that you keep track of, and let other people (e.g. rsync) deal with
>> the complexity of managing that side of the world.
>>
>> And I think you can start experimenting it without any change to the core
>> datastructures.  In your single-page web site in which its sole html file
>> embeds an mpeg movie, you keep track of these two things in git:
>>
>> 	porn-of-the-day.html
>>        porn-of-the-day.mpg -> ../media/6066f5ae75ec.mpg
>>
>> and any time you want to feed a new movie, you update the symlink to a
>> different one that lives outside the source-controlled tree, while
>> arranging the link target to be updated out-of-band.
>
> that would work, but the proposed change has some advantages
>
> 1. you store the sha1 of the real mpg in the 'large file' blob so you
> can detect problems

You store the unique identifier of the real mpg in the symbolic link
target which is a blob payload, so you can detect problems already.  I
deliberately said "unique identifier"; you seem to think saying SHA-1
brings something magical but I do not think it needs to be even blob's
SHA-1.  Hashing that much data costs.

In any case, you can have a script (or client-side hook) that does:

    (1) find the out-of-tree symlinks in the index (or in the work tree);

    (2) if it is dangling, and if you have definition of where to get that
        hierarchy from (e.g ../media), run rsync or wget or whatever
        external means to grab it.

and call it after "git pull" updates from some other place.  The "git
media" of Scott's message could be an alias to such a command.

Adding a new type "external-blob" would be an unwelcome pain.  Reusing
"blob" so that existing "blob" codepath now needs to notice special "0"
that is not length "0" is even bigger pain than that.

And that is a pain for unknown benefit, especially when you can start
experimenting without any changes to the existing data structure.  In the
worst case, the experiment may not pan out as well as you hoped and if
that is the end of the story, so be it.  It is not a great loss.  If it
works well enough and we can have the external large media support without
any changes to the data structure, that would be really great.  If it
sort-of works but hits limitation, we can analyze how best to overcome
that limitation, and at that time it _might_ turn out to be the best
approach to introduce a new blob type.

But I do not think we know that yet.

In the longer run, as you speculated in your message, I think the native
blob codepaths need to be updated to tolerate a large, unmappable objects
better.  With that goal in mind, I think it is a huge mistake to
prematurely introduce an arbitrary distinct "blob" and "large blob" types,
if in the end they need to be merged back again; it would force the future
code indefinitely to care about the historical "large blob" types that was
once supported.

> 2. since it knows the sha1 of the real file, it can auto-create the
> real file as needed, without wasting space on too many copies of it.

Hmm, since when SHA-1 is reversible?
