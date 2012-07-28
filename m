From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 3/7] Extract, test and enhance the logic to collapse ../foo paths.
Date: Sat, 28 Jul 2012 02:38:28 -0700
Message-ID: <1343468312-72024-4-git-send-email-schwern@pobox.com>
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
	id 1Sv3V0-0007ho-HS
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 11:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941Ab2G1Jjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 05:39:35 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50635 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770Ab2G1Ji6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 05:38:58 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so6493452pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 02:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=waUdd8EKu/NzsJ3C2ZQ/JmH0cLaCYiAiAyLtYYWkmBw=;
        b=cuBDpvUKBh+cgKt1gEcvtN2LCI5yLGH6ytfqXDEaBVFnSld5zHaPGw8LcWqtsHdB6/
         0RmlaHoJRs9bYKWEKok90o9Zguikn7QnWipCY2h5rqN9fcw2drBIhXnF0NnJ7psMAQW1
         7UygUF7loI1agy/kq2VODTyiILz9VPAIb+ZrsRqIIIPFxsMg09oJJzPAXhe04lDzkBOY
         q6j0UkDUhKNnD9uTPmG1qghsBDRyZkJ0rCo0FlIETUOrSO+uyOgdKUP37YZSQ5bnqVQ3
         TCV6Hk61olrnurfTAAiXBOc/KPhh7pn/gRoHmEKHltSEC1wIE0scVjjvvFlT/D94T+1j
         Ob/A==
Received: by 10.68.203.73 with SMTP id ko9mr20484402pbc.66.1343468338217;
        Sat, 28 Jul 2012 02:38:58 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id rs4sm3689907pbc.0.2012.07.28.02.38.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 02:38:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343468312-72024-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202414>

From: "Michael G. Schwern" <schwern@pobox.com>

The SVN API functions will not accept ../foo but their canonicalization
functions will not collapse it.  So we'll have to do it ourselves.

_collapse_dotdot() works better than the existing regex did.

This will be used shortly when canonicalize_path() starts using the
SVN API.
---
 perl/Git/SVN/Utils.pm             | 14 +++++++++++++-
 t/Git-SVN/Utils/collapse_dotdot.t | 23 +++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 t/Git-SVN/Utils/collapse_dotdot.t

diff --git a/perl/Git/SVN/Utils.pm b/perl/Git/SVN/Utils.pm
index 9d5d3c5..7314e52 100644
--- a/perl/Git/SVN/Utils.pm
+++ b/perl/Git/SVN/Utils.pm
@@ -72,6 +72,18 @@ API as a file path.
 
 =cut
 
+# Turn foo/../bar into bar
+sub _collapse_dotdot {
+	my $path = shift;
+
+	1 while $path =~ s{/[^/]+/+\.\.}{};
+	1 while $path =~ s{[^/]+/+\.\./}{};
+	1 while $path =~ s{[^/]+/+\.\.}{};
+
+	return $path;
+}
+
+
 sub canonicalize_path {
 	my ($path) = @_;
 	my $dot_slash_added = 0;
@@ -83,7 +95,7 @@ sub canonicalize_path {
 	# good reason), so let's do this manually.
 	$path =~ s#/+#/#g;
 	$path =~ s#/\.(?:/|$)#/#g;
-	$path =~ s#/[^/]+/\.\.##g;
+	$path = _collapse_dotdot($path);
 	$path =~ s#/$##g;
 	$path =~ s#^\./## if $dot_slash_added;
 	$path =~ s#^/##;
diff --git a/t/Git-SVN/Utils/collapse_dotdot.t b/t/Git-SVN/Utils/collapse_dotdot.t
new file mode 100644
index 0000000..1da1cce
--- /dev/null
+++ b/t/Git-SVN/Utils/collapse_dotdot.t
@@ -0,0 +1,23 @@
+#!/usr/bin/env perl
+
+use strict;
+use warnings;
+
+use Test::More 'no_plan';
+
+use Git::SVN::Utils;
+my $collapse_dotdot = \&Git::SVN::Utils::_collapse_dotdot;
+
+my %tests = (
+	"foo/bar/baz"			=> "foo/bar/baz",
+	".."				=> "..",
+	"foo/.."			=> "",
+	"/foo/bar/../../baz"		=> "/baz",
+	"deeply/.././deeply/nested"	=> "./deeply/nested",
+);
+
+for my $arg (keys %tests) {
+	my $want = $tests{$arg};
+
+	is $collapse_dotdot->($arg), $want, "_collapse_dotdot('$arg') => $want";
+}
-- 
1.7.11.3
