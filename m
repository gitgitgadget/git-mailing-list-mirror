From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] apply: free patch->result
Date: Wed, 21 Mar 2012 15:21:32 -0700
Message-ID: <7vwr6dzjbn.fsf_-_@alter.siamese.dyndns.org>
References: <cover.1331158240.git.jaredhance@gmail.com>
 <eadfc83a0d823cc04ea37bf606b57597fb632156.1331158240.git.jaredhance@gmail.com> <7v1uol1tud.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 23:21:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SATua-000524-PC
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 23:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971Ab2CUWVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 18:21:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43549 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964796Ab2CUWVe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 18:21:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 355B96F65;
	Wed, 21 Mar 2012 18:21:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gE9+nEZpuZguEhwIaYN4tbn0aSo=; b=uICuCi
	GCZVubWImWIY1PBi2A0BGVi2Suk+iSYCuIWqYzE9flTO+Hw9Ed/GpkpbunBsNnSY
	+UuGoLjSE2uVIyWIUVtZz99SYigM6qx60C1Egy6d0xQldpv631pxcn9F9keQ7OBb
	8z2JCtopg/wnbvIAaUzXf906+c74ZZFqh9zTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rMU+ODoLE/QSokRBh0IYG0FU/qDGd21G
	hZNStcKDR3LLd0duxcWTji2FebyYLXnlrax7Wr1ocrxCf1Xj6r7BBDNbqPkQJW8E
	lGloYA/zflE1oid400wHiYZNKN9hhz1uI1HetIqXYgSGwQsdr8XJDmzKnqdQc3lz
	HB765Utc7TY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D5D96F64;
	Wed, 21 Mar 2012 18:21:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B64266F62; Wed, 21 Mar 2012
 18:21:33 -0400 (EDT)
In-Reply-To: <7v1uol1tud.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 21 Mar 2012 15:18:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 374ED8BA-73A4-11E1-862F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193625>

This is by far the largest piece of data, much larger than the patch and
fragment structures or the three name fields in the patch structure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
I have not finished auditing all the codepaths, so this change needs to be
eyeballed carefully. We may be pointing an unfreeable piece of memory or a
piece of memory that belong to other structures that are going to be freed
otherwise.

 builtin/apply.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5d03e50..c919db3 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -212,6 +212,7 @@ static void free_patch(struct patch *patch)
 		free(patch->def_name);
 		free(patch->old_name);
 		free(patch->new_name);
+		free(patch->result);
 		free(patch);
 		patch = patch_next;
 	}
-- 
1.7.10.rc1.76.g1a8310
