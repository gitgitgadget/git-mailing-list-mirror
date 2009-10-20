From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git hang with corrupted .pack
Date: Tue, 20 Oct 2009 13:50:37 -0700
Message-ID: <7vaazln61u.fsf@alter.siamese.dyndns.org>
References: <20091014042249.GA5250@hexapodia.org>
 <20091014142351.GI9261@spearce.org> <7viqeaovmp.fsf@alter.siamese.dyndns.org>
 <7vzl7mng35.fsf@alter.siamese.dyndns.org>
 <7vpr8hn9ly.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910201538180.21460@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Andy Isaacson <adi@hexapodia.org>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Oct 20 22:50:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0LfU-0008F1-LF
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 22:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbZJTUur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 16:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752951AbZJTUur
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 16:50:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbZJTUuq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 16:50:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 607337FC41;
	Tue, 20 Oct 2009 16:50:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L86Q2/NOH2SsUExq1/Kt5IHccRQ=; b=c9xU7O
	3463B7jUcfgovJFW8YohzjTS2MqHJUdQyJOSgv86w0q2qNjwMvYvkd3Z/7Uv4K8i
	h9AFEtCNvsKob34RvKT8EKvj8JDhukCBR+n3Q/LvJAtP5YUy6YVKINA1rXdf64hH
	dCdmuhYPJZyZ6GmuLBJ2mz3ZdT3QUVak/P2Vc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c0xdEVdcWNhmQOeC0TSuhIijCSyW22T6
	Ik7oI1WKfmGauz4YDqyM6SCuaI4xBr1GHliGgZ/DZB7joE8ewqR363uwmOH9lUyh
	UKLS5TK5jsiyW4Sobb8dIMn5xxcFJXzyfXlc9q2Fru6yJCsDk2HJqykidFFhemD5
	71DXsMju4Xk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 20E1F7FC40;
	Tue, 20 Oct 2009 16:50:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0B8447FC3F; Tue, 20 Oct 2009
 16:50:38 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0910201538180.21460@xanadu.home> (Nicolas
 Pitre's message of "Tue\, 20 Oct 2009 15\:46\:45 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D7DF308-BDBA-11DE-B083-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130847>

Nicolas Pitre <nico@fluxnic.net> writes:

> I didn't spend the time needed to think about this issue and your 
> proposed fix yet.  However I think that using sizeof(delta_head)-1 
> makes the code a bit confusing.  At this point i'd use:
>
> 	int size = sizeof(delta_head) - 1;
>
> and use that variable instead just like it is done in 
> unpack_compressed_entry() to have the same code pattern.

Sounds good.  Here is a reroll with a bit more explanation.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 20 Oct 2009 12:40:02 -0700
Subject: [PATCH] Fix "corrupt input stream" check while reading from packfiles

An ealier "fix" made us break out of the loop when we get Z_BUF_ERROR back
from inflate(), and either the input stream still had some data to
consume, or we have already got the full output we expected.

This is the same kind of mistake as we corrected with 456cdf6 (Fix loose
object uncompression check., 2007-03-19); it is valid for inflate() to
produce full output before it consumes the input stream fully; e.g.
immediately before reading the end of stream marker.

Instead, detect corrupt input stream by feeding the input as long as
inflate() wants to without detecting a real error, and giving it an output
buffer that is one byte longer than necessary.  If it touches the extra
byte, we know that the input stream is corrupt; otherwise inflate() will
notice the broken input stream by itself.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4cc8939..f0907b8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1344,7 +1344,8 @@ unsigned long get_size_from_delta(struct packed_git *p,
 			          off_t curpos)
 {
 	const unsigned char *data;
-	unsigned char delta_head[20], *in;
+	unsigned char delta_head[21], *in;
+	unsigned long expected_size = sizeof(delta_head) - 1;
 	z_stream stream;
 	int st;
 
@@ -1357,13 +1358,14 @@ unsigned long get_size_from_delta(struct packed_git *p,
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
 		st = git_inflate(&stream, Z_FINISH);
-		if (st == Z_BUF_ERROR && (stream.avail_in || !stream.avail_out))
-			break;
+		if (!stream.avail_out)
+			break; /* the payload is larger than it should be! */
 		curpos += stream.next_in - in;
 	} while ((st == Z_OK || st == Z_BUF_ERROR) &&
-		 stream.total_out < sizeof(delta_head));
+		 stream.total_out < expected_size);
 	git_inflate_end(&stream);
-	if ((st != Z_STREAM_END) && stream.total_out != sizeof(delta_head)) {
+	if ((st != Z_STREAM_END) &&
+	    stream.total_out != expected_size) {
 		error("delta data unpack-initial failed");
 		return 0;
 	}
@@ -1589,15 +1591,15 @@ static void *unpack_compressed_entry(struct packed_git *p,
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
+			break; /* the payload is larger than it should be! */
 		curpos += stream.next_in - in;
 	} while (st == Z_OK || st == Z_BUF_ERROR);
 	git_inflate_end(&stream);
-- 
1.6.5.1.107.gba912
