From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] treap: make treap_insert return inserted node
Date: Sun, 5 Dec 2010 03:35:17 -0600
Message-ID: <20101205093517.GE4332@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120005334.GL17445@burratino>
 <20101130194833.GA9064@burratino>
 <20101205093357.GD4332@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 10:35:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPB0R-0006oA-JQ
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 10:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066Ab0LEJfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 04:35:38 -0500
Received: from mail-iw0-f194.google.com ([209.85.214.194]:33702 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab0LEJfg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 04:35:36 -0500
Received: by iwn6 with SMTP id 6so694965iwn.1
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 01:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rweWke5T3WZPBDjKPvGmGQP1TjKPrT71CjTZtMIwMek=;
        b=nUwK/b+mYj3SnEQGkCgOxC82PYWKgZOLrD3o+j8A0+ewYadTHznL0zgZch3KIvcJTh
         sGZ8t2wsfVBMT6VHODqYyKdOdFOKqb4olbURTKm4Pjn+4hqs7WMIohO/oEfl/hOfTKg+
         U9SfGYHyrwtl6v3tYrL6qcIOUiqxPZD1Ne9zM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QqxgYUgRLp7MBYPQSWyDpZgX5Vxv4Dp1kDuWySFZ8cH0Sxj7rTQKoztMLCmMbiQmJI
         2r0JKW15nxg64UBEXuQJUGv8Ue/EoeeW42SP++02IHE+8AWXvVYiHRZLkS2Nnl0i5IpZ
         0nEFOFxWrGDn/ftz0cuCps18dNNH/Q4dgx534=
Received: by 10.231.166.207 with SMTP id n15mr4272835iby.115.1291541735700;
        Sun, 05 Dec 2010 01:35:35 -0800 (PST)
Received: from burratino ([68.255.109.73])
        by mx.google.com with ESMTPS id 34sm3704640ibi.20.2010.12.05.01.35.33
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Dec 2010 01:35:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101205093357.GD4332@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162933>

Suppose I try the following:

	struct int_node *node = node_pointer(node_alloc(1));
	node->n = 5;
	treap_insert(&root, node);
	printf("%d\n", node->n);

Usually the result will be 5.  But since treap_insert draws memory
from the node pool, if the caller is unlucky then (1) the node pool
will be full and (2) realloc will be forced to move the node pool to
find room, so the node address becomes invalid and the result of
dereferencing it is undefined.

So we ought to use offsets in preference to pointers for references
that would remain valid after a call to treap_insert.  Tweak the
signature to hint at a certain special case: since the inserted node
can change address (though not offset), as a convenience teach
treap_insert to return its new address.

So the motivational example could be fixed by adding "node =".

	struct int_node *node = node_pointer(node_alloc(1));
	node->n = 5;
	node = treap_insert(&root, node);
	printf("%d\n", node->n);

Based on a true story.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
[resending to list --- sorry for the mess.]

 test-treap.c    |   11 ++++++++---
 vcs-svn/trp.h   |    3 ++-
 vcs-svn/trp.txt |   10 ++++++++--
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/test-treap.c b/test-treap.c
index cdba511..ab8c951 100644
--- a/test-treap.c
+++ b/test-treap.c
@@ -38,9 +38,14 @@ int main(int argc, char *argv[])
 		usage("test-treap < ints");
 
 	while (strbuf_getline(&sb, stdin, '\n') != EOF) {
-		item = node_alloc(1);
-		strtonode(node_pointer(item), sb.buf);
-		treap_insert(&root, node_pointer(item));
+		struct int_node *node = node_pointer(node_alloc(1));
+
+		item = node_offset(node);
+		strtonode(node, sb.buf);
+		node = treap_insert(&root, node_pointer(item));
+		if (node_offset(node) != item)
+			die("inserted %"PRIu32" in place of %"PRIu32"",
+				node_offset(node), item);
 	}
 
 	item = node_offset(treap_first(&root));
diff --git a/vcs-svn/trp.h b/vcs-svn/trp.h
index ee35c68..c32b918 100644
--- a/vcs-svn/trp.h
+++ b/vcs-svn/trp.h
@@ -188,11 +188,12 @@ a_attr uint32_t MAYBE_UNUSED a_pre##insert_recurse(uint32_t cur_node, uint32_t i
 		return ret; \
 	} \
 } \
-a_attr void MAYBE_UNUSED a_pre##insert(struct trp_root *treap, a_type *node) \
+a_attr a_type *MAYBE_UNUSED a_pre##insert(struct trp_root *treap, a_type *node) \
 { \
 	uint32_t offset = trpn_offset(a_base, node); \
 	trp_node_new(a_base, a_field, offset); \
 	treap->trp_root = a_pre##insert_recurse(treap->trp_root, offset); \
+	return trpn_pointer(a_base, offset); \
 } \
 a_attr uint32_t MAYBE_UNUSED a_pre##remove_recurse(uint32_t cur_node, uint32_t rem_node) \
 { \
diff --git a/vcs-svn/trp.txt b/vcs-svn/trp.txt
index eb4c191..5ca6b42 100644
--- a/vcs-svn/trp.txt
+++ b/vcs-svn/trp.txt
@@ -21,7 +21,9 @@ The caller:
 
 . Allocates a `struct trp_root` variable and sets it to {~0}.
 
-. Adds new nodes to the set using `foo_insert`.
+. Adds new nodes to the set using `foo_insert`.  Any pointers
+  to existing nodes cannot be relied upon any more, so the caller
+  might retrieve them anew with `foo_pointer`.
 
 . Can find a specific item in the set using `foo_search`.
 
@@ -73,10 +75,14 @@ int (*cmp)(node_type \*a, node_type \*b)
 and returning a value less than, equal to, or greater than zero
 according to the result of comparison.
 
-void foo_insert(struct trp_root *treap, node_type \*node)::
+node_type {asterisk}foo_insert(struct trp_root *treap, node_type \*node)::
 
 	Insert node into treap.  If inserted multiple times,
 	a node will appear in the treap multiple times.
++
+The return value is the address of the node within the treap,
+which might differ from `node` if `pool_alloc` had to call
+`realloc` to expand the pool.
 
 void foo_remove(struct trp_root *treap, node_type \*node)::
 
-- 
1.7.2.4
