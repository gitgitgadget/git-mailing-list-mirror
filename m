From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [FYI/PATCH 1/5] Git::SVN: introduce path accessor
Date: Mon, 17 Sep 2012 02:08:20 -0700
Message-ID: <20120917090820.GB358@elie.Belkin>
References: <1343419252-9447-1-git-send-email-schwern@pobox.com>
 <1343419252-9447-2-git-send-email-schwern@pobox.com>
 <20120917090435.GA358@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca,
	"Michael G. Schwern" <schwern@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 11:08:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDXJh-0004hN-Ri
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 11:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab2IQJI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 05:08:26 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54834 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249Ab2IQJIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 05:08:25 -0400
Received: by ieak13 with SMTP id k13so199089iea.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 02:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EQReKqC3MjVECdH5EHugRf3B5GhA4ByCZ9Yv+N2g5Y0=;
        b=il6kJBdZKTOnA+bzeKZpYEoGINDWEpuQ7PYwhHTnXBBDxIzaFctFogfsk0V4h/gVva
         YZDNwMmKGQttepQNKSQius4sSABVpcmoAeMkgvh/x6+v34+EADuJqqICjjVsUlF6MxvP
         g23FiVGRylNu6PzVCo7JacC7VEoouQqkpzThTCdAU9CUeQsrxe5LbVrh6RGEqv2MEucP
         xe7Xr1iJ9dqpWLqp09N3NTWpevXT/2f7NkOjHnovQdCkzp/3XzeCgCnnldgsMTxTGQb1
         xalNjcfWikbn63R4zN7T6rhHMuBxwMoSVPm12lkOisgAxY5wRb5gllFhq0aaaLMK9m0y
         zuYA==
Received: by 10.50.154.164 with SMTP id vp4mr5951994igb.66.1347872904758;
        Mon, 17 Sep 2012 02:08:24 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id uj6sm10909898igb.4.2012.09.17.02.08.23
        (version=SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 02:08:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120917090435.GA358@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205666>

From: Michael G. Schwern <schwern@pobox.com>
Date: Fri, 27 Jul 2012 13:00:48 -0700

Each Git::SVN handle has a (base) URL and a (relative) path pointing
to the top-level directory of the branch it handles.  Introduce a
getter and setter for the path as preparation for automatically
canonicalizing it when reading or writing.

For example, instead of

	$oldpath = $gs->{path};
	$gs->{path} = $url;
	$gs->{path} =~ s!^\Q$min_url\E(/|$)!!;

now you can write

	$oldpath = $gs->path;
	$url =~ s!^\Q$min_url\E(/|$)!!;
	$gs->path($url);

[jn: split from a larger patch]

Signed-off-by: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 perl/Git/SVN.pm |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index b8b34744..268e0e84 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -2282,6 +2282,18 @@ sub _new {
 	        map_root => "$dir/.rev_map", repo_id => $repo_id }, $class;
 }
 
+sub path {
+	my $self = shift;
+
+	if (@_) {
+		my $path = shift;
+		$self->{path} = $path;
+		return;
+	}
+
+	return $self->{path};
+}
+
 # for read-only access of old .rev_db formats
 sub unlink_rev_db_symlink {
 	my ($self) = @_;
-- 
1.7.10.4
