From: Junio C Hamano <junkio@cox.net>
Subject: Re: Libification project (SoC)
Date: Thu, 15 Mar 2007 23:54:01 -0700
Message-ID: <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
References: <20070316042406.7e750ed0@home.brethil>
	<20070316045928.GB31606@spearce.org>
	<7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
	<20070316060033.GD31606@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 07:54:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS6KG-0005bx-OT
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 07:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbXCPGyG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 02:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752940AbXCPGyF
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 02:54:05 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:59192 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbXCPGyE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 02:54:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070316065403.GPMO18070.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Mar 2007 02:54:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bJu21W0061kojtg0000000; Fri, 16 Mar 2007 02:54:02 -0400
In-Reply-To: <20070316060033.GD31606@spearce.org> (Shawn O. Pearce's message
	of "Fri, 16 Mar 2007 02:00:33 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42331>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> > On the other hand, many of the variables declared in environment.c
>> > are repository specific configuration variables.  These probably
>> > should be abstracted into some sort of wrapper, so that multiple
>> > repositories can be accessed from within the same process.  Why?
>> > a future mod_perl running gitweb.cgi accessing repositories through
>> > libgit.a and Perl bindings of course!
>> 
>> I think if you are abstracting them out, into "struct repo_state",
>> the index and object store related variables such as packed_git
>> should go there as well, so your recommendation feels very
>> inconsistent to me.
>
> I missed packed_git, but you are right, that should definately go
> with a struct repo_state.  And maybe you are right that the index
> should go with it... but I'm not sure the index should be tied to the
> repository at all.  Its strictly convention that the index goes with
> the repository; GIT_INDEX_FILE lets you say otherwise at the command
> line level, why can't we do otherwise from a library level too?

Even within a plumbing, being able to shuffle multiple indices
at once would be very useful.  For example, if I were to rewrite
unpack-trees, I would most likely read from the current index
and trees and populate a new index from emptiness by appending
to it, thereby avoiding the binary-search and insert costs.

I've thought about the layering when Smurf first brought up the
libification (which was a loooong time ago), and concluded three
layered approach would be most useful.

The bottom layer is object store across repositories.  If we
ignore SHA-1 collisions as an issue (and we _will_ ignore it for
forseeable future), unless you are doing "read from one
repository and write that to another repository", it is more
handy to be able to name an object and get its data without
knowing which repository's object store it comes from, and it
would make "git log master~A..master~B" across repositories
(i.e. 'master' of repository A and 'master' of repository B)
possible.  An example interface would be like:

(current)
void *read_sha1_file(const unsigned char *sha1,
		     enum object_type *type,
		     unsigned long *size);

(libified)
void *git_read_sha1_file(struct gitlib *,
			 const unsigned char *sha1,
			 enum object_type *type,
			 unsigned long *size);

where "struct gitlib" has a list of "struct object_store", and
we will have:

int git_add_object_store(struct gitlib *, const char *path);

to add one directory as object store the toplevel gitlib structure
knows about.  In a sense, "struct gitlib" and object store is so
global that we might not even need to have it as a parameter
(iow, it and "struct object **obj_hash" from object.c can stay
global).

The middle layer is repositories, primarily their refs and
reflogs.  An example interface would be like:

(current)
int get_sha1(const char *name, unsigned char *sha1);

(libified)
int git_get_sha1(struct git_repo *, const char *name, unsigned char *sha1);

where "struct git_repo" is one repository (and it would have a
pointer to "struct gitlib *" so that we can follow objects to
follow parents and stuff).

And the top layer would have indices, and working trees as
per-invocation parameter.

(current)
int cache_name_pos(const char *name, int namelen);
int unpack_trees(struct object_list *trees, struct unpack_trees_options *o);

(libified)
int git_cache_name_pos(struct git_cache *, const char *name, int namelen);
int git_unpack_trees(struct object_list *trees, struct git_unpack_trees_options *o);

where "struct git_cache" has "index" thingies, such as
active_cache, active_nr, active_alloc, and active_cache_tree.
And we would have pointer to "struct git_cache *" in unpack_trees_options
structure.
