From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] index-pack: always zero-initialize object_entry list
Date: Tue, 19 Mar 2013 10:13:10 -0700
Message-ID: <7vboafjot5.fsf@alter.siamese.dyndns.org>
References: <20130319102422.GB6341@sigill.intra.peff.net>
 <20130319105852.GA15182@sigill.intra.peff.net>
 <8738vr5rqh.fsf@pctrast.inf.ethz.ch>
 <20130319154353.GA10010@sigill.intra.peff.net>
 <20130319155244.GA16532@sigill.intra.peff.net>
 <20130319161722.GA17445@sigill.intra.peff.net>
 <87ehfb2w4q.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Stefan Zager <szager@google.com>,
	<git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 19 18:13:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI06Y-0003FD-67
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 18:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757115Ab3CSRNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 13:13:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44430 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755440Ab3CSRNN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 13:13:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27F88AA15;
	Tue, 19 Mar 2013 13:13:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RHZlGYU1QhINqjABsyYwk6RWTY0=; b=MDcH4v
	ZBHet6kolNV3CmBOiGUZZVo7b4uqMcbHDaiJa/4WCzp1ZjAFgzdlUH3SErza9+la
	0DxgSkGPwhbFoDeGTk3RZH1nQWuIrlQNO53VZbXXK8RF6c+4tsxAsoxTh6w15Fcj
	M0lUHCogRZSn3QKEtSgCtN/1s7j+GWqsPyCU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pBi3b3uALk283igkUo7J7fw9vuG5vY3t
	72wdx/bZ/EWxqTuhwuBu2A60QXJ6i/A96GCPuJFi5MWSVPB6PYAqkpKnWytYllpm
	j4xQ1F2yXY5btkwXarPB7LRRYpJI+Bm2B884xy0r0GjeW/apyprfmsetOkSWYCvA
	ZFzxS815/Qs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15D46AA14;
	Tue, 19 Mar 2013 13:13:12 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B4C9AA0F; Tue, 19 Mar 2013
 13:13:11 -0400 (EDT)
In-Reply-To: <87ehfb2w4q.fsf@pctrast.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 19 Mar 2013 17:27:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4719D844-90B8-11E2-AE1E-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218539>

Thomas Rast <trast@student.ethz.ch> writes:

> It apparently relates to the use of .idx.offset to compute the "next"
> offset, cf. append_obj_to_pack():
>
> 	struct object_entry *obj = &objects[nr_objects++];
>    ...
> 	obj[1].idx.offset = obj[0].idx.offset + n;
> 	obj[1].idx.offset += write_compressed(f, buf, size);
>
> So you trashed the offset of the first object after all the objects that
> are actually *in* the patch.
>
> And with that: ACK.

Ahh, I also was scratching my head about that +1 thing.  After all,
the +1 in the argument to xrealloc() was already a clue.

Thanks both for digging to the bottom of this one.
