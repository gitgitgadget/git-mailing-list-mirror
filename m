From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] Exporter for code_swarm
Date: Wed, 16 Sep 2009 22:27:03 +0200
Message-ID: <1253132823-29993-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 22:27:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo160-0003Fb-Sn
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 22:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759981AbZIPU1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 16:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759960AbZIPU1K
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 16:27:10 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:45727 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759959AbZIPU1I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 16:27:08 -0400
Received: by fxm17 with SMTP id 17so2560922fxm.37
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 13:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=7erGTMWlBFOPmzgxXYjE3Ybnc7o+hLATAa9VZwWD8T0=;
        b=u0NURl3JmFzNXGnujAtbyOEwx188kLMV36mpUGZ5eeVphSmTH6C0ijI5Dt8eGdw/2D
         RON5qlqhRMW9X2iJs1hWgbv+eRQAiEtKQUAF8GhNfPr30tuvNTvqJeAR1xSiUp8VZ3dA
         6anqdd/rcwL/DD1Jpvk/oofF1tAweBcZ0MwrU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=RcL2jMrvvm3xyW8FvRoVlaSuOoUOv9sBHxTD0F+V+FeLt77qNe9zx0sN/YwaBj4X2q
         PRXMjVWVLCOAXVPoi6yr23rUn9f8CmnaL4LaarHon8I6dsDJOEbi5IODiHgS3CQGF3Ai
         eA+Z5wETBhDcP1FrcxPy85Tu5ofr5izNdGcO4=
Received: by 10.86.232.5 with SMTP id e5mr7746170fgh.27.1253132831323;
        Wed, 16 Sep 2009 13:27:11 -0700 (PDT)
Received: from localhost (host-78-13-48-163.cust-adsl.tiscali.it [78.13.48.163])
        by mx.google.com with ESMTPS id l12sm854709fgb.2.2009.09.16.13.27.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Sep 2009 13:27:10 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.1.345.ge2d8f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128674>

This simple Perl script echoes the entire project history into a format
suitable for consumption from the organic project development visualizer
code_swarm http://vis.cs.ucdavis.edu/~ogawa/codeswarm/ and any other
software that expects a file event XML file in the same format.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 contrib/git-file-events.perl |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)
 create mode 100755 contrib/git-file-events.perl

I had actually considered writing a patch to add the format as a predefined
format for git log, but on second thoughts I decided it was not really worth
the effort. This script, although it's just a quick hack, serves the purpose
just as well, although it's obviously not suited for anything more than
contrib/, if for anything at all.

Enjoy.


diff --git a/contrib/git-file-events.perl b/contrib/git-file-events.perl
new file mode 100755
index 0000000..b5fd5e5
--- /dev/null
+++ b/contrib/git-file-events.perl
@@ -0,0 +1,28 @@
+#!/usr/bin/perl
+
+# Output full repository log as a list of file events, in the format expected by
+# code_swarm http://vis.cs.ucdavis.edu/~ogawa/codeswarm/
+#
+# Usage: perl git-file-events.perl > events.xml
+
+open(LOG, 'git log --reverse --date-order --format="%x09%at000%x09%aN" --name-only|');
+
+my $date = undef;
+my $author = undef;
+
+print "<?xml version=\"1.0\" ?>\n<file_events>\n";
+while (<LOG>) {
+	chomp;
+	if (/^\t(\d+)\t(.*)/) {
+		$date = $1;
+		$author = $2;
+	} else {
+		next unless $_;
+		die "Malformed log: no author!\n'$_'\n" unless $author;
+		$file = $_;
+		$file =~ s/\n//g;
+		$file =~ s/"//g;
+		print "<event date=\"$date\" filename=\"$_\" author=\"$author\" />\n";
+	}
+}
+print "</file_events>\n";
-- 
1.6.4.1.345.ge2d8f
