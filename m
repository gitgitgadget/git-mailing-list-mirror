From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Mon, 26 Mar 2012 14:14:23 -0700
Message-ID: <7vd37znjyo.fsf@alter.siamese.dyndns.org>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
 <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com>
 <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com>
 <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
 <871uomrubl.fsf@thomas.inf.ethz.ch>
 <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com>
 <871uomq64c.fsf@thomas.inf.ethz.ch>
 <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com>
 <878virfx11.fsf@thomas.inf.ethz.ch>
 <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	<git@vger.kernel.org>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 23:14:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCHFJ-0001Os-9S
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 23:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756907Ab2CZVO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 17:14:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38869 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756556Ab2CZVO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 17:14:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 780E67A40;
	Mon, 26 Mar 2012 17:14:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XqJl0QroACvk+u+ghRLAWpFVSs4=; b=x8/Vkk
	qNVdRuW6wKT+uOPX3AuWyJHx49WAOV93gywNTigdm6qyDdNuydYCHC2y5Ysty988
	/4sT+adbrDzizvyo80bdOSjMeHwcyXtR/7UOm/dS1HsRNMFQpigo+XI6d4xNmPmY
	0W8qkjO92ar5dmrUK5EFupxQnipQx8q6T0jw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ua3w3iEila5XRbYTLy2mtwxPETZH3HZs
	JkaPBGvpE9EWxadejrMBOHVPaznjTYG1GwzOJ4yvCMOldpb76W46zlE8o/CJTrIB
	mHe3o2/z5Z24cPl6FZKcCjPBmBMptn7GUDrY96R+e/rbbA4ywKAuY94Thd3Kz6zb
	q0E0TnPp7Pg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F2617A3F;
	Mon, 26 Mar 2012 17:14:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1E1F7A3C; Mon, 26 Mar 2012
 17:14:24 -0400 (EDT)
In-Reply-To: <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com> (Thomas
 Gummerer's message of "Mon, 26 Mar 2012 22:35:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A9E4693E-7788-11E1-9C30-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193977>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> The proposed solution is to rework the index, in order to make it possible to
> have a complexity of O(log(n)), where n is the number of index entries, for 
> simple operations like adding files. More complex operations shall also
> benefit from the new index format, although a complexity of O(log(n)) might not
> be reached, while keeping the index format easy enough to parse for .git reading
> programs. The amount of data for which that the hash will be computed however
> shall be log(n). N is the number of entries in the index.

Where does log(N) come from, and is that a hard requirement?

Rephrasing your problem description, you want to address the inefficiency
that we have to write the full 1m entries to a new file in order to update
only one file when the index tracks 1m paths.  

Wouldn't the goal be more in line with that problem statement if you
instead aim to make the cost proportional to the number of entries that
are updated, regardless of how many entries exist in the index?

> In phase one the pysical index format shall be replaced with the new index 
> format, which does neither require a full recalculation of the sha-1 hash nor a
> full rewrite of the index to the disk. The new index format will be mapped to 
> the current in-memory structure, which will only be changed in phase two. For 
> further optimization the cache-tree sha-1 hashes shall be mapped to the new 
> index format, which should avoid cache-tree invalidations.

It is unclear what you meant by the last sentence.  The cache-tree
invalidation is a critical part of the machinery that allows later
write-tree to reuse the already computed subtree object names, without
having to recompute subtree object names until they are really necessary
(i.e. when writing a tree out).  By "avoiding" it, are you going to make
write-tree always recompute all the subtree object names?  Or are you
planning to keep the cached tree information always up to date by
recomputing subtree object names and keeping them in the index even when
they are not yet needed?  If the latter, how would you handle when a part
of the index contains unmerged entries?

Right now, the code that updates the in-core index records "Is the in-core
index clean, or modified?" bit and nothing else.  Without updating the
in-core structure and the codepaths that access it, how is it possible for
your phase I to selectively write out only the modified (either added,
updated or removed) part of it?  In other words, I do not think it is
realistic to expect that the core parts to stay oblivious to the new index
semantics during the "phase one".

> -- Timeline --
> 24/04 - 12/05: Getting familiar with the old index

It might make more sense to write the "proposed solution" *after* this
step is done; otherwise you wouldn't even know the problems you are trying
to solve.  That may mean that this part of the schedule may need to be
shortened or started way before the beginning of GSoC.
