From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC][PATCH] Re: git-rm isn't the inverse action of git-add
Date: Sun, 8 Jul 2007 19:10:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707081855300.4248@racer.site>
References: <46893F61.5060401@jaeger.mine.nu>
 <20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net>
 <46895EA4.5040803@jaeger.mine.nu> <20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net>
 <vpq7ipittl2.fsf@bauges.imag.fr> <Pine.LNX.4.64.0707022205210.4071@racer.site>
 <vpqoditkc23.fsf@bauges.imag.fr> <Pine.LNX.4.64.0707031308170.4071@racer.site>
 <vpqir91hagz.fsf@bauges.imag.fr> <20070704200806.GA3991@efreet.light.src>
 <vpqd4z7q820.fsf@bauges.imag.fr> <vpqfy3yajbj.fsf_-_@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jan Hudec <bulb@ucw.cz>,
	Yann Dirson <ydirson@altern.org>,
	Christian Jaeger <christian@jaeger.mine.nu>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Jul 08 20:18:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7bL3-00063V-9A
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 20:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671AbXGHSS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 14:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754655AbXGHSS1
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 14:18:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:40148 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754671AbXGHSS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 14:18:26 -0400
Received: (qmail invoked by alias); 08 Jul 2007 18:18:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 08 Jul 2007 20:18:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+BN98VD2mB33ZV4b0Y/hLcrOsQfCcBwR3D21Gfl3
	9KBFwileyMrMyH
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqfy3yajbj.fsf_-_@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51900>

Hi,

On Sun, 8 Jul 2007, Matthieu Moy wrote:

> Subject: [PATCH] Make git-rm obey in more circumstances.

This is not really a good patch title.  Since it only obeys your 
particular understanding of what it should do.  You are changing 
semantics, and you should say so.

> In the previous behavior of git-rm, git refused to do anything in case 
> of a difference between the file on disk, the index, and the HEAD. As a 
> result, the -f flag is forced even for simple senarios like:
> 
> $ git add foo
> # oops, I didn't want to version it
> $ git rm -f [--cached] foo
> # foo is deleted on disk if --cached isn't provided.
> 
> This patch proposes a saner behavior. When there are no difference at 
> all between file, index and HEAD, the file is removed both from the 
> index and the tree, as before.
> 
> Otherwise, if the index matches either the file on disk or the HEAD, the 
> file is removed from the index, but the file is kept on disk, it may 
> contain important data.

However, if some of the files are of the first kind, and some are of the 
second kind, you happily apply with mixed strategies.  IMO that is wrong.

>  static struct {
>  	int nr, alloc;
> -	const char **name;
> +	struct file_info * files;
>  } list;
>  
>  static void add_list(const char *name)
>  {
>  	if (list.nr >= list.alloc) {
>  		list.alloc = alloc_nr(list.alloc);
> -		list.name = xrealloc(list.name, list.alloc * sizeof(const char *));
> +		list.files = xrealloc(list.files, list.alloc * sizeof(const char *));

This is wrong, too.  Yes, it works.  But it really should be 
"sizeof(struct file_info *)".  Remember, code is also documentation.

> +static int remove_file_maybe(const struct file_info fi, int quiet)
> +{
> +	const char *path = fi.name;
> +	if (!fi.local_changes && !fi.staged_changes) {
> +		/* The file matches either the index or the HEAD.
> +		 * It's content exists somewhere else, it's safe to
> +		 * delete it.
> +		 */
> +		return remove_file(path);
> +	} else {

Superfluous "{ .. }".

> +		if (!quiet)
> +			fprintf(stderr, 
> +				"note: file '%s' not removed "
> +				"(doesn't match %s).\n",
> +				path,
> +				fi.local_changes?"the index":"HEAD");
> +		return 0;
> +	}
> +}

I suspect that this case does never fail. 0 means success for 
remove_file().  Not good.  You should at least have a way to ensure that 
it removed the files from the working tree from a script.  Otherwise there 
is not much point in returning a value to begin with.

> @@ -224,13 +257,13 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>  	if (!index_only) {
>  		int removed = 0;
>  		for (i = 0; i < list.nr; i++) {
> -			const char *path = list.name[i];
> -			if (!remove_file(path)) {
> +			if (!remove_file_maybe(list.files[i], quiet)) {
>  				removed = 1;
>  				continue;
>  			}
>  			if (!removed)
> -				die("git-rm: %s: %s", path, strerror(errno));
> +				die("git-rm: %s: %s", 
> +				    list.files[i].name, strerror(errno));
>  		}
>  	}

Style: the old code set and used "path" for readability.  You should do 
the same (with "file", probably).

Additionally, since this changes semantics, you better provide test cases 
to show what is expected to work, and _ensure_ that it actually works.

Ciao,
Dscho
