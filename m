From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH] builtin-rerere: fix a small leak
Date: Tue, 17 Jun 2008 00:23:31 -0700
Message-ID: <7vk5go7cek.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 17 09:24:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8VYU-0005Vz-Lq
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 09:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbYFQHXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 03:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753636AbYFQHXo
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 03:23:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542AbYFQHXo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 03:23:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B7D1F235B9;
	Tue, 17 Jun 2008 03:23:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EBF17235B8; Tue, 17 Jun 2008 03:23:38 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 50835BD6-3C3E-11DD-A1E7-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85273>

The data read from MERGE_RR file is kept in path-list by hanging textual
40-byte conflict signature to path of the blob that contains the
conflict.  The signature is strdup'ed twice, and the second copy is given
to the path-list, leaking the first copy.

Signed-off-by: Junio C Hamano <junio@pobox.com>
---
 * Am I overlooking something obvious, or is this simply a never-reviewed
   buglet that nobody has noticed for a long time?

 builtin-rerere.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index 5c81142..85222d9 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -43,7 +43,7 @@ static void read_rr(struct path_list *rr)
 			; /* do nothing */
 		if (i == sizeof(buf))
 			die("filename too long");
-		path_list_insert(buf, rr)->util = xstrdup(name);
+		path_list_insert(buf, rr)->util = name;
 	}
 	fclose(in);
 }
