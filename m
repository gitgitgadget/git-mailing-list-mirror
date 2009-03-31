From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 1/4] send-email: don't attempt to prompt if tty is closed
Date: Tue, 31 Mar 2009 12:22:11 -0400
Message-ID: <e439cc23328dc25d153baed21f6ad7d90106eb03.1238516122.git.jaysoffian@gmail.com>
References: <cover.1238516122.git.jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>,
	=?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 18:24:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoglC-0007f0-Hv
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 18:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760655AbZCaQW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 12:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760394AbZCaQW4
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 12:22:56 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:35585 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760071AbZCaQWz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 12:22:55 -0400
Received: by qyk16 with SMTP id 16so4637386qyk.33
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 09:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=//RsqNK4WGqmQkL9Zc2hY8i0I31NYtpv25+GPsYRVFM=;
        b=plwXF2veT45gnDs/QzAu4F3Y1rX0nqCEcX2b1y1vmkKJxy5/NXvZjU3Moxz/vc2CJM
         82pQb73ib+nmjBtF2uT2AilShZ7+y2fdjWTK/1b4/MlX4GjPs9BtLx0aRy30fhDCWRdW
         rJscGTR2wG4XhnkWtwaKhD40qZrHpgA7KpB4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ph9a6Bp/y7ROeUDAZR74PZPuPX08RMeK2xpr7CGQ0qkmYKIk4w+M6bkOPwyQrc/gJ+
         Zohjr3GggJETIdhJAAKs8CfLADQnqhHhW5pidnjzAem8UwmNRP63tqhKKUVHqghwULaS
         lOYAylmpmI864hy2nJVDHUT1il9RwTFBB9Ho4=
Received: by 10.224.60.138 with SMTP id p10mr8397285qah.232.1238516573015;
        Tue, 31 Mar 2009 09:22:53 -0700 (PDT)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 6sm22138qwk.17.2009.03.31.09.22.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 09:22:52 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.427.g15408
In-Reply-To: <cover.1238516122.git.jaysoffian@gmail.com>
In-Reply-To: <cover.1238516122.git.jaysoffian@gmail.com>
References: <cover.1238516122.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115277>

Attempting to prompt when the tty is closed (typically when running from
cron) is pointless and emits a warning. This patch causes ask() to
return early, squelching the warning.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 git-send-email.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5916c86..d790660 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -612,6 +612,9 @@ sub ask {
 	my $default = $arg{default};
 	my $resp;
 	my $i = 0;
+	return defined $default ? $default : undef
+		unless defined $term->IN and defined fileno($term->IN) and
+		       defined $term->OUT and defined fileno($term->OUT);
 	while ($i++ < 10) {
 		$resp = $term->readline($prompt);
 		if (!defined $resp) { # EOF
-- 
1.6.2.1.427.g15408
