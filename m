From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/3] Rename imap-send's internal info/warn functions.
Date: Thu, 21 Dec 2006 19:48:12 -0500
Message-ID: <20061222004812.GA14789@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 01:48:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxYaD-0002vU-4v
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 01:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423163AbWLVAsS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 19:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423165AbWLVAsS
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 19:48:18 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57648 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423163AbWLVAsR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 19:48:17 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GxYZx-0005Oo-BL; Thu, 21 Dec 2006 19:48:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E94DF20FB65; Thu, 21 Dec 2006 19:48:12 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35099>

Because I am about to introduce a global warn() function (much
like the global error function) this global declaration would
conflict with the one supplied by imap-send.  Further since
imap-send's warn function output depends on its Quiet setting
we cannot simply remove its internal definition and use the
forthcoming global one.

So refactor warn() -> imap_warn() and info() -> imap_info()
(the latter was done just to be consistent in naming).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 imap-send.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 894cbbd..ad91858 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -96,8 +96,8 @@ typedef struct {
 
 static int Verbose, Quiet;
 
-static void info( const char *, ... );
-static void warn( const char *, ... );
+static void imap_info( const char *, ... );
+static void imap_warn( const char *, ... );
 
 static char *next_arg( char ** );
 
@@ -297,7 +297,7 @@ buffer_gets( buffer_t * b, char **s )
 }
 
 static void
-info( const char *msg, ... )
+imap_info( const char *msg, ... )
 {
 	va_list va;
 
@@ -310,7 +310,7 @@ info( const char *msg, ... )
 }
 
 static void
-warn( const char *msg, ... )
+imap_warn( const char *msg, ... )
 {
 	va_list va;
 
@@ -903,7 +903,7 @@ imap_open_store( imap_server_conf_t *srvc )
 	/* open connection to IMAP server */
 
 	if (srvc->tunnel) {
-		info( "Starting tunnel '%s'... ", srvc->tunnel );
+		imap_info( "Starting tunnel '%s'... ", srvc->tunnel );
 
 		if (socketpair( PF_UNIX, SOCK_STREAM, 0, a )) {
 			perror( "socketpair" );
@@ -926,31 +926,31 @@ imap_open_store( imap_server_conf_t *srvc )
 
 		imap->buf.sock.fd = a[1];
 
-		info( "ok\n" );
+		imap_info( "ok\n" );
 	} else {
 		memset( &addr, 0, sizeof(addr) );
 		addr.sin_port = htons( srvc->port );
 		addr.sin_family = AF_INET;
 
-		info( "Resolving %s... ", srvc->host );
+		imap_info( "Resolving %s... ", srvc->host );
 		he = gethostbyname( srvc->host );
 		if (!he) {
 			perror( "gethostbyname" );
 			goto bail;
 		}
-		info( "ok\n" );
+		imap_info( "ok\n" );
 
 		addr.sin_addr.s_addr = *((int *) he->h_addr_list[0]);
 
 		s = socket( PF_INET, SOCK_STREAM, 0 );
 
-		info( "Connecting to %s:%hu... ", inet_ntoa( addr.sin_addr ), ntohs( addr.sin_port ) );
+		imap_info( "Connecting to %s:%hu... ", inet_ntoa( addr.sin_addr ), ntohs( addr.sin_port ) );
 		if (connect( s, (struct sockaddr *)&addr, sizeof(addr) )) {
 			close( s );
 			perror( "connect" );
 			goto bail;
 		}
-		info( "ok\n" );
+		imap_info( "ok\n" );
 
 		imap->buf.sock.fd = s;
 
@@ -979,7 +979,7 @@ imap_open_store( imap_server_conf_t *srvc )
 
 	if (!preauth) {
 
-		info ("Logging in...\n");
+		imap_info ("Logging in...\n");
 		if (!srvc->user) {
 			fprintf( stderr, "Skipping server %s, no user\n", srvc->host );
 			goto bail;
@@ -1006,7 +1006,7 @@ imap_open_store( imap_server_conf_t *srvc )
 			fprintf( stderr, "Skipping account %s@%s, server forbids LOGIN\n", srvc->user, srvc->host );
 			goto bail;
 		}
-		warn( "*** IMAP Warning *** Password is being sent in the clear\n" );
+		imap_warn( "*** IMAP Warning *** Password is being sent in the clear\n" );
 		if (imap_exec( ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user, srvc->pass ) != RESP_OK) {
 			fprintf( stderr, "IMAP error: LOGIN failed\n" );
 			goto bail;
-- 
1.4.4.3.ga78a1
