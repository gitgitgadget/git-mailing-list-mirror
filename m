From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] daemon: unbreak NO_IPV6 build regression
Date: Tue, 05 May 2015 11:07:12 -0700
Message-ID: <xmqqd22eew4v.fsf_-_@gitster.dls.corp.google.com>
References: <CAK4aQQJ9yT8+Q9jPQ78cauhyPj3j5WmpgrQJ5=cA-ECjaWn8BQ@mail.gmail.com>
	<xmqqioc6ewnw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eduardo Espejo <eduardo.espejo@gmail.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 05 20:07:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YphFj-00081f-4X
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 20:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761150AbbEESHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 14:07:19 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756055AbbEESHP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 14:07:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E64604DEAD;
	Tue,  5 May 2015 14:07:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z6II1HMDrVhGy60z61Ci8KNViBM=; b=whFrF4
	o/ZWkSPr5iVwP1kwr5Ma7f4v85LkUpflyUkXkNbTYjsNjBFe1n2dGUJBlds9GSI2
	eu6ioob/MiLQZc1yg94FBRL9s40Rf0P+HBOp0Kn+2i/tTVxUXavPQJ3zrAnfhMKX
	dvIB48aW4VGdcGhOn+GtGDATmduyb/Ocl4PaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=itPmjf52F6tsEubG4xJtSAesdMPZ9UXn
	qUNhMOVLJqg+Yawn9ajOqv8ESm9/F6Oca8J6LJGtyJ6SWbMvhIm3xBSnsZwFFl2+
	yNU2BFfbscQZ57cGyUFG191t8xm6RydJ85WBc8QFmMPYEHa1j+msjJleh0aG4LQ4
	ldj3X81qCfg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD24E4DEAB;
	Tue,  5 May 2015 14:07:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FAAC4DEAA;
	Tue,  5 May 2015 14:07:14 -0400 (EDT)
In-Reply-To: <xmqqioc6ewnw.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 05 May 2015 10:55:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8EDE9932-F351-11E4-BC8E-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268410>

When 01cec54e (daemon: deglobalize hostname information, 2015-03-07)
wrapped the global variables such as hostname inside a struct, it
forgot to convert one location that spelled "hostname" that needs to
be updated to "hi->hostname".

This was inside NO_IPV6 block, and was not caught by anybody.

Reported by: Eduardo Espejo
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/daemon.c b/daemon.c
index 9ee2187..4be1091 100644
--- a/daemon.c
+++ b/daemon.c
@@ -633,7 +633,7 @@ static void lookup_hostname(struct hostinfo *hi)
 		char **ap;
 		static char addrbuf[HOST_NAME_MAX + 1];
 
-		hent = gethostbyname(hostname.buf);
+		hent = gethostbyname(hi->hostname.buf);
 		if (hent) {
 			ap = hent->h_addr_list;
 			memset(&sa, 0, sizeof sa);
-- 
2.4.0-311-gf1d9b8d
