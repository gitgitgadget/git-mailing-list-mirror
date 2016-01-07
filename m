From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segmentation fault found while fuzzing .pack file under 2.7.0.rc3
Date: Thu, 07 Jan 2016 14:54:50 -0800
Message-ID: <xmqqtwmp2e6d.fsf@gitster.mtv.corp.google.com>
References: <568BC8D1.3080201@gmail.com>
	<20160105152436.GA1205@sigill.intra.peff.net>
	<xmqqr3ht41w8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacek Wielemborek <d33tah@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 07 23:54:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHJSL-0006g9-GF
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 23:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbcAGWyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 17:54:53 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50890 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752230AbcAGWyw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 17:54:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DB5563A0FE;
	Thu,  7 Jan 2016 17:54:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0VYSbfnjmq2M4iUPgXo3eHNwQ4k=; b=FhUXUL
	TWzXbusl3HWxY8cUPjXYGsWh73oKg6ddpeblgRPGZH37b696p8LnKQ/LQzw/RsgX
	T1HYZSeZb0B6mJY6ibWM9Vdn3kjkUUWAR5LAmSq/4LzdRfbPSKofBdFwYYRicgJx
	XtdS8vfeGvOHA596hDcWYeRNJbTRtr+6bYUPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gutEmGE5i68d4bb32TwGnOKXTU+EJeKQ
	kqip3Nfth6yZDcYIDC2HcTH3VxHhotOj+f8OZgPP7P8l+jPaGQhMiemGM+8SRPVs
	qskulD50zkqLUifLJe3/Nb2TBAq8IytvasPEsfuFFNxwi3Oc1cSlJ+hsirqzLHaa
	PE8i3NucebE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D27C03A0FD;
	Thu,  7 Jan 2016 17:54:51 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 55A293A0FC;
	Thu,  7 Jan 2016 17:54:51 -0500 (EST)
In-Reply-To: <xmqqr3ht41w8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 07 Jan 2016 11:37:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A8ECC8FA-B591-11E5-95F1-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283513>

When we map in the .idx file, we do only minimum sanity checks to
make sure that the .idx file itself has sorted fan-out.  We do not
check if the object names are sorted, so a bogus .idx could tell us
that an object does not exist when it exists in the matching .pack,
but that is harmless.  Also an unsorted object names will not make
our binary search run in circles while looking things up.

We do not check if the offset of individual objects are within the
corresponding .pack file, either, and nth_packed_object_offset()
does return the data read from .idx file that is not checked for
sanity.  use_pack(), which is the helper used by the callers of
nth_packed_object_offset() that finds the offset in the packfile for
each object, avoids allowing a read access to mapped pack data
beyond the end of it, so it is OK to return bogus value that was
read from the .idx file from this function, but there is one
computation the function itself does using a possibly bogus value
read from the disk: to find out where in the secondary offset table
in the .idx file the offset in the packfile is stored.

---

 This is not even compile tested; I just wanted to prevent people
 from adding two unnecessary checks to this function following my
 analysis in the previous message.  I think returning bogus value
 stored in a crafted .idx file from this function is OK, as the
 offset will be first used by use_pack() and the sanity of the
 offset, relative to the packfile size, is checked there, and an
 offset that points to a random point in the packfile will be caught
 by the pack reading code, either by unpack_compressed_entry() or by
 patch_delta(), so that is also safe.

 We do need to check the unprotected access here.  Nobody else in
 the current codepath protects us from this access attempting to
 read an unmapped memory and segfault.

 sha1_file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index 73ccd49..8aca1f6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2458,6 +2458,13 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 		off = ntohl(*((uint32_t *)(index + 4 * n)));
 		if (!(off & 0x80000000))
 			return off;
+
+		/* 8-byte offset table */
+		if ((p->index_size - (8 + 256 * 4 + 28 * p->num_objects + 40))
+		    <
+		    (off & 0x7fffffff) * 8)
+			die("offset beyond end of .idx file");
+
 		index += p->num_objects * 4 + (off & 0x7fffffff) * 8;
 		return (((uint64_t)ntohl(*((uint32_t *)(index + 0)))) << 32) |
 				   ntohl(*((uint32_t *)(index + 4)));
