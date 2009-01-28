From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Tue, 27 Jan 2009 21:44:21 -0800
Message-ID: <7vr62ovvbe.fsf@gitster.siamese.dyndns.org>
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
 <20090128033020.GF1321@spearce.org> <p06240812c5a58676a1e2@[63.138.152.192]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Bannasch <stephen.bannasch@deanbrook.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 06:46:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS3FN-0001R0-OL
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 06:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbZA1Fob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 00:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbZA1Fob
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 00:44:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbZA1Foa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 00:44:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C37C4948BF;
	Wed, 28 Jan 2009 00:44:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A06F8948BE; Wed,
 28 Jan 2009 00:44:23 -0500 (EST)
In-Reply-To: <p06240812c5a58676a1e2@[63.138.152.192]> (Stephen Bannasch's
 message of "Tue, 27 Jan 2009 22:52:42 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B96EE018-ECFE-11DD-B344-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107481>

Stephen Bannasch <stephen.bannasch@deanbrook.org> writes:

> At 7:30 PM -0800 1/27/09, Shawn O. Pearce wrote:
>>PJ - the short story here is, to forever work around these buggy
>>1.6.1 clients, you'd have to either run an old server forever,
>>or forever run a patched server that disables the newer ".have"
>>extension in the advertised data written by git-upload-pack.
>>There just isn't a way to hide this from the client.
>>
>>Really though, I'd recommend getting your users to upgrade to a
>>non-buggy client.  Pasky has the same problem on repo.or.cz; if
>>he doesn't have it already he will soon when he upgrades...
>
> Do you know if this problem is fixed in tag v1.6.1.1?
>
>   Tagger: Junio C Hamano <gitster@pobox.com>
>   Date:   Sun Jan 25 12:41:48 2009 -0800
>   commit 5c415311f743ccb11a50f350ff1c385778f049d6

Give us a break.  This was reported today and diagnosed a few hours ago.

In the meantime, here is a minimum patch that should help you to help us
convince the approach we decided to take would work fine for people.



 connect.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git c/connect.c w/connect.c
index 2f23ab3..8026850 100644
--- c/connect.c
+++ w/connect.c
@@ -43,6 +43,9 @@ int check_ref_type(const struct ref *ref, int flags)
 
 static void add_extra_have(struct extra_have_objects *extra, unsigned char *sha1)
 {
+	if (!has_sha1_file(sha1))
+		return;
+
 	ALLOC_GROW(extra->array, extra->nr + 1, extra->alloc);
 	hashcpy(&(extra->array[extra->nr][0]), sha1);
 	extra->nr++;
