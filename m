From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] path-list documentation: document all functions and data
 structures
Date: Sat, 14 Jun 2008 19:08:19 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806141705050.6439@racer>
References: <1213404964-25161-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Olivier Marin <dkr+ml.git@free.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Don Zickus <dzickus@redhat.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jun 14 20:11:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7aDU-0006U0-TB
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 20:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbYFNSKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 14:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753761AbYFNSKI
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 14:10:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:43576 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753075AbYFNSKF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 14:10:05 -0400
Received: (qmail invoked by alias); 14 Jun 2008 18:10:02 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 14 Jun 2008 20:10:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/27XxQIXP2IZVsPtLFoZFkY9RKJvdnVQQ4pFyWpB
	0UvbtRg7LaiKxO
X-X-Sender: gene099@racer
In-Reply-To: <1213404964-25161-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85028>

Hi,

On Sat, 14 Jun 2008, Miklos Vajna wrote:

> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>

Thanks for doing this... I meant to document it after pushing the 
path_list -> string_list patch.

Speaking of which: Junio, could you give me any clue how you would like to 
proceed with that patch?

> @@ -1,9 +1,93 @@
>  path-list API
>  =============
>  
> -Talk about <path-list.h>, things like
> +The path_list API offers a data structure and functions to handle sorted
> +and unsorted string lists.
>  
> -* it is not just paths but strings in general;
> -* the calling sequence.
> +The name is a bit misleading, a path_list may store not only paths but
> +strings in general.
>  
> -(Dscho)
> +The caller:
> +
> +. Allocates and clears (`memset(&list, \'\0', sizeof(list));`) a
> +  `struct path_list` variable.

Some callers use global variables; these are already initialized.  Also, I 
would not write code here, but later in a concise example.

> +. Initializes the members. You can manually set the `items` member, but
> +  then you have to set `nr`, accordingly. Also don't forget to set
> +  `strdup_paths` if you need it.

I would not promote the manual setting of the items member, until later.  
This is advanced usage, and you have to malloc() the list if you add 
things later, and you should set the `alloc` member in that case, too.

Further, I would like to have an explanation of the variable 
"strdup_paths" first.

Something like: "You might want to set the flag `strdup_paths` if the 
strings should be strdup()ed.  For example, this is necessary when you add 
something like git_path("..."), since that function returns a static 
buffer that will change with the next call to git_path()."

> +. Adds new items to the list, using `path_list_append` or `path_list_insert`.
> +
> +. Can check if a string is in the list using `path_list_has_path` or
> +  `unsorted_path_list_has_path` and get it from the list using
> +  `path_list_lookup` for sorted lists.
> +
> +. Can sort an unsorted list using `sort_path_list`.
> +
> +. Finally it should free the list using `path_list_clear`.

Here, you should add a note that it is more efficient to build an unsorted 
list and sort it afterwards, instead of building a sorted list (O(n log n) 
instead of O(n^2)).

However, if you use the list to check if a certain string was added 
already, you should not do that (using unsorted_path_list_has_path()), 
because the complexity would be quadratic again (but with a worse factor).

> +`path_list_insert`::
> +
> +	Insert a new element to the path_list. The returned pointer can be handy
> +	if you want to write something to the `util` pointer of the
> +	path_list_item containing the just added string.

	Since this function uses xrealloc() (which die()s if it fails) if 
	the list needs to grow, it is safe not to check the pointer.  I.e.
	you may write "path_list_insert(...)->util = ...;"

> +`unsorted_path_list_has_path`::
> +
> +	It's like `path_list_has_path()` but for unsorted lists.

	Obviously, this function needs to look through all items, as 
	opposed to its counterpart for sorted lists, which performs a 
	binary search.

> +Data structures
> +---------------
> +
> +* `struct path_list_item`
> +
> +Represent an item of the list. The `path` member is a pointer to the

s/sent/&s/

> +string, and you may use the `util` member for any purpose, if you want.
> +
> +* `struct path_list`
> +
> +Represents the list itself.
> +
> +. The array of items are available via the `items` member.
> +. The `nr` member contains the number of items stored in the list.
> +. The `alloc` member is used for `ALLOC_GROW()`.

Maybe "The `alloc` member is used to avoid reallocating at every 
insertion.  You should not tamper with it."

> +. Setting the `strdup_paths` member to 1 means that the added paths are
> +  copied to the path list and not just a pointer to them is stored.

Like I said, I would say that it will strdup() the strings before adding 
them, and then motivate it (by presenting a case where it helps, e.g. 
git_path()).

Of course, a short and concise example how to use path_lists would be 
nice... ;-)

Ciao,
Dscho
