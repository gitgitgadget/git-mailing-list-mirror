From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] rerere: make rr-cache fanout directory honor umask
Date: Mon, 09 Jul 2012 16:28:21 -0700
Message-ID: <7vsjd0ikfe.fsf_-_@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1207061700060.2056@iabervon.org>
 <20120707215029.GA26819@blimp.dmz> <7vobnpn224.fsf@alter.siamese.dyndns.org>
 <20120709225829.GA8397@sigill.intra.peff.net>
 <7v1ukkjzyz.fsf@alter.siamese.dyndns.org>
 <7vwr2cikwa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 10 01:29:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoNNy-0007zC-V5
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 01:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab2GIX2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 19:28:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36027 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560Ab2GIX2X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 19:28:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8012691EA;
	Mon,  9 Jul 2012 19:28:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q0aHAr7J2qctUCD7USKKpwUqtZo=; b=aNQRue
	zoqZUadwmX21yCsSjprFmWubqE9DI41FOpYA0D81HJlISlLZ23vm7FRs6WePSG+J
	pWqQVqiVw+w7fODO81MjaqQniklAMplCENV1kAODQR+/9YJ0cg9uq4jISKx+9Ajd
	jb4bfsH7kf3O3xphQ/TqFdm7licWyBNXNVfXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ULYaxZaq7mLEUzQbh+l9ieaGsDn+uAau
	+PYgcgcVX3gHyNVkZXRjE6UYGgPuRWOiZPxUZch5P4hf4mS6NPAnbVifwKEjxE3/
	2rVSCth89uOGNwEAMEYoMb+2SHlNeswDx770CByAlv6SkHfz8eyPM5BgtBmqqwTc
	Wsjx2dDlIbI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7449891E9;
	Mon,  9 Jul 2012 19:28:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC0F891E7; Mon,  9 Jul 2012
 19:28:22 -0400 (EDT)
In-Reply-To: <7vwr2cikwa.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 09 Jul 2012 16:18:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C65A1AB8-CA1D-11E1-A709-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201234>

This is the last remaining call to mkdir(2) that restricts the permission
bits by passing 0755.  Just use the same mkdir_in_gitdir() used to create
the leaf directories.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rerere.c b/rerere.c
index dcb525a..651c5de 100644
--- a/rerere.c
+++ b/rerere.c
@@ -524,7 +524,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 				continue;
 			hex = xstrdup(sha1_to_hex(sha1));
 			string_list_insert(rr, path)->util = hex;
-			if (mkdir(git_path("rr-cache/%s", hex), 0755))
+			if (mkdir_in_gitdir(git_path("rr-cache/%s", hex)))
 				continue;
 			handle_file(path, NULL, rerere_path(hex, "preimage"));
 			fprintf(stderr, "Recorded preimage for '%s'\n", path);
-- 
1.7.11.1.294.gf7b86df
