From: Junio C Hamano <gitster@pobox.com>
Subject: Re: in_merge_bases() is too expensive for recent "pu" update
Date: Tue, 28 Aug 2012 09:03:09 -0700
Message-ID: <7vehmr57ia.fsf@alter.siamese.dyndns.org>
References: <CACsJy8C-VxzwigyUDHnUkXN7vhB+93X96pH9MvgB0ps7v-_NmQ@mail.gmail.com>
 <878vd5k7uu.fsf@thomas.inf.ethz.ch> <7va9xfpyyf.fsf@alter.siamese.dyndns.org>
 <877gsjmo3a.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 28 18:03:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6OG8-0001J8-G7
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 18:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab2H1QDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 12:03:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45471 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753022Ab2H1QDN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 12:03:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40E608E2C;
	Tue, 28 Aug 2012 12:03:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=noyPvl7+kUG3i01XP5ilHtANx5s=; b=KFUt5X
	0DgdIkCUBLP0kqmSmUJDKknAVmNJOZqpPoT3CRCv3IrtNXuig5+f6puGDXod3r7B
	40d6pwVopkT5zrl+B4vRrLHRYpykQ5KQG9Ib1Wg9i4KmJuv3i4ZZD3IFKsdSIZA7
	aQwqXlkaw5iyZc+9K2ZUj+D0IKjWkKW+LfKqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qXoNFGZjMOkAVm7naZUPoe/wVWkilOFA
	/KJGE0MXTD4xL+GY8LE93Mpg0EgtME9yjRrpiYQL+PjQCXbv6byAlr2cLaKyfi1L
	9wnshCnURqO4rlgBTKl12QfDqCyIqlYl78HlRkHTRFmkYOXbvWisjtaU2+kaySi+
	Tzfbd//kFBs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DF6B8E2B;
	Tue, 28 Aug 2012 12:03:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87DEB8E2A; Tue, 28 Aug 2012
 12:03:11 -0400 (EDT)
In-Reply-To: <877gsjmo3a.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 28 Aug 2012 10:12:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DDD70AE2-F129-11E1-99D4-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204429>

Thomas Rast <trast@inf.ethz.ch> writes:

> I'm also mildly surprised that it ended up being correct, albeit with
> some extra work from you :-)

I actually am not all that surprised.  It just shows that the
original code was layered in more or less the right way.  At the the
bottom layer we would want a way to paint graph down to common
ancestors cheaply, and then on top we want to have a way to filter
out the redundant ones.  It is a different story that the
implementation of individual layers may still have rooms for
improvements (just like the last patch in my series showed for the
upper layer where we used to do N * (N-1) when we only needed N).

I have a suspicion that the merge_bases_many() at the bottom layer
could be built on an even cheaper API.  This caller you added does
not need "bases" list returned; it only wants to see that ancestors
of "commit" and "reference" down to their common ancestors are
painted in two colors PARENT1 and PARENT2.  Instead of iterating
over the returned candidate list, we might be able to do

	common = PARENT1 | PARENT2;
	paint_ancestors(commit, 1, reference);
        commit_is_common = ((commit->object.flags & common) == common);
        clear_commit_marks(commit, all_flags);
        clear_commit_marks(*reference, all_flags);

where paint_ancestors() just paints but does not accumlate to return
a commit_list.  Note that paint_ancestors() need to always paint its
arguments (merge_bases_many() has an early special case to return a
list that only has "commit" when it appears in "reference" without
painting anything, and the callers like get_merge_bases_many() know
this to avoid calling clear_commit_marks()) if we are to go in this
direction, so it is unclear if it will be overall gain.
