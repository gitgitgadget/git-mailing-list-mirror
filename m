From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/4] match-trees: drop "x = x" initializations
Date: Sat, 23 Mar 2013 21:55:53 -0700
Message-ID: <7vli9d4crq.fsf@alter.siamese.dyndns.org>
References: <20130322161837.GG3083@sigill.intra.peff.net>
 <20130322162155.GB25857@sigill.intra.peff.net>
 <514DFB1A.8040102@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Mar 24 05:56:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJcym-0007Bc-Tm
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 05:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556Ab3CXEz4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Mar 2013 00:55:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40760 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab3CXEz4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Mar 2013 00:55:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77C0B81EA;
	Sun, 24 Mar 2013 00:55:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=y63mthC4l90d
	MN6Mgj3c2w1SXKA=; b=UBrvrPPs0osETkR0aaq8Aj5VdLzB61W2lQw0CG3D6MG9
	1zLcGI/qJ7wqGcO+Gir1kolC/CZL23SvLntZznd+wqqsSFvRfn+hLGT0EXqqTTOE
	n8DbkXswYBZZ2Zua4eE2M/Lbx4gDb7oF+XAci55jBnB0kGQgAVqn7hzMQHQTpGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PIaNmt
	KDLgXOWxD8nZVgh3o2UmKaHLf5tKQ5fNCwrMIalf4fVBK/vlaLDmLrmsckF6fEUe
	TnNwD9P0m2bJLw8f2T8sVTEQ04WXzQw6HCS6/IUZLyYQpuZB7Dhfgs8GzQfokIf+
	JXO7Oh69KctTGngvi9HHOO/2DzaIL9hC6pskQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CB7981E9;
	Sun, 24 Mar 2013 00:55:55 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA4E481E7; Sun, 24 Mar 2013
 00:55:54 -0400 (EDT)
In-Reply-To: <514DFB1A.8040102@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat, 23 Mar 2013 19:57:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C035826-943F-11E2-9A93-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218932>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Hmm, let's see if we can help the compiler follow the code without
> making it harder for people to understand.  The patch looks a bit
> jumbled, but the resulting code is OK in my biased opinion.

I actually think the result is much better than a mere "OK"; the
duplicated "at this point we know path1 (or path2) is missing from
the other side" has been bothering me and I was about to suggest a
similar rewrite before I read your message ;-)

However, the same compiler still thinks {elem,path,mode}1 can be
used uninitialized (but not {elem,path,mode}2).  The craziness I
reported in the previous message is also the same.  With this patch
on top to swap the side we inspect first, the compiler thinks
{elem,path,mode}2 can be used uninitialized but not the other three
variables X-<.

So I like your change for readability, but for GCC 4.4.5 we still
need the unnecessary initialization.

 match-trees.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index c0c66bb..9ea2c80 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -77,16 +77,16 @@ static int score_trees(const unsigned char *hash1, =
const unsigned char *hash2)
 		unsigned mode1, mode2;
 		int cmp =3D 0;
=20
-		if (one.size)
-			elem1 =3D tree_entry_extract(&one, &path1, &mode1);
-		else
-			/* two has more entries */
-			cmp =3D 1;
 		if (two.size)
 			elem2 =3D tree_entry_extract(&two, &path2, &mode2);
 		else
 			/* two lacks this entry */
 			cmp =3D -1;
+		if (one.size)
+			elem1 =3D tree_entry_extract(&one, &path1, &mode1);
+		else
+			/* two has more entries */
+			cmp =3D 1;
=20
 		if (!cmp)
 			cmp =3D base_name_compare(path1, strlen(path1), mode1,
