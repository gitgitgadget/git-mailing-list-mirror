From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] daemon: support <directory> arguments again
Date: Mon, 3 Jan 2011 22:04:46 -0600
Message-ID: <20110104040446.GA3541@burratino>
References: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
 <1288834524-2400-9-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 05:05:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZy90-0006nK-5S
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 05:05:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971Ab1ADEFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 23:05:03 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33146 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab1ADEFB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 23:05:01 -0500
Received: by yxt3 with SMTP id 3so5492208yxt.19
        for <git@vger.kernel.org>; Mon, 03 Jan 2011 20:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=T7g+ht4QIOmafVHwGpfFNz0kWrXDYWT75xwL/OKzw0o=;
        b=QOrLq+ciBxIYD/2YcuKKWrkoB+PF6ofhKUR0DPboj+dlxDS8NklRyOBVdPgBSfOCGk
         eOpcN8tQck59yYTtCrn3VwKZl9GnDBTd/Gz4HgyLK7mqeaBqIndqD7V2OH6LM7tV6Bfa
         odofr9pM61dY5FnnvnNpjSwIzElNjLhKuJZ1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=T1gaJ405QDKOPytoo9LlyX+dha0wLcODplcNVFeuX5ydjUybZkXfMDSSGswcK6MWCB
         A1VI+iM36Ip7ocAhfAar/3BYR0Az0E0Im2XQ3k6ajL91o6iHHHsT6EwFBH20CBPnelvZ
         DaI6QrLgygTxSXhooMTQLofZC67nEf25ZKoGo=
Received: by 10.100.164.1 with SMTP id m1mr12898890ane.269.1294113900038;
        Mon, 03 Jan 2011 20:05:00 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id 37sm28990864anr.24.2011.01.03.20.04.58
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 Jan 2011 20:04:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1288834524-2400-9-git-send-email-kusmabite@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164472>

Ever since v1.7.4-rc0~125^2~8 (daemon: use run-command api for async
serving, 2010-11-04), git daemon spawns child processes instead of
forking to serve requests.  The child processes learn that they are
being run for this purpose from the presence of the --serve command
line flag.

When running with <ok_path> arguments, the --serve flag is treated
as one of the path arguments and the special child behavior does
not kick in.  So the child becomes an ordinary git daemon process,
notices that all the addresses it needs are in use, and exits with
the message "fatal: unable to allocate any listen sockets on port
9418".

Fix it by putting --serve at the beginning of the command line,
where the flag cannot be mistaken for a path argument.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
On the client side:

 $ git clone git://localhost/git/git.git
 Cloning into git...
 fatal: read error: Connection reset by peer

On the server side:

 # $git_src/bin-wrappers/git daemon --verbose --base-path=/var/cache /var/cache/git
 fatal: unable to allocate any listen sockets on port 9418
 [3602] [3604] Disconnected (with error)

Bisects to v1.7.4-rc0~125^2~8.  This patch seems to fix it.  Thoughts?

 daemon.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/daemon.c b/daemon.c
index 4059593..132b7a8 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1181,9 +1181,10 @@ int main(int argc, char **argv)
 
 	/* prepare argv for serving-processes */
 	cld_argv = xmalloc(sizeof (char *) * (argc + 2));
-	for (i = 0; i < argc; ++i)
-		cld_argv[i] = argv[i];
-	cld_argv[argc] = "--serve";
+	cld_argv[0] = argv[0];	/* git-daemon */
+	cld_argv[1] = "--serve";
+	for (i = 1; i < argc; ++i)
+		cld_argv[i+1] = argv[i];
 	cld_argv[argc+1] = NULL;
 
 	return serve(&listen_addr, listen_port, pass, gid);
-- 
1.7.4.rc0
