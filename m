From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Tue, 29 Jan 2013 10:08:08 -0800
Message-ID: <7vtxpzq2uv.fsf@alter.siamese.dyndns.org>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091610.GD9999@sigill.intra.peff.net>
 <7vy5fbq48t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 19:08:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Fbl-0002UF-OG
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 19:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205Ab3A2SIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 13:08:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38962 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753480Ab3A2SIL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 13:08:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56071B7B8;
	Tue, 29 Jan 2013 13:08:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eeLQX3jI1adL8ZV2t2DbQbGww8o=; b=q7iakm
	hxy2M7yi0Bvqa9lCfETsFDfAHGGZIePXmZLrGvlZn1UlIKx6nun6umC0l9KqMvpw
	z/UqDfovg3NCQEk3VPAhoxJjkT/mMpSDo/bxcBG/vscNs+hgwppm08ktu6JbMj3x
	4hP9fRXM7q/ZbYzDNIV8dclFXgOshyul5CXxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U2HmAL08xtmrE7+8cR15nxgsdxYgaeuk
	t4t0TEqwB/FGPn7CAYjk8zd/cmkZm81flZLRqp7oS8VFhrIGSKLemIHjcrGqMuhL
	BYST6xg5wAGwZQmjibxefheCjr3h1FnNau3xnK2lJz/aKfnogB+IPzXvaJVfWKWi
	Oxn397gqi08=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A86CB7B7;
	Tue, 29 Jan 2013 13:08:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8295B7B3; Tue, 29 Jan 2013
 13:08:09 -0500 (EST)
In-Reply-To: <7vy5fbq48t.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 29 Jan 2013 09:38:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6B0FAF0-6A3E-11E2-B20D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214952>

Junio C Hamano <gitster@pobox.com> writes:

> I am torn on this one.
>
> These cached properties of a single commit will not change no matter
> which pack it appears in, and it feels logically wrong, especially
> when you record these object names in the full SHA-1 form, to tie a
> "commit metapack" to a pack.  Logically there needs only one commit
> metapack that describes all the commits known to the repository when
> the metapack was created.
>
> In order to reduce the disk footprint and I/O cost, the future
> direction for this mechanism may want to point into an existing
> store of SHA-1 hashes with a shorter file offset, and the .idx file
> could be such a store, and in order to move in that direction, you
> cannot avoid tying a metapack to a pack.

Have you considered if we can extend the .idx format version 2
without actually having to bump the version number?  My quick
reading of check_packed_git_idx() tells me that we have a gap after
the "large offset table" that we can place extensions, but I may be
mistaken.  If we indeed can, then perhaps adding a series of

	4-byte "id" header
        4-byte extension length (or 8-byte)
        ... N-byte worth of extension data ...

followed by

	20-byte SHA-1 checksum of all the extension sections
	8-byte file offset to the first extension section

at that gap, immediately before the trailer of the .idx file written
by git_SHA1_Final(), in a way similar to the index extension is done
may give us a natural way to deal with this.  The reader can first
read the offset recorded at the tail, checking if the offset is
plausible because it may not exist, the check the extension section
checksum, to see if the file has extension, or the file just ends
with the large offset table and the 28 bytes it tried to were from
the entries near the end of the large offset table.

If that is not worth attempting, perhaps we may still want to store
this as an optional extended section and bump the .idx format
version.

Then it will be very natural for the extension data that store the
commit metainfo to name objects in the pack the .idx file describes
by the offset in the SHA-1 table.

As we always say, .idx is a local cache and bumping its version is
not a huge headache compared to other longer term storage items.
