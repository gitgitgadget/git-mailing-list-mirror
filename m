From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] push: introduce REJECT_FETCH_FIRST and
 REJECT_NEEDS_FORCE
Date: Mon, 21 Jan 2013 22:04:10 -0800
Message-ID: <7vd2wxda91.fsf@alter.siamese.dyndns.org>
References: <20130121234002.GE17156@sigill.intra.peff.net>
 <1358834027-32039-1-git-send-email-gitster@pobox.com>
 <1358834027-32039-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 07:04:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxWyI-0007p1-Pl
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 07:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab3AVGEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 01:04:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59046 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058Ab3AVGEN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 01:04:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92A0278E3;
	Tue, 22 Jan 2013 01:04:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gE40UYKjbeLIVbSKlk+AscAOyPE=; b=FsH/as
	tinrX9ElxLDP5ncTnduIfY5L1bnLyi18zELpUxawV3+/vmQ9Pw5vuhRhaQWYxgqW
	ujiFTuyIV2XGH6rxtc4/Ch8TQUupbZE2tOqlYSg8qSVAwMMYHq4gIf0DEatTXKMR
	2sCURKoHEK6bxktJbKlRCL9JdoGu367mTpuM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a8tgShAO8Wd5Xi4Up8nYQs2xULX3juO9
	BRocu+qeY+EpggmzkCZ+vVMRSmqv11HO1DkfShMuzouOqbZJ3kcGC6y8nfoftn0V
	CAOIw5z+EW7vkK4FFRIp16l5RDtTa22W9WaUKAEqLhCIZ4UKCE4sMseypUQcIyI2
	crmOVRszrxU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8329378E2;
	Tue, 22 Jan 2013 01:04:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E447678E0; Tue, 22 Jan 2013
 01:04:11 -0500 (EST)
In-Reply-To: <1358834027-32039-3-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Mon, 21 Jan 2013 21:53:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8AE163AC-6459-11E2-B346-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214199>

This one has a logic flaw.  The logic outlined in the cover letter
is correct, and the one described in the log message of this one is
not.

We should say "fetch first" only when we do not have old_sha1.


diff --git a/remote.c b/remote.c
index 248910f..8c39ea2 100644
--- a/remote.c
+++ b/remote.c
@@ -1325,10 +1325,10 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 
 			if (!prefixcmp(ref->name, "refs/tags/"))
 				ref->status = REF_STATUS_REJECT_ALREADY_EXISTS;
-			else if (!has_sha1_file(ref->old_sha1) ||
-				 !lookup_commit_reference_gently(ref->old_sha1, 1))
+			else if (!has_sha1_file(ref->old_sha1))
 				ref->status = REF_STATUS_REJECT_FETCH_FIRST;
-			else if (!lookup_commit_reference_gently(ref->new_sha1, 1))
+			else if (!lookup_commit_reference_gently(ref->new_sha1, 1) ||
+				 !lookup_commit_reference_gently(ref->old_sha1, 1))
 				ref->status = REF_STATUS_REJECT_NEEDS_FORCE;
 			else if (!ref_newer(ref->new_sha1, ref->old_sha1))
 				ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
