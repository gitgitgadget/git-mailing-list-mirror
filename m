From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 3/4] bundle: don't leak an fd in case of early return
Date: Fri, 01 Apr 2016 10:29:51 -0700
Message-ID: <xmqqk2khi6eo.fsf@gitster.mtv.corp.google.com>
References: <1459470946-16522-1-git-send-email-sbeller@google.com>
	<1459470946-16522-4-git-send-email-sbeller@google.com>
	<xmqqzitdi7iq.fsf@gitster.mtv.corp.google.com>
	<20160401171535.GB20345@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, sunshine@sunshineco.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 01 19:29:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am2tR-0006c6-SA
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 19:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbcDAR3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 13:29:54 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751284AbcDAR3y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 13:29:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3C0B94FBF5;
	Fri,  1 Apr 2016 13:29:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hdJ7BCq1ryObt01EmjygNFgaM44=; b=vrpA0K
	Dv+7lSLz/S2oEghZ1DCZVL5j8nzlkbzpRdan/zIi0XWsyP5J0NGl0QHZfKrp7rCh
	nezHGMntx9AMZvZkh9rYE9uXQXqysO/wlwYnBRw1jaDbAgyT6g6Se/HKMmMoe27L
	rcKdjrnsL99uMcKPHThA716R/aO7qwVCfFnn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F7aW/I/htXCUm6MRkTeCTeyoFNvwLwDI
	qx5q0Epy8kiPg7dv1WE1GdYA28qcrLBIYuGF4q8r+8cTR6CFv7hN1b3VAnW1lcLg
	Cu8gTijgffIfsek0IooQRrcquqdjTjbBWoXwB/9Q+XakpO4zWrAHlUZ04eRk8Hbp
	I0pLt21F2jc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 31EB74FBF2;
	Fri,  1 Apr 2016 13:29:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 950E04FBF1;
	Fri,  1 Apr 2016 13:29:52 -0400 (EDT)
In-Reply-To: <20160401171535.GB20345@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 1 Apr 2016 13:15:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 57E1EB80-F82F-11E5-A615-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290566>

Jeff King <peff@peff.net> writes:

> You didn't see my response to the other patch yet. :)
>
>> >  	/* write pack */
>> >  	if (write_pack_data(bundle_fd, &revs))
>> > -		return -1;
>> > +		goto err;
>
> This does still suffer from the double-close I mentioned earlier. I'm
> not sure if we want to address that or not.

Something like this on top?

 bundle.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index 08e32ca..bbf4efa 100644
--- a/bundle.c
+++ b/bundle.c
@@ -453,8 +453,10 @@ int create_bundle(struct bundle_header *header, const char *path,
 		goto err;
 
 	/* write pack */
-	if (write_pack_data(bundle_fd, &revs))
+	if (write_pack_data(bundle_fd, &revs)) {
+		bundle_fd = -1; /* already closed by the above call */
 		goto err;
+	}
 
 	if (!bundle_to_stdout) {
 		if (commit_lock_file(&lock))
@@ -463,7 +465,8 @@ int create_bundle(struct bundle_header *header, const char *path,
 	return 0;
 err:
 	if (!bundle_to_stdout) {
-		close(bundle_fd);
+		if (0 <= bundle_fd)
+			close(bundle_fd);
 		rollback_lock_file(&lock);
 	}
 	return -1;
