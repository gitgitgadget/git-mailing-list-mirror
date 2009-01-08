From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Can I prevent someone clone my git repository?
Date: Thu, 8 Jan 2009 16:49:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901081648550.30769@pacific.mpi-cbg.de>
References: <856bfe0e0901072303i4fcd3bf6u99790ab9f4170937@mail.gmail.com> <7vr63e42ke.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901081227170.30769@pacific.mpi-cbg.de> <20090108143257.GX21154@genesis.frugalware.org> <alpine.DEB.1.00.0901081541041.30769@pacific.mpi-cbg.de>
 <20090108152934.GA16840@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>,
	Emily Ren <lingyan.ren@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 16:50:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKx9g-00072F-ER
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 16:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbZAHPtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 10:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbZAHPtL
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 10:49:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:33667 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752345AbZAHPtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 10:49:09 -0500
Received: (qmail invoked by alias); 08 Jan 2009 15:49:05 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp056) with SMTP; 08 Jan 2009 16:49:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185F09sxBM54566kCU6HFcM4DorWXJHNaxaL2vrZ4
	rGKtmVyOi1i5E4
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090108152934.GA16840@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104929>

Hi,

On Thu, 8 Jan 2009, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Thu, 8 Jan 2009, Miklos Vajna wrote:
> > 
> > > On Thu, Jan 08, 2009 at 12:27:59PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > > like git://your-host/repository.git
> > > > 
> > > > If the people are on different IPs, a hook can restrict who may clone, 
> > > > since commit v1.6.1-rc1~109.
> > > 
> > > Hmm, but I think there is no hook called "pre-send" or so that could 
> > > return status code 1 to prevent receiving, so that commit on its own 
> > > does not does what Emily needs here.
> > 
> > Oops.  I assumed there is a pre-upload hook, but apparently I was wrong.
> > 
> > Would be easy to introduce that hook, though...
> 
> Well, sure, but Emily is asking about "no clone".
> 
> Does that mean that users can ask for incremental updates, but not
> initial clones where there is nothing in common?
> 
> If so then any sort of hook needs an input parameter and needs
> to be called after the commit negotation is complete, so the hook
> can be told "the other side has some stuff" or "the other side has
> nothing at all".
> 
> FWIW I was just yesterday talking to a co-worker about adding this
> sort of behavior to Gerrit2.  Cloning the Linux kernel over its
> internal sshd is quite a bit slower than doing it over native git,
> so we were talking about blocking initial clones.  Everything in
> a Gerrit server should be opensource and available over git://,
> so its just a limit to save server resources.

If you want it, here is an initial patch without tests.  Indeed, it has 
not been tested at all.

-- snipsnap --
[PATCH] Add a pre-upload hook to git-upload-pack

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 upload-pack.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index e5adbc0..bca0428 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -140,6 +140,27 @@ static int do_rev_list(int fd, void *create_full_pack)
 	return 0;
 }
 
+static int pre_upload_hook(int is_clone)
+{
+	struct child_process proc;
+	const char *name = git_path("hooks/pre-upload");
+	const char *argv[3];
+	int i = 0;
+
+	if (access(name, X_OK) < 0)
+		return 0;
+
+	memset(&proc, 0, sizeof(proc));
+	argv[i++] = name;
+	if (is_clone)
+		argv[i++] = "clone";
+	argv[i++] = NULL;
+	proc.argv = argv;
+	proc.no_stdin = 1;
+	proc.stdout_to_stderr = 1;
+	return run_command(&proc);
+}
+
 static void create_pack_file(void)
 {
 	struct async rev_list;
@@ -153,6 +174,9 @@ static void create_pack_file(void)
 	const char *argv[10];
 	int arg = 0;
 
+	if (pre_upload_hook(create_full_pack))
+		die("upload denied by pre-upload hook");
+
 	rev_list.proc = do_rev_list;
 	/* .data is just a boolean: any non-NULL value will do */
 	rev_list.data = create_full_pack ? &rev_list : NULL;
