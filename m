From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] allow OFS_DELTA objects during a push
Date: Fri, 01 May 2009 16:56:47 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905011616130.6741@xanadu.home>
References: <20090415182754.GF23644@curie-int>
 <alpine.LFD.2.00.0904151443030.6741@xanadu.home>
 <7vy6tj109a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 22:57:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzznM-0001l7-2O
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 22:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756500AbZEAU5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 16:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756441AbZEAU5K
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 16:57:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59324 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbZEAU5J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 16:57:09 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KIZ00GD5GUNVXH0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 01 May 2009 16:56:47 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vy6tj109a.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118096>

The fetching of OFS_DELTA objects has been negotiated between both peers 
since git version 1.4.4.  However, this was missing from the push side 
where every OFS_DELTA objects were always converted to REF_DELTA objects 
causing an increase in transferred data.

To fix this, both the client and the server processes have to be 
modified: the former to invoke pack-objects with --delta-base-offset 
when the server provides the ofs-delta capability, and the later to send 
that capability when OFS_DELTA objects are allowed as already indicated 
by the repack.usedeltabaseoffset config variable which is TRUE by 
default since git v1.6.0.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

On Wed, 29 Apr 2009, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Hence an average difference of 17 bytes per delta.  Given that REF_DELTA 
> > objects have a 20-byte SHA1 base reference which is replaced with a 
> > variable length encoding of a pack offset in the OFS_DELTA case, we're 
> > talking about 2.98 bytes for that offset encoding which feels about 
> > right.
> >
> > [...]
> >
> > And the code matches this theory as well.  Can you try this patch if you 
> > have a chance?
> 
> Is there any progress on this?
> 
> I think you did a veryclear analysis.  8% size reduction is not only
> unignorable but use of delta offset should also help runtime efficiency,
> right?

Indeed.

Here's the final patch.  My initial one didn't work because the server 
side didn't advertise the needed capability.  So both sides will have to 
be updated for pushes with OFS_DELTA to kick in.

 builtin-receive-pack.c |   22 +++++++++++++++-------
 builtin-send-pack.c    |    8 +++++++-
 send-pack.h            |    1 +
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index a970b39..4b9d921 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -27,10 +27,9 @@ static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
 static int report_status;
+static int prefer_ofs_delta = 1;
 static const char *head_name;
-
-static char capabilities[] = " report-status delete-refs ";
-static int capabilities_sent;
+static char *capabilities_to_send;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -84,24 +83,29 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "repack.usedeltabaseoffset") == 0) {
+		prefer_ofs_delta = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
 static int show_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
-	if (capabilities_sent)
+	if (!capabilities_to_send)
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
 	else
 		packet_write(1, "%s %s%c%s\n",
-			     sha1_to_hex(sha1), path, 0, capabilities);
-	capabilities_sent = 1;
+			     sha1_to_hex(sha1), path, 0, capabilities_to_send);
+	capabilities_to_send = NULL;
 	return 0;
 }
 
 static void write_head_info(void)
 {
 	for_each_ref(show_ref, NULL);
-	if (!capabilities_sent)
+	if (capabilities_to_send)
 		show_ref("capabilities^{}", null_sha1, 0, NULL);
 
 }
@@ -687,6 +691,10 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	else if (0 <= receive_unpack_limit)
 		unpack_limit = receive_unpack_limit;
 
+	capabilities_to_send = (prefer_ofs_delta) ?
+		" report-status delete-refs ofs-delta " :
+		" report-status delete-refs ";
+
 	add_alternate_refs();
 	write_head_info();
 	clear_extra_refs();
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index d5a1c48..473a3de 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -43,12 +43,16 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
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
@@ -315,6 +319,8 @@ int send_pack(struct send_pack_args *args,
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
 
