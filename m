From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 7/8] update-ref: support multiple simultaneous updates
Date: Wed, 04 Sep 2013 14:27:31 -0700
Message-ID: <xmqqd2ool1ks.fsf@gitster.dls.corp.google.com>
References: <cover.1378142795.git.brad.king@kitware.com>
	<cover.1378307529.git.brad.king@kitware.com>
	<ad27a96b70198e837ac61995a1328960e10072bc.1378307529.git.brad.king@kitware.com>
	<xmqqsixkmonq.fsf@gitster.dls.corp.google.com>
	<52279107.2070205@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 23:27:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHKc3-0000lN-Ct
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 23:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757053Ab3IDV1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 17:27:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51504 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756598Ab3IDV1i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 17:27:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEF473F43A;
	Wed,  4 Sep 2013 21:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rFA3DAMkVHNO/PUpGEzzJfkx67c=; b=Kbr8p4
	28fIUTtwwr5GB+8ibbtSZhLkrTYGv5yLGeJjaS/dpWVHcAK+SpledtE0DIpLmhAH
	hUy75yJ6y2Ju2fJVHW3Z6TCA6SrEPbTRGW+wQCg2Bo3OTrB+xM/r+d+pRQAhxXHS
	SLU/PkU/NRaImL0MOEpqVypgCIRm1fgufpGk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s+zvTLg3iZAoU7lGM7UKbnHwf93BBfgq
	v9DjScYRzjDAZ/gyJgVlEq2cRxD/Fj5GOhrKpDLCVqdcVQVrwKi8EZQ1x3sKZSGj
	ihzMC7JYARYgxiYvapq4y4J47wX3t8pqQL+yK8wXKpubVTk3t1gREj17EOTbY8Nz
	UsdEQn8fmtY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77B343F437;
	Wed,  4 Sep 2013 21:27:37 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 585B83F429;
	Wed,  4 Sep 2013 21:27:35 +0000 (UTC)
In-Reply-To: <52279107.2070205@kitware.com> (Brad King's message of "Wed, 04
	Sep 2013 15:59:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D0F83E1E-15A8-11E3-B00F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233879>

Brad King <brad.king@kitware.com> writes:

> Nothing else uses LF NUL.  I chose it as a starting point for
> this very discussion, which I asked about in $gmane/233653.

The primary reason why LF raised my eyebrow was because the reason
why many subcommands use "-z" (and NUL) is often because the payload
may have LF in a record and LF cannot be used as a record separator
without escaping.  And they use NUL knowing that the payload data in
fields cannot contain a NUL.  If we used LF as a signal to define
the structure of the record, it pretty much defeats the whole point
of defining "-z" format.  The -m reason string will be made into a
single liner deep in the codepath but it _can_ contain LF.

I would have been more receptive to, say, double-NUL as a record
terminator, while using a NUL as a field terminator, or something,
but then we would need to have a way to express an empty field.

> In this particular use case we know the last field will never
> be LF but that may not be so for future cases.  There is no way
> to represent sentinel-terminated arbitrary variable-width records
> of NUL-terminated fields without some kind of escaping for the
> sentinel value, but the whole point of -z is to avoid escaping.

Indeed, but one escape hatch we have is that payload will not
contain NUL anywhere, so whenever we see a NUL, we can trust that it
defines the structure of the record, and is not a part of the
payload.

Stepping back a bit, here are some observations on the arguments
update-ref can take:

 * "-m <reason>" is a reason given for this entire update. As the
   point of this new feature is to give an all-or-none update to one
   or more refs, I think we should not have to accept more than one
   reason (more specifically, the -m option does _not_ belong to a
   specific record that describes what happens to a single ref).

 * "-d <ref> <oldvalue>" is a way to delete a ref. <oldvalue> may be
   missing.

 * "--no-deref <ref> <newvalue> <oldvalue>" and "<ref> <newvalue>
   <oldvalue>" are ways to update or create a ref. Again <oldvalue>
   may be missing.

So it looks to me that one possible format that is easy to generate
by machine without ambiguity may be:

    * The first record could be

      m NUL <reason strong> NUL

      but it is optional. The reason string may contain LF but just
      like invocation from the command line, LF will eventually
      cleaned up into a SP.

    * Then a series of records of different kinds follow.

      - A delete record looks like this:

        d NUL <ref> NUL <oldvalue> NUL

        If you want to delete the ref without "oldvalue" protection,
        just say

        d NUL <ref> NUL NUL

      - A create/update record looks like one of these:

        u NUL <ref> NUL <newvalue> NUL <oldvalue> NUL
        n NUL <ref> NUL <newvalue> NUL <oldvalue> NUL

        Again, if you want to delete the ref without "oldvalue"
        protection, just say

        u NUL <ref> NUL <newvalue> NUL NUL
        n NUL <ref> NUL <newvalue> NUL NUL

     * EOF signals the end of the request.

I am not saying the above is the best format, but the point is that
the mode of the operation defines the structure, so unlike parsing
xml or json where you first parse the structure and then interpret
what each element means, you can define a simple format where the
kind of element comes upfront to allow the parser/interpreter know
what is expected to follow it.
