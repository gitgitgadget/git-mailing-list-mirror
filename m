From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: debugging git clone  via git-daemon     "cannot handle daemon
 internally"
Date: Fri, 7 Jan 2011 17:42:10 -0600
Message-ID: <20110107234210.GB15495@burratino>
References: <4D234FEF.2030501@ecosensory.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: John Griessen <john@ecosensory.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 00:42:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbLxP-0005Rf-Py
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 00:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340Ab1AGXmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 18:42:31 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59916 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab1AGXm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 18:42:29 -0500
Received: by ywl5 with SMTP id 5so6942230ywl.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 15:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=BJvYxScz8Wgv7MHBbZO6xlfqJn/RyKYSWi/Vlr+9hvE=;
        b=Hg7yIWkbMxoWAaqn7otCDOesZeLs7RZGepTfhOVeyVBSYOgUPDa5KRENjCvlDEftx8
         yX3GbZIntAO0t6daUCFSc8HbscgIm5U6uxclF4csexQEUhIxmGor9H2M9WZPMc+6yUgP
         CxgiVvB3TkZzXH1687Mqv2eqTElP8m+1vlg7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=E9qvAV877jMGuqaw+wkziXfvmBknzBHMzwDSAn1DY1Sk16Qdz2H0S/l7r9oG8NATa+
         HyiasCE0/EaeK4c9gkxpHpfHiinrH3ycPvmaUtqGG2NRYY8NW3kFvMleS/HF7lOxStY0
         T24nETvR8DwBLsrivXa8FWkQe0ybma7aWuwO8=
Received: by 10.151.107.7 with SMTP id j7mr16889641ybm.111.1294443748780;
        Fri, 07 Jan 2011 15:42:28 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id q31sm13270233yba.6.2011.01.07.15.42.23
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 15:42:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D234FEF.2030501@ecosensory.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164787>

John Griessen wrote:

> john@toolbench:~/EEProjects/test$ telnet mail.cibolo.us 9418
> Trying 76.191.252.85...
> Connected to mail.cibolo.us.
> Escape character is '^]'.
> fatal: cannot handle daemon internally
> Connection closed by foreign host.
> 
> 
> What does "cannot handle daemon internally" signify to you all?

Progress. :)  Interesting.

The message comes from "main" in git.c:

      if (!prefixcmp(cmd, "git-")) {
            cmd += 4;
            argv[0] = cmd;
            handle_internal_command(argc, argv);
            die("cannot handle %s internally", cmd);
      }

Perhaps you have inetd set up to try to run git with argv[0] set
to git-daemon?  git-daemon (daemon.c) has its own "main" so it
would take something of that nature to produce this symptom.

Maybe something like this would have made diagnosis easier.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/pkt-line.c b/pkt-line.c
index 295ba2b..694571d 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -121,6 +121,22 @@ static int packet_length(const char *linelen)
 	return len;
 }
 
+static void NORETURN die_bad_length(int fd, const char linelen[4])
+{
+	struct strbuf msg = STRBUF_INIT;
+	FILE *fp;
+
+	if ((memcmp(linelen, "fata", 4) &&
+	     memcmp(linelen, "erro", 4) &&
+	     memcmp(linelen, "warn", 4)) ||
+	    !(fp = fdopen(fd, "r")))
+		die("protocol error: bad line length character: %.4s", linelen);
+
+	strbuf_getline(&msg, fp, '\n');
+	die("protocol error: bad line length character: %.4s%s",
+		linelen, msg.buf);
+}
+
 int packet_read_line(int fd, char *buffer, unsigned size)
 {
 	int len;
@@ -129,7 +145,7 @@ int packet_read_line(int fd, char *buffer, unsigned size)
 	safe_read(fd, linelen, 4);
 	len = packet_length(linelen);
 	if (len < 0)
-		die("protocol error: bad line length character: %.4s", linelen);
+		die_bad_length(fd, linelen);
 	if (!len)
 		return 0;
 	len -= 4;
