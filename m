From: Nicolas Pitre <nico@cam.org>
Subject: Re: Weird growth in packfile during initial push
Date: Wed, 15 Apr 2009 15:51:40 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904151443030.6741@xanadu.home>
References: <20090415182754.GF23644@curie-int>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 21:53:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuBAu-0005EO-Oh
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 21:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594AbZDOTwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 15:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbZDOTwB
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 15:52:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23502 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893AbZDOTwA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 15:52:00 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KI5005VLR4DUCD1@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 15 Apr 2009 15:50:38 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090415182754.GF23644@curie-int>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116646>

On Wed, 15 Apr 2009, Robin H. Johnson wrote:

> I was doing a more recent conversion of the Gentoo repo, and ran into
> some odd behavior in the packfile size.
> 
> For anybody else following the repo, you can now get it on the new hardware at:
> http://git-exp.overlays.gentoo.org/gitweb/?p=exp/gentoo-x86.git;a=summary
> 
> I did the conversion with cvs2svn, packed, added the remote and pushed, only to
> find that the pack on the remote side suddenly seemed to be ~60MiB larger.

Hmmm.

> $ ls -la /tmp/convert/gentoo-x86-cvs2git/.git/objects/pack
> total 903804
> drwxr-xr-x 2 robbat2 users       119 Apr 14 08:05 .
> drwxr-xr-x 4 robbat2 users        28 Apr 14 08:05 ..
> -r--r--r-- 1 robbat2 users 139155472 Apr 14 08:05 pack-f805bb448f864becfeac9c7f8a8ac2ef90c26787.idx
> -r--r--r-- 1 robbat2 users 786336481 Apr 14 08:05 pack-f805bb448f864becfeac9c7f8a8ac2ef90c26787.pack
> 
> $ git remote add origin git+ssh://git@git-exp.overlays.gentoo.org/exp/gentoo-x86.git
> $ git push origin master:master
> Initialized empty Git repository in /var/gitroot/exp/gentoo-x86.git/
> Counting objects: 4969800, done.
> Delta compression using up to 8 threads.
> Compressing objects: 100% (1217809/1217809), done.
> Writing objects: 100% (4969800/4969800), 810.56 MiB | 21608 KiB/s, done.
> Total 4969800 (delta 3735812), reused 4969800 (delta 3735812)

Here we know for sure that all objects were directly reused, so no 
attempt at recompressing them was done.  The only thing that 
pack-objects might do in this case in addition to directly streaming the 
existing pack is to convert delta object headers from OFS_DELTA to 
REF_DELTA.

> $ ls -la /var/gitroot/exp/gentoo-x86.git/objects/pack
> total 966876
> drwxr-xr-x 2 git git      4096 Apr 14 08:43 .
> drwxr-xr-x 4 git git      4096 Apr 14 08:35 ..
> -r--r--r-- 1 git git 139155472 Apr 14 08:43 pack-f805bb448f864becfeac9c7f8a8ac2ef90c26787.idx
> -r--r--r-- 1 git git 849936308 Apr 14 08:43 pack-f805bb448f864becfeac9c7f8a8ac2ef90c26787.pack

Let's see if my theory stands:

	849936308 - 786336481 = 63599827
	63599827 / 3735812 = 17.02

Hence an average difference of 17 bytes per delta.  Given that REF_DELTA 
objects have a 20-byte SHA1 base reference which is replaced with a 
variable length encoding of a pack offset in the OFS_DELTA case, we're 
talking about 2.98 bytes for that offset encoding which feels about 
right.

[...]

And the code matches this theory as well.  Can you try this patch if you 
have a chance?

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 91c3651..e41adbf 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -44,12 +44,16 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		"--stdout",
 		NULL,
 		NULL,
+		NULL,
 	};
 	struct child_process po;
 	int i;
 
+	i = 4;
 	if (args->use_thin_pack)
-		argv[4] = "--thin";
+		argv[i++] = "--thin";
+	if (args->use_ofs_delta)
+		argv[i++] = "--delta-base-offset";
 	memset(&po, 0, sizeof(po));
 	po.argv = argv;
 	po.in = -1;
@@ -316,6 +320,8 @@ int send_pack(struct send_pack_args *args,
 		ask_for_status_report = 1;
 	if (server_supports("delete-refs"))
 		allow_deleting_refs = 1;
+	if (server_supports("ofs-delta"))
+		args->use_ofs_delta = 1;
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
diff --git a/send-pack.h b/send-pack.h
index 83d76c7..1d7b1b3 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -6,6 +6,7 @@ struct send_pack_args {
 		send_mirror:1,
 		force_update:1,
 		use_thin_pack:1,
+		use_ofs_delta:1,
 		dry_run:1;
 };
 


Nicolas
