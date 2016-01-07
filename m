From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segmentation fault found while fuzzing .pack file under 2.7.0.rc3
Date: Thu, 07 Jan 2016 11:37:11 -0800
Message-ID: <xmqqr3ht41w8.fsf@gitster.mtv.corp.google.com>
References: <568BC8D1.3080201@gmail.com>
	<20160105152436.GA1205@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacek Wielemborek <d33tah@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 07 20:37:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHGN9-0005cR-05
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 20:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbcAGThR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 14:37:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752120AbcAGThP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 14:37:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 059863833E;
	Thu,  7 Jan 2016 14:37:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UiTjT3r643T+HxPXgZPxG/gqD8Y=; b=NXcNgJ
	QhueMiEd6iE6n18qFMuRD8Ix6gVsp5uNsqKrL10doi4YEiQ41Dj2RjyTjexR4wJN
	BVPaWl5PRuJ3SMgPyJkj+N2EThR7z3dNxwiODctgdn6cONaO3gbKFxFRRp+ozB/0
	HaLmkfU2MKjV/EMguAZgndN0AfA/KUvv9XnRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jq/1cOe4olg758Iu0tAOvsocpuVE5G8C
	nV/kHflE0zLPcWg+QjszG7d1CMSXdN2Msbb3UX6Jyt7y/NkDNnUro+KLcopveFFD
	1+XgdNjyY0CrpHMeMU+OhbBo8VUlGqq9/M6wGnevI3OieGFpSxbrfCKlOMSO/xd2
	/2Yb7p6PV4k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EE8693833D;
	Thu,  7 Jan 2016 14:37:12 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5F68D3833C;
	Thu,  7 Jan 2016 14:37:12 -0500 (EST)
In-Reply-To: <20160105152436.GA1205@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 5 Jan 2016 10:24:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0C6F8CA8-B576-11E5-A0CC-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283500>

Jeff King <peff@peff.net> writes:

> [1] I briefly ran your case under valgrind and got:
>
>     ==5409== Invalid read of size 4
>     ==5409==    at 0x55F92A: nth_packed_object_offset (sha1_file.c:2464)
>     ==5409==    by 0x55FBD4: find_pack_entry_one (sha1_file.c:2523)
>     ==5409==    by 0x55FCF7: fill_pack_entry (sha1_file.c:2566)
>     ==5409==    by 0x55FDE2: find_pack_entry (sha1_file.c:2604)
>     ==5409==    by 0x5615BA: has_sha1_file_with_flags (sha1_file.c:3212)
>     ==5409==    by 0x50FC38: has_sha1_file (cache.h:1049)
>     ==5409==    by 0x51043B: parse_object (object.c:259)
>     ==5409==    by 0x546BF9: get_reference (revision.c:254)
>     ==5409==    by 0x54CA15: setup_revisions (revision.c:2342)
>     ==5409==    by 0x4531DA: cmd_log_init_finish (log.c:156)
>     ==5409==    by 0x453465: cmd_log_init (log.c:211)
>     ==5409==    by 0x4547EB: cmd_log (log.c:672)
>     ==5409==  Address 0x840244bc is not stack'd, malloc'd or (recently) free'd
>
>     So I'd guess it's not the pack itself, but rather the .idx which is
>     full of nonsense values. And that's always generated from scratch
>     locally.

After I seeing your "it's not the pack itself but rather the .idx"
without looking at (rather, conciously avoiding to look at) the
valgrind trace, I checked the codepath that starts from
read_packed_sha1().

When we map in the .idx file, we do minimum sanity checks to make
sure that .idx file itself has sorted fan-out.  We do not check if
the object names are sorted, so a bogus .idx could tell us that an
object does not exist when it exists in the matching .pack, but that
is harmless.  Also an unsorted object names will not make our binary
search run in circles while looking things up.  We do not check if
the offset of individual objects are within the corresponding .pack
file, either.

And I arrived at nth_packed_object_offset(), so I think I am hitting
the right nail.  There are a few values we read from the .idx file
here that we would want to validate for sanity.


    off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
    {
            const unsigned char *index = p->index_data;
            index += 4 * 256;
            if (p->index_version == 1) {
                    return ntohl(*((uint32_t *)(index + 24 * n)));

This can return an offset that goes beyond the end of the packfile,
possibly leading to a read access of unmapped region.

            } else {
                    uint32_t off;
                    index += 8 + p->num_objects * (20 + 4);
                    off = ntohl(*((uint32_t *)(index + 4 * n)));
                    if (!(off & 0x80000000))
                            return off;

This also can return an offset that goes beyond the end of the
packfile.

Otherwise 'off' at this point gives an offset into the .idx file
itself, that is the location of the 8-byte offset into the packfile.

                    index += p->num_objects * 4 + (off & 0x7fffffff) * 8;

And this computation can take us beyond the end of the .idx

                    return (((uint64_t)ntohl(*((uint32_t *)(index + 0)))) << 32) |
                                       ntohl(*((uint32_t *)(index + 4)));

Or the value we read with this can take us beyond the end of the
packfile.

            }
    }

As long as the returned value is within the valid region of
packfile, packed_object_info() and unpack_entry() should be
responsible for ensuring that we do not read past the end of the
data.  They should both begin by calling use_pack(), which already
has the "offset beyond end of packfile" check, so I think that they
would successfully catch a malicious .idx file that has handcrafted
bad offsets if we fixed nth_packed_object_offset().
