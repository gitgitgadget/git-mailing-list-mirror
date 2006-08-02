From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Wed, 2 Aug 2006 12:53:33 -0400
Message-ID: <20060802165333.GA22726@coredump.intra.peff.net>
References: <20060801225352.26998.qmail@web31801.mail.mud.yahoo.com> <7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net> <1154535801.19994.15.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Luben Tuikov <ltuikov@yahoo.com>,
	Git List <git@vger.kernel.org>,
	Martin Waitz <tali@admingilde.org>,
	Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Wed Aug 02 18:53:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8JyW-0000hV-30
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 18:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWHBQxh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 12:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWHBQxh
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 12:53:37 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3983 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751232AbWHBQxg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 12:53:36 -0400
Received: (qmail 7567 invoked from network); 2 Aug 2006 12:52:59 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 2 Aug 2006 12:52:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed,  2 Aug 2006 12:53:33 -0400
To: Jon Loeliger <jdl@freescale.com>
Content-Disposition: inline
In-Reply-To: <1154535801.19994.15.camel@cashmere.sps.mot.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24657>

On Wed, Aug 02, 2006 at 11:23:22AM -0500, Jon Loeliger wrote:

> With this "params in config.mk" approach, I have to
> run it multiple times, once for each web server I run.
>
> I _really_ would prefer an "include from ." feature
> where I can place the specific gitweb_config.pm parts
> in the same directory where gitweb.{pl,cgi} is installed.

Why don't we have sensible compile-time defaults that can be overridden
by a run-time config file like every other sane program? For those who
are opposed to the run-time config, they can simply not have a config
file.

See the (completely untested) patch below. Obviously the config file
name has to be set at build time. However, since it is interpolated by
perl, you can do clever things like:
  /etc/gitweb/$ENV{MY_VIRTUAL_HOST}.pl

-Peff

---
 Makefile           |    2 ++
 gitweb/gitweb.perl |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 2562a2c..170d082 100644
--- a/Makefile
+++ b/Makefile
@@ -127,6 +127,7 @@ GIT_PYTHON_DIR = $(prefix)/share/git-cor
 # DESTDIR=
 
 # default configuration for gitweb
+GITWEB_CONFIG = gitweb_config.perl
 GITWEB_SITENAME =
 GITWEB_PROJECTROOT = /pub/git
 GITWEB_LIST =
@@ -629,6 +630,7 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 	    -e 's|@@GIT_VERSION@@|$(GIT_VERSION)|g' \
 	    -e 's|@@GIT_BINDIR@@|$(bindir)|g' \
+	    -e 's|@@GITWEB_CONFIG@@|$(GITWEB_CONFIG)|g' \
 	    -e 's|@@GITWEB_SITENAME@@|$(GITWEB_SITENAME)|g' \
 	    -e 's|@@GITWEB_PROJECTROOT@@|$(GITWEB_PROJECTROOT)|g' \
 	    -e 's|@@GITWEB_LIST@@|$(GITWEB_LIST)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1db1414..cc33d97 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -66,6 +66,9 @@ # file to use for guessing MIME types be
 # (relative to the current git repository)
 our $mimetypes_file = undef;
 
+our $GITWEB_CONFIG = "@@GITWEB_CONFIG@@";
+require $GITWEB_CONFIG if -e $GITWEB_CONFIG;
+
 # input validation and dispatch
 our $action = $cgi->param('a');
 if (defined $action) {
-- 
1.4.2.rc2.g59706-dirty
