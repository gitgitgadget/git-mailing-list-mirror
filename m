From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 2/1] fixup! git-svn: use YAML format for mergeinfo cache
 when possible
Date: Sun, 27 May 2012 14:48:22 -0500
Message-ID: <20120527194822.GA31460@burratino>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
 <20110823081546.GA28091@dcvr.yhbt.net>
 <7vobzgrrbg.fsf@alter.siamese.dyndns.org>
 <20120527192541.GA29490@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, Jason Gross <jgross@MIT.EDU>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 27 21:48:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYjSD-0005ld-G5
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 21:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538Ab2E0Tsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 15:48:37 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55482 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab2E0Tsg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 15:48:36 -0400
Received: by obbtb18 with SMTP id tb18so4307618obb.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GV4KqpzdRh6Ggf1VaXUy1wLAOi08/TykOR5WXEgkWkI=;
        b=DZmFkZTElhFmN0ppEL/njJDp4oeMkRwXmYL8Gca4sF21x0Imybm0FYW0DJZ6/jFj/O
         8/0RQ1lWu2VFT4ecbwp5Y0kt/5Ds54ISIIHej9QJBfZ/ILoAZEpCPvPN306ZmshZ/0Lc
         kMHy/f0qDUZIqTzu5vND7EoFAY/DUdtX8zA8s3DDdxjLkoa9ibjz0ivu79Iwnld2huYy
         F/hLfcbL9OX4AdjHCtYVIrqVnVpba5u+WLFsLg4H2HLFhTTjSeEvfQWLPFXoqhGaW4j7
         LJPJsqBowPs2anRha2i82WNf1yHC8+vQHcfi8XAEgXQVuQkUjppDXz386fLJejEdwE9A
         /wRA==
Received: by 10.50.87.227 with SMTP id bb3mr2987734igb.57.1338148116201;
        Sun, 27 May 2012 12:48:36 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id nz4sm4244863igc.14.2012.05.27.12.48.35
        (version=SSLv3 cipher=OTHER);
        Sun, 27 May 2012 12:48:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120527192541.GA29490@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198617>

Jonathan Nieder wrote:

> YAML::Any is not a core perl module.  This patch uses it when and only
> when it is available.

And here's a patch for squashing in that makes that true.  Sorry for
the confusion.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-svn.perl |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git c/git-svn.perl i/git-svn.perl
index 96b6046a..1b4ef68f 100755
--- c/git-svn.perl
+++ i/git-svn.perl
@@ -2042,7 +2042,11 @@ sub gc_directory {
 package Git::SVN::Memoize::YAML;
 use warnings;
 use strict;
-use YAML::Any ();
+my $usable;
+BEGIN {
+	$Git::SVN::Memoize::YAML::usable = eval { require YAML::Any; 1 };
+	require YAML::Any if $usable;
+}
 
 # based on Memoize::Storable.
 
@@ -2151,10 +2155,6 @@ use Time::Local;
 use Memoize;  # core since 5.8.0, Jul 2002
 use Memoize::Storable;
 use POSIX qw(:signal_h);
-my $can_use_yaml;
-BEGIN {
-	$can_use_yaml = eval { require YAML::Any; 1};
-}
 
 my ($_gc_nr, $_gc_period);
 
@@ -3681,7 +3681,7 @@ sub tie_for_persistent_memoization {
 	my $hash = shift;
 	my $path = shift;
 
-	if ($can_use_yaml) {
+	if ($Git::SVN::Memoize::YAML::usable) {
 		tie %$hash => 'Git::SVN::Memoize::YAML', "$path.yaml";
 	} else {
 		tie %$hash => 'Memoize::Storable', "$path.db", 'nstore';
