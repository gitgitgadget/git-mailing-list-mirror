From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Segfault on merge with 1.6.2.1
Date: Mon, 30 Mar 2009 09:48:35 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0903300944350.7534@intel-tinevez-2-302>
References: <op.urifmtkkso3nzr@sulidor.mdjohnson.us> <20090329121700.GN22446@genesis.frugalware.org> <op.urk20nanso3nzr@sulidor.mdjohnson.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Michael Johnson <redbeard@mdjohnson.us>
X-From: git-owner@vger.kernel.org Mon Mar 30 09:50:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoCG2-0004bH-Sd
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 09:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbZC3Hsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 03:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbZC3Hsj
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 03:48:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:57104 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752256AbZC3Hsj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 03:48:39 -0400
Received: (qmail invoked by alias); 30 Mar 2009 07:48:36 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp020) with SMTP; 30 Mar 2009 09:48:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+HCjpbQ6CHLv2oAlwR70zu7UmJWjZPvos1SfRJpM
	RjCGO5tdi/qGmn
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <op.urk20nanso3nzr@sulidor.mdjohnson.us>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115098>

Hi,

On Sun, 29 Mar 2009, Michael Johnson wrote:

> On Sun, 29 Mar 2009 07:17:00 -0500, Miklos Vajna <vmiklos@frugalware.org>
> wrote:
> 
> >On Sat, Mar 28, 2009 at 11:19:31AM -0500, Michael Johnson
> ><redbeard@mdjohnson.us> wrote:
> > >The 1.6.2.1 version just segfaults, but 1.5.6.5 says:
> > >
> > >/usr/bin/git-merge: line 438: 32335 Segmentation fault
> > >git-merge-$strategy $common -- "$head_arg" "$@"
> > >Merge with strategy recursive failed.
> > >
> > >In all cases, .git/index.lock is left behind.
> >
> >That's because 1.6.2.1 has git-merge in C and it calls merge-recursive
> >directly without a fork. Could you try it in gdb and provide a
> >backtrace, please?
> 
> Well, I've got a backtrace, but I don't have debugging symbols, apparently.
> There is not a Debian package I can find that has them. I checked
> debug.debian.net, as well as the standard sid repository. So I will have to
> rebuild the package with debugging turned on. I will not be able to do that
> tonight, unfortunately. I will probably have a chance tomorrow evening.
> 
> Just in case it might be useful, though, here's the backtrace, without
> symbols.
> 
> Starting program: /usr/bin/git merge origin/dojo-1.3
> (no debugging symbols found)
> ... repeated multiple times ...
> [Thread debugging using libthread_db enabled]
> (no debugging symbols found)
> ... repeated multiple times
> [New Thread 0xb7a73b30 (LWP 21505)]
> 
> Program received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0xb7a73b30 (LWP 21505)]
> 0x080e5a6f in ?? ()
> (gdb) backtrace
> #0  0x080e5a6f in ?? ()
> #1  0x0893e000 in ?? ()
> #2  0x000f0000 in ?? ()
> #3  0xbf949098 in ?? ()
> #4  0x080e63ad in ?? ()
> #5  0x08977fcf in ?? ()
> #6  0x000f0000 in ?? ()
> #7  0xfff0ffff in ?? ()
> #8  0x08945dd8 in ?? ()
> #9  0x00000000 in ?? ()

This segfault sounds vaguely like something I tried to fix.  
Unfortunately, I cannot spend time on it right now, except send you the 
patch that could help the issue:

-- snipsnap --

>From 084909acbb576be4c4815e047ee4247b95c70cda Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Mon, 10 Nov 2008 23:25:31 +0100
Subject: [PATCH] merge-recursive: fail gracefully with directory/submodule conflicts

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c         |   15 ++++++++-------

diff --git a/merge-recursive.c b/merge-recursive.c
index 3e1bc3e..8ada5a9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -519,14 +519,14 @@ static void update_file_flags(struct merge_options *o,
 		void *buf;
 		unsigned long size;
 
-		if (S_ISGITLINK(mode))
-			die("cannot read object %s '%s': It is a submodule!",
-			    sha1_to_hex(sha), path);
-
-		buf = read_sha1_file(sha, &type, &size);
+		if (S_ISGITLINK(mode)) {
+			buf = xstrdup(sha1_to_hex(sha));
+			size = strlen(buf);
+		} else
+			buf = read_sha1_file(sha, &type, &size);
 		if (!buf)
 			die("cannot read object %s '%s'", sha1_to_hex(sha), path);
-		if (type != OBJ_BLOB)
+		if (!S_ISGITLINK(mode) && type != OBJ_BLOB)
 			die("blob expected for %s '%s'", sha1_to_hex(sha), path);
 		if (S_ISREG(mode)) {
 			struct strbuf strbuf = STRBUF_INIT;
@@ -542,7 +542,8 @@ static void update_file_flags(struct merge_options *o,
 			free(buf);
 			goto update_index;
 		}
-		if (S_ISREG(mode) || (!has_symlinks && S_ISLNK(mode))) {
+		if (S_ISGITLINK(mode) || S_ISREG(mode) ||
+				(!has_symlinks && S_ISLNK(mode))) {
 			int fd;
 			if (mode & 0100)
 				mode = 0777;
