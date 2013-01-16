From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Wed, 16 Jan 2013 08:36:01 -0800
Message-ID: <7vsj61xez2.fsf@alter.siamese.dyndns.org>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
 <DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Rorvick <chris@rorvick.com>, git@vger.kernel.org,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 17:36:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvVyb-0004Kz-NH
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 17:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758521Ab3APQgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 11:36:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42815 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757884Ab3APQgG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 11:36:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8B0DB75C;
	Wed, 16 Jan 2013 11:36:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KSZNHKFwnvNy7oyHQ6IIljcpj2E=; b=cVX85R
	5HOJRFj2iyMFOeMnpGHT81HzK1k9FF7VIthZ0bE1ZoaWPvp6OLqy38Zz1rpBnHif
	iqnvZ9G5YYu2rYyBK8burdhiCiEwE1uE9Y4tcK/g0sCYEItYuqoQJlme4FZXi8Mz
	4L8bwzvgvrXIgTPMJpzH+76A69M5v680XEZlc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Axip3dF7vyPQxOoqG1K33rg1iODDLjAL
	KzVKv6zDCbcsonyYO32zdqWqgZigFbVdu7kDorTt05zhAaU8pw1AgmwhslVplqM6
	g/488DiBITcezIWiPWQKoJDGwxK0jSWxxtJsZp+UeAVXk1Dx09nI5qNssjngAgQ2
	OzX/BW+ZtLw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF147B75A;
	Wed, 16 Jan 2013 11:36:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C23B7B751; Wed, 16 Jan 2013
 11:36:03 -0500 (EST)
In-Reply-To: <DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de> (Max Horn's
 message of "Wed, 16 Jan 2013 14:32:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1B1972E-5FFA-11E2-B63A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213766>

Max Horn <max@quendi.de> writes:

> But with next, I get this:
>
>
>  ! [rejected]        master -> master (already exists)
> error: failed to push some refs to '/Users/mhorn/Proje...o_orig'
> hint: Updates were rejected because the destination reference already exists
> hint: in the remote.
>
> This looks like a regression to me.

It is an outright bug.  The new helper function is_forwrdable() is
bogus to assume that both original and updated objects can be
locally inspected, but you do not necessarily have the original
locally.

 remote.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index aa6b719..4a253ef 100644
--- a/remote.c
+++ b/remote.c
@@ -1286,9 +1286,12 @@ static inline int is_forwardable(struct ref* ref)
 	if (!prefixcmp(ref->name, "refs/tags/"))
 		return 0;
 
-	/* old object must be a commit */
+	/*
+	 * old object must be a commit, but we may be forcing
+	 * without having it in the first place!
+	 */
 	o = parse_object(ref->old_sha1);
-	if (!o || o->type != OBJ_COMMIT)
+	if (o && o->type != OBJ_COMMIT)
 		return 0;
 
 	/* new object must be commit-ish */
