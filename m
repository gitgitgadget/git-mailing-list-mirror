From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] http.c: fix parsing of http.sslCertPasswordProtected variable
Date: Fri, 12 Jul 2013 11:52:47 -0700
Message-ID: <7v38rjlif4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 20:52:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxiSc-0005HQ-Kg
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 20:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180Ab3GLSwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 14:52:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39054 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965173Ab3GLSwu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 14:52:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81F92307FD;
	Fri, 12 Jul 2013 18:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=t
	KrBLULZrPJa7ve9Z8kR8FaCcCY=; b=s64p0fjmmzpWZ/1SUEqN/LO4KgFArrwDJ
	7wFGesLXDee4r0SDPcsW9U4XYQtBAql7KDsSfVwto5ZSLjID8MSFefgv1qah7uPS
	hAl2ZNVoC0ZwXNKG61siftFgcuxhaNqJFVdjUlASCA1ZTW1rwI/MKaSfCrP43J8v
	WQ8NHnMAEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=FnHYW/kpkojF5B49h2jF8hLWnc296tUKrgcg17sYp494KVwejb6MO2r/
	P1DVhAi5iDRBxrw8gsF4Qm9SC3903Hm+id+yjkCqDciymlBJ3CBeUl7tfxrJ/o8f
	rz/khmRMskbSujPZ5w+p9Fqd2Mt8VrLRc13f0oLmPe8LMkoArW0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 761FB307FC;
	Fri, 12 Jul 2013 18:52:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9E15307FA;
	Fri, 12 Jul 2013 18:52:48 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F4012B6-EB24-11E2-A208-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230237>

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
1.8.3.2-942-gc84dfcb
