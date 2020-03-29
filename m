Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URI_HEX autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0901C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 00:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CED206CC
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 00:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=sourcephile.fr header.i=@sourcephile.fr header.b="T94pBIkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgC2AaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 20:30:02 -0400
Received: from revolt129.abo.ilico.org ([80.67.180.129]:40942 "EHLO
        mermet.sourcephile.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbgC2AaC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 20:30:02 -0400
X-Greylist: delayed 554 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Mar 2020 20:30:02 EDT
From:   Julien Moutinho <julm+git@sourcephile.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sourcephile.fr;
        s=20200101; t=1585441246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HGsMBcZRprlN1eKOfuQqPtNzwLdzD+d3xIK26Z3ryKU=;
        b=T94pBIkTfA/34zKa9A61d/xpUqbWCtykavFmrX0IeEaGdx1fG3nss50SDC15gzGO/eIc9k
        +/vLL88d4TZVPRx1lG9VlnXqQWWaIwfM9w9kXTSoU+iEurDBveavNnTtnvtPkwy+sS6wO5
        64cuPfVj5Fg9ZkhVznEXpLAAOjieWyQhSOuAdGzOL4nvQfC9lI18keRt6uUI+VDzp8+8Aj
        CD9R2fnldIP4+EyeBWFugWKFIdqGKX0en54DEynnfThKzvBtRq8VZbm2bR/CD97sAgNr5u
        X2v3V2v9XP0fVCFHOelu8UoC4rpq5mryqFb5Qw4Jd74KiF8HDzJ+X7DhyzpRaVpPBh6eS6
        HQTp+YREbICP12DPlfqB+N3aLnORGkxpY0yC5J3kdiWYmeFBdGWuZbglLwf41vIfyv2EY8
        NcKPxdGwt5KrIjxZDTp7RzUs1dBjgI9p7o2iesa6FfzoenPRJEzY12Q0duLNhvZwnpwu6J
        Md0X/dFsXl62lv8ureFJ6px+wdmEaTg3iNeWbDFudxrxsH7++PIZk/5BLGiWPJvp3hzwRX
        ncvQ/u+29/Vf46xCK/3MYkH2doDBj9upgjJxmafjxJl9psJMKW9zpmDJq7YONDR9UJs86a
        v3UmGW9TDazRfAkHleyJZ9anDnUGW4p9VpKQW0xXjr5yZISTXfBNM=
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Julien Moutinho <julm+git@sourcephile.fr>
Subject: [PATCH] gitweb: fix UTF-8 encoding when using CGI::Fast
Date:   Sun, 29 Mar 2020 01:20:28 +0100
Message-Id: <20200329002028.26080-1-julm+git@sourcephile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

FCGI streams are implemented using the older stream API: TIEHANDLE,
therefore applying PerlIO layers using binmode() has no effect to them.
The solution in this patch is to redefine the FCGI::Stream::PRINT function
to use UTF-8 as output encoding, except within git_blob_plain() and git_snapshot()
which must still output in raw binary mode.

This problem and solution were previously reported back in 2012:
- http://git.661346.n2.nabble.com/Gitweb-running-as-FCGI-does-not-print-its-output-in-UTF-8-td7573415.html
- http://stackoverflow.com/questions/5005104

Signed-off-by: Julien Moutinho <julm+git@sourcephile.fr>
---
 gitweb/gitweb.perl | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 65a3a9e..1a02a12 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1291,9 +1291,23 @@ sub run_request {
 our ($pre_dispatch_hook, $post_dispatch_hook, $pre_listen_hook);
 our $CGI = 'CGI';
 our $cgi;
+our $FCGI_Stream_PRINT_raw = \&FCGI::Stream::PRINT;
 sub configure_as_fcgi {
 	require CGI::Fast;
 	our $CGI = 'CGI::Fast';
+	# FCGI is not Unicode aware hence the UTF-8 encoding must be done manually.
+	# However no encoding must be done within git_blob_plain() and git_snapshot()
+	# which must still output in raw binary mode.
+	no warnings 'redefine';
+	my $enc = Encode::find_encoding('UTF-8');
+	*FCGI::Stream::PRINT = sub {
+		my @OUTPUT = @_;
+		for (my $i = 1; $i < @_; $i++) {
+			$OUTPUT[$i] = $enc->encode($_[$i], Encode::FB_CROAK|Encode::LEAVE_SRC);
+		}
+		@_ = @OUTPUT;
+		goto $FCGI_Stream_PRINT_raw;
+	};
 
 	my $request_number = 0;
 	# let each child service 100 requests
@@ -7079,6 +7093,7 @@ sub git_blob_plain {
 			($sandbox ? 'attachment' : 'inline')
 			. '; filename="' . $save_as . '"');
 	local $/ = undef;
+	local *FCGI::Stream::PRINT = $FCGI_Stream_PRINT_raw;
 	binmode STDOUT, ':raw';
 	print <$fd>;
 	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
@@ -7417,6 +7432,7 @@ sub git_snapshot {
 
 	open my $fd, "-|", $cmd
 		or die_error(500, "Execute git-archive failed");
+	local *FCGI::Stream::PRINT = $FCGI_Stream_PRINT_raw;
 	binmode STDOUT, ':raw';
 	print <$fd>;
 	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
-- 
2.25.1

