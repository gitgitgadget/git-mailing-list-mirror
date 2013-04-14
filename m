From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 27/33] pack_refs(): change to use do_for_each_entry()
Date: Sun, 14 Apr 2013 14:54:42 +0200
Message-ID: <1365944088-10588-28-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 15:03:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMai-0004wC-GI
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 15:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837Ab3DNNDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 09:03:25 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:59222 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751631Ab3DNNDX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 09:03:23 -0400
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Apr 2013 09:03:23 EDT
X-AuditID: 1207440d-b7fd06d000000905-b2-516aa75f08c1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 57.1F.02309.F57AA615; Sun, 14 Apr 2013 08:55:59 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAkO007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:57 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsUixO6iqBu/PCvQ4Ox2VouuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M6YOGcxe8E30Yo1X24zNzB+Fuxi5OSQEDCR+HnmBTOELSZx4d56ti5GLg4hgcuMEt+3
	r2OGcM4ySby/s4oFpIpNQFdiUU8zUxcjB4eIQLbE7rXyIGFmAQeJzZ8bGUHCwgKuEvemsoOY
	LAKqElNfaIBU8AJFJ6y8zQ6xSkHi+PZtjCA2J1B8+vNjYHEhAReJWZtns05g5F3AyLCKUS4x
	pzRXNzcxM6c4NVm3ODkxLy+1SNdILzezRC81pXQTIySceHcw/l8nc4hRgINRiYf3BWNWoBBr
	YllxZe4hRkkOJiVR3p5lQCG+pPyUyozE4oz4otKc1OJDjBIczEoivI6tQDnelMTKqtSifJiU
	NAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgTv66VAjYJFqempFWmZOSUIaSYOThDBBbKB
	B2jDW5BC3uKCxNzizHSIolOMilLivCkgZwmAJDJK8+AGwCL/FaM40D/CvE9B2nmASQOu+xXQ
	YCagwT5700EGlyQipKQaGNNORlg3aM2q/rojdYvM1c7Wq/2VG/5qXf117maytqKXXXG8Yvv9
	hIrJU/YdXDnJcV/fsm7Fd0I6e10Wd8su/sLIPufCzLumThGbpA39tgcGH+vk82eyv+knf/bl
	6gl+tvJRNz4p3pydliux48AipfmNkT72u7LFpHNFLwfNUHJ4qCZ9kWHBNyWW4oxE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221133>

pack_refs() was not using any of the extra features of for_each_ref(),
so change it to use do_for_each_entry().  This also gives it access to
the ref_entry and in particular its peeled field, which will be taken
advantage of in the next commit.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index e0411c5..471d71d 100644
--- a/refs.c
+++ b/refs.c
@@ -2001,37 +2001,38 @@ static int do_not_prune(int flags)
 	return (flags & (REF_ISSYMREF|REF_ISPACKED));
 }
 
-static int pack_one_ref(const char *refname, const unsigned char *sha1,
-			  int flags, void *cb_data)
+static int pack_one_ref(struct ref_entry *entry, void *cb_data)
 {
 	struct pack_refs_cb_data *cb = cb_data;
 	struct object *o;
 	int is_tag_ref;
 
-	/* Do not pack the symbolic refs */
-	if ((flags & REF_ISSYMREF))
+	/* Do not pack symbolic or broken refs: */
+	if ((entry->flag & REF_ISSYMREF) || !ref_resolves_to_object(entry, 0))
 		return 0;
-	is_tag_ref = !prefixcmp(refname, "refs/tags/");
+	is_tag_ref = !prefixcmp(entry->name, "refs/tags/");
 
 	/* ALWAYS pack refs that were already packed or are tags */
-	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref && !(flags & REF_ISPACKED))
+	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref &&
+	    !(entry->flag & REF_ISPACKED))
 		return 0;
 
-	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), refname);
+	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(entry->u.value.sha1),
+		entry->name);
 
-	o = parse_object_or_die(sha1, refname);
+	o = parse_object_or_die(entry->u.value.sha1, entry->name);
 	if (o->type == OBJ_TAG) {
-		o = deref_tag(o, refname, 0);
+		o = deref_tag(o, entry->name, 0);
 		if (o)
 			fprintf(cb->refs_file, "^%s\n",
 				sha1_to_hex(o->sha1));
 	}
 
-	if ((cb->flags & PACK_REFS_PRUNE) && !do_not_prune(flags)) {
-		int namelen = strlen(refname) + 1;
+	if ((cb->flags & PACK_REFS_PRUNE) && !do_not_prune(entry->flag)) {
+		int namelen = strlen(entry->name) + 1;
 		struct ref_to_prune *n = xcalloc(1, sizeof(*n) + namelen);
-		hashcpy(n->sha1, sha1);
-		strcpy(n->name, refname);
+		hashcpy(n->sha1, entry->u.value.sha1);
+		strcpy(n->name, entry->name);
 		n->next = cb->ref_to_prune;
 		cb->ref_to_prune = n;
 	}
@@ -2108,7 +2109,7 @@ int pack_refs(unsigned int flags)
 	/* perhaps other traits later as well */
 	fprintf(cbdata.refs_file, "# pack-refs with: peeled fully-peeled \n");
 
-	for_each_ref(pack_one_ref, &cbdata);
+	do_for_each_entry(NULL, "", pack_one_ref, &cbdata);
 	if (ferror(cbdata.refs_file))
 		die("failed to write ref-pack file");
 	if (fflush(cbdata.refs_file) || fsync(fd) || fclose(cbdata.refs_file))
-- 
1.8.2.1
