From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] enable "no-done" extension only when serving over smart-http
Date: Tue, 29 Mar 2011 10:24:59 -0700
Message-ID: <7vhbalsutw.fsf@alter.siamese.dyndns.org>
References: <7vlizxsv82.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shawn@a-pb-sasl-sd.pobox.com, O.Pearce@a-pb-sasl-sd.pobox.com,
	" <spearce@spearce.org>"@a-pb-sasl-sd.pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 29 19:25:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4cfJ-0001Wg-NN
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 19:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930Ab1C2RZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 13:25:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60407 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab1C2RZF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 13:25:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0ADB048E6;
	Tue, 29 Mar 2011 13:26:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YHypHOSzF94KCU9RPXI3cuigMW4=; b=jE1a2a
	D46B1e+mcBM+hFtBGoYkWF7BHCkjbo6/qWnBPa+3ckMUQhsvNkvKtyDZEmim17WP
	YFVnXM39XUJYuAsMDxsYInoCaGEjr2y1Z7cZdlIL80xHofXWzV6xVOw/E4699rrm
	7SO7puIsdcw3Iyss4HtBktBB2KtbTTjvbWTsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uvEhMHFqBQccG1xY4cIegFi7K5mGcusD
	RVOfAQ26+uU/Mmyqv6SQkUJC7mXYvUbmN/MpNLRAuGHxYZO0w1FIJpvPq/Tr1DyD
	nrTJBWrBWb2i9Br4SjDNzy1VjfDIiIsnJrhby177DD3wnxPHsEyUx+bvZ3LWwJvP
	5NVCpCxDBzI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D55AB48E5;
	Tue, 29 Mar 2011 13:26:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0ABBE48E4; Tue, 29 Mar 2011
 13:26:46 -0400 (EDT)
In-Reply-To: <7vlizxsv82.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 29 Mar 2011 10:16:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA5CCF72-5A29-11E0-A2F3-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170285>

Do not advertise no-done capability when upload-pack is not serving over
smart-http, as there is no way for this server to know when it should stop
reading in-flight data from the client, even though it is necessary to
drain all the in-flight data in order to unblock the client.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 5924f6f..a247fb9 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -640,15 +640,16 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag multi_ack_detailed no-done";
+		" include-tag multi_ack_detailed";
 	struct object *o = parse_object(sha1);
 
 	if (!o)
 		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
 
 	if (capabilities)
-		packet_write(1, "%s %s%c%s\n", sha1_to_hex(sha1), refname,
-			0, capabilities);
+		packet_write(1, "%s %s%c%s%s\n", sha1_to_hex(sha1), refname,
+			     0, capabilities,
+			     stateless_rpc ? " no-done" : "");
 	else
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname);
 	capabilities = NULL;
