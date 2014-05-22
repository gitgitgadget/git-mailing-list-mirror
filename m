From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 15:12:59 -0700
Message-ID: <xmqq61kxmphw.fsf@gitster.dls.corp.google.com>
References: <1400775763.1933.5.camel@stross>
	<CABPp-BHtYnput7SiAbnqUjpDibTi5o_2MAXfSj17fCdKSC7Hjg@mail.gmail.com>
	<1400782642.18134.8.camel@stross>
	<20140522183930.GB1167@sigill.intra.peff.net>
	<1400785669.18134.21.camel@stross>
	<20140522190959.GA18785@sigill.intra.peff.net>
	<20140522193030.GA22383@sigill.intra.peff.net>
	<xmqqha4hmr9d.fsf@gitster.dls.corp.google.com>
	<1400795586.18134.40.camel@stross>
	<xmqqd2f5mq5h.fsf@gitster.dls.corp.google.com>
	<1400796077.18134.41.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 23 00:13:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnbEe-0004dH-Oo
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 00:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbaEVWNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 18:13:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64028 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996AbaEVWNH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 18:13:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1795019D42;
	Thu, 22 May 2014 18:13:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rBHu/ZS3NJNK95oW9SR7/pywMNU=; b=BrMn3t
	T7cSmfxNZwv4ABw4vlHGOHdsPry94dE/qZ4deGqzji29zWhXBotU0u4ebR85/4OE
	eBtBNwPkK7KkOAhj4tPU95BVHNTqsB8+Ikd0uZcHixIj3mmwMaQoe0hgKrJgd6m/
	SvTTTEjoscFY1BW63ExX6jF857/u/jOqolLTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VEGfWVoBiaV+PH8onONrL5uyokHqmxZT
	DzxpER1jmPSK819f/Bvbpbb514NNczrk2jHyWQe+n3QQe/ijJqncAhsnOo6Pkhs/
	VhBcHXQji78jpvxKqiuyzhePyge3d0yYUX5FgF/CsI0LEHBbS8Lcm9M1vHVJJXYo
	8ok6LtP+EOQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0BB6719D41;
	Thu, 22 May 2014 18:13:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 08B6919D35;
	Thu, 22 May 2014 18:13:00 -0400 (EDT)
In-Reply-To: <1400796077.18134.41.camel@stross> (David Turner's message of
	"Thu, 22 May 2014 18:01:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3CDFDEC6-E1FE-11E3-AEB5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249951>

David Turner <dturner@twopensource.com> writes:

>> Yes.  As I said, that should not usually be a problem for those who
>> do the real work (read: commit), at which time write-tree will fully
>> populate the cache-tree.
>
> Git commit does not in fact populate the cache-tree.

If that is the case, we must have broken the write-tree codepath
over time.

Of course, "git commit foo" will need to prepare a temporary index
where only the entry "foo" is different from the HEAD version, write
the tree to create a commit, but we do not write out the main index
as a tree after updating the same entry "foo" in it (there may be
other changes relative to HEAD), so its cache-tree is only
invalidated at "foo" when we updating the entry and we do not spend
extra cycles to repopulate it.

But at least my understanding has been that "git commit" (no partial
commit, write the whole index as a commit) which uses the "git
write-tree" machinery knows which subtree has what tree object name
and populates the cache-tree fully.
