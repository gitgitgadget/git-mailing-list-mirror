From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: correctly identify mergetag signature verification status
Date: Thu, 10 Jul 2014 15:27:14 -0700
Message-ID: <xmqq7g3k7su5.fsf@gitster.dls.corp.google.com>
References: <53AD6C6E.1080208@drmicha.warpmail.net>
	<41f5b516d13fd02408f66ee38704a6c1bb09cbb3.1403875032.git.git@drmicha.warpmail.net>
	<20140628004458.GB13228@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:27:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5MoL-0008PZ-Cl
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 00:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbaGJW1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 18:27:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52753 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751815AbaGJW1W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 18:27:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 83879271F7;
	Thu, 10 Jul 2014 18:27:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ct5RYHjfR7qCMNUxZuPEMPh9XPk=; b=cyT1g1
	LdQMXH0dVXD9AKkFUrvkONQ3CcIQlNf29ad+jKj7rZhj8gF0LHr0fiVUlMnWXZlG
	8mYzf89vqsMP/T/QtagZ4SJj2BGIbqH2xqyQZVv2qL9O7LH086Ax+iNREoeG22i2
	+SG0R4E42R/xhPcTNboFVys3Koe3UYhjjtT2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iBvs8AjRo6Soxao4zhGu3R5FBJw10THS
	hJcUd2gbuTfR4jIk4kqqa4b2Hv8xXtHkLjavTFSxjbiMYuELdKaKmTAnPfNNL0VI
	it8DCQ7TIv9HwFFzp+ug+WfGYM5EVN0RkmtMNRONEdW53bJ5pLj/CTY6s0+GpqCl
	Q0Ky85IuKCc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 79F68271F6;
	Thu, 10 Jul 2014 18:27:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3ABFC271F0;
	Thu, 10 Jul 2014 18:27:01 -0400 (EDT)
In-Reply-To: <20140628004458.GB13228@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 27 Jun 2014 20:44:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4FEAD260-0881-11E4-8A74-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253224>

Jeff King <peff@peff.net> writes:

> Perhaps it would be easier to read (and would have made the logic error
> you are fixing more obvious) as:
>
>   if (extra->len > payload_size) {
> 	if (!verify_signed_buffer(...))
> 		status = 0; /* good; all other code paths leave it as -1 */
> 	else if (verify_message.len <= gpg_message_offset)
> 		strbuf_addstr(&verify_message, "No signature\n");
>   }
>
> That is, for each conditional to check one more thing needed for a good
> signature, and then know that all other code paths leave status as -1.

Thanks.  Let's do it this way, then.

 log-tree.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 1982631..b4bbfe1 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -446,16 +446,17 @@ static void show_one_mergetag(struct rev_info *opt,
 
 	payload_size = parse_signature(extra->value, extra->len);
 	status = -1;
-	if (extra->len > payload_size)
-		if (verify_signed_buffer(extra->value, payload_size,
-					 extra->value + payload_size,
-					 extra->len - payload_size,
-					 &verify_message, NULL)) {
-			if (verify_message.len <= gpg_message_offset)
-				strbuf_addstr(&verify_message, "No signature\n");
-			else
-				status = 0;
-		}
+	if (extra->len > payload_size) {
+		/* could have a good signature */
+		if (!verify_signed_buffer(extra->value, payload_size,
+					  extra->value + payload_size,
+					  extra->len - payload_size,
+					  &verify_message, NULL))
+			status = 0; /* good */
+		else if (verify_message.len <= gpg_message_offset)
+			strbuf_addstr(&verify_message, "No signature\n");
+		/* otherwise we couldn't verify, which is shown as bad */
+	}
 
 	show_sig_lines(opt, status, verify_message.buf);
 	strbuf_release(&verify_message);
