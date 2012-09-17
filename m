From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [FYI/PATCH 3/5] Git::SVN: use accessor to write path
Date: Mon, 17 Sep 2012 02:10:53 -0700
Message-ID: <20120917091053.GD358@elie.Belkin>
References: <1343419252-9447-1-git-send-email-schwern@pobox.com>
 <1343419252-9447-2-git-send-email-schwern@pobox.com>
 <20120917090435.GA358@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca,
	"Michael G. Schwern" <schwern@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 11:11:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDXMA-0005li-9u
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 11:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372Ab2IQJK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 05:10:58 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63787 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755342Ab2IQJK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 05:10:57 -0400
Received: by pbbrr13 with SMTP id rr13so8704859pbb.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 02:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=g6FRGATVdF7QMH1MQDqQLWfQzAfnjowm8fWj0EPGZcQ=;
        b=waXnwgMXmVHWkJ2A4ACAcFFT2EHlPM6mCa/PlNW3I1BqON6HsiBNOimMGlmdK9uyhU
         ki+vJMKrzffdXzBm9SgCpLDkEI5XLF73QLTUwPiEVvU5lFfb3MKPAIBclu0cTDNptm8w
         AUohDDrAHuY/RcN61RUUlcx+dEs384L4eT9v7pa7Dy/NoC3kUs68TpnTfpr0bCHRac2T
         yd9h47x3VKLBIRGSwCiJdwjLZiTrGRokioWPtrvfnnClmj3aZPmwv7o7z0BmSTGZkRE+
         t2vu3J7kFYaDr9Y9/IG1paUadikdd9IfVC961AHj11o/fNQNDuxOl22+dJdjJIOhrNuF
         +IuA==
Received: by 10.66.75.105 with SMTP id b9mr19106793paw.58.1347873057252;
        Mon, 17 Sep 2012 02:10:57 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id to6sm6636798pbc.12.2012.09.17.02.10.55
        (version=SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 02:10:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120917090435.GA358@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205668>

From: Michael G. Schwern <schwern@pobox.com>
Date: Fri, 27 Jul 2012 13:00:48 -0700

This patch only touches cases where the path field is written to using
$gs->{path}.  Cases where the path is set directly in a hash literal
will be addressed separately.

[jn: split from a larger patch]

Signed-off-by: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 perl/Git/SVN.pm |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 02d5abc0..826a7fa6 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -315,11 +315,11 @@ sub init_remote_config {
 					     "$url => $min_url\n";
 			}
 			my $old_path = $self->path;
-			$self->{path} = $url;
-			$self->{path} =~ s!^\Q$min_url\E(/|$)!!;
+			$url =~ s!^\Q$min_url\E(/|$)!!;
 			if (length $old_path) {
-				$self->{path} .= "/$old_path";
+				$url .= "/$old_path";
 			}
+			$self->path($url);
 			$url = $min_url;
 		}
 	}
@@ -343,8 +343,10 @@ sub init_remote_config {
 	unless ($no_write) {
 		command_noisy('config',
 			      "svn-remote.$self->{repo_id}.url", $url);
-		$self->{path} =~ s{^/}{};
-		$self->{path} =~ s{%([0-9A-F]{2})}{chr hex($1)}ieg;
+		my $path = $self->path;
+		$path =~ s{^/}{};
+		$path =~ s{%([0-9A-F]{2})}{chr hex($1)}ieg;
+		$self->path($path);
 		command_noisy('config', '--add',
 			      "svn-remote.$self->{repo_id}.fetch",
 			      $self->path.":".$self->refname);
@@ -435,17 +437,19 @@ sub new {
 		}
 	}
 	my $self = _new($class, $repo_id, $ref_id, $path);
-	if (!defined $self->path || !length $self->path) {
+	$path = $self->path;
+	if (!defined $path || !length $path) {
 		my $fetch = command_oneline('config', '--get',
 		                            "svn-remote.$repo_id.fetch",
 		                            ":$ref_id\$") or
 		     die "Failed to read \"svn-remote.$repo_id.fetch\" ",
 		         "\":$ref_id\$\" in config\n";
-		($self->{path}, undef) = split(/\s*:\s*/, $fetch);
+		($path, undef) = split(/\s*:\s*/, $fetch);
 	}
-	$self->{path} =~ s{/+}{/}g;
-	$self->{path} =~ s{\A/}{};
-	$self->{path} =~ s{/\z}{};
+	$path =~ s{/+}{/}g;
+	$path =~ s{\A/}{};
+	$path =~ s{/\z}{};
+	$self->path($path);
 	$self->{url} = command_oneline('config', '--get',
 	                               "svn-remote.$repo_id.url") or
                   die "Failed to read \"svn-remote.$repo_id.url\" in config\n";
-- 
1.7.10.4
