From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/4] match-trees: drop "x = x" initializations
Date: Fri, 22 Mar 2013 14:33:16 -0700
Message-ID: <7vtxo35dcz.fsf@alter.siamese.dyndns.org>
References: <20130322161837.GG3083@sigill.intra.peff.net>
 <20130322162155.GB25857@sigill.intra.peff.net>
 <7v1ub76s8c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 22 22:33:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ9au-0002QV-33
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 22:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423329Ab3CVVdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 17:33:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34511 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423311Ab3CVVdT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 17:33:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDA95A5E2;
	Fri, 22 Mar 2013 17:33:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vBQRMmhP6tzjtiv9juEpVUs4Aws=; b=E5QEtb
	PJOMgSo4oMb5APnsHe6QnYKaGOI7FKg0q/e/CXkDxZzE//yroSsMoYevArJZxyTS
	Je7Opbhjt2hRNp6nsiu5riIdEo68OnHWVXo2vVmMss0Rz+Kv6fWugQu6MvT0JUEM
	CSZwbnU/xppeiBsc02mrGA2SuQ/pW3wCSUBLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hm8hXfKsIE4Z+VsXx+7XLLRhTyQ5C7mI
	cMcCvMaK5RxCTv048QPmfeSL3BV4+dlCLtOILipV7eNX6V8JIET96GmUNyhuqNm+
	m9AyVNiJJhS3yP1pT3WXx0VW+qgYPLJ8F5RQlBiPpgtMUJLtiyQjrRgCDwSEzevK
	6RFmhayO8S0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2DB5A5E1;
	Fri, 22 Mar 2013 17:33:18 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 321E9A5E0; Fri, 22 Mar 2013
 17:33:18 -0400 (EDT)
In-Reply-To: <7v1ub76s8c.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 22 Mar 2013 14:26:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C9E9028-9338-11E2-B215-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218851>

Junio C Hamano <gitster@pobox.com> writes:

> These three are all updated by the same tree_entry_extract() call,
> and whenever we use mode[12] we use path[12], so if it decides path1
> is used or assigned, it should be able to tell mode1 is, too.
>
> Unsatisfactory, it surely is...

And immediately after I wrote the above, I am greeted by this:

    gcc (Debian 4.4.5-8) 4.4.5
    match-trees.c:75: error: 'elem1' may be used uninitialized in this function
    match-trees.c:77: error: 'path1' may be used uninitialized in this function

and this crazy one on top squelches it.

If you flip the order of four lines that extracts only when size is
non-zero to extract first from two into elem2, then the warning is
given for elem2/path2 but not for elem1/path1.

I'll initialize all of them to nonsense values for now.

diff --git a/match-trees.c b/match-trees.c
index 4360f10..88981e8 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -72,9 +72,9 @@ static int score_trees(const unsigned char *hash1, const unsigned char *hash2)
 		die("%s is not a tree", sha1_to_hex(hash2));
 	init_tree_desc(&two, two_buf, size);
 	while (one.size || two.size) {
-		const unsigned char *elem1;
+		const unsigned char *elem1 = NULL;
 		const unsigned char *elem2;
-		const char *path1;
+		const char *path1 = NULL;
 		const char *path2;
 		unsigned mode1 = 0; /* make gcc happy */
 		unsigned mode2 = 0; /* make gcc happy */
