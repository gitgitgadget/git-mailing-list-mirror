From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Escape file:// URL's to meet subversion SVN::Ra requirements
Date: Sat, 17 Dec 2011 18:48:23 -0500
Message-ID: <1324165694-sup-8940@pinkfloyd.chass.utoronto.ca>
References: <1320251895-6348-1-git-send-email-bwalton@artsci.utoronto.ca> <1320251895-6348-2-git-send-email-bwalton@artsci.utoronto.ca> <20111217095019.GC8845@elie.hsd1.il.comcast.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: GIT List <git@vger.kernel.org>, normalperson@yhbt.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 18 01:36:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rc4kD-0006vI-0R
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 01:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133Ab1LRAgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 19:36:45 -0500
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:47450 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058Ab1LRAgo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 19:36:44 -0500
X-Greylist: delayed 2900 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Dec 2011 19:36:44 EST
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:42730 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Rc3zL-0006Le-HB; Sat, 17 Dec 2011 18:48:23 -0500
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Rc3zL-0005JA-G7; Sat, 17 Dec 2011 18:48:23 -0500
In-reply-to: <20111217095019.GC8845@elie.hsd1.il.comcast.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187408>

Excerpts from Jonathan Nieder's message of Sat Dec 17 04:50:19 -0500 2011:

Hi Jonathan,

Thanks for following up on this.  I've intermittently spent time
digging away at it but other than a few poorly placed fixes that
allowed me to get further into the test suite before failure, I
haven't found a workable fix yet.  I've included my wip patch below as
it may help others that are more familiar with the workings of git-svn
isolate a nice clean place to solve the problem.

> The bad effect is that it converts percent signs to %25.  So
> commands like "git svn clone file:///path/to/test%20repository" that
> previously worked might not work any more, if v1.6.5-rc0~61 (svn:
> assume URLs from the command-line are URI-encoded, 2009-08-16) did
> not do its job completely.

I wonder if simply doing a uri decode followed by a uri encode might
work?  That would decode things that already had some encoding and
then re-encode everything to handle a mixed encodings...I really think
that the svn code should take 'raw' strings and encode internally but
that ship has sailed.

> Another possible approach: to imitate the svn command line tools, we
> could use SVN::Client::url_from_path in some appropriate place.

I've been looking at these functions too.

Thanks
-Ben

>From 98a6b6b4f26a644db5089fce68be6cf7261e4fe1 Mon Sep 17 00:00:00 2001
From: Ben Walton <bwalton@opencsw.org>
Date: Wed, 9 Nov 2011 02:39:05 +0100
Subject: [PATCH] selectively use svn functions to sanitize urls

Signed-off-by: Ben Walton <bwalton@opencsw.org>
---
 git-svn.perl |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 351e743..fb1ce65 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1342,9 +1342,13 @@ sub escape_uri_only {
 
 sub escape_url {
 	my ($url) = @_;
-	if ($url =~ m#^([^:]+)://([^/]*)(.*)$#) {
-		my ($scheme, $domain, $uri) = ($1, $2, escape_uri_only($3));
-		$url = "$scheme://$domain$uri";
+	if ($SVN::Core::VERSION =~ /^1\.[0-6]/) {
+		if ($url =~ m#^([^:]+)://([^/]*)(.*)$#) {
+			my ($scheme, $domain, $uri) = ($1, $2, escape_uri_only($3));
+			$url = "$scheme://$domain$uri";
+		}
+	} else {
+		$url = SVN::_Core::svn_uri_canonicalize($url);
 	}
 	$url;
 }
@@ -2222,7 +2226,7 @@ sub init_remote_config {
 					     "$url => $min_url\n";
 			}
 			my $old_path = $self->{path};
-			$self->{path} = $url;
+			$self->{path} = SVN::_Core::svn_uri_canonicalize($url);
 			$self->{path} =~ s!^\Q$min_url\E(/|$)!!;
 			if (length $old_path) {
 				$self->{path} .= "/$old_path";
@@ -5363,9 +5367,13 @@ sub escape_uri_only {
 
 sub escape_url {
 	my ($url) = @_;
-	if ($url =~ m#^(https?)://([^/]+)(.*)$#) {
-		my ($scheme, $domain, $uri) = ($1, $2, escape_uri_only($3));
-		$url = "$scheme://$domain$uri";
+	if ($SVN::Core::VERSION =~ /^1\.[0-6]/) {
+		if ($url =~ m#^(https?)://([^/]+)(.*)$#) {
+			my ($scheme, $domain, $uri) = ($1, $2, escape_uri_only($3));
+			$url = "$scheme://$domain$uri";
+		}
+	} else {
+		$url = SVN::_Core::svn_uri_canonicalize($url);
 	}
 	$url;
 }
-- 
1.7.6.1
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
