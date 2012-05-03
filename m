From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/18] refs.c: extract function search_for_subdir()
Date: Thu, 03 May 2012 13:56:50 -0700
Message-ID: <7vmx5pdlv1.fsf@alter.siamese.dyndns.org>
References: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
 <1335479227-7877-6-git-send-email-mhagger@alum.mit.edu>
 <7v4nrxf3m2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu May 03 22:57:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ35L-0004FQ-FA
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 22:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758662Ab2ECU5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 16:57:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33559 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754928Ab2ECU4w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 16:56:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9CE7755D;
	Thu,  3 May 2012 16:56:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5kgrAAyU4AO6wFgyD7qDiH0pTJI=; b=Q30Asu
	o2Dp70l2aKZb9aKFa/NKq4Xh6f1sNiUDovDexbACumUcESdbo4mKnRPI4MgirAJ9
	zKjBCf5F+jepjBY6x6wosE8mQdCSiENaxrWJhaGy4Dh8kz/z/BcXBd6RUiDsw7OF
	dR0stDrDJB3E1Cnwfz4Gmx+6c8FAN9oNveikk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qHcMSB97vvKZP+mU2qpI3PVAOa9pSMle
	YrCgS7AXM/XRK2K6uzp+7KDIUpBlwNSg9APmVQaCLFpkyNB5sy9XbwuX1anPIBEO
	ZYdl5ALv+XgiyHSCNkOIqZxu38spIkknpRLosjNECnXmjaWUdJwa9B/unYKbZ/35
	qMlrURrjFMg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E061F755C;
	Thu,  3 May 2012 16:56:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62389755B; Thu,  3 May 2012
 16:56:51 -0400 (EDT)
In-Reply-To: <7v4nrxf3m2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 03 May 2012 12:48:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 81C60906-9562-11E1-8ED2-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196958>

Junio C Hamano <gitster@pobox.com> writes:

> Hrm.  The old code used to reset "dir" to NULL before breaking, so the
> entire function used to return NULL.  Now, it calls search_for_subdir(),
> which calls search_ref_dir() and gets NULL in entry, and returns NULL.
>
> Wouldn't we end up returning the original parameter "dir" instead of NULL
> in that case?  Would that make a difference?

In other words, isn't something like this necessary?

Otherwise, wouldn't do_for_each_ref() called for a non-existing "refs/"
subhierarchy in "base" start from the top-level packed_dir/loose_dir
returned from find_containing_dir(), and end up running do_for_each_ref_in_dirs()
with both top-level packed_dir/loose_dir and traversing all of them, only
to find nothing?

 refs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 9f2da16..af5da5f 100644
--- a/refs.c
+++ b/refs.c
@@ -390,8 +390,10 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
 			   refname + dirname.len,
 			   (slash + 1) - (refname + dirname.len));
 		subdir = search_for_subdir(dir, dirname.buf, mkdir);
-		if (!subdir)
+		if (!subdir) {
+			dir = NULL;
 			break;
+		}
 		dir = subdir;
 	}
 
