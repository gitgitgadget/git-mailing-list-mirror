From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git hang with corrupted .pack
Date: Wed, 21 Oct 2009 23:06:14 -0700
Message-ID: <7vd44gm089.fsf@alter.siamese.dyndns.org>
References: <20091014042249.GA5250@hexapodia.org>
 <20091014142351.GI9261@spearce.org> <7viqeaovmp.fsf@alter.siamese.dyndns.org>
 <7vzl7mng35.fsf@alter.siamese.dyndns.org>
 <7vpr8hn9ly.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910201538180.21460@xanadu.home>
 <7vaazln61u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Isaacson <adi@hexapodia.org>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 22 08:06:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0qop-0005sm-FK
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 08:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbZJVGG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 02:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbZJVGG2
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 02:06:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbZJVGG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 02:06:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EF55C628EF;
	Thu, 22 Oct 2009 02:06:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=IbPpMf402WAQyZXvEBoK8M2Lq/0=; b=rODRFX1mbQZSvRzpJQShJ8V
	L4YAZV5WNIjHSB+2yFHOa/Shg0n/Ar0NJ4eQE5tjFXXBiAOkB4E8AnBZjEmsWkMe
	PjvvauSWaPOeJ2l55amgIW2Gb6pMcz0skJYnwO7/RdI+p8l4ZAvwsrz9Fkur6fCO
	5EjuHFdyZnUjBJUrWXDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=cjclQIvo9kl1A+oq3S/U+UfYaBhutBAgHhbL/PZ1GkqGqSz9I
	9GpR4sHkWbxbNPv5I9g/YJZHMk9e48JNaMKiPvseFmiDB+5sJBFrSJPD65iG1Sbb
	x7FVE3QOra4DkaDb/TT4CEOKzYUW0t9j2F+QG+f6REoDBctlIeYRevBBEU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A9E46628EE;
	Thu, 22 Oct 2009 02:06:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FACD628EC; Thu, 22 Oct
 2009 02:06:15 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 06A5AED0-BED1-11DE-94C7-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130992>

Junio C Hamano <gitster@pobox.com> writes:

> Nicolas Pitre <nico@fluxnic.net> writes:
>
>> I didn't spend the time needed to think about this issue and your 
>> proposed fix yet.

I looked at the issue again, and came to the conclusion that we need quite
different fix for the two inflate callsites, as they do quite different
things.

-- >8 --
Subject: Fix incorrect error check while reading deflated pack data

The loop in get_size_from_delta() feeds a deflated delta data from the
pack stream _until_ we get inflated result of 20 bytes[*] or we reach the
end of stream.

    Side note. This magic number 20 does not have anything to do with the
    size of the hash we use, but comes from 1a3b55c (reduce delta head
    inflated size, 2006-10-18).

The loop reads like this:

    do {
        in = use_pack();
        stream.next_in = in;
        st = git_inflate(&stream, Z_FINISH);
        curpos += stream.next_in - in;
    } while ((st == Z_OK || st == Z_BUF_ERROR) &&
             stream.total_out < sizeof(delta_head));

This git_inflate() can return:

 - Z_STREAM_END, if use_pack() fed it enough input and the delta itself
   was smaller than 20 bytes;

 - Z_OK, when some progress has been made;

 - Z_BUF_ERROR, if no progress is possible, because we either ran out of
   input (due to corrupt pack), or we ran out of output before we saw the
   end of the stream.

The fix b3118bd (sha1_file: Fix infinite loop when pack is corrupted,
2009-10-14) attempted was against a corruption that appears to be a valid
stream that produces a result larger than the output buffer, but we are
not even trying to read the stream to the end in this loop.  If avail_out
becomes zero, total_out will be the same as sizeof(delta_head) so the loop
will terminate without the "fix".  There is no fix from b3118bd needed for
this loop, in other words.

The loop in unpack_compressed_entry() is quite a different story.  It
feeds a deflated stream (either delta or base) and allows the stream to
produce output up to what we expect but no more.

    do {
        in = use_pack();
        stream.next_in = in;
        st = git_inflate(&stream, Z_FINISH);
        curpos += stream.next_in - in;
    } while (st == Z_OK || st == Z_BUF_ERROR)

This _does_ risk falling into an endless interation, as we can exhaust
avail_out if the length we expect is smaller than what the stream wants to
produce (due to pack corruption).  In such a case, avail_out will become
zero and inflate() will return Z_BUF_ERROR, while avail_in may (or may
not) be zero.

But this is not a right fix:

    do {
        in = use_pack();
        stream.next_in = in;
        st = git_inflate(&stream, Z_FINISH);
+       if (st == Z_BUF_ERROR && (stream.avail_in || !stream.avail_out)
+               break; /* wants more input??? */
        curpos += stream.next_in - in;
    } while (st == Z_OK || st == Z_BUF_ERROR)

as Z_BUF_ERROR from inflate() may be telling us that avail_in has also run
out before reading the end of stream marker.  In such a case, both avail_in
and avail_out would be zero, and the loop should iterate to allow the end
of stream marker to be seen by inflate from the input stream.

The right fix for this loop is likely to be to increment the initial
avail_out by one (we allocate one extra byte to terminate it with NUL
anyway, so there is no risk to overrun the buffer), and break out if we
see that avail_out has become zero, in order to detect that the stream
wants to produce more than what we expect.  After the loop, we have a
check that exactly tests this condition:

    if ((st != Z_STREAM_END) || stream.total_out != size) {
        free(buffer);
        return NULL;
    }

So here is a patch (without my previous botched attempts) to fix this
issue.  The first hunk reverts the corresponding hunk from b3118bd, and
the second hunk is the same fix proposed earlier. 

---
 sha1_file.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4cc8939..63981fb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1357,8 +1357,6 @@ unsigned long get_size_from_delta(struct packed_git *p,
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
 		st = git_inflate(&stream, Z_FINISH);
-		if (st == Z_BUF_ERROR && (stream.avail_in || !stream.avail_out))
-			break;
 		curpos += stream.next_in - in;
 	} while ((st == Z_OK || st == Z_BUF_ERROR) &&
 		 stream.total_out < sizeof(delta_head));
@@ -1589,15 +1587,15 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	buffer[size] = 0;
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out = buffer;
-	stream.avail_out = size;
+	stream.avail_out = size + 1;
 
 	git_inflate_init(&stream);
 	do {
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
 		st = git_inflate(&stream, Z_FINISH);
-		if (st == Z_BUF_ERROR && (stream.avail_in || !stream.avail_out))
-			break;
+		if (!stream.avail_out)
+			break; /* the payload is larger than it should be */
 		curpos += stream.next_in - in;
 	} while (st == Z_OK || st == Z_BUF_ERROR);
 	git_inflate_end(&stream);
