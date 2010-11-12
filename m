From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Scripted clone generating an incomplete, unusable .git/config
Date: Thu, 11 Nov 2010 22:32:30 -0600
Message-ID: <20101112043229.GB10765@burratino>
References: <AANLkTik7-QzrMKDpV=W4dqpuguZsAr5yrMELmHu5NZMd@mail.gmail.com>
 <20101111103742.GA16422@burratino>
 <AANLkTinzotA4TSjMjjmW--gw7ST3dXMyHzPveGynaVmZ@mail.gmail.com>
 <20101111173253.GC16972@burratino>
 <alpine.LNX.2.00.1011111241360.14365@iabervon.org>
 <20101111184829.GG16972@burratino>
 <20101111190508.GA3038@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, Git ML <git@vger.kernel.org>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Carl Worth <cworth@cworth.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 12 05:33:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGlJu-0000ai-Qa
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 05:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab0KLEc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 23:32:57 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33836 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468Ab0KLEc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 23:32:56 -0500
Received: by gxk23 with SMTP id 23so1652029gxk.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 20:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NXj+j+OmhwK8gM+SLVfv5LwC33vQZgu1w5dHa9m5p0Q=;
        b=e2O33/2A+MT5VTnLdLFSbZvPtZZzkQOIZhm9KmHMZkz/DEsDPLd48sVjXy42Nx8QpW
         HkWcStPwIL2p287JPUyE2RMyk0pYunYOtIbnbwnQrks9MhmSF6oVDAcAvjzBYeR9nt78
         EMa5UujvcUZMQRS2+z24TfZNbG00OD/j0czhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GxzOJiQZMdlCbZdbXwdWyPN5bDp42KEflk1CuL83rclNNr+mpagyxUA/996lAz2Lbg
         DvWaeklL0y8Is6Qo9WM6cOaZAxXJLbKFc8Cts+v3f1IetIoMX3dgT4G6KfcbR/TzPQQL
         AjCpOwpaX2a1HgTbe+yBo24FQ+KEt6QIENXpU=
Received: by 10.151.44.11 with SMTP id w11mr3165325ybj.26.1289536375287;
        Thu, 11 Nov 2010 20:32:55 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id n49sm2078609yha.34.2010.11.11.20.32.52
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 20:32:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101111190508.GA3038@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161321>

Jeff King wrote:

> I don't think it makes sense for git-clone to do this itself. If we are
> going to say "SIGPIPE should default to SIG_DFL on startup" then we
> should do it as the very first thing in the git wrapper, not just for
> git-clone. That gives each git program a known starting point of
> behavior.

Here's what that might look like.

-- 8< --
Subject: SIGPIPE and other fatal signals should default to SIG_DFL

The intuitive behavior when a git command receives a fatal
signal is for it to die.

Indeed, that is the default handling.  However, POSIX semantics
allow the parent of a process to override that default by
ignoring a signal, since ignored signals are preserved by fork() and
exec().  For example, Python 2.6 and 2.7's os.popen() runs a shell
with SIGPIPE ignored (Python issue 1736483).

Worst of all, in such a situation, many git commands use
sigchain_push_common() to run cleanup actions (removing temporary
files, discarding locks, that kind of thing) before passing control to
the original handler; if that handler ignores the signal rather than
exiting, then execution will continue in an unplanned-for and unusual
state.

So give the signals in question default handling at the start of
main(), before sigchain_push_common can be called.

NEEDSWORK:

 - imposes an obnoxious maintenance burden.  New non-builtins
   that might call sigchain_push_common() would need to have
   default handling restored at the start of main().

 - needs tests, especially for interaction with "git daemon"
   client shutdown

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Currently git daemon uses SIG_IGN state on SIGTERM to protect
children with active connections.  Why isn't that causing the same
sort of problems as os.popen() causes?

 check-racy.c   |    1 +
 daemon.c       |    1 +
 fast-import.c  |    1 +
 git.c          |    2 ++
 http-backend.c |    1 +
 http-fetch.c   |    1 +
 http-push.c    |    1 +
 imap-send.c    |    1 +
 remote-curl.c  |    1 +
 shell.c        |    2 ++
 show-index.c   |    2 ++
 upload-pack.c  |    1 +
 12 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/check-racy.c b/check-racy.c
index 00d92a1..f1ad9d5 100644
--- a/check-racy.c
+++ b/check-racy.c
@@ -6,6 +6,7 @@ int main(int ac, char **av)
 	int dirty, clean, racy;
 
 	dirty = clean = racy = 0;
+	sigchain_push_common(SIG_DFL);
 	read_cache();
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
diff --git a/daemon.c b/daemon.c
index 7ccd097..7719f33 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1001,6 +1001,7 @@ int main(int argc, char **argv)
 	gid_t gid = 0;
 	int i;
 
+	sigchain_push_common(SIG_DFL);
 	git_extract_argv0_path(argv[0]);
 
 	for (i = 1; i < argc; i++) {
diff --git a/fast-import.c b/fast-import.c
index dc48245..ce28759 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3027,6 +3027,7 @@ int main(int argc, const char **argv)
 {
 	unsigned int i;
 
+	sigchain_push_common(SIG_DFL);
 	git_extract_argv0_path(argv[0]);
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
diff --git a/git.c b/git.c
index e08d0f1..a8677fb 100644
--- a/git.c
+++ b/git.c
@@ -502,6 +502,8 @@ int main(int argc, const char **argv)
 	if (!cmd)
 		cmd = "git-help";
 
+	sigchain_push_common(SIG_DFL);
+
 	/*
 	 * "git-xxxx" is the same as "git xxxx", but we obviously:
 	 *
diff --git a/http-backend.c b/http-backend.c
index 14c90c2..b03455a 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -550,6 +550,7 @@ int main(int argc, char **argv)
 	char *cmd_arg = NULL;
 	int i;
 
+	sigchain_push_common(SIG_DFL);
 	git_extract_argv0_path(argv[0]);
 	set_die_routine(die_webcgi);
 
diff --git a/http-fetch.c b/http-fetch.c
index 762c750..aca4e8f 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -24,6 +24,7 @@ int main(int argc, const char **argv)
 	int get_verbosely = 0;
 	int get_recover = 0;
 
+	sigchain_push_common(SIG_DFL);
 	git_extract_argv0_path(argv[0]);
 
 	while (arg < argc && argv[arg][0] == '-') {
diff --git a/http-push.c b/http-push.c
index c9bcd11..a9d0894 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1791,6 +1791,7 @@ int main(int argc, char **argv)
 	struct remote *remote;
 	char *rewritten_url = NULL;
 
+	sigchain_push_common(SIG_DFL);
 	git_extract_argv0_path(argv[0]);
 
 	repo = xcalloc(sizeof(*repo), 1);
diff --git a/imap-send.c b/imap-send.c
index 71506a8..eb13adc 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1538,6 +1538,7 @@ int main(int argc, char **argv)
 	int nongit_ok;
 
+	sigchain_push_common(SIG_DFL);
 	git_extract_argv0_path(argv[0]);
 
 	if (argc != 1)
 		usage(imap_send_usage);
diff --git a/remote-curl.c b/remote-curl.c
index 04d4813..804492d 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -787,6 +787,7 @@ int main(int argc, const char **argv)
 	struct strbuf buf = STRBUF_INIT;
 	int nongit;
 
+	sigchain_push_common(SIG_DFL);
 	git_extract_argv0_path(argv[0]);
 	setup_git_directory_gently(&nongit);
 	if (argc < 2) {
diff --git a/shell.c b/shell.c
index dea4cfd..9798b99 100644
--- a/shell.c
+++ b/shell.c
@@ -137,6 +137,8 @@ int main(int argc, char **argv)
 	int devnull_fd;
 	int count;
 
+	sigchain_push_common(SIG_DFL);
+
 	/*
 	 * Always open file descriptors 0/1/2 to avoid clobbering files
 	 * in die().  It also avoids not messing up when the pipes are
diff --git a/show-index.c b/show-index.c
index 4c0ac13..7d48c88 100644
--- a/show-index.c
+++ b/show-index.c
@@ -11,6 +11,8 @@ int main(int argc, char **argv)
 	unsigned int version;
 	static unsigned int top_index[256];
 
+	sigchain_push_common(SIG_DFL);
+
 	if (argc != 1)
 		usage(show_index_usage);
 	if (fread(top_index, 2 * 4, 1, stdin) != 1)
diff --git a/upload-pack.c b/upload-pack.c
index f05e422..4c764f7 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -682,6 +682,7 @@ int main(int argc, char **argv)
 	int i;
 	int strict = 0;
 
+	sigchain_push_common(SIG_DFL);
 	git_extract_argv0_path(argv[0]);
 	read_replace_refs = 0;
 
