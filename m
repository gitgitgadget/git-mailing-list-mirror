From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] get_fetch_map(): tighten checks on dest refs
Date: Fri, 04 May 2012 15:35:18 -0700
Message-ID: <7vsjff8ti1.fsf_-_@alter.siamese.dyndns.org>
References: <7vsjfj7des.fsf@alter.siamese.dyndns.org>
 <7vwr4r8tpm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 05 00:35:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQR5y-0003h0-Ib
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 00:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759997Ab2EDWfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 18:35:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45225 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757775Ab2EDWfV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 18:35:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42EF76382;
	Fri,  4 May 2012 18:35:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=asAVGCtpmgZmh1bwBPFEt0w9ZLU=; b=EdqmaP
	+kmqfGIxaBlqSrid+B3DybtPeOPfoVZQqKWQWPcfz6NG9oXbSSAhzqE+vsnKD0J+
	6Sf6yrqOPLRJJQ8vMD8VSSI9pQoKXa2g4JkIJ7aXwHFdyDb5M4VJySbzeq8lKiuZ
	+AFgBV8VjiFeEV47/pxlob4mMfLZkW6Q1dj8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DGmGYLS1/jEazIe8s2TtSGzuBUe5OzcZ
	y93oo2I3aW4Y6ccpE8u57IBZKiTzwQCCUL0j1TsBR8C9K4gBWIRH57rPCgZYgSPe
	Nr3L5nCdmcdpDSUnaYLTXPJpcb8AvdD7E7HKl0pzQV/X8fvBeAF84lYatE0sOUMt
	1RT/Hm9t56I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3908E6381;
	Fri,  4 May 2012 18:35:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE2BE637F; Fri,  4 May 2012
 18:35:19 -0400 (EDT)
In-Reply-To: <7vwr4r8tpm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 04 May 2012 15:30:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6DCC6D96-9639-11E1-BBB8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197078>

The code to check the refname we store the fetched result locally did not
bother checking the first 5 bytes of it, presumably assuming that it
always begin with "refs/".  For a fetch refspec (or the result of applying
wildcard on one), we always want the RHS to map to something inside
"refs/" hierarchy, so let's spell that rule out in a more explicit way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index eacd8ad..0f2b1db 100644
--- a/remote.c
+++ b/remote.c
@@ -1402,8 +1402,8 @@ int get_fetch_map(const struct ref *remote_refs,
 
 	for (rmp = &ref_map; *rmp; ) {
 		if ((*rmp)->peer_ref) {
-			if (check_refname_format((*rmp)->peer_ref->name + 5,
-				REFNAME_ALLOW_ONELEVEL)) {
+			if (prefixcmp((*rmp)->peer_ref->name, "refs/") ||
+			    check_refname_format((*rmp)->peer_ref->name, 0)) {
 				struct ref *ignore = *rmp;
 				error("* Ignoring funny ref '%s' locally",
 				      (*rmp)->peer_ref->name);
-- 
1.7.10.1.500.g37b1e9a
