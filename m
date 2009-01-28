From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Tue, 27 Jan 2009 20:38:31 -0800
Message-ID: <7v1vuoxcxk.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901280034310.3586@pacific.mpi-cbg.de>
 <20090127233939.GD1321@spearce.org>
 <7v1vuo1f6d.fsf@gitster.siamese.dyndns.org>
 <bab6a2ab0901271634x7201130bx4a565bd8bea6967b@mail.gmail.com>
 <7vvds0z1c1.fsf@gitster.siamese.dyndns.org>
 <7vk58gz04l.fsf@gitster.siamese.dyndns.org>
 <7vfxj4yzjj.fsf@gitster.siamese.dyndns.org>
 <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com>
 <20090128020220.GE1321@spearce.org>
 <7v3af4yvmu.fsf@gitster.siamese.dyndns.org>
 <20090128033020.GF1321@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: PJ Hyett <pjhyett@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 05:40:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS2Df-0005gE-CD
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 05:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbZA1Ein (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 23:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbZA1Eim
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 23:38:42 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbZA1Eil (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 23:38:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 275F794497;
	Tue, 27 Jan 2009 23:38:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 29F5C94495; Tue,
 27 Jan 2009 23:38:32 -0500 (EST)
In-Reply-To: <20090128033020.GF1321@spearce.org> (Shawn O. Pearce's message
 of "Tue, 27 Jan 2009 19:30:20 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8874B626-ECF5-11DD-AD0E-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107475>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> Hmm, I am puzzled.
>> 
>> I do not know how 41fa7d2 (Teach git-fetch to exploit server side
>> automatic tag following, 2008-03-03), which is about the conversation
>> between fetch-pack and upload-pack, is relevant to the issue at hand,
>> which is about the conversation between send-pack and receive-pack.
>
> Oh, right, its not.  I was pointing out that the last time the
> protocol changed in a way the server can infer something about the
> client, which IIRC was 41fa7d2, we still don't have a way to tell
> what the client is.

But you are still talking as if there is one protocol you can call "the
protocol", but it is not.  The send-pack receive-pack protocol is on topic
in this thread; the quoted commit was about a separate and independent
fetch-pack upload-pack protocol.  It does not matter when that unrelated
protocol was enhanced.

> PJ - the short story here is, to forever work around these buggy
> 1.6.1 clients, you'd have to either run an old server forever,
> or forever run a patched server that disables the newer ".have"
> extension in the advertised data written by git-upload-pack.
> There just isn't a way to hide this from the client.
>
> Really though, I'd recommend getting your users to upgrade to a
> non-buggy client.  Pasky has the same problem on repo.or.cz; if
> he doesn't have it already he will soon when he upgrades...

Yeah, I'll apply the attached patch to 'maint' and it will be in the next
1.6.1.X maintenance release.  I suspect that your 1.6.1 users are the ones
who like to be on the cutting edge, and it wouldn't be unreasonable to
expect that they will update soon (1.6.1 has been out only for one month).

-- >8 --
Subject: [PATCH] send-pack: do not send unknown object name from ".have" to pack-objects

v1.6.1 introduced ".have" extension to the protocol to allow the receiving
side to advertise objects that are reachable from refs in the repositories
it borrows from.  This was meant to be used by the sending side to avoid
sending such objects; they are already available through the alternates
mechanism.

The client side implementation in v1.6.1, which was introduced with
40c155f (push: prepare sender to receive extended ref information from the
receiver, 2008-09-09) aka v1.6.1-rc1~203^2~1, were faulty in that it did
not consider the possiblity that the repository receiver borrows from
might have objects it does not know about.

This implements a tentative fix.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-send-pack.c |   49 +++++++++++++++++++++++++++----------------------
 1 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index a9fdbf9..fae597b 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -15,6 +15,26 @@ static struct send_pack_args args = {
 	/* .receivepack = */ "git-receive-pack",
 };
 
+static int feed_object(const unsigned char *theirs, int fd, int negative)
+{
+	char buf[42];
+
+	if (negative) {
+		if (!has_sha1_file(theirs))
+			return 1;
+		/*
+		 * NEEDSWORK: we should not be satisfied by simply having
+		 * theirs, but should be making sure it is reachable from
+		 * some of our refs.
+		 */
+	}
+
+	memcpy(buf + negative, sha1_to_hex(theirs), 40);
+	if (negative)
+		buf[0] = '^';
+	buf[40 + negative] = '\n';
+	return write_or_whine(fd, buf, 41 + negative, "send-pack: send refs");
+}
 /*
  * Make a pack stream and spit it out into file descriptor fd
  */
@@ -35,7 +55,6 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 	};
 	struct child_process po;
 	int i;
-	char buf[42];
 
 	if (args.use_thin_pack)
 		argv[4] = "--thin";
@@ -51,31 +70,17 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 	 * We feed the pack-objects we just spawned with revision
 	 * parameters by writing to the pipe.
 	 */
-	for (i = 0; i < extra->nr; i++) {
-		memcpy(buf + 1, sha1_to_hex(&extra->array[i][0]), 40);
-		buf[0] = '^';
-		buf[41] = '\n';
-		if (!write_or_whine(po.in, buf, 42, "send-pack: send refs"))
+	for (i = 0; i < extra->nr; i++)
+		if (!feed_object(extra->array[i], po.in, 1))
 			break;
-	}
 
 	while (refs) {
 		if (!is_null_sha1(refs->old_sha1) &&
-		    has_sha1_file(refs->old_sha1)) {
-			memcpy(buf + 1, sha1_to_hex(refs->old_sha1), 40);
-			buf[0] = '^';
-			buf[41] = '\n';
-			if (!write_or_whine(po.in, buf, 42,
-						"send-pack: send refs"))
-				break;
-		}
-		if (!is_null_sha1(refs->new_sha1)) {
-			memcpy(buf, sha1_to_hex(refs->new_sha1), 40);
-			buf[40] = '\n';
-			if (!write_or_whine(po.in, buf, 41,
-						"send-pack: send refs"))
-				break;
-		}
+		    !feed_object(refs->old_sha1, po.in, 1))
+			break;
+		if (!is_null_sha1(refs->new_sha1) &&
+		    !feed_object(refs->new_sha1, po.in, 0))
+			break;
 		refs = refs->next;
 	}
 
-- 
1.6.1.1.273.g0e555
