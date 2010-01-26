From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH v4] Threaded grep
Date: Tue, 26 Jan 2010 12:43:03 +0100
Message-ID: <20100126114303.GA1854@fredrik-laptop>
References: <20100125225139.GA3048@fredrik-laptop>
 <7vpr4x1x20.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 12:43:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZjpD-0000fi-OQ
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 12:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282Ab0AZLnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 06:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193Ab0AZLnM
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 06:43:12 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:55550 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab0AZLnK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 06:43:10 -0500
Received: by ewy19 with SMTP id 19so864634ewy.21
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 03:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dBm2GCahAlAlblRjpUBp+AfBCJJ7SVbOxhRjOVn7flA=;
        b=gza0MlgbULrdhpFi7GmpVlVeVVuWeCpuv+m86ReTd0+lo1Uxss5BeUHxdKpcQAo6lx
         tTFFCkd2IkgXra0rQ63Lo+JF6Pn+eSBkmxHZvaxdHroB0W3CZvGOMN9xE1Ukh2QC3zBW
         BKIiulnK4VZn3P5SVVpgOx3BoUD902B6sm3zM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MAY62PeBSoVzsJJy4thkMrnjcmv4nRbEQLNvusOzFg14T7kxfOk/i9yHVoJdRvJ5PM
         4GhRvkDfI0fg8cle6DOLGVCLutj44egpbz1wcl0y35u6KQTPQuRnPIZKPJM1xIg2diq8
         D1nSK83TxCR9dFDZxKSwwmcDu/5aCIgIvc8/0=
Received: by 10.213.110.14 with SMTP id l14mr4960027ebp.82.1264506188851;
        Tue, 26 Jan 2010 03:43:08 -0800 (PST)
Received: from fredrik-laptop (c83-250-149-66.bredband.comhem.se [83.250.149.66])
        by mx.google.com with ESMTPS id 14sm5187578ewy.3.2010.01.26.03.43.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 03:43:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vpr4x1x20.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138032>

On Mon, Jan 25, 2010 at 05:20:39PM -0800, Junio C Hamano wrote:
> Fredrik Kuivinen <frekui@gmail.com> writes:
> 
> > The patch has been rebased on top of next.
> >
> > Additional changes since v3:
> >
> > * Fix some issues with Git's native pthreads implementation on
> >   Windows (pthread_cond_broadcast is still used though).
> > * Fix style issues.
> > * When greping in a tree, allocate memory for the data buffer as
> >   late as possible.
> > * Return void from grep_sha1_async and grep_file_async instead of
> >   always returning 0.
> 
> Thanks; I've fixed up a few old-style declaration header and queued the
> result to 'pu'.

I just noticed that I forgot to take the read_sha1 lock in
grep_tree. The result is a race condition in read_sha1_file.

Here is a patch to fix this. It applies on top of ae35c68 (Threaded
grep). Could you please squash it in? Let me know if you want me to
resend the entire patch instead.

(The only important thing is that we now take the read_sha1_mutex in
grep_tree. The rest is there just to make it self-consistent.)


- Fredrik

--- 8< ---

diff --git a/builtin-grep.c b/builtin-grep.c
index 7ecf222..6cc743d 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -75,10 +75,15 @@ static int todo_done;
 static int all_work_added;
 
 /* This lock protects all the variables above. */
-static pthread_mutex_t grep_lock;
+static pthread_mutex_t grep_mutex;
 
 /* Used to serialize calls to read_sha1_file. */
-static pthread_mutex_t read_sha1_lock;
+static pthread_mutex_t read_sha1_mutex;
+
+#define grep_lock() pthread_mutex_lock(&grep_mutex)
+#define grep_unlock() pthread_mutex_unlock(&grep_mutex)
+#define read_sha1_lock() pthread_mutex_lock(&read_sha1_mutex)
+#define read_sha1_unlock() pthread_mutex_unlock(&read_sha1_mutex)
 
 /* Signalled when a new work_item is added to todo. */
 static pthread_cond_t cond_add;
@@ -93,10 +98,10 @@ static pthread_cond_t cond_result;
 
 static void add_work(enum work_type type, char *name, void *id)
 {
-	pthread_mutex_lock(&grep_lock);
+	grep_lock();
 
 	while ((todo_end+1) % ARRAY_SIZE(todo) == todo_done) {
-		pthread_cond_wait(&cond_write, &grep_lock);
+		pthread_cond_wait(&cond_write, &grep_mutex);
 	}
 
 	todo[todo_end].type = type;
@@ -107,16 +112,16 @@ static void add_work(enum work_type type, char *name, void *id)
 	todo_end = (todo_end + 1) % ARRAY_SIZE(todo);
 
 	pthread_cond_signal(&cond_add);
-	pthread_mutex_unlock(&grep_lock);
+	grep_unlock();
 }
 
 static struct work_item *get_work(void)
 {
 	struct work_item *ret;
 
-	pthread_mutex_lock(&grep_lock);
+	grep_lock();
 	while (todo_start == todo_end && !all_work_added) {
-		pthread_cond_wait(&cond_add, &grep_lock);
+		pthread_cond_wait(&cond_add, &grep_mutex);
 	}
 
 	if (todo_start == todo_end && all_work_added) {
@@ -125,7 +130,7 @@ static struct work_item *get_work(void)
 		ret = &todo[todo_start];
 		todo_start = (todo_start + 1) % ARRAY_SIZE(todo);
 	}
-	pthread_mutex_unlock(&grep_lock);
+	grep_unlock();
 	return ret;
 }
 
@@ -148,7 +153,7 @@ static void work_done(struct work_item *w)
 {
 	int old_done;
 
-	pthread_mutex_lock(&grep_lock);
+	grep_lock();
 	w->done = 1;
 	old_done = todo_done;
 	for(; todo[todo_done].done && todo_done != todo_start;
@@ -165,7 +170,7 @@ static void work_done(struct work_item *w)
 	if (all_work_added && todo_done == todo_end)
 		pthread_cond_signal(&cond_result);
 
-	pthread_mutex_unlock(&grep_lock);
+	grep_unlock();
 }
 
 static void *run(void *arg)
@@ -181,11 +186,7 @@ static void *run(void *arg)
 		opt->output_priv = w;
 		if (w->type == WORK_SHA1) {
 			unsigned long sz;
-			void* data;
-
-			pthread_mutex_lock(&read_sha1_lock);
-			data = load_sha1(w->identifier, &sz, w->name);
-			pthread_mutex_unlock(&read_sha1_lock);
+			void* data = load_sha1(w->identifier, &sz, w->name);
 
 			if (data) {
 				hit |= grep_buffer(opt, w->name, data, sz);
@@ -218,8 +219,8 @@ static void start_threads(struct grep_opt *opt)
 {
 	int i;
 
-	pthread_mutex_init(&grep_lock, NULL);
-	pthread_mutex_init(&read_sha1_lock, NULL);
+	pthread_mutex_init(&grep_mutex, NULL);
+	pthread_mutex_init(&read_sha1_mutex, NULL);
 	pthread_cond_init(&cond_add, NULL);
 	pthread_cond_init(&cond_write, NULL);
 	pthread_cond_init(&cond_result, NULL);
@@ -246,18 +247,18 @@ static int wait_all(void)
 	int hit = 0;
 	int i;
 
-	pthread_mutex_lock(&grep_lock);
+	grep_lock();
 	all_work_added = 1;
 
 	/* Wait until all work is done. */
 	while (todo_done != todo_end)
-		pthread_cond_wait(&cond_result, &grep_lock);
+		pthread_cond_wait(&cond_result, &grep_mutex);
 
 	/* Wake up all the consumer threads so they can see that there
 	 * is no more work to do.
 	 */
 	pthread_cond_broadcast(&cond_add);
-	pthread_mutex_unlock(&grep_lock);
+	grep_unlock();
 
 	for (i = 0; i < ARRAY_SIZE(threads); i++) {
 		void *h;
@@ -265,8 +266,8 @@ static int wait_all(void)
 		hit |= (int) (intptr_t) h;
 	}
 
-	pthread_mutex_destroy(&grep_lock);
-	pthread_mutex_destroy(&read_sha1_lock);
+	pthread_mutex_destroy(&grep_mutex);
+	pthread_mutex_destroy(&read_sha1_mutex);
 	pthread_cond_destroy(&cond_add);
 	pthread_cond_destroy(&cond_write);
 	pthread_cond_destroy(&cond_result);
@@ -274,6 +275,9 @@ static int wait_all(void)
 	return hit;
 }
 #else /* !NO_PTHREADS */
+#define read_sha1_lock()
+#define read_sha1_unlock()
+
 static int wait_all(void)
 {
 	return 0;
@@ -407,7 +411,11 @@ static void *load_sha1(const unsigned char *sha1, unsigned long *size,
 		       const char *name)
 {
 	enum object_type type;
-	char *data = read_sha1_file(sha1, &type, size);
+	char *data;
+
+	read_sha1_lock();
+	data = read_sha1_file(sha1, &type, size);
+	read_sha1_unlock();
 
 	if (!data)
 		error("'%s': unable to read %s", name, sha1_to_hex(sha1));
@@ -596,7 +604,10 @@ static int grep_tree(struct grep_opt *opt, const char **paths,
 			void *data;
 			unsigned long size;
 
+			read_sha1_lock();
 			data = read_sha1_file(entry.sha1, &type, &size);
+			read_sha1_unlock();
+
 			if (!data)
 				die("unable to read tree (%s)",
 				    sha1_to_hex(entry.sha1));
