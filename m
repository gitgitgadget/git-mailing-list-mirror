From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-push through git protocol
Date: Sun, 21 Jan 2007 11:04:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701211034490.14248@woody.osdl.org>
References: <17843.29798.866272.414435@lisa.zopyra.com> <ep00nl$mop$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 21 20:04:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8hzJ-0007Xr-Be
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 20:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbXAUTES (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 14:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbXAUTES
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 14:04:18 -0500
Received: from smtp.osdl.org ([65.172.181.24]:58246 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751333AbXAUTER (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 14:04:17 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0LJ4EhB031586
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 21 Jan 2007 11:04:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0LJ4Dhb008072;
	Sun, 21 Jan 2007 11:04:13 -0800
To: Jakub Narebski <jnareb@gmail.com>, Bill Lear <rael@zopyra.com>
In-Reply-To: <ep00nl$mop$1@sea.gmane.org>
X-Spam-Status: No, hits=-0.66 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37337>



On Sun, 21 Jan 2007, Jakub Narebski wrote:
> > 
> > It seems there should be a way to configure a repo or the git daemon
> > to say "Allow push operations".
> > 
> > I looked through the release notes Junio posted for 1.5.0-rc2, but
> > found no reference to the git daemon.
> 
> git:// protocol is not authenticated. git by design allow push only through
> authenticated protocols, i.e. local, ssh:// (git+ssh://), http(s):// with
> WebDAV, probably in the future ftps://. 

Well, it _should_ actually be truly fairly trivial to allow pushing over 
the git:// protocol, and while it's not authenticated, I could well 
imagine that it would make sense from within a firewalled setup (where 
nobody but trusted internal people can reach the git port anyway).

So in that sense, I do think Bill's request makes some amount of sense.

At the same time, I suspect it's not a great idea, unless you also add 
*some* kind of logging facility to git-daemon.

But here is a trivial patch that *MAY* do what Bill wants.

NOTE! "git-receive-pack" is disabled by default, so you need to enable it 
explicitly by starting git-daemon with the "--enable=receive-pack" command  
line argument, or by having your config enable it automatically.

And a second note: I obviously didn't test it. I'm Linus. I don't do no 
steenking testing..

		Linus

---
diff --git a/daemon.c b/daemon.c
index f039534..9590372 100644
--- a/daemon.c
+++ b/daemon.c
@@ -372,9 +372,16 @@ static int upload_archive(void)
 	return -1;
 }
 
+static int receive_pack(void)
+{
+	execl_git_cmd("receive-pack", ".", NULL);
+	return -1;
+}
+
 static struct daemon_service daemon_service[] = {
 	{ "upload-archive", "uploadarch", upload_archive, 0, 1 },
 	{ "upload-pack", "uploadpack", upload_pack, 1, 1 },
+	{ "receive-pack", "receivepack", receive_pack, 0, 1 },
 };
 
 static void enable_service(const char *name, int ena) {
