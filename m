From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 4/7] Add join_paths() to safely concatenate paths.
Date: Sat, 28 Jul 2012 02:38:29 -0700
Message-ID: <1343468312-72024-5-git-send-email-schwern@pobox.com>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 28 11:39:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv3Uz-0007ho-2M
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 11:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974Ab2G1Jjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 05:39:36 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50635 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab2G1Ji7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 05:38:59 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so6493452pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 02:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=FChV2rgOQCFiXqb3cPZNpYIzh6pjCj0PIY8/Yil9YW4=;
        b=00an2WWszH87PVUpgXIZbweFW4LJQ2MPsqAyDvd9OU2hpYPCuydELDSItQXxKh7WVQ
         mRFf7QWzOCb8Dpj/Ti1+PT87svzd4/my50HvEFgb2oQq/xIs5e+n5H/jEIXGmzXfbPrc
         4kzSWkOyiL13JNgPQ7K6v2t1svd4/qtF4eOic4rvdlPdHPAwuWfsRPdvsUueS3N6JE8V
         Pio3ast32WA46zSHWqescDfRj7HkZb7HYrc+lmt60pbum7NmUteLKhYVeLg3k1xdS138
         hgYwamkGdWcgVV96NymffM5mAi8VVi7bSMZ9VrvqyBhrROEaBA4myVGnaajflVTrPvj9
         M0/w==
Received: by 10.68.227.163 with SMTP id sb3mr20523959pbc.74.1343468339201;
        Sat, 28 Jul 2012 02:38:59 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id rs4sm3689907pbc.0.2012.07.28.02.38.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 02:38:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343468312-72024-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202416>

From: "Michael G. Schwern" <schwern@pobox.com>

Otherwise you might wind up with things like...

    my $path1 = undef;
    my $path2 = 'foo';
    my $path = $path1 . '/' . $path2;

creating '/foo'.  Or this...

    my $path1 = 'foo/';
    my $path2 = 'bar';
    my $path = $path1 . '/' . $path2;

creating 'foo//bar'.

Could have used File::Spec, but I'm shying away from it due to SVN
1.7's pickiness about paths.  Felt it would be better to have our own
we can control completely.
---
 git-svn.perl                 |  3 ++-
 perl/Git/SVN.pm              | 10 ++++++----
 perl/Git/SVN/Utils.pm        | 32 ++++++++++++++++++++++++++++++++
 t/Git-SVN/Utils/join_paths.t | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 5 deletions(-)
 create mode 100644 t/Git-SVN/Utils/join_paths.t

diff --git a/git-svn.perl b/git-svn.perl
index a857484..6e3e240 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -34,6 +34,7 @@ use Git::SVN::Utils qw(
 	can_compress
 	canonicalize_path
 	canonicalize_url
+	join_paths
 );
 
 use Git qw(
@@ -1275,7 +1276,7 @@ sub get_svnprops {
 	$path = $cmd_dir_prefix . $path;
 	fatal("No such file or directory: $path") unless -e $path;
 	my $is_dir = -d $path ? 1 : 0;
-	$path = $gs->{path} . '/' . $path;
+	$path = join_paths($gs->{path}, $path);
 
 	# canonicalize the path (otherwise libsvn will abort or fail to
 	# find the file)
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 7913d8f..b0ed3ea 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -23,7 +23,11 @@ use Git qw(
     command_output_pipe
     command_close_pipe
 );
-use Git::SVN::Utils qw(fatal can_compress);
+use Git::SVN::Utils qw(
+	fatal
+	can_compress
+	join_paths
+);
 
 my $can_use_yaml;
 BEGIN {
@@ -316,9 +320,7 @@ sub init_remote_config {
 			}
 			my $old_path = $self->path;
 			$url =~ s!^\Q$min_url\E(/|$)!!;
-			if (length $old_path) {
-				$url .= "/$old_path";
-			}
+			$url = join_paths($url, $old_path);
 			$self->path($url);
 			$url = $min_url;
 		}
diff --git a/perl/Git/SVN/Utils.pm b/perl/Git/SVN/Utils.pm
index 7314e52..deade07 100644
--- a/perl/Git/SVN/Utils.pm
+++ b/perl/Git/SVN/Utils.pm
@@ -12,6 +12,7 @@ our @EXPORT_OK = qw(
 	can_compress
 	canonicalize_path
 	canonicalize_url
+	join_paths
 );
 
 
@@ -134,4 +135,35 @@ sub _canonicalize_url_ourselves {
 }
 
 
+=head3 join_paths
+
+    my $new_path = join_paths(@paths);
+
+Appends @paths together into a single path.  Any empty paths are ignored.
+
+=cut
+
+sub join_paths {
+	my @paths = @_;
+
+	@paths = grep { defined $_ && length $_ } @paths;
+
+	return '' unless @paths;
+	return $paths[0] if @paths == 1;
+
+	my $new_path = shift @paths;
+	$new_path =~ s{/+$}{};
+
+	my $last_path = pop @paths;
+	$last_path =~ s{^/+}{};
+
+	for my $path (@paths) {
+		$path =~ s{^/+}{};
+		$path =~ s{/+$}{};
+		$new_path .= "/$path";
+	}
+
+	return $new_path .= "/$last_path";
+}
+
 1;
diff --git a/t/Git-SVN/Utils/join_paths.t b/t/Git-SVN/Utils/join_paths.t
new file mode 100644
index 0000000..d4488e7
--- /dev/null
+++ b/t/Git-SVN/Utils/join_paths.t
@@ -0,0 +1,32 @@
+#!/usr/bin/env perl
+
+use strict;
+use warnings;
+
+use Test::More 'no_plan';
+
+use Git::SVN::Utils qw(
+	join_paths
+);
+
+# A reference cannot be a hash key, so we use an array.
+my @tests = (
+	[]					=> '',
+	["/x.com", "bar"]			=> '/x.com/bar',
+	["x.com", ""]				=> 'x.com',
+	["/x.com/foo/", undef, "bar"]		=> '/x.com/foo/bar',
+	["x.com/foo/", "/bar/baz/"]		=> 'x.com/foo/bar/baz/',
+	["foo", "bar"]				=> 'foo/bar',
+	["/foo/bar", "baz", "/biff"]		=> '/foo/bar/baz/biff',
+	["", undef, "."]			=> '.',
+	[]					=> '',
+
+);
+
+while(@tests) {
+	my($have, $want) = splice @tests, 0, 2;
+
+	my $args = join ", ", map { qq['$_'] } map { defined($_) ? $_ : 'undef' } @$have;
+	my $name = "join_paths($args) eq '$want'";
+	is join_paths(@$have), $want, $name;
+}
-- 
1.7.11.3
