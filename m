From: Allen Hubbe <allenbh@gmail.com>
Subject: [PATCH] git-send-email.perl: Add sendmail aliases support
Date: Thu, 21 May 2015 14:51:40 -0400
Message-ID: <3f1091c3de6e4e62037bc3c84c69026e33ee9707.1432229888.git.allenbh@gmail.com>
Cc: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Allen Hubbe <allenbh@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 20:52:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvVZl-0004eX-V7
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 20:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbbEUSwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 14:52:10 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:32941 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbbEUSwI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 14:52:08 -0400
Received: by yhcb70 with SMTP id b70so23540074yhc.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 11:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=M0iblQukI7xMiYG0wXAK/96UwYCmFduV52HEmRwk9OA=;
        b=hXzAlaDIUUo/jvckx+9tQLL2n+/S5W3ICUXO7qNY6yW7Cct8Ymjl5J12EKdHAZZQFD
         bMezQBJaPgjbdpZM636B62MoDkCX5R5OTR0FUiPgpFeziDUcdNiYmq+htWNiTnOVDYsj
         O6ArtLjurXb7vHlkkwlfMLptfuYzH3iTQCpNWkkx9n6NN0UNxqXxoRz+xF2xkbWQJQNW
         fq77XQRSs+OAmXAH81D8H6CEeZMU8rTRZ888pNaCYimgkyY2mCZ+gom7BnJitX8IT6tG
         ga5MtWdU1aIFmM1B50DyEsZAPuOUOMhjXAYcRdk/gzG4xtOUIbFfAFrp9GbBKyC7lxia
         qzkw==
X-Received: by 10.170.154.212 with SMTP id v203mr4631323ykc.93.1432234327364;
        Thu, 21 May 2015 11:52:07 -0700 (PDT)
Received: from localhost.localdomain (cpe-65-190-128-155.nc.res.rr.com. [65.190.128.155])
        by mx.google.com with ESMTPSA id m28sm16789783yhm.21.2015.05.21.11.52.05
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 21 May 2015 11:52:06 -0700 (PDT)
X-Mailer: git-send-email 2.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269646>

Support sendmail (and postfix) style email aliases in git-send-email.
This is the format of /etc/mail/aliases, documented by `man 5 aliases`.
The man page may be provided by sendmail or postfix on your system, or
by another email service that uses the same configuration file.

See also: http://www.postfix.org/aliases.5.html.

This format is more simple than the other alias file formats, so it may
be preferred by some users.  The format is as follows.

<alias>: <address|alias>[, <address|alias>...]

Example (no indent in aliases file):
	alice: Alice W Land <awol@example.com>
	bob: Robert Bobbyton <bob@example.com>
	chloe: chloe@example.com
	abgroup: alice, bob
	bcgrp: bob, chloe, Other <o@example.com>

This patch DOES NOT support line continuations as are described by the
specification.  Line continuations are indicated by either (or both) a
trailing '\' on the line to be continued, or leading whitespace on the
continuing line.  This patch does not do anything with the trailing '\',
and ignores lines starting with whitespace.

This patch also ignores lines that starts with '#', comment character,
and empty lines.

Signed-off-by: Allen Hubbe <allenbh@gmail.com>
---
 git-send-email.perl | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e1e9b14..5f2ec0d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -515,7 +515,12 @@ my %parse_alias = (
 			       $aliases{$alias} = [ split_addrs($addr) ];
 			  }
 		      } },
-
+	sendmail => sub { my $fh = shift; while (<$fh>) {
+		next if /^$|^#|^\s/;
+		if (/^(\S+)\s*:\s*(.*?)\\?$/) {
+			my ($alias, $addr) = ($1, $2);
+			$aliases{$alias} = [ split_addrs($addr) ];
+		}}},
 	gnus => sub { my $fh = shift; while (<$fh>) {
 		if (/\(define-mail-alias\s+"(\S+?)"\s+"(\S+?)"\)/) {
 			$aliases{$1} = [ $2 ];
-- 
2.3.4
