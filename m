From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 1/6] http.c: fix parsing of http.sslCertPasswordProtected variable
Date: Wed, 31 Jul 2013 12:26:03 -0700
Message-ID: <1375298768-7740-2-git-send-email-gitster@pobox.com>
References: <1375298768-7740-1-git-send-email-gitster@pobox.com>
Cc: "Kyle J. McKay" <mackyle@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 21:26:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4c2Y-0006Sv-Gz
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 21:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760277Ab3GaT0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 15:26:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35297 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757320Ab3GaT0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 15:26:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB75B35798;
	Wed, 31 Jul 2013 19:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=4+Xd
	wadNh6LvaiH527fQ/DxhTIg=; b=Ycf7VwxXIbeqg9UyX/1F/bBzJABB6lkhCRCB
	jAmP0C8G4JKaonRB3yf6rkkfy+E77/IAQzrD7qA5SMJp0IPrmF7n/lJ0uCIfXd6d
	6MY9D+fdWP1xJv6hf8MLaMulhs6Y/k26v6bXRPaZkVyfoiI2SoRTZheiJqbw17Mw
	d/CMNyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	lsqsP+Bpx+gCca+/bBntoxf2O76jT25BRXEE3X4jXe8iRC6MTKZLjbLwKXRl3H90
	4y5rtPxT8eF3Hq0BAN+lNTpfAAGOLawEq1falQtBUQV/wAX5S8hA5nNmrJTHeqeK
	sSTe0MPMOgNAa4XKSfe01I37QpxcgiU1hzBQUpc/reA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 227B935797;
	Wed, 31 Jul 2013 19:26:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1B2B35792;
	Wed, 31 Jul 2013 19:26:13 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc0-153-g9820077
In-Reply-To: <1375298768-7740-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1045163A-FA17-11E2-800D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231444>

The existing code triggers only when the configuration variable is
set to true.  Once the variable is set to true in a more generic
configuration file (e.g. ~/.gitconfig), it cannot be overriden to
false in the repository specific one (e.g. .git/config).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 92aba59..37986f8 100644
--- a/http.c
+++ b/http.c
@@ -160,8 +160,7 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.sslcainfo", var))
 		return git_config_string(&ssl_cainfo, var, value);
 	if (!strcmp("http.sslcertpasswordprotected", var)) {
-		if (git_config_bool(var, value))
-			ssl_cert_password_required = 1;
+		ssl_cert_password_required = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp("http.ssltry", var)) {
-- 
1.8.4-rc0-153-g9820077
