From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] parse-options: make sure argh string does not have SP or _
Date: Mon, 24 Mar 2014 10:52:05 -0700
Message-ID: <1395683525-2868-4-git-send-email-gitster@pobox.com>
References: <1395481654-5920-1-git-send-email-ilya.bobyr@gmail.com>
 <1395683525-2868-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 18:52:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS92w-00038Z-Ov
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726AbaCXRwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:52:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48637 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753697AbaCXRwT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 13:52:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAD2875B24;
	Mon, 24 Mar 2014 13:52:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=mAAt
	fbfZ14fOCyM1jMjMIKRqIJc=; b=Z0XJO1ulB3yGFYr0mNZDv8AJYa0pDu5hktlx
	NPuu3LkOAyKs6KmM3bWdJ1fGmbxTs5h6NEpvTZWwfttyAoIe00NF7ACM6pyDlQnZ
	Wp5dJLgjeRshrRmgNByYAus2cd8F3rOoZxGXnWpAcBk+S2JnLDC8cXB6OWod18bk
	RSvnIg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Q/OXCL
	NXISrgMSHLGVtKj+6YAyQE6E551wo3t27n8hw4nBgOeby0pOB3l7WxwA5TS2ETpc
	GB6zIeFeFSb7YwihNvYx5VT1JnxV7KFI374fjAcUGKmCwIa/FBDtjIoHiiR8UGEg
	zFG9w2A0NFVITmou1a3RZ8c1IHYK+kInBXHjM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7FEC75B23;
	Mon, 24 Mar 2014 13:52:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 938A375B1F;
	Mon, 24 Mar 2014 13:52:16 -0400 (EDT)
X-Mailer: git-send-email 1.9.1-471-g8d9dec6
In-Reply-To: <1395683525-2868-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 09B19328-B37D-11E3-9A94-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244826>

We encourage to spell an argument hint that consists of multiple
words as a single-token separated with dashes.  In order to help
catching violations added by new callers of parse-options, make sure
argh does not contain SP or _ when the code validates the option
definitions.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index a5fa0b8..c81d3a0 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -375,6 +375,9 @@ static void parse_options_check(const struct option *opts)
 		default:
 			; /* ok. (usually accepts an argument) */
 		}
+		if (opts->argh &&
+		    strcspn(opts->argh, " _") != strlen(opts->argh))
+			err |= optbug(opts, "multi-word argh should use dash to separate words");
 	}
 	if (err)
 		exit(128);
-- 
1.9.1-471-gcccbd8b
