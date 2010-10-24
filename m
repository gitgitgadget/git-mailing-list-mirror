From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 09/10] gitweb: provide a routine to display (sub)sections
Date: Sun, 24 Oct 2010 12:45:35 +0200
Message-ID: <1287917136-26103-10-git-send-email-giuseppe.bilotta@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 12:46:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9y5z-0004rf-E5
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 12:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485Ab0JXKqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 06:46:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45935 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932465Ab0JXKqX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 06:46:23 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so2370311wyf.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 03:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=h7xWFSQwVcY3/i6YpJOc9zaMp7TGSjTmsB9XPFFIfHw=;
        b=T4MoDHlrs4e8LZVtZRZNpyvIArOpoDVES8DrnU0kRipiVtgFeJvxsY9nHRVL89f2x7
         xER2LU4W/4Y62qea/0DMt8yNqo/vkJrW8ZbAgPtDYlHctWDWqxDeSr/yRUeVmWs16mSc
         nDQiSCPFmhD4WOEKJ1LyaipnzPA8Ewt2WHSSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vZnkWU46bpyR02Ac6FuQMA/C7J42pwOrQUJdXMqJNxUE1cZc7AVN/oYULl9zEbt2eN
         x3tDjBy2ilhjG8HrV/8ViC83EJtYwN9CntfFab9rZn4ERtOSHpRpa67ObbfuwgQm94x0
         21S9Oywu8uDvKkm44RVNwzLFzAqqFVL04B4TM=
Received: by 10.216.35.133 with SMTP id u5mr4840577wea.72.1287917182258;
        Sun, 24 Oct 2010 03:46:22 -0700 (PDT)
Received: from localhost ([151.60.176.122])
        by mx.google.com with ESMTPS id y80sm3313179weq.27.2010.10.24.03.46.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 03:46:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159847>

The routine puts the given contento into a DIV element, automatically
adding a header div. The content can be provided as a standard scalar
value (which is used as-is), as a scalar ref (which is HTML-escaped), as
a function reference to be executed, or as a file handle to be dumped.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ec2626d..feca8bc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3805,6 +3805,44 @@ sub format_repo_url {
 	return "<tr class=\"metadata_url\"><td>$name</td><td>$url</td></tr>\n";
 }
 
+# Group output by placing it in a DIV element and adding a header.
+# Options for start_div() can be provided by passing a hash reference as the
+# first parameter to the function.
+# Options to git_print_header_div() can be provided by passing an array
+# reference. This must follow the options to start_div if they are present.
+# The content can be a scalar, which is output as-is, a scalar reference, which
+# is output after html escaping, an IO handle passed either as *handle or
+# *handle{IO}, or a function reference. In the latter case all following
+# parameters will be taken as argument to the content function call.
+sub git_print_section {
+	my ($div_args, $header_args, $content);
+	my $arg = shift;
+	if (ref($arg) eq 'HASH') {
+		$div_args = $arg;
+		$arg = shift;
+	}
+	if (ref($arg) eq 'ARRAY') {
+		$header_args = $arg;
+		$arg = shift;
+	}
+	$content = $arg;
+
+	print $cgi->start_div($div_args);
+	git_print_header_div(@$header_args);
+
+	if (ref($content) eq 'CODE') {
+		$content->(@_);
+	} elsif (ref($content) eq 'SCALAR') {
+		print esc_html($$content);
+	} elsif (ref($content) eq 'GLOB' or ref($content) eq 'IO::Handle') {
+		print <$content>;
+	} elsif (!ref($content) && defined($content)) {
+		print $content;
+	}
+
+	print $cgi->end_div;
+}
+
 sub print_local_time {
 	print format_local_time(@_);
 }
-- 
1.7.3.68.g6ec8
