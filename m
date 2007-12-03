From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH] Allow HTTP proxy to be overridden in config
Date: Tue, 04 Dec 2007 10:48:54 +1300
Organization: Catalyst IT (NZ) Ltd
Message-ID: <475479C6.3050506@catalyst.net.nz>
References: <1195776420-22075-1-git-send-email-sam.vilain@catalyst.net.nz>	<7voddl24b7.fsf@gitster.siamese.dyndns.org>	<47464A90.4030509@catalyst.net.nz> <7vhcj387jh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, francois@debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 23:01:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzJML-0000eG-Iy
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 23:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbXLCWBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 17:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbXLCWBa
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 17:01:30 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:56660 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbXLCWB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 17:01:29 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=wilber.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with esmtp (Exim 4.63)
	(envelope-from <samv@wilber.wgtn.cat-it.co.nz>)
	id 1IzJLo-0007CE-Gt; Tue, 04 Dec 2007 11:01:16 +1300
Received: by wilber.wgtn.cat-it.co.nz (Postfix, from userid 1000)
	id 668251FDC0; Tue,  4 Dec 2007 11:01:16 +1300 (NZDT)
FCC: imap://sam.vilain@mail.catalyst.net.nz/INBOX/Sent
X-Identity-Key: id1
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; uuencode=0
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <7vhcj387jh.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66965>

Junio C Hamano wrote:
> In that sense, I think http.proxy configuration variable does not go far
> enough, even though it might be a step in the right direction.  Perhaps
> use your configuration variable http.proxy (or "core.environment") to
> define the global default, with remote.$name.httpproxy to override it?

Sure, why not.

Subject: [PATCH] Add remote.<name>.proxy

As well as allowing a default proxy option, allow it to be set
per-remote.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 Documentation/config.txt |    8 +++++++-
 remote.c                 |    2 ++
 remote.h                 |    5 +++++
 transport.c              |    3 +++
 4 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7e6c02a..831df58 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -545,7 +545,8 @@ access method.
 
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy'
-	environment variable (see gitlink:curl[1]).
+	environment variable (see gitlink:curl[1]).  This can be overridden
+	on a per-remote basis; see remote.<name>.proxy
 
 http.sslVerify::
 	Whether to verify the SSL certificate when fetching or pushing
@@ -695,6 +696,11 @@ remote.<name>.url::
 	The URL of a remote repository.  See gitlink:git-fetch[1] or
 	gitlink:git-push[1].
 
+remote.<name>.proxy::
+	For remotes that require curl (http, https and ftp), the URL to
+	the proxy to use for that remote.  Set to the empty string to
+	disable proxying for that remote.
+
 remote.<name>.fetch::
 	The default set of "refspec" for gitlink:git-fetch[1]. See
 	gitlink:git-fetch[1].
diff --git a/remote.c b/remote.c
index bec2ba1..94df314 100644
--- a/remote.c
+++ b/remote.c
@@ -278,6 +278,8 @@ static int handle_config(const char *key, const char *value)
 	} else if (!strcmp(subkey, ".tagopt")) {
 		if (!strcmp(value, "--no-tags"))
 			remote->fetch_tags = -1;
+	} else if (!strcmp(subkey, ".proxy")) {
+		remote->fetch_refspec = xstrdup(value);
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index 878b4ec..2268558 100644
--- a/remote.h
+++ b/remote.h
@@ -25,6 +25,11 @@ struct remote {
 
 	const char *receivepack;
 	const char *uploadpack;
+
+	/*
+	 * for curl remotes only
+	 */
+	const char *proxy;
 };
 
 struct remote *remote_get(const char *name);
diff --git a/transport.c b/transport.c
index 43b9e7c..c62ec88 100644
--- a/transport.c
+++ b/transport.c
@@ -463,6 +463,9 @@ static struct ref *get_refs_via_curl(const struct transport *transport)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, refs_url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
+	if (transport->remote->proxy) {
+		curl_easy_setopt(slot->curl, CURLOPT_PROXY, transport->remote->proxy);
+	}
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
-- 
1.5.3.5
