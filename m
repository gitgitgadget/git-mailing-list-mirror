From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Support gitlinks in fast-import/export.
Date: Fri, 18 Jul 2008 18:36:26 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807181810400.8986@racer>
References: <200807182103.37272.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 19:37:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJttV-0004Ix-0d
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 19:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbYGRRgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 13:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbYGRRgY
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 13:36:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:38801 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751277AbYGRRgY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 13:36:24 -0400
Received: (qmail invoked by alias); 18 Jul 2008 17:36:22 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp004) with SMTP; 18 Jul 2008 19:36:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX192B04a7Z12U6dODOIrsEVACp3b2LQ6f3XvqukSlu
	+6RZvzf0YZii9l
X-X-Sender: gene099@racer
In-Reply-To: <200807182103.37272.angavrilov@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89061>

Hi,

On Fri, 18 Jul 2008, Alexander Gavrilov wrote:

> 	What I'm unsure of is, should fast-export try to reuse commit
> 	marks for gitlinks where it happened to recognize the object,
> 	or always output the SHA as it is stored in the tree?

Are they commit marks?  No.  So they should be handled as marks, just as 
those for blobs and trees.

(They are commit marks in the _submodule_, but that does not matter here.)

> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index 395c055..80c591a 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -481,6 +481,9 @@ in octal.  Git only supports the following modes:
>    what you want.
>  * `100755` or `755`: A normal, but executable, file.
>  * `120000`: A symlink, the content of the file will be the link target.
> +* `160000`: A gitlink, SHA-1 of the object refers to a commit in
> +  another repository. Git links can only be specified by SHA or through
> +  a commit mark. They are used to implements submodules.

s/\(implement\)s/\1/

> diff --git a/builtin-fast-export.c b/builtin-fast-export.c
> index d0a462f..14b1549 100644
> --- a/builtin-fast-export.c
> +++ b/builtin-fast-export.c
> @@ -123,8 +123,19 @@ static void show_filemodify(struct diff_queue_struct *q,
>  			printf("D %s\n", spec->path);
>  		else {
>  			struct object *object = lookup_object(spec->sha1);
> -			printf("M %06o :%d %s\n", spec->mode,
> -			       get_object_mark(object), spec->path);
> +			int mark = object ? get_object_mark(object) : 0;

As I said, that looks wrong.  Maybe we have to fake objects for the 
gitlinks.

> @@ -183,7 +194,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
>  				    "", &rev->diffopt);
>  
>  	for (i = 0; i < diff_queued_diff.nr; i++)
> -		handle_object(diff_queued_diff.queue[i]->two->sha1);
> +		if (!S_ISGITLINK(diff_queued_diff.queue[i]->two->mode))
> +			handle_object(diff_queued_diff.queue[i]->two->sha1);

Why?  You do not want to export changes in the submodules?

> diff --git a/fast-import.c b/fast-import.c
> index e72b286..e7977c1 100644
> --- a/fast-import.c
> +++ b/fast-import.c

I'll let Shawn comment on that.  Oh, wait, it's his last day in work 
today.  Maybe I have something useful to say about this part of the patch, 
then, to save Shawn some work.

> @@ -1900,7 +1901,16 @@ static void file_change_m(struct branch *b)
>  		p = uq.buf;
>  	}
>  
> -	if (inline_data) {
> +	if (S_ISGITLINK(mode)) {
> +		if (inline_data)
> +			die("Git links cannot be specified 'inline': %s",
> +				command_buf.buf);
> +		else if (oe) {
> +			if (oe->type != OBJ_COMMIT)
> +				die("Not a commit (actually a %s): %s",
> +					typename(oe->type), command_buf.buf);

How is that supposed to work?  Do I understand correctly that you require 
the user to construct a commit object for the gitlink?  That would be 
actively wrong.

Oh, and your patch lacks test cases that demonstrate how you envisage the 
whole thing to work.

Ciao,
Dscho
