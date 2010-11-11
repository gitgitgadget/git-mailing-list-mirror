From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 09/11] gitweb: provide a routine to display (sub)sections
Date: Thu, 11 Nov 2010 13:26:16 +0100
Message-ID: <1289478378-15604-10-git-send-email-giuseppe.bilotta@gmail.com>
References: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 13:27:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGWF8-0000Sd-1T
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 13:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756562Ab0KKM05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 07:26:57 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43993 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756512Ab0KKM0z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 07:26:55 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so630026wyb.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 04:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pnIwLWJJOS9Za5rXdma7WJ4sVzSHoev05Fqp6oBUoYI=;
        b=cQOIvXN9Orxype/p2qmegAIHDDg9dcAsyIBMKvMcJD/eNmFovZ1wZf3DazYkRwQ9Bl
         DKD0MSZIP/CKmNiue49xmn8qx+fegse79VMGTeO5AHA2/8ByB6nVzOT1EZqvL3ph7Srk
         DA7nnBx2w5Tz3LBQHqEpCEv3NeqVCT+OZNw6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tmQINQTmx97PKnHv5t0Fnr0e01dmxBfZCjreBLdS8NOsUAWZJ7lRMU3wIjE4dIVQq0
         g9dQ6D8/WWkJcaxhROp+k7P8LCH7RekfqIiZnDtKtu6bC6yRMRyUg/ljEXoOrcuS0xoG
         w3Is373vc4sj0sxKtdd4qE6Mi8rotAcefeoc8=
Received: by 10.216.231.82 with SMTP id k60mr610122weq.64.1289478413742;
        Thu, 11 Nov 2010 04:26:53 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id x65sm1229469weq.25.2010.11.11.04.26.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 04:26:53 -0800 (PST)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161237>

The routine puts the given contento into a DIV element, automatically
adding a header div. The content can be provided as a standard scalar
value (which is used as-is), as a scalar ref (which is HTML-escaped), as
a function reference to be executed, or as a file handle to be dumped.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6e7a663..64da0cc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3802,6 +3802,44 @@ sub format_repo_url {
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
