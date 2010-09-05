From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH] Add ERR support to smart HTTP
Date: Sun,  5 Sep 2010 20:30:15 +0300
Message-ID: <1283707815-32038-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 19:28:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsJ0o-0005pd-7v
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 19:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab0IER2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 13:28:08 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:53101 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589Ab0IER2H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 13:28:07 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id CC4B918CEC6
	for <git@vger.kernel.org>; Sun,  5 Sep 2010 20:28:05 +0300 (EEST)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A024C6A5CC3; Sun, 05 Sep 2010 20:28:05 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id B094A27D84
	for <git@vger.kernel.org>; Sun,  5 Sep 2010 20:28:04 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155464>

All "true smart transports" support ERR packets, allowing server
to send back error message explaining reasons for refusing the
request instead of just rudely closing connection without any error.

However, since smart HTTP isn't "true smart transport", but instead
dumb one from git main executable perspective, smart HTTP needs to
implement its own version of this.

Now that Gitolite supports HTTP too, it needs to be able to send
error messages for authorization failures back to client so that's
one probable user for this feature.

The error is sent as '<packetlength># ERR <message>" and must be the
first packet in response. The reason for putting the '#' there is that
old git versions will interpret that as invalid server response and
print (at least the first line of) the error together with complaint
of invalid response (mangling it a bit but it will still be understandable,
in manner similar to existing smart transport ERR messages).

Thus for example server response:

"0031# ERR W access for foo/alice/a1 DENIED to bob"

Will cause the following to be printed:

"fatal: remote error: W access for foo/alice/a1 DENIED to bob"

If the git version is old and doesn't support this feature, then the
message will be:

"fatal: invalid server response; got '# ERR W access for foo/alice/a1
DENIED to bob'"

Which is at least undertandable.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 remote-curl.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 24fbb9a..46fa971 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -153,6 +153,8 @@ static struct discovery* discover_refs(const char *service)
 
 		if (packet_get_line(&buffer, &last->buf, &last->len) <= 0)
 			die("%s has invalid packet header", refs_url);
+		if (buffer.len >= 6 && !strncmp(buffer.buf, "# ERR ", 6))
+			die("remote error: %s", buffer.buf + 6);
 		if (buffer.len && buffer.buf[buffer.len - 1] == '\n')
 			strbuf_setlen(&buffer, buffer.len - 1);
 
-- 
1.7.2.4.g27652
