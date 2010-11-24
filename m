From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] fast-import: treat SIGUSR1 as a request to access
 objects early
Date: Wed, 24 Nov 2010 14:53:19 -0600
Message-ID: <20101124205319.GA12245@burratino>
References: <20101122081601.GA9722@burratino>
 <7vpqtusbyx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Raja R Harinath <harinath@hurrynot.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Gabriel Filion <lelutin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 21:53:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLMLO-0008Qr-98
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 21:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756554Ab0KXUx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 15:53:29 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56341 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab0KXUx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 15:53:29 -0500
Received: by vws2 with SMTP id 2so163566vws.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 12:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=u6mX9xcPXcKxh6juB2VXcN30SIVdHM6Kw7Fq3A9IAKw=;
        b=cdA/IssONUTPvL1rHOUyi8xW27DXVGL69wYcH2n3fLSYmKU6URJHMbkPa5jzJUoOh3
         E+msfTuATSnUSAjVKH4os8xdEBjp0Vs7MlKHdXC+rNle6y8tqSNA8o192Ckzo6QnbiSa
         udtS0M6jes4vJtCVMc0qI9qyVyIRAeX+tufHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=k2sqdScEeOtdYk7S/I6T7s3Jl+hWsTtFKuTh00nQ9xUHbvVNu6w7GZ4rxQNOBtjN2k
         yUGic34dOvnnxRIJXFhsrkRwNW3L6dvlbXQ4bm0yOQOrFyFbpaOTU5hiBNWir9fetLN7
         Z0gYlpLiSLnI9Y9EEPFgFh2/JEXGMUXpOvdM4=
Received: by 10.220.179.7 with SMTP id bo7mr2447228vcb.61.1290632007865;
        Wed, 24 Nov 2010 12:53:27 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id w30sm1777329vcr.16.2010.11.24.12.53.25
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 24 Nov 2010 12:53:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vpqtusbyx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162084>

Junio C Hamano wrote:

> I would have expected the new implementation of parse_checkpoint() to just
> set the checkpoint_requested variable to true, so that the checkpoint
> always happens in the main loop, which somehow feels cleaner.

Nice.  Here's that plus some minor cleanups I had in my tree.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 6be3938..5937cc0 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1119,7 +1119,6 @@ operator can use this facility to peek at the objects and refs from an
 import in progress, at the cost of some added running time and worse
 compression.
 
-
 Author
 ------
 Written by Shawn O. Pearce <spearce@spearce.org>.
diff --git a/fast-import.c b/fast-import.c
index e8f08fb..a348994 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -490,7 +490,6 @@ static NORETURN void die_nicely(const char *err, va_list params)
 
 static void set_checkpoint_signal(void)
 {
-	/* nothing */
 }
 
 #else
@@ -2351,7 +2350,7 @@ static void parse_reset_branch(void)
 		unread_command_buf = 1;
 }
 
-static void do_checkpoint(void)
+static void checkpoint(void)
 {
 	checkpoint_requested = 0;
 	if (object_count) {
@@ -2364,7 +2363,7 @@ static void do_checkpoint(void)
 
 static void parse_checkpoint(void)
 {
-	do_checkpoint();
+	checkpoint_requested = 1;
 	skip_optional_lf();
 }
 
@@ -2524,7 +2523,7 @@ int main(int argc, const char **argv)
 			die("Unsupported command: %s", command_buf.buf);
 
 		if (checkpoint_requested)
-			do_checkpoint();
+			checkpoint();
 	}
 	end_packfile();
 
