From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC Patch] Preventing corrupt objects from entering the
 repository
Date: Fri, 15 Feb 2008 00:06:49 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802142345450.30505@racer.site>
References: <20080210175812.GB12162@auto.tuwien.ac.at> <7vmyq8cqfn.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802101929310.2732@xanadu.home> <20080211195623.GA21878@auto.tuwien.ac.at> <alpine.LFD.1.00.0802111513360.2732@xanadu.home>
 <20080211215806.GA24971@auto.tuwien.ac.at> <alpine.LFD.1.00.0802120937330.2732@xanadu.home> <20080213074209.GG24004@spearce.org> <20080213081128.GA27730@auto.tuwien.ac.at> <alpine.LSU.1.00.0802131200410.30505@racer.site>
 <20080214190455.GB26527@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Fri Feb 15 01:07:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPo7H-0004xO-UM
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 01:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbYBOAGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 19:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756466AbYBOAGz
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 19:06:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:33396 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762070AbYBOAGx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 19:06:53 -0500
Received: (qmail invoked by alias); 15 Feb 2008 00:06:50 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp026) with SMTP; 15 Feb 2008 01:06:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19nvshMwa9nbvBmbfzrS/IB1FLaz4XXowCKP+4Ztu
	YVVOa83VMlteTX
X-X-Sender: gene099@racer.site
In-Reply-To: <20080214190455.GB26527@auto.tuwien.ac.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73931>

Hi,

On Thu, 14 Feb 2008, Martin Koegler wrote:

> diff --git a/commit.c b/commit.c
> index 8b8fb04..53f0042 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -311,6 +311,8 @@ int parse_commit(struct commit *item)
>  	unsigned long size;
>  	int ret;
>  
> +	if (!item)
> +		return -1;

Yeah, I just grepped for users of parse_commit(), and there are just too 
many, so this change makes sense.

> @@ -385,8 +387,7 @@ struct commit *pop_most_recent_commit(struct commit_list **list,
>  
>  	while (parents) {
>  		struct commit *commit = parents->item;
> -		parse_commit(commit);
> -		if (!(commit->object.flags & mark)) {
> +		if (!parse_commit(commit) && !(commit->object.flags & mark)) {

This makes sense, too.

> @@ -552,8 +553,10 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
>  		 */
>  		return commit_list_insert(one, &result);
>  
> -	parse_commit(one);
> -	parse_commit(two);
> +	if (parse_commit(one))
> +		die("invalid commit");
> +	if (parse_commit(two))
> +		die("invalid commit");

I'd rather have this return NULL after displaying an error.  After all, 
merge_bases() is sort of "libified".

BTW a simple "git grep parse_commit\( | grep -vwe if -e gitweb" shows 
this:

builtin-blame.c:                        parse_commit(commit);
builtin-checkout.c:     parse_commit(commit);
builtin-checkout.c:                     parse_commit(old->commit);
builtin-checkout.c:             parse_commit(new->commit);
builtin-checkout.c:                     parse_commit(new.commit);
builtin-describe.c:                     parse_commit(p);
builtin-describe.c:                     parse_commit(p);
builtin-fast-export.c:  parse_commit(commit);
builtin-fast-export.c:          parse_commit(commit->parents->item);
builtin-fetch-pack.c:                   parse_commit(commit);
builtin-fetch-pack.c:                           parse_commit(commit);
builtin-fetch-pack.c:                   parse_commit(commit);
builtin-name-rev.c:             parse_commit(commit);
builtin-show-branch.c:                          parse_commit(p);
builtin-show-branch.c:          parse_commit(commit);
commit.c:int parse_commit(struct commit *item)
commit.c:               parse_commit(commit);
commit.c:       parse_commit(one);
commit.c:       parse_commit(two);
commit.c:                       parse_commit(p);
commit.h:int parse_commit(struct commit *item);
contrib/gitview/gitview:                self.parse_commit(commit_lines)
contrib/gitview/gitview:        def parse_commit(self, commit_lines):
shallow.c:              parse_commit(commit);
upload-pack.c:                          parse_commit((struct commit *)object);

A few of those need checking, too, I think.

> @@ -584,9 +587,12 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
>  		while (parents) {
>  			struct commit *p = parents->item;
>  			parents = parents->next;
> +			if (!p)
> +				die("invalid commit");
>  			if ((p->object.flags & flags) == flags)
>  				continue;
> -			parse_commit(p);
> +			if(parse_commit(p))
> +				die("invalid commit");
>  			p->object.flags |= flags;
>  			insert_by_date(p, &list);
>  		}

Again, please do not die() in merge_bases().

> diff --git a/revision.c b/revision.c
> index 6e85aaa..9f8723d 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -46,6 +46,8 @@ void add_object(struct object *obj,
>  
>  static void mark_blob_uninteresting(struct blob *blob)
>  {
> +	if (!blob)
> +		return;

IMHO not needed [*1*].  The first user of this (static) function calls it 
with lookup_blob(), which assumes that the blob has been read already.

The second uses a checked object.

> @@ -57,6 +59,8 @@ void mark_tree_uninteresting(struct tree *tree)
>  	struct name_entry entry;
>  	struct object *obj = &tree->object;
>  
> +	if (!obj)
> +		return;

Same here.

> @@ -94,6 +98,8 @@ void mark_parents_uninteresting(struct commit *commit)
>  
>  	while (parents) {
>  		struct commit *commit = parents->item;
> +		if (!commit)
> +			continue;

Can parents->item really be NULL?  I think not.  And indeed, a little 
search reveals that parse_commit_buffer() does this when it constructs the 
parents list, and encounters an invalid SHA-1:

return error("bad parents in commit %s", sha1_to_hex(item->object.sha1));

In case it is a valid SHA-1, but not a commit, it is ignored.

> @@ -173,6 +179,8 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
>  		struct tag *tag = (struct tag *) object;
>  		if (revs->tag_objects && !(flags & UNINTERESTING))
>  			add_pending_object(revs, object, tag->tag);
> +		if (!tag->tagged)
> +			die("bad tag");

I haven't looked yet, but I suspect that this is as impossible as the 
invalid parent.

> @@ -685,12 +693,16 @@ static int add_parents_only(struct rev_info *revs, const char *arg, int flags)
>  		it = get_reference(revs, arg, sha1, 0);
>  		if (it->type != OBJ_TAG)
>  			break;
> +		if (!((struct tag*)it)->tagged)
> +			return 0;

See above.

>  		hashcpy(sha1, ((struct tag*)it)->tagged->sha1);
>  	}
>  	if (it->type != OBJ_COMMIT)
>  		return 0;
>  	commit = (struct commit *)it;
>  	for (parents = commit->parents; parents; parents = parents->next) {
> +		if (!parents->item)
> +			continue;

See above.

> diff --git a/sha1_file.c b/sha1_file.c
> index 4179949..c25ce64 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1943,7 +1943,8 @@ void *read_object_with_reference(const unsigned char *sha1,
>  		}
>  		ref_length = strlen(ref_type);
>  
> -		if (memcmp(buffer, ref_type, ref_length) ||
> +		if (ref_length + 40 >= size ||
> +		    memcmp(buffer, ref_type, ref_length) ||

Makes sense.

> diff --git a/sha1_name.c b/sha1_name.c
> index be8489e..bd0bce6 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -396,6 +396,8 @@ static int get_parent(const char *name, int len,
>  	p = commit->parents;
>  	while (p) {
>  		if (!--idx) {
> +			if (!p->item)
> +				return -1;

See above.

> @@ -417,6 +419,8 @@ static int get_nth_ancestor(const char *name, int len,
>  
>  		if (!commit || parse_commit(commit) || !commit->parents)
>  			return -1;
> +		if (!commit->parents->item)
> +			return -1;

See above.

> @@ -494,6 +498,8 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
>  				return error("%.*s: expected %s type, but the object dereferences to %s type",
>  					     len, name, typename(expected_type),
>  					     typename(o->type));
> +			if (!o)
> +				return -1;

You probably want to guard for ((tag *)o)->tagged == NULL; Okay, now I am 
curious. *megoesandlooks*  Indeed, if the tag refers to an unknown type, 
tagged = NULL.

But I think in that case, it should return an error().  And maybe only for 
type == OBJ_TAG.

> @@ -580,6 +586,8 @@ static int handle_one_ref(const char *path,
>  		return 0;
>  	if (object->type == OBJ_TAG)
>  		object = deref_tag(object, path, strlen(path));
> +	if (!object)
> +		return 0;

As above, it looks strange to see that object->something is checked, and 
_then_ object.  I'd put this into curly brackets, together with the 
deref_tag(), just to help the reader a bit, should she be as weak in mind 
as yours truly.

> @@ -617,7 +625,8 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
>  		unsigned long size;
>  
>  		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
> -		parse_object(commit->object.sha1);
> +		if(!parse_object(commit->object.sha1))
> +			continue;

Makes sense, but please add a space after the "if".

> diff --git a/tag.c b/tag.c
> index 38bf913..990134f 100644
> --- a/tag.c
> +++ b/tag.c
> @@ -9,7 +9,10 @@ const char *tag_type = "tag";
>  struct object *deref_tag(struct object *o, const char *warn, int warnlen)
>  {
>  	while (o && o->type == OBJ_TAG)
> -		o = parse_object(((struct tag *)o)->tagged->sha1);
> +		if (((struct tag *)o)->tagged)
> +			o = parse_object(((struct tag *)o)->tagged->sha1);
> +		else
> +			o = NULL;

Knowing that tagged _can_ be NULL, this makes tons of sense.  Except that 
again, I'd call error() to tell the user, before setting o = NULL.

Ciao,
Dscho

[*1*] There might be a few people arguing that defensive programming is 
never wrong.

Alas, I saw my share of defensive programming, and more often than not, 
the real bugs were hard to find in between all those checks.  And some 
checks were actively wrong -- again hard to see...

Remember: You can make code so simple that there are obviously no bugs. 
And the other way is to make it so complicated that there are no obvious 
bugs.
