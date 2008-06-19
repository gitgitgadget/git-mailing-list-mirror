From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-apply doesn't handle same name patches well [V3]
Date: Thu, 19 Jun 2008 15:15:16 -0700
Message-ID: <7vk5glrs0b.fsf@gitster.siamese.dyndns.org>
References: <1213646686-31964-1-git-send-email-dzickus@redhat.com>
 <7vbq1z375d.fsf@gitster.siamese.dyndns.org>
 <20080619213341.GP16941@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 00:16:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9SQm-0006lb-HV
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 00:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbYFSWPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 18:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbYFSWPk
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 18:15:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbYFSWPk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 18:15:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 928AD1CAD5;
	Thu, 19 Jun 2008 18:15:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5FC0E1CACF; Thu, 19 Jun 2008 18:15:24 -0400 (EDT)
In-Reply-To: <20080619213341.GP16941@redhat.com> (Don Zickus's message of
 "Thu, 19 Jun 2008 17:33:41 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3C4A080C-3E4D-11DD-AE78-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85548>

Don Zickus <dzickus@redhat.com> writes:

> On Tue, Jun 17, 2008 at 05:42:54PM -0700, Junio C Hamano wrote:
>> Don Zickus <dzickus@redhat.com> writes:
> ...
> I was going to try to figure out a way to grab it from fn_cache but I
> wasn't sure how much of the 'lstat' info is needed later.

The usual case of one-diff-one-path patch application wants to make sure
that there is no discrepancy between the index and the work tree for the
path when working in --index mode.  When working in work-tree-only mode,
lstat just makes sure that the path to be patched actually exists (or
doesn't, if it is a creation patch).

When fn_cache is used, you pretend as if the resulting path exists and up
to date when found in fn_cache and the previous round succeeded, so you
can substitute the lstat (you cannot just lose it, but need to make sure
the path exists after applying the earlier fn_cache contents when handling
a later patch that wants to touch an existing file).  As you pretend that
the previous round succeeded, you do not have to check the up-to-dateness
between the index and work tree when dealing with a path that has previous
result in fn_cache, even when operating in --index mode.

>> or do you mean that the first patch rename-edits A to B, but the second
>> one still wants to edit A in place and you would want to pretend as if the
>> later one is for a patch to B?  I would think that is doable but asking
>> for too much magic, and a tool with too much magic is scary.
>
> Personally I think this case should be a failure.  I even attached a
> testcase in my patch to make sure this failed.  I wasn't comfortable doing
> this magic either.

Good.

>> There is a case where a normal git patch contains two separate patches to
>> the same file.  A typechange patch is always expressed as a deletion of
>> the old path immediately followed by a creation of the same path.  I have
>> to wonder why that codepath for handing that particular special case is
>> not changed in this patch.  Surely the mechanism you are adding is a
>> generalization that can cover such a case as well, isn't it?
>
> Heh.  Maybe, but I didn't know the code well enough to do that.  Pointers?

See the way "prev_patch" is used in check_patch.

>> > @@ -2176,6 +2184,38 @@ static int read_file_or_gitlink(struct cache_entry *ce, struct strbuf *buf)
>> >  	return 0;
>> >  }
>> >  
>> > +struct patch *in_fn_cache(char *name)
>> > +{
>> > +	struct path_list_item *item;
>> > +
>> > +	item = path_list_lookup(name, &fn_cache);
>> > +	if (item != NULL)
>> > +		return (struct patch *)item->util;
>> > +
>> > +	return NULL;
>> > +}
>> > +
>> > +void add_to_fn_cache(char *name, struct patch *patch)
>> > +{
>> > +	struct path_list_item *item;
>> > +
>> > +	/* Always add new_name unless patch is a deletion */
>> > +	if (name != NULL) {
>> > +		item = path_list_insert(name, &fn_cache);
>> > +		item->util = patch;
>> > +	}
>> > +
>> > +	/* skip normal diffs, creations and copies */
>> 
>> This comment is a "Huh?".
> I was just making a note about which cases I wanted to skip and which ones
> I wanted to process.  I can expand on it.  For example, patches that
> contain normal diffs, file creations and git copies or ignored as don't
> cares.  Only file deletions and git renames were interesting to me in the
> code below.

The function's purpose is to record what the expected state of the path
after the current patch has applied successfully, and

 * If it is not a deletion, you will record the postimage, so that a later
   patch can work from there, not from what is in the initial state;

 * If it is a deletion (or rename-away), you record that the path after
   this patch no longer exists, so that you can catch a later broken patch
   that tries to touch the path.

You have already handled "normal diff, creation and copy" in the first
part "if (name != NULL)", but you talk about it again here, which was the
"Huh?" inducing part.  It gave an impression that the part that follows
does something other than the above two.

>> > +	/*
>> > +	 * store a failure on rename/deletion cases because
>> > +	 * later chunks shouldn't patch old names
>> > +	 */
>> > +	if ((name == NULL) || (patch->is_rename)) {
>> > +		item = path_list_insert(patch->old_name, &fn_cache);
>> > +		item->util = (struct patch *) -1;

If you have a patch that does A->B (rename), C->A (rename), A->A (mod),
would your code handle that?

>> If you look at the patch->old_name _anyway_, why do you give a separate
>> name parameter to this function?  The function would be much easier to
>> read if you pass only patch, and use patch->new_name instead of the
>> separate name parameter.  Otherwise the reader needs to scroll down and
>> figure out that name is a new name by looking at the call site to
>> understand what is going on.
>
> Yeah, leftover code that was added when I ran into rename and copy
> problems.
>
>> 
>> > +	}
>> > +}
>> > +
>> >  static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
>> >  {
>> >  	struct strbuf buf;
>> > @@ -2188,7 +2228,16 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
>> >  		if (read_file_or_gitlink(ce, &buf))
>> >  			return error("read of %s failed", patch->old_name);
>> >  	} else if (patch->old_name) {
>> > -		if (S_ISGITLINK(patch->old_mode)) {
>> > +		struct patch *tpatch = in_fn_cache(patch->old_name);
>> > +
>> > +		if (tpatch != NULL) {
>> > +			if (tpatch == (struct patch *) -1) {
>> > +				return error("patch %s has been renamed/deleted",
>> > +					patch->old_name);
>> > +			}
>> > +			/* We have a patched copy in memory use that */
>> > +			strbuf_add(&buf, tpatch->result, tpatch->resultsize);
>> > +		} else if (S_ISGITLINK(patch->old_mode)) {
>> 
>> Isn't this wrong?  Why can't this new enhancement be used while operating
>> only on the index?
>
> I don't know, can it?  You tell me.  I wasn't sure on the whole index
> thing worked.

Perhaps a "git-apply" primer might help.  The program can work in three
modes of operation.

 * normal mode: look at and operate only on work tree files.

 * --index mode: work on both the index and the work tree.  IOW, patch the
   files and immediately do "git add -u" on that path, so that even
   addition and deletion are recorded in the index.  In this case, the
   paths involved must be up-to-date between the work tree and the index
   when you start "git apply"; otherwise you will lose your local
   changes.

 * --cached mode: work only on the index and never look at nor touch the
   work tree.

Now, if you have a patch that has A->A (mod), followed by another A->A(mod),
is there a good reason why you allow it in the first two modes and not the
last one?  I do not think so.
