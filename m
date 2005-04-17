From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [3/5] Add http-pull
Date: Sun, 17 Apr 2005 20:10:54 +0200
Message-ID: <20050417181054.GB1461@pasky.ji.cz>
References: <Pine.LNX.4.21.0504171108060.30848-100000@iabervon.org> <Pine.LNX.4.21.0504171127160.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 20:08:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNEAs-0002zy-8D
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 20:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVDQSLB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 14:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVDQSLB
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 14:11:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39060 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261386AbVDQSKz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 14:10:55 -0400
Received: (qmail 4217 invoked by uid 2001); 17 Apr 2005 18:10:54 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504171127160.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 17, 2005 at 05:31:16PM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> http-pull is a program that downloads from a (normal) HTTP server a commit
> and all of the tree and blob objects it refers to (but not other commits,
> etc.). Options could be used to make it download a larger or different
> selection of objects. It depends on libcurl, which I forgot to mention in
> the README again.
> 
> Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>

So, while you will be resending the patch, please update the README.

> Index: Makefile
> ===================================================================
> --- d662b707e11391f6cfe597fd4d0bf9c41d34d01a/Makefile  (mode:100644 sha1:b2ce7c5b63fffca59653b980d98379909f893d44)
> +++ 157b46ce1d82b3579e2e1258927b0d9bdbc033ab/Makefile  (mode:100644 sha1:940ef8578cf469354002cd8feaec25d907015267)
> @@ -35,6 +35,7 @@
>  
>  LIBS= -lssl -lz
>  
> +http-pull: LIBS += -lcurl
>  
>  $(PROG):%: %.o $(COMMON)
>  	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

Whew. Looks like an awful trick, you say this works?! :-)

At times, I wouldn't want to be a GNU make parser.

> Index: http-pull.c
> ===================================================================
> --- /dev/null  (tree:d662b707e11391f6cfe597fd4d0bf9c41d34d01a)
> +++ 157b46ce1d82b3579e2e1258927b0d9bdbc033ab/http-pull.c  (mode:100644 sha1:106ca31239e6afe6784e7c592234406f5c149e44)
> @@ -0,0 +1,126 @@
> +	if (!stat(filename, &st)) {
> +		return 0;
> +	}

access()

> +	url = malloc(strlen(base) + 50);

Off-by-one. What about the trailing NUL?

> +	strcpy(url, base);
> +	posn = url + strlen(base);
> +	strcpy(posn, "objects/");
> +	posn += 8;
> +	memcpy(posn, hex, 2);
> +	posn += 2;
> +	*(posn++) = '/';
> +	strcpy(posn, hex + 2);


> +static int process_tree(unsigned char *sha1)
> +{
> +	void *buffer;
> +        unsigned long size;
> +        char type[20];
> +
> +        buffer = read_sha1_file(sha1, type, &size);

Something with your whitespaces is wrong here. ;-)

> +	fetch(rev->tree);
> +	process_tree(rev->tree);

> +	fetch(sha1);
> +	process_commit(sha1);

You are ignoring return codes of own routines everywhere.
You should use error() instead of plain -1, BTW.


I think you should have at least two disjunct modes - either you are
downloading everything related to the given commit, or you are
downloading all commit records for commit predecessors.

Even if you might not want all the intermediate trees, you definitively
want the intermediate commits, to keep the history graph contignuous.

So in git pull, I'd imagine to do

	http-pull -c $new_head
	http-pull -t $(tree-id $new_head)

So, -c would fetch a given commit and all its predecessors until it hits
what you already have on your side. -t would fetch a given tree with all
files and subtrees and everything. http-pull shouldn't default on
either, since they are mutually exclusive.

What do you think?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
