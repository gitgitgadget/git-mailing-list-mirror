From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 08/18] git notes merge: Initial implementation handling trivial merges only
Date: Sat, 9 Oct 2010 01:55:19 +0200
Message-ID: <201010090155.20858.johan@herland.net>
References: <1285719811-10871-1-git-send-email-johan@herland.net> <1285719811-10871-9-git-send-email-johan@herland.net> <20101007062433.GF2285@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, bebarino@gmail.com, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 09 02:00:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4MrO-0003Yo-UM
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 02:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759889Ab0JIAAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 20:00:15 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:63581 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759611Ab0JIAAO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 20:00:14 -0400
Received: from pd9587e9f.dip.t-dialin.net ([217.88.126.159] helo=epsilon.localnet)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P4MrD-000LTO-06; Sat, 09 Oct 2010 02:00:11 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.32-24-generic; KDE/4.4.2; i686; ; )
In-Reply-To: <20101007062433.GF2285@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158548>

On Thursday 7. October 2010 08.24.33 Jonathan Nieder wrote:
> Johan Herland wrote:
> > This initial implementation of 'git notes merge' only handles the trivial
> > merge cases (i.e. where the merge is either a no-op, or a fast-forward).
> 
> [...]
> 
> This reminds me: it would be nice if non-builtin scripts could use
> 
> 	git notes --get-notes-ref $refarg
> 
> to learn the configured notes ref.  In other words, shouldn't the
> default_notes_ref() exposed in patch 2 also be exposed to scripted
> callers?

I agree, but I'd like to name it 'git notes get-ref' instead, to stay
consistent with the current subcommand (instead of option) design.

> If someone else doesn't get around to it, I can mock
> something up in the next few days.

There is a patch implementing 'git notes get-ref' in the next iteration
of this series. :)

> > +++ b/notes-merge.h
> > @@ -0,0 +1,30 @@
> > +#ifndef NOTES_MERGE_H
> > +#define NOTES_MERGE_H
> > +
> > +struct notes_merge_options {
> > +	const char *local_ref;
> > +	const char *remote_ref;
> > +	int verbosity;
> > +};
> > +
> > +void init_notes_merge_options(struct notes_merge_options *o);
> 
> [...]
> 
> > +int notes_merge(struct notes_merge_options *o,
> > +		unsigned char *result_sha1);
> 
> So the command is usable as-is from other builtins.  Nice.

Yep, that's the idea. notes-merge.h is really only an extension of
notes.h for providing the merge-related functionality.

> > +++ b/notes-merge.c
> > @@ -0,0 +1,103 @@
> 
> [...]
> 
> > +void init_notes_merge_options(struct notes_merge_options *o)
> > +{
> > +	memset(o, 0, sizeof(struct notes_merge_options));
> > +	o->verbosity = 2;
> > +}
> > +
> > +static int show(struct notes_merge_options *o, int v)
> > +{
> > +	return (o->verbosity >= v) || o->verbosity >= 5;
> > +}
> 
> Should the verbosities be of enum type?
> 
> 	enum notes_merge_verbosity {
> 		DEFAULT_VERBOSITY = 2,
> 		MAX_VERBOSITY = 5,
> 		etc
> 	};

Maybe. I've added these constants and used them where it made sense
(to me) in the next iteration.

> > +
> > +#define OUTPUT(o, v, ...) \
> > +	do { if (show((o), (v))) { printf(__VA_ARGS__); puts(""); } } while (0)
> 
> I would find it easier to read
> 
> 	if (o->verbosity >= DEFAULT_VERBOSITY)
> 		fprintf(stderr, ...)
> 
> unless there are going to be a huge number of messages.

The current version is modeled on the show() and output() functions in
merge-recursive.c. I think that works better in this situation.
Or maybe you have a better solution for merge-recursive.c as well?

> > +
> > +int notes_merge(struct notes_merge_options *o,
> > +		unsigned char *result_sha1)
> > +{
> > +	unsigned char local_sha1[20], remote_sha1[20];
> > +	struct commit *local, *remote;
> > +	struct commit_list *bases = NULL;
> > +	const unsigned char *base_sha1;
> > +	int result = 0;
> > +
> > +	hashclr(result_sha1);
> > +
> > +	OUTPUT(o, 5, "notes_merge(o->local_ref = %s, o->remote_ref = %s)",
> > +	       o->local_ref, o->remote_ref);
> 
> Would trace_printf be a good fit for messages like this one?  If not,
> any idea about how it could be made to fit some day?
> 
> (It is especially nice to be able to direct the trace somewhere other
> than stdout and stderr when running tests.)

Agreed. The OUTPUT(o, 5, ...) instances should use trace_printf()
instead. Fixed in the next iteration.

> > +
> > +	if (!o->local_ref || get_sha1(o->local_ref, local_sha1)) {
> > +		/* empty notes ref => assume empty notes tree */
> 
> Can an empty ref be distinguished from a missing ref?  It would be
> nice to error out when breakage is detected.

I'm not sure when you think we should (or shouldn't) error out. FWIW,
I've modeled the current code on what 'git merge' does. See [1] for
more details.

> > +	/* Find merge bases */
> > +	bases = get_merge_bases(local, remote, 1);
> > +	if (!bases) {
> > +		base_sha1 = null_sha1;
> > +		OUTPUT(o, 4, "No merge base found; doing history-less merge");
> > +	} else if (!bases->next) {
> > +		base_sha1 = bases->item->object.sha1;
> > +		OUTPUT(o, 4, "One merge base found (%.7s)",
> > +		       sha1_to_hex(base_sha1));
> > +	} else {
> > +		/* TODO: How to handle multiple merge-bases? */
> 
> With a recursive merge of the ancestors, of course. :)
> 
> The difficult part is what to do when a merge of ancestors results in
> conflicts.

Exactly. I feel notes merge conflicts are confusing enough to the
average user, and I'd rather not expose them to resolving conflicts in
_recursive_ notes merges...

I guess this becomes a discussion of whether we should model notes
merges on the 'resolve' merge strategy or the 'recursive' merge
strategy. Without having studied each strategy in-depth, I don't know
how much "better" 'recursive' is than 'resolve', especially not from
the POV of notes merges. Are there features of 'recursive' that are
useful to notes merges?

(All I know of the effectual differences between 'resolve' and
'recursive' is the hand waving on the 'git merge' man page:
  "...has been reported to result in fewer merge conflicts without
   causing mis-merges by tests done on actual merge commits taken from
   Linux 2.6 kernel development history.")

In conclusion, if someone can show that's it's worth implementing
recursive notes merging, then I'll gladly do it, but until then I'll
stick with the simplicity of using the first merge base.

> > +++ b/builtin/notes.c
> > @@ -772,6 +779,50 @@ static int show(int argc, const char **argv, const
> > +static int merge(int argc, const char **argv, const char *prefix)
> > +{
> > [...]
> > +	o.verbosity = verbosity + 2; // default verbosity level is 2
> 
> Maybe
> 
> 	o.verbosity += verbosity;
> 
> or
> 
> 	o.verbosity = DEFAULT_NOTES_MERGE_VERBOSITY + verbosity;
> 
> to allow the default verbosity to be set in one place?

Agreed. Fixed in the next iteration.

> > +	result = notes_merge(&o, result_sha1);
> > +
> > +	strbuf_addf(&msg, "notes: Merged notes from %s into %s",
> > +		    remote_ref.buf, default_notes_ref());
> > +	if (result == 0) { /* Merge resulted (trivially) in result_sha1 */
> > +		/* Update default notes ref with new commit */
> > +		update_ref(msg.buf, default_notes_ref(), result_sha1, NULL,
> > +			   0, DIE_ON_ERR);
> > +	} else {
> > +		/* TODO: */
> > +		die("'git notes merge' cannot yet handle non-trivial merges!");
> 
> Mm.  In the long run, will (result != 0) mean "merge conflict"?

Almost. If you look at the notes_merge() docs in notes-merge.h by the
end of this series, you'll see the following return values:

0: Merge trivially succeeded in an existing commit (e.g. fast-forward).

1: Merge successfully completes a merge commit (i.e. no conflicts).

-1: Merge results is conflicts.

> Thanks for a pleasant read.

Thanks for reading! :)


...Johan


[1]: Let's analyze the different cases here:

1. local_ref ("our" side of the merge) doesn't exist
(i.e. an unborn notes ref):

In this situation 'git merge' simply creates local_ref to point at
remote_ref. 'git notes merge' does the same.


2. local_ref is empty (.git/refs/notes/$local_ref is an empty file):

'git merge' fails with
  error: unable to resolve reference HEAD: No such file or directory
  fatal: Cannot lock the ref 'HEAD'.

'git notes merge' fails with
  error: unable to resolve reference refs/notes/$local_ref: No such file or directory
  fatal: Cannot lock the ref 'refs/notes/$local_ref'.

3. local_ref refers to a non-existing commit:

'git merge' fails with
  error: Could not read $non_existing_sha1
  error: Trying to write ref ORIG_HEAD with nonexistant object $non_existing_sha1
  fatal: Cannot update the ref 'ORIG_HEAD'.
  fatal: bad object HEAD

'git notes merge' fails with
  fatal: Failed to read notes tree referenced by refs/notes/$local_ref ($non_existing_sha1)

4. local_ref refers to a non-commit (tree or blob):

'git merge' fails with
  error: Object $tree_sha1 is a tree, not a commit
  error: Object $tree_sha1 is a tree, not a commit
  Segmentation fault (someone might want to look into this...)

'git notes merge' fails with
  error: Object $tree_sha1 is a tree, not a commit
  fatal: Could not parse commit 'refs/notes/$local_ref.

Looking at remote_ref instead:

5. remote_ref ("their" side of the merge) doesn't exist
(i.e. an unborn notes ref):

'git merge' fails with:
  fatal: '$remote_ref' does not point to a commit

'git notes merge' fails with:
  fatal: Could not parse commit 'refs/notes/$remote_ref'.

6. remote_ref is empty (.git/refs/notes/$remote_ref is an empty file):

same as #5

7. remote_ref refers to a non-existing commit:

same as #5

8. remote_ref refers to a non-commit (tree or blob):

'git merge' fails with
  error: $remote_ref: expected commit type, but the object dereferences to tree type
  fatal: '$remote_ref' does not point to a commit

'git notes merge' fails with
  error: Object $tree_sha1 is a tree, not a commit
  fatal: Could not parse commit '$remote_ref'.

I believe all these outcomes make sense.

-- 
Johan Herland, <johan@herland.net>
www.herland.net
