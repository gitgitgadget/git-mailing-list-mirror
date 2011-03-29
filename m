From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] enable "no-done" extension only when fetching over
 smart-http
Date: Tue, 29 Mar 2011 10:16:29 -0700
Message-ID: <7vlizxsv82.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 19:16:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4cX5-0005h4-GG
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 19:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016Ab1C2RQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 13:16:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52768 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006Ab1C2RQj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 13:16:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8E7C047DD;
	Tue, 29 Mar 2011 13:18:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=f
	AxorNqwzXaIl6/KV2T0X70vxpM=; b=T/rRrv06uFHlR0RoWRbSIDYnWpNjMFZys
	TiY0KUBFY27UJW2jypoJuNIzC+VyBQd+XHSPH31npzE092rY9EgHPa2jVQTeZhs5
	0zjoQ+UfHOalwQXZ7nfOCQpNXddNHKCptOzcJm43kb9TbMIPERrKyXEymIct6N+l
	ha01Mddb5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=by+ftsxpYU6Lv3W9fvRgzWaTsy7yD2l/Pz992tT6c/vXAKoAFfy+pCxS
	BekCQmV/3t4EbMWiN8wl9+a7LidxtPkzzonCJJfZsLb58k38PrurpiIRGaNYlh76
	gOzj1U9E84T7eP7jF9SrsFb06yPiuqmZTR4LJFyUpaJPNXGze8k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B9C247DB;
	Tue, 29 Mar 2011 13:18:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5DF8D47DA; Tue, 29 Mar 2011
 13:18:17 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B4FBED4-5A28-11E0-A2F3-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170282>

When 'no-done' protocol extension is used, the upload-pack (i.e. the
server side) process stops listening to the fetch-pack after issuing the
final NAK, and starts sending the generated pack data back, but there may
be more "have" send by the latter in flight that the fetch-pack is
expecting to be responded with ACK/NAK.  This will typically result in a
deadlock (both will block on write that the other end never reads) or
SIGPIPE on the fetch-pack end (upload-pack will finish writing a small
pack and goes away).

Disable it unless fetch-pack is running under smart-http, where there is
no such streaming issue.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch-pack.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 59fbda5..52707a8 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -708,7 +708,8 @@ static struct ref *do_fetch_pack(int fd[2],
 		if (server_supports("no-done")) {
 			if (args.verbose)
 				fprintf(stderr, "Server supports no-done\n");
-			no_done = 1;
+			if (args.stateless_rpc)
+				no_done = 1;
 		}
 	}
 	else if (server_supports("multi_ack")) {
