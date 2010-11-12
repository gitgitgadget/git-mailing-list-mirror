From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] daemon, tag, verify-tag: do not pass ignored signals to
 child (Re: Scripted clone generating an incomplete, unusable .git/config)
Date: Thu, 11 Nov 2010 23:12:34 -0600
Message-ID: <20101112051234.GD10765@burratino>
References: <AANLkTik7-QzrMKDpV=W4dqpuguZsAr5yrMELmHu5NZMd@mail.gmail.com>
 <20101111103742.GA16422@burratino>
 <AANLkTinzotA4TSjMjjmW--gw7ST3dXMyHzPveGynaVmZ@mail.gmail.com>
 <20101111173253.GC16972@burratino>
 <alpine.LNX.2.00.1011111241360.14365@iabervon.org>
 <20101111184829.GG16972@burratino>
 <20101111190508.GA3038@sigill.intra.peff.net>
 <20101112043229.GB10765@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, Git ML <git@vger.kernel.org>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Carl Worth <cworth@cworth.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 12 06:13:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGlwi-0006Cq-OK
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 06:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810Ab0KLFNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 00:13:01 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39993 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab0KLFNA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 00:13:00 -0500
Received: by gwb20 with SMTP id 20so336759gwb.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 21:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jKgq3EeLbCwywSmc/FjYKr6oxXtO6uSYpVmlAy0C8uM=;
        b=UIsEHXxIGnDy8Jx3RX/jFYgwzjo1mat6XydBnephVjRheRnkkn1lqOrVf852ZGCmJE
         TbhBJ0PoWM6vzD1RH2B/BLty/GA/vJ3uSFYIBdSe1Sx3zRFGfHiAmvV/W86AdxDThH6L
         OdHGUq7KSj2DKWpwun5hX/HGMUxnqCz564H+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kt0pUganhFges8vFnIYYBdL+Nce5b0gzwRbHiklL7pj/11ZFLluQirJCxzJOg0uM2Z
         NtiZv9YXrSXOowq8WqNxypQEoYEg1UCfNfcCeCn18wbFIgLsd78Qc8p3h2O6OL5YkzKy
         55XdzoYqYrZqe9i0yhhfRh+PVbJTm07A6+I2Q=
Received: by 10.150.195.11 with SMTP id s11mr3337535ybf.22.1289538779284;
        Thu, 11 Nov 2010 21:12:59 -0800 (PST)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id q18sm482241ybk.3.2010.11.11.21.12.57
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 21:12:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101112043229.GB10765@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161324>

Jonathan Nieder wrote:

> Currently git daemon uses SIG_IGN state on SIGTERM to protect
> children with active connections.  Why isn't that causing the same
> sort of problems as os.popen() causes?

It's late so please do not trust me, but I think the following would
fix that.

-- 8< --
Subject: daemon, tag, verify-tag: do not pass ignored signals to child

It is bad practice to have signals ignored or blocked while creating a
child process, since to do so triggers not-so-well-tested code paths
in many programs.

tag and verify-tag block SIGPIPE to avoid termination from writing
after gpg fails and closes its pipe early.  Ignoring SIGPIPE in the
child is an unintended side-effect; avoid it by narrowing the scope
of the request to ignore SIGPIPE to encompass only the write() (and
in particular, not the fork()).

Connection handling threads in daemon block SIGTERM to avoid
termination of active connections when the number of connections gets
too high.  Use a signal handling function instead of SIG_IGN to
avoid passing the ignored signal to the child.  Ignoring SIGTERM in
the request-handling child is not necessary, since kill_some_child()
never tries to kill those.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Needs tests.

 builtin/tag.c        |   11 +++++++----
 builtin/verify-tag.c |   10 +++++++---
 daemon.c             |    6 +++++-
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index d311491..efc9b93 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -173,10 +173,6 @@ static int do_sign(struct strbuf *buffer)
 			bracket[1] = '\0';
 	}
 
-	/* When the username signingkey is bad, program could be terminated
-	 * because gpg exits without reading and then write gets SIGPIPE. */
-	signal(SIGPIPE, SIG_IGN);
-
 	memset(&gpg, 0, sizeof(gpg));
 	gpg.argv = args;
 	gpg.in = -1;
@@ -189,9 +185,14 @@ static int do_sign(struct strbuf *buffer)
 	if (start_command(&gpg))
 		return error("could not run gpg.");
 
+	/* When the username signingkey is bad, program could be terminated
+	 * because gpg exits without reading and then write gets SIGPIPE. */
+	sigchain_push(SIGPIPE, SIG_IGN);
+
 	if (write_in_full(gpg.in, buffer->buf, buffer->len) != buffer->len) {
 		close(gpg.in);
 		close(gpg.out);
+		sigchain_pop(SIGPIPE);
 		finish_command(&gpg);
 		return error("gpg did not accept the tag data");
 	}
@@ -199,6 +200,8 @@ static int do_sign(struct strbuf *buffer)
 	len = strbuf_read(buffer, gpg.out, 1024);
 	close(gpg.out);
 
+	sigchain_pop(SIGPIPE);
+
 	if (finish_command(&gpg) || !len || len < 0)
 		return error("gpg failed to sign the tag");
 
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 9f482c2..5361017 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -54,8 +54,15 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 		return error("could not run gpg.");
 	}
 
+	/* sometimes the program was terminated because this signal
+	 * was received in the process of writing the gpg input: */
+	sigchain_push(SIGPIPE, ignore_signal);
+
 	write_in_full(gpg.in, buf, len);
 	close(gpg.in);
+
+	sigchain_pop(SIGPIPE);
+
 	ret = finish_command(&gpg);
 
 	unlink_or_warn(path);
@@ -104,9 +111,6 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	if (argc <= i)
 		usage_with_options(verify_tag_usage, verify_tag_options);
 
-	/* sometimes the program was terminated because this signal
-	 * was received in the process of writing the gpg input: */
-	signal(SIGPIPE, SIG_IGN);
 	while (i < argc)
 		if (verify_tag(argv[i++], verbose))
 			had_error = 1;
diff --git a/daemon.c b/daemon.c
index 7719f33..ccc560b 100644
--- a/daemon.c
+++ b/daemon.c
@@ -243,6 +243,10 @@ static int git_daemon_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+static void ignore_termination_signal(int sig)
+{
+}
+
 static int run_service(char *dir, struct daemon_service *service)
 {
 	const char *path;
@@ -294,7 +298,7 @@ static int run_service(char *dir, struct daemon_service *service)
 	 * We'll ignore SIGTERM from now on, we have a
 	 * good client.
 	 */
-	signal(SIGTERM, SIG_IGN);
+	signal(SIGTERM, ignore_termination_signal);
 
 	return service->fn();
 }
-- 
1.7.2.3.557.gab647.dirty
