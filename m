From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v2 00/16] Return of smart HTTP
Date: Mon, 12 Oct 2009 19:24:59 -0700
Message-ID: <1255400715-10508-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 04:34:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxXD7-0004cs-IA
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 04:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758815AbZJMCZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 22:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758812AbZJMCZx
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 22:25:53 -0400
Received: from george.spearce.org ([209.20.77.23]:35580 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbZJMCZx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 22:25:53 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C5416380E7; Tue, 13 Oct 2009 02:25:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00,
	WEIRD_PORT autolearn=no version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4839D380E7
	for <git@vger.kernel.org>; Tue, 13 Oct 2009 02:25:16 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130103>

The series has gotten a lot larger since my last posting, but I have
what appears to be a fully working client *AND* server implementation
for both fetch and push, and the client should be supporting deeping
shallow repositories over the smart variant of HTTP.

I've dropped the documentation patch from the series for now as
I have quite a few edits queued up from folks in the last round
(thanks for those!) that I have not yet applied.  So there is no
point in sending that particular patch again.

This series is still lacking:

* The HTTP protocol documentation
* Manual page for git-http-backend
* Tests for the smart http transport code (existing tests pass)
* ack from the CC'd maintainers  :-)

For those who are really curious, this applies to 'master' and I'm
running my local server under Apache with this as my configuration:

 -- httpd.conf <8--
 LoadModule cgi_module /usr/libexec/apache2/mod_cgi.so
 LoadModule alias_module /usr/libexec/apache2/mod_alias.so
 LoadModule env_module /usr/libexec/apache2/mod_env.so

 Listen 127.0.0.1:8079

 ServerRoot /home/spearce/test
 ErrorLog error_log
 PidFile httpd.pid
 LockFile httpd.lock

 <IfModule mime_module>
 TypesConfig /etc/mime.types
 </IfModule>

 DocumentRoot /home/spearce/test/www

 SetEnv GIT_EXEC_PATH /home/spearce/cgit
 ScriptAlias /git/ /home/spearce/cgit/git-http-backend/
 --<8--

 $ httpd -f httpd.conf
 $ git clone --bare foo.git /home/spearce/test/www/test.git

 URL is ... http://localhost:8070/git/test.git


Shawn O. Pearce (16):
  pkt-line: Add strbuf based functions
  pkt-line: Make packet_read_line easier to debug
  fetch-pack: Use a strbuf to compose the want list
  Move "get_ack()" back to fetch-pack
  Add multi_ack_2 capability to fetch-pack/upload-pack
  remote-curl: Refactor walker initialization
  remote-helpers: Fetch more than one ref in a batch
  remote-helpers: Support custom transport options
  Move WebDAV HTTP push under remote-curl
  Git-aware CGI to provide dumb HTTP transport
  Add one shot RPC options to upload-pack, receive-pack
  Smart fetch and push over HTTP: server side
  Discover refs via smart HTTP server when available
  Smart push over HTTP: client side
  Smart fetch over HTTP: client side
  Smart HTTP fetch: gzip requests

 .gitignore                           |    1 +
 Documentation/config.txt             |    8 +
 Documentation/git-remote-helpers.txt |   79 ++++
 Makefile                             |    1 +
 builtin-fetch-pack.c                 |  210 ++++++++--
 builtin-receive-pack.c               |   26 +-
 builtin-send-pack.c                  |  116 +++++-
 cache.h                              |    1 -
 commit.c                             |   10 +-
 commit.h                             |    2 +-
 connect.c                            |   21 -
 fetch-pack.h                         |    3 +-
 http-backend.c                       |  451 +++++++++++++++++++++
 http-push.c                          |   43 ++-
 pkt-line.c                           |   83 ++++-
 pkt-line.h                           |    4 +
 remote-curl.c                        |  729 +++++++++++++++++++++++++++++++--
 send-pack.h                          |    3 +-
 sideband.c                           |   11 +-
 transport-helper.c                   |  264 ++++++++++++-
 transport.c                          |   32 +--
 upload-pack.c                        |   71 +++-
 22 files changed, 1955 insertions(+), 214 deletions(-)
 create mode 100644 http-backend.c
