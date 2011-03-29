From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] enable "no-done" extension only when serving over smart-http
Date: Tue, 29 Mar 2011 10:32:18 -0700
Message-ID: <7vfwq5suhp.fsf@alter.siamese.dyndns.org>
References: <7vlizxsv82.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 29 19:32:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4cmP-0004wB-U2
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 19:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003Ab1C2Rc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 13:32:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab1C2Rc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 13:32:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A102E49E6;
	Tue, 29 Mar 2011 13:34:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MpxNEba/N4j40soLDdqcdJKkG0o=; b=sTrpGO
	/E1ht3VuA4mJeA0s9kL3mlS5iPVLHjZvrGU/CO8xnw2FlQ1yY6+EzNnqCarwpmEH
	/eJLA7Zd+zDEaV07y5KFUsNJnjd5E1jTbknysurwIWV774QbOrSxZZkYNijpJ6lv
	8haLHii1FQVMhxxo/qsVkqJB5eFYF0iKCaqEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HNlwOBS0lNRMuQJL/GMN8PYgHd6glFN+
	vf8LgfiVWNAa49LOMOrBt1vvLEmmdJeMUO/3vE5YOPNTCIMZ5tbsIDEsQTGbwHrw
	uAZJ9M+HxzupxLaLi4CeaTSKhVdceDF4Ok2Cwd8KpePGZTZAxgXCgyPStiE+4af0
	sLJb2LYrt78=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7D8C749E5;
	Tue, 29 Mar 2011 13:34:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6C6D049E4; Tue, 29 Mar 2011
 13:34:07 -0400 (EDT)
In-Reply-To: <7vlizxsv82.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 29 Mar 2011 10:16:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1991038-5A2A-11E0-A87E-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170289>

Do not advertise no-done capability when upload-pack is not serving over
smart-http, as there is no way for this server to know when it should stop
reading in-flight data from the client, even though it is necessary to
drain all the in-flight data in order to unblock the client.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Sorry for the resend...

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
