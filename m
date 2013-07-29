From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] "git config --get-urlmatch $section.$key $url"
Date: Mon, 29 Jul 2013 15:49:07 -0700
Message-ID: <1375138150-19520-1-git-send-email-gitster@pobox.com>
References: <7vli4v66b3.fsf@alter.siamese.dyndns.org>
Cc: "Kyle J. McKay" <mackyle@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 30 00:49:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3wFr-0007zT-Te
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 00:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756250Ab3G2WtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 18:49:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45505 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755706Ab3G2WtN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 18:49:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E423340E5;
	Mon, 29 Jul 2013 22:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6hDB
	QIJ7+PqqxdDNlZJNfVFvNlU=; b=ozPAWiTPRfIK8T2cFWA9TIBBDeu2l/xsGj12
	TvsOvWKHA1YWNyPcDQz6LhyuTAlvCDS7lHNUHar4KLlIl89mBBwlwYd+nIphSVZv
	bMH8TWSSfZZa+JK947wd6hP/Wx+f6i+EwHFEBtonmxD5aLLXTCRm2yHlOIz04GD7
	zog7qkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	gEiWblbuBG2qTiDu+xLh5xyB2Ek3ZKRaWwPuSIr/+HUI1dcaQddBlEco99siM85c
	w6DLgYtp96syQ/PzsxCSUl+l9LG9tF4e7mH82lmKs7CARmICFK0RWYUeX+2QY16K
	CHdnt0cfeSTaDvs1rJM+e8/Fy3ugGFYPJ0psLS3VhXw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEA83340E4;
	Mon, 29 Jul 2013 22:49:12 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 350D5340DD;
	Mon, 29 Jul 2013 22:49:12 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc0-137-g17832d4
In-Reply-To: <7vli4v66b3.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 164F4BBC-F8A1-11E2-B6CE-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231334>

So here is a bit of refactoring to extract the logic to find the
entry $section.<urlpattern>.$key from the configuration that best
matches the given $url to answer "what value $section.$key should be
for $url?" out of http.c (primarily because we never want to link
"git cofnig" with the cURL library), and use it from "git config" to
implement Peff's idea to extend "git config".

The first step is a pure code movement, plus some renaming of the
functions.

The second step is to factor out the code to handle --bool, --int, etc.
as a helper so that the new codepath can use it.

The last step currently duplicates the logic in http_options(), but
we might want to refactor it further so that the two functions can
share more code.  We hopefully can get rid of test-url-normalize and
instead use "git config --get-urlmatch" in the tests that protect
the http.<url>.config topic.

Junio C Hamano (3):
  url-match: split out URL matching logic out of http.c
  builtin/config: refactor collect_config()
  config: --get-urlmatch

 Makefile             |   2 +
 builtin/config.c     | 183 ++++++++++++++++---
 http.c               | 500 +--------------------------------------------------
 test-url-normalize.c |   2 -
 url-match.c          | 468 +++++++++++++++++++++++++++++++++++++++++++++++
 url-match.h          |  35 ++++
 6 files changed, 671 insertions(+), 519 deletions(-)
 create mode 100644 url-match.c
 create mode 100644 url-match.h

-- 
1.8.4-rc0-137-g17832d4
