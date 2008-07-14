From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] commit walk machinery is dangerous !
Date: Mon, 14 Jul 2008 16:32:45 -0700
Message-ID: <7vod50dote.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0807141641110.12484@xanadu.home>
 <7vbq10f7wr.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0807141904250.12484@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 01:33:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIXYH-0006cy-Qi
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 01:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759404AbYGNXcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 19:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759402AbYGNXcy
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 19:32:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34932 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759401AbYGNXcx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 19:32:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 093DB2786F;
	Mon, 14 Jul 2008 19:32:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2FFB12786A; Mon, 14 Jul 2008 19:32:47 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0807141904250.12484@xanadu.home> (Nicolas
 Pitre's message of "Mon, 14 Jul 2008 19:08:59 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2C25BF48-51FD-11DD-ADED-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88480>

Nicolas Pitre <nico@cam.org> writes:

> It is those with semantic meaning (e.g. object doesn't exist) which 
> should be audited, especially if used in the context of repository 
> modification, which pretty much limits it to the test case I produced.

I've been wondering if we should make the change 8eca0b4 (implement some
resilience against pack corruptions, 2008-06-23) less aggressive.

It makes loose objects and data from other packs to be used as fallback
where we used to just punt, which is a genuine improvement for "salvaging"
mode of operation, but at the same time, it now forbids the callers to
expect that the objects they learned to exist from has_sha1_file() or
nth_packed_object_sha1() should never result NULL return value from
read_sha1_file().

It may make it safe again to fail if you cannot salvage using fallback
method after all.  Something like the attached.

This is unrelated to the issue at hand, but I also notice that there are
few callsites outside sha1_file.c that bypasses cache_or_unpack_entry()
and call unpack_entry() directly.  I wonder if they should be using the
cached version, making unpack_entry() static...

 sha1_file.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 2df78b5..55aa361 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1649,7 +1649,7 @@ static void *unpack_delta_entry(struct packed_git *p,
 		mark_bad_packed_object(p, base_sha1);
 		base = read_sha1_file(base_sha1, type, &base_size);
 		if (!base)
-			return NULL;
+			exit(129);
 	}
 
 	delta_data = unpack_compressed_entry(p, w_curs, curpos, delta_size);
@@ -1946,6 +1946,8 @@ static void *read_packed_sha1(const unsigned char *sha1,
 		      sha1_to_hex(sha1), (uintmax_t)e.offset, e.p->pack_name);
 		mark_bad_packed_object(e.p, sha1);
 		data = read_sha1_file(sha1, type, size);
+		if (!data)
+			exit(129);
 	}
 	return data;
 }
