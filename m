From: Alberto Bertogli <albertito@gmail.com>
Subject: [PATCH] builtin-apply: Show a more descriptive error on failure when opening a patch
Date: Mon, 14 Apr 2008 11:23:38 -0300
Message-ID: <1208183018-27887-1-git-send-email-albertito@gmail.com>
References: <7vtzi5bkdz.fsf@gitster.siamese.dyndns.org>
Cc: Alberto Bertogli <albertito@gmail.com>
To: git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 14 16:27:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlPdQ-0001Xl-M7
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 16:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762257AbYDNOYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 10:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762255AbYDNOYq
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 10:24:46 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:13169 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762246AbYDNOYo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 10:24:44 -0400
Received: by an-out-0708.google.com with SMTP id d31so424048and.103
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 07:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=K5NiaQRW0UBK+W9U5LlCny6mwlGsYFvNP/9Dok5Iyqw=;
        b=snNSZ/7hIVDwUrlOMx7AQwx1Xx7flKCgN4j4iNTJiESNG4Wr+KDlza048/flFSNjODiMo8Gz+AlDU02G/2SkvQ5+WirApr9+ZW3FjvCZJgCCzhGnO9pe6ukdApFxsL1nVEGKM2ICtoaFR1CtLVbF0luz1M7u2+nuxzwU08DDIY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OxFCuQPTA1GKfsS4Ox+kqmeF/8cNiyPP/bzBQq66DtpGUPKdbMvOv+Gq5g8M36iZpFDQhiw95FwfBMopRuC+ANqwfgLOlMUj+JoRcAV3ea3PgYoRpSugMJT70hHij3sh4nsLeC0ZtFCZoSFliHClLssIOCalbekGr4p5Oz54CVg=
Received: by 10.100.4.1 with SMTP id 1mr12389174and.77.1208183081766;
        Mon, 14 Apr 2008 07:24:41 -0700 (PDT)
Received: from gmail.com ( [201.253.179.18])
        by mx.google.com with ESMTPS id n29sm5002758elf.5.2008.04.14.07.24.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Apr 2008 07:24:37 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.105.g9d11e.dirty
In-Reply-To: <7vtzi5bkdz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79505>

When a patch can't be opened (it doesn't exist, there are permission
problems, etc.) we get the usage text, which is not a proper indication of
failure.

This patch fixes that by calling error() instead.

Signed-off-by: Alberto Bertogli <albertito@gmail.com>
---

This one (hopefuly) addresses both Junio and Johannes' comments.

Thanks,
		Alberto


 builtin-apply.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index abe73a0..ebbe609 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -3120,8 +3120,12 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			arg = prefix_filename(prefix, prefix_length, arg);
 
 		fd = open(arg, O_RDONLY);
-		if (fd < 0)
-			usage(apply_usage);
+		if (fd < 0) {
+			error("can't open patch '%s': %s", arg,
+					strerror(errno));
+			return 1;
+		}
+
 		read_stdin = 0;
 		set_default_whitespace_mode(whitespace_option);
 		errs |= apply_patch(fd, arg, inaccurate_eof);
-- 
1.5.5.105.g9d11e.dirty
