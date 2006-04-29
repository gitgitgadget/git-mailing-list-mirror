From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
Date: Sat, 29 Apr 2006 12:30:09 -0700
Message-ID: <7vlkto6uym.fsf@assigned-by-dhcp.cox.net>
References: <20060429165151.2570.qmail@science.horizon.com>
	<Pine.LNX.4.64.0604291006270.3701@g5.osdl.org>
	<e309vq$m2r$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 29 21:30:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZv98-00082r-Ty
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 21:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWD2TaP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 15:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWD2TaP
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 15:30:15 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:7909 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750738AbWD2TaO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Apr 2006 15:30:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060429193014.HVWA25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 29 Apr 2006 15:30:14 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e309vq$m2r$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	29 Apr 2006 20:07:36 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19315>

Jakub Narebski <jnareb@gmail.com> writes:

> IF (and that is big if) git commit header will be extended to have some
> extra "link" (enforcing connectivity) headers, like proposed "bind" for
> subprojects, "prev" for pu-like union branches, "merge-base" for merges,
> there would be repeated work on enforcing connectivity. Hence generic
> "link" header (formerly "related") proposal.

The "link <sha1> <type> <meta>" header extension was done
primarily for that reason this way.  I carried it in my "pu"
branch for a few days but Linus convinced me privately that it
was a bad idea, so it is not merged in "pu" anymore.  Just to
make it easy for people to view what we are discussing, I pushed
the branch head to jc/bind-2 topic branch, but the code will
_not_ be merged.

The code in commit.c to recognize and link the releated objects
pointed by the "link" header to the commit looked like below
(see 11bbee26 commit on that branch):

+       optr = &item->links;
+       while (!memcmp(bufptr, "link ", 5)) {
+               struct object *object;
+
+               if (!get_sha1_hex(bufptr + 5, parent) &&
+                   bufptr[45] == ' ' &&
+                   (object = lookup_unknown_object(parent)) != NULL) {
+                       struct object_list *l = xmalloc(sizeof(*l));
+                       l->item = object;
+                       l->next = *optr;
+                       l->name = NULL;
+                       *optr = l;
+                       optr = &l->next;
+                       n_refs++;
+                       bufptr += 45;
+               }
+               else
+                       return error("bad link in commit %s",
+                                    sha1_to_hex(item->object.sha1));
+               while (*bufptr++ != '\n')
+                       ; /* skip over subdirectory name */
+       }

But if your are going to introduce "merge-base" and similar
headers that have impact to connectivity traversal code, you can
easily change the !memcmp(buptr, "link ", 5) with a sequence of
"memcmp(foo) || memcmp(bar) || ...", and use the "l->name" field
to point at the header itself, so that the user of the resulting
commit object can easily tell what kind of link-like header it
is, and enforce further semantics that are specific to each kind
of such header on it.  The revision traversal change that was
done in a later commit (7091fd commit) does not have to change.

The code sharing aspect you brought up is a very important
issue.  This is revision traversal, which is really the central
part of git and needs deep thought to touch without breaking, so
we would like to avoid risking breaking it by repeatedly
touching it.  But that can be done without making the recorded
header something like "link <sha1> <type> <metainfo>" which is
too generic.
