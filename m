From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] lf_to_crlf_filter(): tell the caller we added "\n" when
 draining
Date: Fri, 16 Dec 2011 14:43:20 -0800
Message-ID: <7vaa6sgmt3.fsf_-_@alter.siamese.dyndns.org>
References: <Pine.GSO.4.63.1111231801580.5099@shipon.roxen.com>
 <20111125153829.GB10417@beez.lab.cmartin.tk>
 <Pine.GSO.4.63.1111251705330.22588@shipon.roxen.com>
 <20111125170219.GD10417@beez.lab.cmartin.tk>
 <7vy5v2wleb.fsf@alter.siamese.dyndns.org>
 <20111128104812.GA2386@beez.lab.cmartin.tk>
 <7viplggoq9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Henrik =?utf-8?Q?Grubbstr=C3=B6m?= <grubba@roxen.com>
To: Git Mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 16 23:44:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbgVf-0004nt-9D
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 23:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231Ab1LPWne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 17:43:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47254 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760943Ab1LPWnX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 17:43:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC6187CFF;
	Fri, 16 Dec 2011 17:43:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ra7DWLFvyMwPu6ZHtFZM3gCdBSE=; b=BLAfvq
	+QevGtp9b7x3IDeZemue68jNFwY/qb3RpyU/AQ0UOi5ju7nlnAYtUU/u5Jp3CLjZ
	gIXWELKufXjXXx8pXQBMwvuhBjxy7uUl43XU/EPXVHjemP4iEhH8cLEqmw7sS5L6
	Hbgr0+Xw8CZ4Qg2HSjsx5+EjLPwQI3Sn0sGlo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IcB8bwvaNDKFl+X9IXpROhJxaaPeEMiN
	PgOOjBdfZTrA6qdlskap/nbaPChmzep9SqcbSR4dFVae57YtvumOQkelJG5od9Z6
	Fz2RfYPC5rJ2khNiB+kXfwyWPP7yVie48p2mIu62lOJj2qomFeh/XtHOcR3PBnW3
	Te0XcPD9do4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C35587CFE;
	Fri, 16 Dec 2011 17:43:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 470D67CFD; Fri, 16 Dec 2011
 17:43:22 -0500 (EST)
In-Reply-To: <7viplggoq9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 16 Dec 2011 14:01:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B9AEDC0-2837-11E1-A835-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187329>

This can only happen when the input size is multiple of the
buffer size of the cascade filter (16k) and ends with an LF,
but in such a case, the code forgot to tell the caller that
it added the "\n" it could not add during the last round.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 convert.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/convert.c b/convert.c
index c2c2c11..c028275 100644
--- a/convert.c
+++ b/convert.c
@@ -879,7 +879,7 @@ int is_null_stream_filter(struct stream_filter *filter)
 
 struct lf_to_crlf_filter {
 	struct stream_filter filter;
-	int want_lf;
+	unsigned want_lf:1;
 };
 
 static int lf_to_crlf_filter_fn(struct stream_filter *filter,
@@ -895,8 +895,11 @@ static int lf_to_crlf_filter_fn(struct stream_filter *filter,
 		lf_to_crlf->want_lf = 0;
 	}
 
-	if (!input)
-		return 0; /* We've already dealt with the state */
+	/* We are told to drain */
+	if (!input) {
+		*osize_p -= o;
+		return 0;
+	}
 
 	count = *isize_p;
 	if (count) {
@@ -931,10 +934,9 @@ static struct stream_filter_vtbl lf_to_crlf_vtbl = {
 
 static struct stream_filter *lf_to_crlf_filter(void)
 {
-	struct lf_to_crlf_filter *lf_to_crlf = xmalloc(sizeof(*lf_to_crlf));
+	struct lf_to_crlf_filter *lf_to_crlf = xcalloc(1, sizeof(*lf_to_crlf));
 
 	lf_to_crlf->filter.vtbl = &lf_to_crlf_vtbl;
-	lf_to_crlf->want_lf = 0;
 	return (struct stream_filter *)lf_to_crlf;
 }
 
-- 
1.7.8.351.g9111b
