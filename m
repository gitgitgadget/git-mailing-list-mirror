From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] send-email: improve recipients_cmd()
Date: Sat, 27 Apr 2013 17:26:01 -0500
Message-ID: <1367101561-14671-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Joe Perches <joe@perches.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 28 00:27:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWDam-00080C-5V
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 00:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646Ab3D0W1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 18:27:24 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:47365 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499Ab3D0W1X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 18:27:23 -0400
Received: by mail-ob0-f181.google.com with SMTP id ta17so4546415obb.12
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 15:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=TyzHXIGh2A1afrgfipBN37DHNltEFdYRkqAhDcCfLnc=;
        b=xTR3OArwq2Mao8NJmGVg2o9h1ciuSIiDKYez11AQl/UXO55nJzmgC5xJezlKn99m38
         bXvOPSwi1FDAQrDEuJ6Dd/2Oh9t2MqIAHLzNI4N+76XZAd8m21kvG//Lzht44mPUWI/d
         idopzWS0RDdv7L0CT+cprfLkE8bEq4xGkAXCuj0y36mS/dj2IdDx3U45dluzb9PvU8+r
         1HuuHrZDxc1XdzZsn8NclTcoLo4VjUIIdcwGoYDEExMVdxMObYYEbWr5JPrZj4kgL0a8
         5cxlXznq1F/MvEoGy/65/T8OQsJad4StcNu8J5D8di4Ull/dnuvn692lPFTJEzmIAIEy
         JxnQ==
X-Received: by 10.60.19.3 with SMTP id a3mr25697506oee.11.1367101640088;
        Sat, 27 Apr 2013 15:27:20 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jv10sm14236446oeb.3.2013.04.27.15.27.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 15:27:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222710>

We don't need to quote the filename to pass to the command, we can use
an array of all the arguments to pass to the command, which is safer,
and more extensible.

Commit a47eab0 (send-email: use the three-arg form of open in
recipients_cmd) stated we couldn't pass $file directly, but in fact, we
can, the multi-word string is passed as is, and we can pass an array
too.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-send-email.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index bd13cc8..7880d12 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1452,11 +1452,11 @@ foreach my $t (@files) {
 # Execute a command (e.g. $to_cmd) to get a list of email addresses
 # and return a results array
 sub recipients_cmd {
-	my ($prefix, $what, $cmd, $file) = @_;
+	my ($prefix, $what, $cmd, @args) = @_;
 
 	my $sanitized_sender = sanitize_address($sender);
 	my @addresses = ();
-	open my $fh, "-|", "$cmd \Q$file\E"
+	open my $fh, "-|", $cmd, @args
 	    or die "($prefix) Could not execute '$cmd'";
 	while (my $address = <$fh>) {
 		$address =~ s/^\s*//g;
-- 
1.8.2.1.1031.g2ee5873
