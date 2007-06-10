From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce light weight commit annotations
Date: Sun, 10 Jun 2007 16:29:38 -0700
Message-ID: <7v4plf5qxp.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706091854330.4059@racer.site>
	<7v4plf7948.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0706102333050.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 11 01:29:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxWqw-0005GB-1Z
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 01:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759556AbXFJX3k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 19:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759847AbXFJX3k
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 19:29:40 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:55517 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759096AbXFJX3j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 19:29:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070610232938.YZCE18396.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Jun 2007 19:29:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9zVe1X00R1kojtg0000000; Sun, 10 Jun 2007 19:29:39 -0400
In-Reply-To: <Pine.LNX.4.64.0706102333050.4059@racer.site> (Johannes
	Schindelin's message of "Mon, 11 Jun 2007 00:00:09 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49791>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I do not understand... the entries of a tree object are sorted 
> alphabetically, right? Including the convention that if one is a prefix of 
> another, it is "smaller".
>
> While I think that the length would not be any problem, the entries' names 
> of refs/annotations/commit^{tree} are _all_ of length two, and point to 
> other tree objects. _Those_ tree objects contain _only_ entries whose 
> names contain exactly 38 characters.

That is ONLY true if you are introducing a specialized tree
object parser that knows it is dealing with the tree used in
your annotation scheme that has entries of uniform size.  In
such a tree parser, you could bisect or Newton-Raphson a tree
object data to find an entry more efficiently than for normal
trees with enries of variable size.

But I do not think you are planning to do that (nor I would
recommend you to).  With the normal tree parser, the lookup for
"refs/annotations/commit:??/?{38}" you have in your code would
open one tree (the commit's tree), find the one with leading 2
hexdigits you would want among up to 256 entries with linear
search (see tree-walk.c::find_tree_entry()), open that entry
which is another tree, and do the same linear search to find the
entry with the remaining 38 hexdigits.  Finding annotation for
commit 0000abcd... is much less expensive than ffff4567...

>> It will hurt _if_ we introduce a new tree object format that would give 
>> you a quick random-access at an entry, but it is premature to worry 
>> about that now.
>
> I do not see that. Care to enlighten me?

At some point (probably git v3.0.0) we _might_ enhance/extend
the tree object format so that it has an auxiliary hash table to
help you look up an arbitrary entry in a huge tree object (huge
in the sense that readdir(3) returns many entries, not in the
sense that find(1) returns many results) more efficiently. Pack
v4 is rumored to have something like that for in-pack trees.

If that happens, "refs/annotations/commit:?{40}" format would
let you look up an annotation for a given commit much more
efficiently than "refs/annotations/commit:??/?{38}", because it
would have to open only one tree object, instead of two.
