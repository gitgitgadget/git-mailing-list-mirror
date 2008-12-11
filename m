From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: epic fsck SIGSEGV! (was Recovering from epic fail (deleted
 .git/objects/pack))
Date: Wed, 10 Dec 2008 19:44:37 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812101930590.3340@localhost.localdomain>
References: <1228867861.14165.19.camel@starfruit.local> <7vd4g051ax.fsf@gitster.siamese.dyndns.org> <1228903606.4445.53.camel@starfruit.local> <493FAA5A.8070801@viscovery.net> <1228949523.27061.20.camel@starfruit.local> <alpine.LFD.2.00.0812101523570.3340@localhost.localdomain>
 <alpine.LFD.2.00.0812102031440.14328@xanadu.home> <alpine.LFD.2.00.0812101854230.3340@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "R. Tyler Ballance" <tyler@slide.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 04:46:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAcV6-0003RM-0b
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 04:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475AbYLKDov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 22:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbYLKDov
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 22:44:51 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53346 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751666AbYLKDot (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2008 22:44:49 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBB3ieF1001675
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Dec 2008 19:44:41 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBB3ibkj019708;
	Wed, 10 Dec 2008 19:44:38 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0812101854230.3340@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.426 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102771>



On Wed, 10 Dec 2008, Linus Torvalds wrote:
> 
> On Wed, 10 Dec 2008, Nicolas Pitre wrote:
> 
> > On Wed, 10 Dec 2008, Linus Torvalds wrote:
> > 
> > > But we should definitely fix this braindamage in fsck. Rather than 
> > > recursively walk the commits, we should add them to a commit list and just 
> > > walk the list iteratively.
> > 
> > What about:
> > 
> > 	http://marc.info/?l=git&m=122889563424786&w=2
> 
> Not very pretty. The basic notion is ok, but wouldn't it be nicer to at 
> least use a "struct object_array" instead?
> 
> Let me try to cook something up.

I dunno. I like this patch better. It's a bit larger. I think it's a bit 
more clearly separated (ie a "mark_object_reachable()" _literally_ just 
puts the object on a list, and the whole traversal is a whole separate 
phase), but I guess it's a matter of taste.

It has gotten no real testing. Caveat emptor. And I didn't even bother to 
check that it can run with less stack or that it makes any other 
difference.

			Linus

---
 builtin-fsck.c |   38 +++++++++++++++++++++++++++++++-------
 1 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index afded5e..297b2c4 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -64,11 +64,11 @@ static int fsck_error_func(struct object *obj, int type, const char *err, ...)
 	return (type == FSCK_WARN) ? 0 : 1;
 }
 
+static struct object_array pending;
+
 static int mark_object(struct object *obj, int type, void *data)
 {
-	struct tree *tree = NULL;
 	struct object *parent = data;
-	int result;
 
 	if (!obj) {
 		printf("broken link from %7s %s\n",
@@ -96,6 +96,20 @@ static int mark_object(struct object *obj, int type, void *data)
 		return 1;
 	}
 
+	add_object_array(obj, (void *) parent, &pending);
+	return 0;
+}
+
+static void mark_object_reachable(struct object *obj)
+{
+	mark_object(obj, OBJ_ANY, 0);
+}
+
+static int traverse_one_object(struct object *obj, struct object *parent)
+{
+	int result;
+	struct tree *tree = NULL;
+
 	if (obj->type == OBJ_TREE) {
 		obj->parsed = 0;
 		tree = (struct tree *)obj;
@@ -107,15 +121,22 @@ static int mark_object(struct object *obj, int type, void *data)
 		free(tree->buffer);
 		tree->buffer = NULL;
 	}
-	if (result < 0)
-		result = 1;
-
 	return result;
 }
 
-static void mark_object_reachable(struct object *obj)
+static int traverse_reachable(void)
 {
-	mark_object(obj, OBJ_ANY, 0);
+	int result = 0;
+	while (pending.nr) {
+		struct object_array_entry *entry;
+		struct object *obj, *parent;
+
+		entry = pending.objects + --pending.nr;
+		obj = entry->item;
+		parent = (struct object *) entry->name;
+		result |= traverse_one_object(obj, parent);
+	}
+	return !!result;
 }
 
 static int mark_used(struct object *obj, int type, void *data)
@@ -237,6 +258,9 @@ static void check_connectivity(void)
 {
 	int i, max;
 
+	/* Traverse the pending reachable objects */
+	traverse_reachable();
+
 	/* Look up all the requirements, warn about missing objects.. */
 	max = get_max_object_index();
 	if (verbose)
