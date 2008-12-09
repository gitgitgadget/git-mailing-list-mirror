From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] make sure packs to be replaced are closed beforehand
Date: Tue, 09 Dec 2008 14:26:52 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812091414030.14328@xanadu.home>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com>
 <4923FE58.3090503@viscovery.net>
 <alpine.LFD.2.00.0811190753420.27509@xanadu.home>
 <81b0412b0811190534r4f71f981s53de415f79e56e25@mail.gmail.com>
 <49241AEF.1080808@viscovery.net>
 <alpine.LFD.2.00.0811190940480.27509@xanadu.home>
 <81b0412b0811260518o52adb107tbddafb324e7fd97b@mail.gmail.com>
 <alpine.LFD.2.00.0811260931030.14328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 20:28:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA8Fq-0007me-UU
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 20:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbYLIT1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 14:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754213AbYLIT1A
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 14:27:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:16190 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbYLIT07 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 14:26:59 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KBM009P7JCSA220@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 09 Dec 2008 14:26:53 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.00.0811260931030.14328@xanadu.home>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102649>

Especially on Windows where an opened file cannot be replaced, make
sure pack-objects always close packs it is about to replace. Even on
non Windows systems, this could save potential bad results if ever
objects were to be read from the new pack file using offset from the old
index.

This should fix t5303 on Windows.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

On Wed, 26 Nov 2008, Nicolas Pitre wrote:
> On Wed, 26 Nov 2008, Alex Riesen wrote:
> > 2008/11/19 Nicolas Pitre <nico@cam.org>:
> > > On Wed, 19 Nov 2008, Johannes Sixt wrote:
> > >> Oh, the patch only works around the failure in the test case. In a real
> > >> repository there is usually no problem because the destination pack file
> > >> does not exist.
> > >>
> > >> The unusual case is where you do this:
> > >>
> > >>  $ git rev-list -10 HEAD | git pack-objects foobar
> > >>
> > >> twice in a row: In this case the second invocation fails on Windows
> > >> because the destination pack file already exists *and* is open. But not
> > >> even git-repack does this even if it is called twice. OTOH, the test case
> > >> *does* exactly this.
> > >
> > > OK.... Well, despite my earlier assertion, I think the above should be a
> > > valid operation.
> > >
> > > I'm looking at it now.  I'm therefore revoking my earlier ACK as well
> > > (better keep that test case alive).
> > >
> > 
> > Any news here?
> 
> Yes: my hard disk crashed a couple hours after I mentioned this, so most 
> of my time has been spent on recovery since then.  I'll come back to it 
> eventually.

OK, here it is at last.  Please confirm it works on Windows before Junio 
merges it.

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 67eefa2..cedef52 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -535,6 +535,7 @@ static void write_pack_file(void)
 
 			snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
 				 base_name, sha1_to_hex(sha1));
+			free_pack_by_name(tmpname);
 			if (adjust_perm(pack_tmp_name, mode))
 				die("unable to make temporary pack file readable: %s",
 				    strerror(errno));
diff --git a/cache.h b/cache.h
index f15b3fc..231c06d 100644
--- a/cache.h
+++ b/cache.h
@@ -820,6 +820,7 @@ extern int open_pack_index(struct packed_git *);
 extern unsigned char* use_pack(struct packed_git *, struct pack_window **, off_t, unsigned int *);
 extern void close_pack_windows(struct packed_git *);
 extern void unuse_pack(struct pack_window **);
+extern void free_pack_by_name(const char *);
 extern struct packed_git *add_packed_git(const char *, int, int);
 extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t);
 extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t);
diff --git a/sha1_file.c b/sha1_file.c
index 6c0e251..0e021c5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -673,6 +673,37 @@ void unuse_pack(struct pack_window **w_cursor)
 }
 
 /*
+ * This is used by git-repack in case a newly created pack happens to
+ * contain the same set of objects as an existing one.  In that case
+ * the resulting file might be different even if its name would be the
+ * same.  It is best to close any reference to the old pack before it is
+ * replaced on disk.  Of course no index pointers nor windows for given pack
+ * must subsist at this point.  If ever objects from this pack are requested
+ * again, the new version of the pack will be reinitialized through
+ * reprepare_packed_git().
+ */
+void free_pack_by_name(const char *pack_name)
+{
+	struct packed_git *p, **pp = &packed_git;
+
+	while (*pp) {
+		p = *pp;
+		if (strcmp(pack_name, p->pack_name) == 0) {
+			close_pack_windows(p);
+			if (p->pack_fd != -1)
+				close(p->pack_fd);
+			if (p->index_data)
+				munmap((void *)p->index_data, p->index_size);
+			free(p->bad_object_sha1);
+			*pp = p->next;
+			free(p);
+			return;
+		}
+		pp = &p->next;
+	}
+}
+
+/*
  * Do not call this directly as this leaks p->pack_fd on error return;
  * call open_packed_git() instead.
  */
