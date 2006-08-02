From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: require $ENV{'GITWEB_CONFIG'}
Date: Wed, 02 Aug 2006 13:58:33 -0700
Message-ID: <7vhd0uua6e.fsf@assigned-by-dhcp.cox.net>
References: <20060802192333.GA30861@coredump.intra.peff.net>
	<E1G8NLU-0006TL-J7@moooo.ath.cx>
	<20060802205033.GB15678@sigio.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 22:58:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8NnZ-000413-F1
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 22:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWHBU6f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 16:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWHBU6f
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 16:58:35 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:58321 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932086AbWHBU6e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 16:58:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060802205834.SOQ6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Aug 2006 16:58:34 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060802205033.GB15678@sigio.intra.peff.net> (Jeff King's
	message of "Wed, 2 Aug 2006 16:50:33 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24688>

Jeff King <peff@peff.net> writes:

> I think this patch is a good idea, but it seems confusing to have two
> Maybe the environment should trump the built-in
> default:
>   our $GITWEB_CONFIG = $ENV{GITWEB_CONFIG} || '@@GITWEB_CONFIG@@';
> which actually might be a reasonable thing for all of the config
> directives (so people can use a config file, apache environment munging,
> or the built-in defaults).

Sounds very sane.  So Matthias's patch now becomes something
like this:

-- >8 --
diff --git a/gitweb/README b/gitweb/README
index b91d42a..dc4b850 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -23,6 +23,11 @@ You can specify the following configurat
    Points to the location where you put gitweb.css on your web server.
  * GITWEB_LOGO
    Points to the location where you put git-logo.png on your web server.
+ * GITWEB_CONFIG
+   This file will be loaded using 'require'.  If the environment
+   $GITWEB_CONFIG is set when gitweb.cgi is executed the file in the
+   environment variable will be loaded instead of the file
+   specified when gitweb.cgi was created.
 
 Originally written by:
   Kay Sievers <kay.sievers@vrfy.org>
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d5b2de8..c7f13e7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -63,6 +63,6 @@ our $mimetypes_file = undef;
-our $GITWEB_CONFIG = "@@GITWEB_CONFIG@@";
+our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "@@GITWEB_CONFIG@@";
 require $GITWEB_CONFIG if -e $GITWEB_CONFIG;
 
 # version of the core git binary
 our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
