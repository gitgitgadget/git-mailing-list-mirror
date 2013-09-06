From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A naive proposal for preventing loose object explosions
Date: Fri, 06 Sep 2013 10:19:02 -0700
Message-ID: <xmqq61udzx4p.fsf@gitster.dls.corp.google.com>
References: <54d0a7f13b53e15ad485e212057b85a3.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, nasserg@codeaurora.org
To: mfick@codeaurora.org
X-From: git-owner@vger.kernel.org Fri Sep 06 19:19:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHzgi-0006Fi-St
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 19:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581Ab3IFRTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 13:19:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59918 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963Ab3IFRTM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 13:19:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D0C43DF70;
	Fri,  6 Sep 2013 17:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ro/vuMu94SL6qetTLV69t1Bjo+w=; b=WV7Om3
	L+hxYLEsdzkRXafPHkWCtsEH+50F14YIrT8xd05ovqVuZstGdBDJ2tY7RkpJFKKv
	9sk+al42f+/tW5nMCIam9rcD+WJm20W8RYmiXfCt6ttJQ4VsAdc3CBEz5TkwFa/a
	5tUX0a/Bay/gnLlWkWo5NnUv9G+0lnccQOTTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MdKixfLNDFR4ti7kN7UcDvWVPP0CDDeu
	QLatVHt8MrzA9UC5XNmOZTWimgMzURT5G1FmUH5oeOkpFlTUjLmhFxDraLFvrNzY
	aStqKdUsmRi+ZqmCKz4OV9W0D3JA3MNk7Bu9x/b27jOxlqoggjngGPPXZQ7GjhF6
	QWYpwpTBN/U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB6C53DF6D;
	Fri,  6 Sep 2013 17:19:09 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D95B83DF63;
	Fri,  6 Sep 2013 17:19:07 +0000 (UTC)
In-Reply-To: <54d0a7f13b53e15ad485e212057b85a3.squirrel@www.codeaurora.org>
	(mfick@codeaurora.org's message of "Fri, 6 Sep 2013 03:42:50 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 701F6BFA-1718-11E3-B811-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234065>

mfick@codeaurora.org writes:

> Object lookups should likely not get any slower than if
> repack were not run, and the extra new pack might actually help
> find some objects quicker.

In general, having an extra pack, only to keep objects that you know
are available in other packs, will make _all_ object accesses, not
just the ones that are contained in that extra pack, slower.

Instead of mmapping all the .idx files for all the available
packfiles, we could build a table that records, for each packed
object, from which packfile at what offset the data is available to
optimize the access, but obviously building that in-core table will
take time, so it may not be a good trade-off to do so at runtime (a
precomputed super-.idx that we can mmap at runtime might be a good
way forward if that turns out to be the case).

> Does this sound like it would work?

Sorry, but it is unclear what problem you are trying to solve.

Is it that you do not like that "repack -A" ejects unreferenced
objects and makes it loose, which you may have many?

The loosen_unused_packed_objects() function used by "repack -A"
calls the force_object_loose() function (actually, it is the sole
caller of the function).  If you tweak the latter to stream to a
single new "graveyard" packfile and mark it as "kept until expiry",
would it solve the issue the same way but with much smaller impact?

There already is an infrastructure available to open a single output
packfile and send multiple objects to it in bulk-checkin.c, and I am
wondering if you can take advantage of the framework.  The existing
interface to it assumes that the object data is coming from a file
descriptor (the interface was built to support bulk-checkin of many
objects in an empty repository), and it needs refactoring to allow
stream_to_pack() to take different kind of data sources in the form
of stateful callback function, though.
