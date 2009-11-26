From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 10/11] daemon: use full buffered mode for stderr
Date: Thu, 26 Nov 2009 00:39:17 +0000
Message-ID: <1259195958-2372-11-git-send-email-kusmabite@gmail.com>
References: <1259195958-2372-1-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-2-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-3-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-4-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-5-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-6-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-7-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-8-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-9-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-10-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, dotzenlabs@gmail.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlecode.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:40:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSPG-00082V-RZ
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbZKZAkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbZKZAkG
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:40:06 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41835 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965038AbZKZAkF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:40:05 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so295613ewy.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=un6dowA3DOnumJc3fTRmaSncTzAVzrKjywrpoOEaUoQ=;
        b=Uxk3bmn+Ov2C8xEM52u6z3aA/PRx4V4hKNvu9I68MvzToPiQQeDE3/wbPpdIXzR77t
         +W4PRSaNhB6mcc+od/Gj8yVmU26HkniYWsyMd56NPhdziAHs+7XY/KGm6FMMMykpq6+/
         zMPdspkUxwOyDXFW19BcbUkhOOA7lap5i3Lnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KmabJWOMs7/S9RrFG09RENKQ/DFcCuEqGcEA5bKnDzNBaSgheSnXKeHhEkb60qDJv3
         bOP6MKzZcOdZMm8XFygXsujdSTGIWp4yn5mY8WA1JUaikc6niOf4o+CHrydSfDuJyxMD
         z0CAIkHuIHlh8Iax8CUwEOZMAga/qM28CPn5U=
Received: by 10.213.8.28 with SMTP id f28mr1429410ebf.39.1259196011259;
        Wed, 25 Nov 2009 16:40:11 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 10sm386319eyz.15.2009.11.25.16.40.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:40:10 -0800 (PST)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1259195958-2372-10-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133728>

Windows doesn't support line buffered mode for file
streams, so let's just use full buffered mode with
a big buffer ("4096 should be enough for everyone")
and add explicit flushing.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index 1b0e290..130e951 100644
--- a/daemon.c
+++ b/daemon.c
@@ -66,12 +66,14 @@ static void logreport(int priority, const char *err, va_list params)
 		syslog(priority, "%s", buf);
 	} else {
 		/*
-		 * Since stderr is set to linebuffered mode, the
+		 * Since stderr is set to buffered mode, the
 		 * logging of different processes will not overlap
+		 * unless they overflow the (rather big) buffers.
 		 */
 		fprintf(stderr, "[%"PRIuMAX"] ", (uintmax_t)getpid());
 		vfprintf(stderr, err, params);
 		fputc('\n', stderr);
+		fflush(stderr);
 	}
 }
 
@@ -1094,7 +1096,7 @@ int main(int argc, char **argv)
 		set_die_routine(daemon_die);
 	} else
 		/* avoid splitting a message in the middle */
-		setvbuf(stderr, NULL, _IOLBF, 0);
+		setvbuf(stderr, NULL, _IOFBF, 4096);
 
 	if (inetd_mode && (group_name || user_name))
 		die("--user and --group are incompatible with --inetd");
-- 
1.6.5.rc2.7.g4f8d3
