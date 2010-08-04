From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git instaweb + webrick does not work
Date: Wed, 4 Aug 2010 10:25:45 +0000
Message-ID: <20100804102545.GA32128@dcvr.yhbt.net>
References: <1272BF62-A0C8-4940-9472-E46C05BF1723@gmail.com> <m34ofbpcyr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Dippery <mdippery@gmail.com>, git@vger.kernel.org,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Mike Dalessio <mike@csa.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 12:25:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgbAa-0005qV-0D
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 12:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313Ab0HDKZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 06:25:48 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34306 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932295Ab0HDKZq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 06:25:46 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B46C1F761;
	Wed,  4 Aug 2010 10:25:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <m34ofbpcyr.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152572>

Jakub Narebski <jnareb@gmail.com> wrote:
> Michael Dippery <mdippery@gmail.com> writes:
> > I _do_ have webrick. Asking around a bit, I was told the the problem
> > may have been introduced in commit be5347b. Is this so? If not, any
> > other ideas on what may be causing the problem?
> 
> To be more exact commit be5347b (git-instaweb: Put httpd logs in a
> "$httpd_only" subdirectory, 2010-05-28) by Pavan Kumar Sunkara added
> resolve_full_httpd before running *_config (webrick_config in this
> case).  But resolve_full_httpd() beside setting $httpd_only needed
> later for functionality provided by this commit, does also setting
> $full_httpd and checking if given web server can be run.
> 
> The `webrick' support in git-instaweb is peculiar in that webrick_conf
> creates 'webrick' shell script in "$GIT_DIR/gitweb/".  The code that
> checks if web server is available in resolve_full_httpd() searches
> also in "$GIT_DIR/gitweb/"... but it is run before webrick_conf
> function in git-instaweb has a chance to generate 'webrick' script.

I wouldn't mind making it more like what we do with plackup and
having a single Ruby script, eventually.

> The solution would be to either split resolve_full_httpd() into one
> function generating $httpd and $httpd_only, and second function
> generating $full_httpd and checing for web server existence, or create
> a separate check for 'webrick'.

I just split out the check and started modelling things after the code
for plackup.  Unfortunately, I haven't had any luck getting gitweb.cgi
to respect $GITWEB_CONFIG environment with webrick so the following
patch just ensures webrick is properly started, not useful.

Unfortunately I'm barely awake now, but I'll revisit this in ~16 hours
if nobody beats me to it.

>From 70b1773fc0bcb550788b26f2fda6ad6423960115 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Wed, 4 Aug 2010 09:51:25 +0000
Subject: [PATCH] instaweb: fix webrick server startup

This has been broken since commit be5347b
("httpd logs in a "$httpd_only" subdirectory")

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-instaweb.sh |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index b7342e2..1282395 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -57,6 +57,13 @@ resolve_full_httpd () {
 		httpd_only="${httpd%% *}" # cut on first space
 		return
 		;;
+	*webrick*)
+		# server is started by running via generated gitweb.rb in
+		# $fqgitdir/gitweb
+		full_httpd="$fqgitdir/gitweb/webrick.sh"
+		httpd_only="${httpd%% *}" # cut on first space
+		return
+		;;
 	esac
 
 	httpd_only="$(echo $httpd | cut -f1 -d' ')"
@@ -209,11 +216,11 @@ EOF
 	# which assumes _ruby_ is in the user's $PATH. that's _one_
 	# portable way to run ruby, which could be installed anywhere,
 	# really.
-	cat >"$fqgitdir/gitweb/$httpd" <<EOF
+	cat >"$fqgitdir/gitweb/$httpd.sh" <<EOF
 #!/bin/sh
 exec ruby "$fqgitdir/gitweb/$httpd.rb" \$*
 EOF
-	chmod +x "$fqgitdir/gitweb/$httpd"
+	chmod +x "$fqgitdir/gitweb/$httpd.sh"
 
 	cat >"$conf" <<EOF
 :Port: $port
-- 
Eric Wong
