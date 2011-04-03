From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git diff -D: omit the preimage of deletes
Date: Sat, 02 Apr 2011 23:23:13 -0700
Message-ID: <7vtyefg8fi.fsf@alter.siamese.dyndns.org>
References: <7v62qzhqp4.fsf@alter.siamese.dyndns.org>
 <b6975fdc80a338e47c1426e8bf8450b68130b84a.1301664623.git.git@drmicha.warpmail.net> <7vbp0pg4d7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Apr 03 08:23:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6Gid-0006hx-Ri
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 08:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656Ab1DCGXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 02:23:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525Ab1DCGXW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 02:23:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BF20025C9;
	Sun,  3 Apr 2011 02:25:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UWG9tJr74fmZnYOspwbu+t2GSBw=; b=Pq/37j
	EEJgvnGxha1KbSSYNJBCykgfhsMNWjuH8hERequDJ1nWW5KzHcCBLvjObcsUNyjH
	nvXh8dNID/yk3w7uiOU+SLmVRbHXdkJcPVSt7Go+BWg/SuNcLgiVehVqzV5cgePl
	s7gmUdtlU7fhxAOYdxwwr9RO1wNPYntoJqRXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fjo1ozjivo3hr+N6N0Yat1XWsaIproQS
	1LWZjskvh6bn4elgNao5zaIj+0ZUzvzZJygVKjip+N6eZbRLzQEVHJ/k6QnafTd9
	hej9ImiuMD/zwKRXL1mW/2xc2gRRFK4HOsYTUvjQEplPmC0hoDg6FAjIqMWIG8z0
	v/XeDMNzop8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9CD4825C8;
	Sun,  3 Apr 2011 02:25:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8CB4F25C4; Sun,  3 Apr 2011
 02:25:06 -0400 (EDT)
In-Reply-To: <7vbp0pg4d7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 01 Apr 2011 12:26:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FD0CCF2-5DBB-11E0-BF81-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170678>

Junio C Hamano <gitster@pobox.com> writes:

> I would have expected that the patch relative to jc/diff-irreversible-delete
> topic would consist only of changes to diff.c:emit_rewrite_diff(), docs
> and tests.

Here is an "in other words" follow-up.  Your tests looked reasonable (and
pass with this patch on top of what has been queued in 'pu').


 diff.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 5c66a53..05f443c 100644
--- a/diff.c
+++ b/diff.c
@@ -572,11 +572,14 @@ static void emit_rewrite_diff(const char *name_a,
 		line_prefix, metainfo, a_name.buf, name_a_tab, reset,
 		line_prefix, metainfo, b_name.buf, name_b_tab, reset,
 		line_prefix, fraginfo);
-	print_line_count(o->file, lc_a);
+	if (!o->irreversible_delete)
+		print_line_count(o->file, lc_a);
+	else
+		fprintf(o->file, "?,?");
 	fprintf(o->file, " +");
 	print_line_count(o->file, lc_b);
 	fprintf(o->file, " @@%s\n", reset);
-	if (lc_a)
+	if (lc_a && !o->irreversible_delete)
 		emit_rewrite_lines(&ecbdata, '-', data_one, size_one);
 	if (lc_b)
 		emit_rewrite_lines(&ecbdata, '+', data_two, size_two);
