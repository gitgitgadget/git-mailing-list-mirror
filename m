From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 0/6] http.<url>.<key> and friends
Date: Wed, 31 Jul 2013 12:26:02 -0700
Message-ID: <1375298768-7740-1-git-send-email-gitster@pobox.com>
Cc: "Kyle J. McKay" <mackyle@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 21:26:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4c2M-0006LE-GV
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 21:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757390Ab3GaT0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 15:26:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58861 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757320Ab3GaT0N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 15:26:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B32723578C;
	Wed, 31 Jul 2013 19:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=vO+OvH2yDI2F/GV1EuGWNECCFs8
	=; b=ujTO1GjhFffSEzarCTRFklLD1aDoDHB1puQF4o0iYxpNf4mbJDQsUIk9etD
	FJlhAgpmJ2hGjqAIE7GkU2CiEUKhnx26+ZRgVHPo20Tkmd1/dOcyIjhwhWw4b93o
	R95sypNDNErogSfQpN1tDsvMKL2oLXB2YcRDobKIzT2E995Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=bQJqI6eOaq+bCDZeLGwNL
	Eb8o3EankTW0zQhQKjKnCu7yw6eFWsrNc7XWZEQSBNKOPhneYqotzo7Z0raERJiO
	IqE5ErEhsOIpycfvMXfzuom5jQ5zt3V4KMMIDxwaZeHJGtn4fcEvlameuIh6W779
	Nmm1a1vu1v/XV7/lsXh22M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 999FE3578A;
	Wed, 31 Jul 2013 19:26:12 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22F4735787;
	Wed, 31 Jul 2013 19:26:10 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc0-153-g9820077
X-Pobox-Relay-ID: 0E761D68-FA17-11E2-A756-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231443>

This is my attempt to reroll Kyle's http.<url>.<key> series.

It adds a general <section>.<url>.<key> support at the
infrastructure level and then rebuild http.<url>.<key> support on
top of it.  A useful side effect of doing it this way is that it
avoids having to touch the two-name parser http_options() at all.

The same infrastructure is used to add "--get-urlmatch" mode to "git
config", so that scripted Porcelains can use the same mechanism to
ask for the value for <section>.<key> variable with a URL, and learn
the value for <section>.<url>.<key> whose <url> part best matches
the given URL.  In a sense, the infrastructure makes <section>.<key>
a "virtual" variable that is customized for URL.

 * Patch 1/6 is unchanged.

 * Patch 2/6 is to add only the two helpers url_normalize and
   match_urls from the original series by Kyle.

 * Patch 3/6 is the general <section>.<url>.<key> support.  The
   urlmatch_config_entry() wrapper can use existing two-name parser
   to implement "virtual" <section>.<key> variables.

 * Patch 4/6 is the rest of Kyle's http.<url>.<key> ported on top of
   the infrastructure.

 * Patch 5/6 is unchanged from the previous round.

 * Patch 6/6 teaches "--get-urlmatch" to "git config"; this time it
   adds tests and docs.

Junio C Hamano (4):
  http.c: fix parsing of http.sslCertPasswordProtected variable
  config: add generic callback shim to parse section.<url>.key
  builtin/config: refactor collect_config()
  config: "git config --get-urlmatch" parses section.<url>.key

Kyle J. McKay (2):
  config: add helper to normalize and match URLs
  config: parse http.<url>.<variable> using urlmatch

 .gitignore                   |   1 +
 Documentation/config.txt     |  44 ++++
 Documentation/git-config.txt |  29 +++
 Makefile                     |   7 +
 builtin/config.c             | 134 +++++++++--
 http.c                       |  16 +-
 t/.gitattributes             |   1 +
 t/t1300-repo-config.sh       |  25 ++
 t/t5200-url-normalize.sh     | 199 ++++++++++++++++
 t/t5200/README               | Bin 0 -> 644 bytes
 t/t5200/config-1             | Bin 0 -> 180 bytes
 t/t5200/config-2             | Bin 0 -> 80 bytes
 t/t5200/config-3             | Bin 0 -> 118 bytes
 t/t5200/url-1                | Bin 0 -> 20 bytes
 t/t5200/url-10               | Bin 0 -> 23 bytes
 t/t5200/url-11               | Bin 0 -> 25 bytes
 t/t5200/url-2                | Bin 0 -> 20 bytes
 t/t5200/url-3                | Bin 0 -> 23 bytes
 t/t5200/url-4                | Bin 0 -> 23 bytes
 t/t5200/url-5                | Bin 0 -> 23 bytes
 t/t5200/url-6                | Bin 0 -> 23 bytes
 t/t5200/url-7                | Bin 0 -> 23 bytes
 t/t5200/url-8                | Bin 0 -> 23 bytes
 t/t5200/url-9                | Bin 0 -> 23 bytes
 test-url-normalize.c         | 137 +++++++++++
 urlmatch.c                   | 535 +++++++++++++++++++++++++++++++++++++++++++
 urlmatch.h                   |  54 +++++
 27 files changed, 1158 insertions(+), 24 deletions(-)
 create mode 100755 t/t5200-url-normalize.sh
 create mode 100644 t/t5200/README
 create mode 100644 t/t5200/config-1
 create mode 100644 t/t5200/config-2
 create mode 100644 t/t5200/config-3
 create mode 100644 t/t5200/url-1
 create mode 100644 t/t5200/url-10
 create mode 100644 t/t5200/url-11
 create mode 100644 t/t5200/url-2
 create mode 100644 t/t5200/url-3
 create mode 100644 t/t5200/url-4
 create mode 100644 t/t5200/url-5
 create mode 100644 t/t5200/url-6
 create mode 100644 t/t5200/url-7
 create mode 100644 t/t5200/url-8
 create mode 100644 t/t5200/url-9
 create mode 100644 test-url-normalize.c
 create mode 100644 urlmatch.c
 create mode 100644 urlmatch.h

-- 
1.8.4-rc0-153-g9820077
