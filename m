From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] lookup_object(): Speed up 'git gc' by 12%, by reducing
 hash chain length
Date: Fri, 29 Apr 2011 09:26:04 +0200
Message-ID: <20110429072604.GA16371@elte.hu>
References: <20110427213502.GA13647@elte.hu>
 <7vtydh1r3q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 09:26:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFi5m-0004N3-Ub
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 09:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924Ab1D2H0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 03:26:16 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:42802 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754747Ab1D2H0P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 03:26:15 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1QFi5X-000211-LL
	from <mingo@elte.hu>; Fri, 29 Apr 2011 09:26:13 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 110F13E2510; Fri, 29 Apr 2011 09:26:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vtydh1r3q.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.3.1
	-2.0 BAYES_00               BODY: Bayes spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172431>


* Junio C Hamano <gitster@pobox.com> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> > diff --git a/object.c b/object.c
> > index 7e1f2bb..b3fe485 100644
> > --- a/object.c
> > +++ b/object.c
> > @@ -91,7 +91,7 @@ struct object *lookup_object(const unsigned char *sha1)
> >  static void grow_object_hash(void)
> >  {
> >  	int i;
> > -	int new_hash_size = obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
> > +	int new_hash_size = obj_hash_size < 32 ? 32 : 16 * obj_hash_size;
> >  	struct object **new_hash;
> >  
> >  	new_hash = xcalloc(new_hash_size, sizeof(struct object *));
> > @@ -116,7 +116,7 @@ void *create_object(const unsigned char *sha1, int type, void *o)
> >  	obj->flags = 0;
> >  	hashcpy(obj->sha1, sha1);
> >  
> > -	if (obj_hash_size - 1 <= nr_objs * 2)
> > +	if (obj_hash_size - 1 <= nr_objs * 16)
> >  		grow_object_hash();
> >  
> >  	insert_obj_hash(obj, obj_hash, obj_hash_size);
> 
> Shawn was telling me about this exact topic a few months ago, and I do
> agree that object hash grows too slowly when you need to slurp in many
> objects.

I think the main effect might not be the rate of growth and reduced overhead of 
reallocating and reconstructing the hash 4-6 times, but the *spread* of objects 
within the hash table - i.e. the maximum (i.e. optimal) size of the hash.

In a git gc run the hash grows to the max very quickly, then 99% of execution 
time is spent with that optimally sized hash - so growth rate per se does not 
matter much. (it might matter in other usecases)

Find below a debug patch i use to run with a configurable spread.

Note, i just ran the patch on a different system and there the effect was much 
less pronounced. So i'd prefer independent confirmation as well that it speeds 
up things for others as well.

I'll run more numbers - maybe we are just very sensitive to the exact layout of 
the object hash and a 16x spread created a different, more optimal layout.

Thanks,

	Ingo

---

 git.c    |    6 ++++++
 object.c |    5 +++--
 object.h |    1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 4b7dbfa..4c59316 100644
--- a/git.c
+++ b/git.c
@@ -4,6 +4,7 @@
 #include "help.h"
 #include "quote.h"
 #include "run-command.h"
+#include "object.h"
 
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=<path>]] [--html-path]\n"
@@ -97,6 +98,11 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			exit(0);
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
 			use_pager = 1;
+		} else if (!strcmp(cmd, "--object-hash-spread")) {
+			object_hash_spread = atol((*argv)[1]);
+			printf("object hash spread: %d\n", object_hash_spread);
+			(*argv)++;
+			(*argc)--;
 		} else if (!strcmp(cmd, "--no-pager")) {
 			use_pager = 0;
 			if (envchanged)
diff --git a/object.c b/object.c
index 7e1f2bb..3d16a8a 100644
--- a/object.c
+++ b/object.c
@@ -7,6 +7,7 @@
 
 static struct object **obj_hash;
 static int nr_objs, obj_hash_size;
+int object_hash_spread = 2;
 
 unsigned int get_max_object_index(void)
 {
@@ -91,7 +92,7 @@ struct object *lookup_object(const unsigned char *sha1)
 static void grow_object_hash(void)
 {
 	int i;
-	int new_hash_size = obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
+	int new_hash_size = obj_hash_size < 32 ? 32 : object_hash_spread * obj_hash_size;
 	struct object **new_hash;
 
 	new_hash = xcalloc(new_hash_size, sizeof(struct object *));
@@ -116,7 +117,7 @@ void *create_object(const unsigned char *sha1, int type, void *o)
 	obj->flags = 0;
 	hashcpy(obj->sha1, sha1);
 
-	if (obj_hash_size - 1 <= nr_objs * 2)
+	if (obj_hash_size - 1 <= nr_objs * object_hash_spread)
 		grow_object_hash();
 
 	insert_obj_hash(obj, obj_hash, obj_hash_size);
diff --git a/object.h b/object.h
index b6618d9..180a6c1 100644
--- a/object.h
+++ b/object.h
@@ -75,5 +75,6 @@ int object_list_contains(struct object_list *list, struct object *obj);
 void add_object_array(struct object *obj, const char *name, struct object_array *array);
 void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode);
 void object_array_remove_duplicates(struct object_array *);
+extern int object_hash_spread;
 
 #endif /* OBJECT_H */
