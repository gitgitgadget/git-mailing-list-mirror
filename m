From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH v3] Threaded grep
Date: Tue, 19 Jan 2010 08:34:54 +0100
Message-ID: <20100119073454.GA15575@fredrik-laptop>
References: <20100118103334.GA17361@fredrik-laptop>
 <alpine.LFD.2.00.1001180947140.13231@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 19 08:35:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX8cL-0001Cc-2D
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 08:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936Ab0ASHfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 02:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754360Ab0ASHfA
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 02:35:00 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:46233 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab0ASHe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 02:34:59 -0500
Received: by ewy19 with SMTP id 19so1409135ewy.21
        for <git@vger.kernel.org>; Mon, 18 Jan 2010 23:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=vpdqFWsbslMjlhldCxOuWlTsRIEQyxy6RJWUFQs2xJM=;
        b=YaOjnd/IYKoJTAuECG7tjDnQta7MUxZj4xba/cufo9TzEQ5PV17qBz8wUNvZEpRohM
         8DV03bbFysZU3pSVhUtLTsfRiSPkPpDQdqwS+MuTsvm0K3+a/wIj/mpuzrwEpjwBDmOK
         LsoZoI1kQ1anl0YXxYcXBOh9p+pYd5KokP+f0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=M4VJazHii60iAva2tGMUXQCgvWWc6yEWA29TKCJRUd9CmVu6YTH9XnvDRX+8dZu50d
         PNv8jHSxFuCPbeStgh8aXIwQo8OkyNnv/jagWEyc8KByRrSAy2iwvJB/CE6rxtQ6yRgN
         b9nabi2/q1P0Zcko3ipLWU5D9eMa9y3xZLv4k=
Received: by 10.213.47.143 with SMTP id n15mr7875774ebf.60.1263886497758;
        Mon, 18 Jan 2010 23:34:57 -0800 (PST)
Received: from fredrik-laptop (c83-250-149-66.bredband.comhem.se [83.250.149.66])
        by mx.google.com with ESMTPS id 7sm7379448eyb.18.2010.01.18.23.34.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Jan 2010 23:34:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1001180947140.13231@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137441>

On Mon, Jan 18, 2010 at 10:05:19AM -0800, Linus Torvalds wrote:
> On my machine (4 cores with HT, so 8 threads total), I get the 
> following:
> 
>  [ Note: the --no-ext-grep is because I'm comparing with a git that has 
>   the original grep optimization, but hasn't removed the external grep 
>   functionality yet. I just used the same command line when then comparing 
>   to next+your patch, so don't mind it.
> 
>   Also, the three examples are chosen to be: "trivial single match", 
>   "regex single match", and "trivial lots of matches" ]


You may be testing slightly different things: next has 885d211 (grep:
rip out pessimization to use fixmatch()) and bbc09c2 (grep: rip out
support for external grep) was added before. So next+patch uses
regexec and the version with support for external greps uses
strstr. IIRC strstr was a bit faster than regexec on your
box. However, this only explains a small part of the results you are
seeing.

> 
> Before (all best-of-five), with the non-threaded internal grep:
> 
>  - git grep --no-ext-grep qwerty
> 
> 	real	0m0.311s
> 	user	0m0.164s
> 	sys	0m0.144s
> 
>  - git grep --no-ext-grep qwerty.*as
> 
> 	real	0m0.555s
> 	user	0m0.416s
> 	sys	0m0.132s
> 
>  - git grep --no-ext-grep function
> 
> 	real	0m0.461s
> 	user	0m0.276s
> 	sys	0m0.180s
> 
> After, with threading:
> 
>  - git grep --no-ext-grep qwerty
> 
> 	real	0m0.152s
> 	user	0m0.788s
> 	sys	0m0.212s
> 
>  - git grep --no-ext-grep qwerty.*as
> 
> 	real	0m0.148s
> 	user	0m0.724s
> 	sys	0m0.284s
> 
>  - git grep --no-ext-grep function
> 
> 	real	0m0.241s
> 	user	0m1.436s
> 	sys	0m0.216s
> 
> so now it's a clear win in all cases. And as you'd expect, the "complex 
> case with single output" is the one that wins most, since it's the one 
> that should have the most CPU usage, with the least synchronization.
> 
> That said, it still does waste quite a bit of time doing this, and while 
> it almost doubles performance in the last case too, it does so at the cost 
> of quite a bit of overhead.
> 
> (Some overhead is natural, especially since I have HT. Running two threads 
> on the same core does _not_ give double the performance, so the CPU time 
> almost doubling - because the threads themselves run slower - is not 
> unexpected. It's when the CPU time more than quadruples that I suspect 
> that it could be improved a bit).


I haven't seen this overhead during my tests. But I'm _guessing_ that
the problem is that the mutex grep_lock is held while the result is
written to stdout. So when we are writing, no significant amount of
work can be done by any thread. Here is a patch to fix this (applies
on to of v3).



diff --git a/builtin-grep.c b/builtin-grep.c
index 8fca7a6..422b0ec 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -139,21 +139,48 @@ static int grep_file_async(struct grep_opt *opt, char *name,
 	return 0;
 }
 
+/* Mark the work_item as done. The function guarantees that w->done is
+ * set to 1 and that if w is included in a prefix of the range
+ * [todo_done, todo_start) where each work_item has .done == 1, then
+ * w->out will eventually be written to stdout. The writing is done
+ * either by this thread or by the thread which has set 'writing' to
+ * 1.
+ */
 static void work_done(struct work_item *w)
 {
-	int old_done;
+	/* 1 if there is a thread which is writing data to stdout and
+	   0 otherwise. */
+	static int writing = 0;
+	int old_done, write_idx, write_to;
 
 	pthread_mutex_lock(&grep_lock);
 	w->done = 1;
 	old_done = todo_done;
-	for(; todo[todo_done].done && todo_done != todo_start;
-	    todo_done = (todo_done+1) % ARRAY_SIZE(todo)) {
-		w = &todo[todo_done];
-		write_or_die(1, w->out.buf, w->out.len);
-		if (w->type == WORK_BUF)
-			free(w->buf);
-
-		free(w->name);
+
+	/* We need a loop here if todo_start is changed while we write
+	 * some data. */
+	while (!writing && todo[todo_done].done && todo_done != todo_start) {
+		write_idx = todo_done;
+		write_to = todo_start;
+		writing = 1;
+
+		/* Unlock the mutex while we write the data. This is
+		 * safe as writing == 1 and hence there is at most one
+		 * thread which writes data at any time. */
+		pthread_mutex_unlock(&grep_lock);
+		for(; todo[write_idx].done && write_idx != write_to;
+		    write_idx = (write_idx+1) % ARRAY_SIZE(todo)) {
+			w = &todo[write_idx];
+			write_or_die(1, w->out.buf, w->out.len);
+			if (w->type == WORK_BUF)
+				free(w->buf);
+		
+			free(w->name);
+		}
+
+		pthread_mutex_lock(&grep_lock);
+		writing = 0;
+		todo_done = write_idx;
 	}
 
 	if (old_done != todo_done)
