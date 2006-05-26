From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC][PATCH] Allow transfer of any valid sha1
Date: Fri, 26 May 2006 03:04:50 -0700
Message-ID: <7vac95m799.fsf@assigned-by-dhcp.cox.net>
References: <m164jvj1x3.fsf@ebiederm.dsl.xmission.com>
	<7vejyjpz9a.fsf@assigned-by-dhcp.cox.net>
	<m13beysnb2.fsf@ebiederm.dsl.xmission.com>
	<7vwtcay5k8.fsf@assigned-by-dhcp.cox.net>
	<m1lksqdook.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605251024320.5623@g5.osdl.org>
	<7v3beyuffg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605251134410.5623@g5.osdl.org>
	<m13bexetj1.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 12:05:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjZCA-0004ua-Ag
	for gcvg-git@gmane.org; Fri, 26 May 2006 12:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWEZKEx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 06:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWEZKEw
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 06:04:52 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:39393 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751228AbWEZKEw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 06:04:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060526100452.ODCF27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 May 2006 06:04:52 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20804>

ebiederm@xmission.com (Eric W. Biederman) writes:

> diff --git a/fetch-pack.c b/fetch-pack.c
> index a3bcad0..c767d84 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -260,6 +260,27 @@ static void mark_recent_complete_commits
>  	}
>  }
>  
> +static struct ref **get_sha1_heads(struct ref **refs, int nr_heads, char **head)
> +{
> +	int i;
> +	for (i  = 0; i < nr_heads; i++) {
> +		struct ref *ref;
> +		unsigned char sha1[20];
> +		char *s = head[i];
> +		int len = strlen(s);
> +
> +		if (len != 40 || get_sha1_hex(s, sha1))
> +			continue;

So the new convention is fetch-pack can take ref name (as
before), or a bare 40-byte hexadecimal.  I think sane people
would not use ambiguous refname that says "deadbeef" five times,
and even if the do so they could disambiguate by explicitly
saying "refs/heads/" followed by "deadbeef" five times, so it
should be OK.

> +
> +		ref = xcalloc(1, sizeof(*ref) + len + 1);
> +		memcpy(ref->old_sha1, sha1, 20);
> +		memcpy(ref->name, s, len + 1);
> +		*refs = ref;
> +		refs = &ref->next;
> +	}
> +	return refs;
> +}
> +

This function takes the pointer to a location that holds a
pointer to a "struct ref" -- it is the location to store the
newly allocated ref structure, i.e. the next pointer of the last
element in the list.  When it returns, the location pointed at
by the pointer given to you points at the first element you
allocated, and it returns the next pointer of the last element
allocated by it.  That is the same calling convention as
connect.c::get_remote_heads().  So when calling this function to
append to a list you already have, you would give the next
pointer to the last element of the existing list.  But you do
not seem to do that.

I think the body of fetch_pack() should become something like:

	struct ref *ref, **tail;

        tail = get_remote_heads(fd[0], &ref, 0, NULL, 0);
	if (server_supports("multi_ack")) {
		...
	}
	tail = get_sha1_heads(tail, nr_match, match);
	if (everything_local(&ref, nr_match, match)) {
		...

> @@ -311,6 +332,8 @@ static int everything_local(struct ref *
>  	if (cutoff)
>  		mark_recent_complete_commits(cutoff);
>  
> +	filter_refs(refs, nr_match, match);
> +

I am not sure about this change.

In the original code we do not let get_remote_heads() to filter
the refs but call filter_refs() after the "mark all complete
remote refs as common" step for a reason.  Even though we may
not be fetching from some remote refs, we would want to take
advantage of the knowledge of what objects they have so that we
can mark as many objects as common as possible in the early
stage.  I suspect this change defeats that optimization.

So instead I would teach "mark all complete remote refs" loop
that not everything in refs list is a valid remote ref, and skip
what get_sha1_heads() injected, because these arbitrary ones we
got from the command line are not something we know exist on the
remote side.  Maybe something like this.

	/*
	 * Mark all complete remote refs as common refs.
	 * Don't mark them common yet; the server has to be told so first.
	 */
	for (ref = *refs; ref; ref = ref->next) {
		struct object *o;
                if (ref is SHA1 from the command line)
                	continue;
		o = deref_tag(lookup_object(ref->old_sha1), NULL, 0);
		if (!o || o->type != commit_type || !(o->flags & COMPLETE))
			continue;
		...

To implement "ref is SHA1 from the command line", I would add
another 1-bit field to "struct ref" and mark the new ones you
create in get_sha1_heads() as such (existing "force" field
could also become an 1-bit field -- we do not neeed a char).

> @@ -373,6 +394,7 @@ static int fetch_pack(int fd[2], int nr_
>  		packet_flush(fd[1]);
>  		die("no matching remote head");
>  	}
> +	get_sha1_heads(&ref, nr_match, match);

I talked about this one already...

> diff --git a/git-parse-remote.sh b/git-parse-remote.sh
> index 187f088..2372df8 100755
> --- a/git-parse-remote.sh
> +++ b/git-parse-remote.sh
> @@ -105,6 +105,7 @@ canon_refs_list_for_fetch () {
>  		'') remote=HEAD ;;
>  		refs/heads/* | refs/tags/* | refs/remotes/*) ;;
>  		heads/* | tags/* | remotes/* ) remote="refs/$remote" ;;
> +		[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]) ;;

Yuck.  Don't we have $_x40 somewhere?

We never use uppercase so at least we could save 24 columns from
here ;-).
