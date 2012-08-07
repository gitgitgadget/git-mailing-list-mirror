From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] prune.c: only print informational message in
 show_only or verbose mode
Date: Tue, 07 Aug 2012 14:44:51 -0700
Message-ID: <7vlihqv0ks.fsf@alter.siamese.dyndns.org>
References: <CA+sFfMdXc+usFRnCNVoke91_X2qWZARTvPHO=B7Ukxr-j7JB2g@mail.gmail.com>
 <1344315709-15897-1-git-send-email-drafnel@gmail.com>
 <1344315709-15897-2-git-send-email-drafnel@gmail.com>
 <7vtxwfw9rp.fsf@alter.siamese.dyndns.org>
 <7vpq73w9i8.fsf@alter.siamese.dyndns.org>
 <CA+sFfMdVhTwAFLUgrO-mLBh8apG-5X1OJKCN9xgq3-N+1RBrvg@mail.gmail.com>
 <20120807060311.GB13222@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 07 23:45:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyraG-0004YT-6M
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 23:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069Ab2HGVoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 17:44:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51601 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755927Ab2HGVoy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 17:44:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7251291AE;
	Tue,  7 Aug 2012 17:44:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BXBPoE3iyVg+MSZWGKFIkpB5mFQ=; b=G+OMR2
	Yo6rQ9usy2KFSe8dAFsdCa13IXlH7c1KBGTpaaHN3AFiHb+cqNjpz5ChEqZ2iRYx
	XA/lyGMalBIQsSv6x7YVUjR8IaK82Tm/2I9xshc9doHm9H01W7JFITKye11h8XbR
	j+YDH0QAdMN3bw6WaWB22faJkhhqf2zhpAH/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KLiUtCUg0Gb1PlQXuNpcaqJj7Opc772D
	WKnTSMsntWkWlMcTA+y9KMZJO7WbRDEETOkdMSY/zzv9weO7BgSzDPetOVhHuPDY
	KF7Fwgtb3m/1XlneBCWGhgjcU4A5zhhn9FaZxgu8ksKB9cenRErQgeu5btNc616U
	oh0l9hGV5nw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60A0791AC;
	Tue,  7 Aug 2012 17:44:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B933991AB; Tue,  7 Aug 2012
 17:44:52 -0400 (EDT)
In-Reply-To: <20120807060311.GB13222@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 7 Aug 2012 02:03:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1ED59786-E0D9-11E1-BE7F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203050>

Jeff King <peff@peff.net> writes:

> I still think your 2/2 is worth doing independently, though. It is silly
> that git-prune will not mention pruned objects without "-v", but will
> mention temporary files. They should be in the same category.

Ok, so I'll queue it as a separate topic with a different
justification.

-- >8 --
From: Brandon Casey <drafnel@gmail.com>
Date: Mon, 6 Aug 2012 22:01:49 -0700
Subject: [PATCH] prune.c: only print informational message in show_only or verbose mode

"git prune" reports removal of loose object files that are no longer
necessary only under the "-v" option, but unconditionally reports
removal of temporary files that are no longer needed.

The original thinking was that presence of a leftover temporary file
should be an unusual occurrence that may indicate an earlier failure
of some sort, and the user may want to be reminded of it.  Removing
an unnecessary loose object file, on the other hand, is just part of
the normal operation.  That is why the former is always printed out
and the latter only when -v is used.

But neither report is particularly useful.  Hide both of these
behind the "-v" option for consistency.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/prune.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index b99b635..6cb9944 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -25,7 +25,8 @@ static int prune_tmp_object(const char *path, const char *filename)
 		return error("Could not stat '%s'", fullpath);
 	if (st.st_mtime > expire)
 		return 0;
-	printf("Removing stale temporary file %s\n", fullpath);
+	if (show_only || verbose)
+		printf("Removing stale temporary file %s\n", fullpath);
 	if (!show_only)
 		unlink_or_warn(fullpath);
 	return 0;
-- 
1.7.12.rc2.53.g9ec2ef6
