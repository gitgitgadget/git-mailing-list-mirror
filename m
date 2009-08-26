From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fix simple deepening of a repo
Date: Tue, 25 Aug 2009 19:10:57 -0700
Message-ID: <20090826021057.GL1033@spearce.org>
References: <alpine.LFD.2.00.0908232320410.6044@xanadu.home> <7vocq5q0j7.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0908240144530.28290@iabervon.org> <alpine.LNX.2.00.0908242212260.26869@reaper.quantumfyre.co.uk> <alpine.LFD.2.00.0908242001250.6044@xanadu.home> <20090825021223.GE1033@spearce.org> <7vab1osc2m.fsf@alter.siamese.dyndns.org> <20090825061248.GG1033@spearce.org> <7vy6p8pfm1.fsf@alter.siamese.dyndns.org> <20090825151424.GJ1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 04:11:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg7yc-00067R-6J
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 04:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932836AbZHZCK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 22:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932834AbZHZCKz
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 22:10:55 -0400
Received: from george.spearce.org ([209.20.77.23]:46466 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932810AbZHZCKz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 22:10:55 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 249B8381FD; Wed, 26 Aug 2009 02:10:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090825151424.GJ1033@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127059>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > So I think that expand-refs is a much nicer general solution than just
> > "server side is configured to hide but still allow certain refs", and
> > client updates cannot be avoided.
> 
> Yes, I agree.
...
> I'm thinking about writing an RFC patch for this today for git.git.

RFC patch below.  This is only the upload-pack side, and lacks
test, etc, so its posted *ONLY* for discussion.  I'll try to flesh
it out further tomorrow into something that could be considered
more seriously.

--8<--
[RFC] upload-pack: expand capability advertises additional refs

The expand capability and associated command permits the client
to ask for information about refs which were not in the initial
advertisement sent when the connection was first opened.

In the below exchange the server initially only advertises its
current HEAD, refs/heads and refs/tags namespaces.  However,
the client has been instructed to fetch anything which matches
refs/remotes/jc/*.

Since no matching refs appeared in the initial advertisement,
the client requests the server to expand the desired pattern,
and terminates its expand request list with a flush.

Upon receiving a flush from the client, the server displays any
local refs which match any of the expand patterns requested,
and then closes this secondary advertisement list with a flush.
If no refs matched, the server immediately returns a flush.

If multiple expand patterns match the same ref, the ref is returned
only once in the secondary advertisement, avoid confusing the client
with duplicate results.

  S: 008f... HEAD\0...include-tag expand
  S: 0043... refs/heads/build-next
  S: 0040... refs/tags/v1.6.4.1
  S: 0043... refs/tags/v1.6.4.1^{}
  S: 0000

  C: 001dexpand refs/remotes/jc/*
  C: 0000

  S: 0043... refs/remotes/jc/maint
  S: 0044... refs/remotes/jc/master
  S: 0000

  C: 0031want ...
  C: 0000

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Shawn O. Pearce <sop@google.com>
---
 upload-pack.c |   97 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 91 insertions(+), 6 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 4d8be83..e1ec608 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -10,6 +10,8 @@
 #include "revision.h"
 #include "list-objects.h"
 #include "run-command.h"
+#include "remote.h"
+#include "string-list.h"
 
 static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=nn] <dir>";
 
@@ -30,6 +32,18 @@ static int multi_ack, nr_our_refs;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
 static int no_progress, daemon_mode;
 static int shallow_nr;
+
+struct adv_ref {
+	struct adv_ref *next;
+	char *name;
+	unsigned pattern:1;
+};
+static struct adv_ref *to_advertise;
+static struct adv_ref **advertise_tail = &to_advertise;
+
+static struct ref *local_refs;
+static struct ref **refs_tail = &local_refs;
+
 static struct object_array have_obj;
 static struct object_array want_obj;
 static unsigned int timeout;
@@ -470,6 +484,17 @@ static int get_common_commits(void)
 	}
 }
 
+static void push_advertise(const char *name)
+{
+	struct adv_ref *adv = xcalloc(1, sizeof(*adv));
+	adv->name = xstrdup(name);
+	adv->pattern = !!strchr(adv->name, '*');
+	*advertise_tail = adv;
+	advertise_tail = &adv->next;
+}
+
+static void send_refs(void);
+
 static void receive_needs(void)
 {
 	struct object_array shallows = {0, 0, NULL};
@@ -484,11 +509,22 @@ static void receive_needs(void)
 		unsigned char sha1_buf[20];
 		len = packet_read_line(0, line, sizeof(line));
 		reset_timeout();
-		if (!len)
+		if (!len) {
+			if (to_advertise) {
+				send_refs();
+				continue;
+			}
 			break;
+		}
 		if (debug_fd)
 			write_in_full(debug_fd, line, len);
 
+		if (!prefixcmp(line, "expand ")) {
+			if (line[len - 1] == '\n')
+				line[len - 1] = 0;
+			push_advertise(line + 7);
+			continue;
+		}
 		if (!prefixcmp(line, "shallow ")) {
 			unsigned char sha1[20];
 			struct object *object;
@@ -603,11 +639,14 @@ static void receive_needs(void)
 	free(shallows.objects);
 }
 
-static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int send_ref(struct string_list_item *item, void *cb_data)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag";
+		" include-tag expand";
+	const struct ref *ref = item->util;
+	const char *refname = ref->name;
+	const unsigned char *sha1 = ref->new_sha1;
 	struct object *o = parse_object(sha1);
 
 	if (!o)
@@ -631,12 +670,58 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	return 0;
 }
 
+static void send_refs(void)
+{
+	struct ref *to_send = NULL, **tail = &to_send;
+	struct ref *ref;
+	struct adv_ref *adv, *next_adv;
+	struct string_list sorted_names;
+
+	for (adv = to_advertise; adv; adv = next_adv) {
+		struct refspec spec;
+
+		memset(&spec, 0, sizeof(spec));
+		spec.pattern = adv->pattern;
+		spec.src = adv->name;
+		spec.dst = adv->name;
+		next_adv = adv->next;
+		get_fetch_map(local_refs, &spec, &tail, 1);
+
+		free(adv->name);
+		free(adv);
+	}
+	to_advertise = NULL;
+	advertise_tail = &to_advertise;
+
+	memset(&sorted_names, 0, sizeof(sorted_names));
+	for (ref = to_send; ref; ref = ref->next)
+		string_list_insert(ref->name, &sorted_names)->util = ref;
+	for_each_string_list(send_ref, &sorted_names, NULL);
+	string_list_clear(&sorted_names, 0);
+	free_refs(to_send);
+	packet_flush(1);
+}
+
+static int scan_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+{
+	struct ref *r = alloc_ref(refname);
+	hashcpy(r->new_sha1, sha1);
+	*refs_tail = r;
+	refs_tail = &r->next;
+	return 0;
+}
+
 static void upload_pack(void)
 {
 	reset_timeout();
-	head_ref(send_ref, NULL);
-	for_each_ref(send_ref, NULL);
-	packet_flush(1);
+	head_ref(scan_ref, NULL);
+	for_each_ref(scan_ref, NULL);
+
+	push_advertise("HEAD");
+	push_advertise("refs/heads/*");
+	push_advertise("refs/tags/*");
+	send_refs();
+
 	receive_needs();
 	if (want_obj.nr) {
 		get_common_commits();
-- 
1.6.4.1.331.gda1d56

-- 
Shawn.
