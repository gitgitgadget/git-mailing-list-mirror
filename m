From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] git-apply doesn't handle same name patches well [V3]
Date: Thu, 19 Jun 2008 17:33:41 -0400
Message-ID: <20080619213341.GP16941@redhat.com>
References: <1213646686-31964-1-git-send-email-dzickus@redhat.com> <7vbq1z375d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:35:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Rmp-0002cd-TZ
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 23:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756880AbYFSVeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 17:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755213AbYFSVeN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 17:34:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54995 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755247AbYFSVeK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 17:34:10 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5JLXgPg021144;
	Thu, 19 Jun 2008 17:33:42 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5JLXf7h016442;
	Thu, 19 Jun 2008 17:33:41 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m5JLXft7016031;
	Thu, 19 Jun 2008 17:33:41 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m5JLXfLV016260;
	Thu, 19 Jun 2008 17:33:41 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m5JLXfbI016259;
	Thu, 19 Jun 2008 17:33:41 -0400
X-Authentication-Warning: drseuss.usersys.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
In-Reply-To: <7vbq1z375d.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85536>

On Tue, Jun 17, 2008 at 05:42:54PM -0700, Junio C Hamano wrote:
> Don Zickus <dzickus@redhat.com> writes:
> 
> > When working with a lot of people who backport patches all day long, every
> > once in a while I get a patch that modifies the same file more than once
> > inside the same patch.  git-apply either fails if the second change relies
> > on the first change or silently drops the first change if the second change
> > is independent.
> 
> Good issue to tackle.
> 
> > A new test has been added to cover the cases I addressed.  However,
> > currently adding changes to renamed file inside the same patch doesn't work
> > correctly (it fails to find new file).  I didn't know how to fix this
> > correctly, so I have the test fail expectedly.
> 
> Do you mean that the first patch rename-edits A to B, and then the second
> patch edits B in place?  Because your fn_cache is keyed by postimage
> filename (in this case B), I would imagine that the later lookup of B
> should successfully find the patch result from the previous one.  Unless
> the in_fn_cache() is somehow wrong...

Yeah, I thought so too, but after debugging the problem, the 'lstat' in
check_preimage() fails to find the file on disk and exits with that error.

I was going to try to figure out a way to grab it from fn_cache but I
wasn't sure how much of the 'lstat' info is needed later.

> 
> or do you mean that the first patch rename-edits A to B, but the second
> one still wants to edit A in place and you would want to pretend as if the
> later one is for a patch to B?  I would think that is doable but asking
> for too much magic, and a tool with too much magic is scary.

Personally I think this case should be a failure.  I even attached a
testcase in my patch to make sure this failed.  I wasn't comfortable doing
this magic either.

> > +/*
> > + * Caches patch filenames to handle the case where a
> > + * patch chunk reuses a filename
> > + */
> > +
> > +struct path_list fn_cache = {NULL, 0, 0, 0};
> 
> "Reuses a filename"?  Do you mean touches the same file again?
> 
> This is not a "cache" in the sense that you can nuke it without changing
> the behaviour except performance, but more about "Record the postimage
> pathnames (and contents, indirectly by pointing at the patch structure)
> each previous patch application would have created".

Yes, poor choice of words.  I'll try to think of a something else.

> 
> There is a case where a normal git patch contains two separate patches to
> the same file.  A typechange patch is always expressed as a deletion of
> the old path immediately followed by a creation of the same path.  I have
> to wonder why that codepath for handing that particular special case is
> not changed in this patch.  Surely the mechanism you are adding is a
> generalization that can cover such a case as well, isn't it?

Heh.  Maybe, but I didn't know the code well enough to do that.  Pointers?
I'll try to poke around and see what I can cleanup, but I will have to
rely on the mailing-list to make sure I did it correctly.

> 
> > @@ -2176,6 +2184,38 @@ static int read_file_or_gitlink(struct cache_entry *ce, struct strbuf *buf)
> >  	return 0;
> >  }
> >  
> > +struct patch *in_fn_cache(char *name)
> > +{
> > +	struct path_list_item *item;
> > +
> > +	item = path_list_lookup(name, &fn_cache);
> > +	if (item != NULL)
> > +		return (struct patch *)item->util;
> > +
> > +	return NULL;
> > +}
> > +
> > +void add_to_fn_cache(char *name, struct patch *patch)
> > +{
> > +	struct path_list_item *item;
> > +
> > +	/* Always add new_name unless patch is a deletion */
> > +	if (name != NULL) {
> > +		item = path_list_insert(name, &fn_cache);
> > +		item->util = patch;
> > +	}
> > +
> > +	/* skip normal diffs, creations and copies */
> 
> This comment is a "Huh?".
I was just making a note about which cases I wanted to skip and which ones
I wanted to process.  I can expand on it.  For example, patches that
contain normal diffs, file creations and git copies or ignored as don't
cares.  Only file deletions and git renames were interesting to me in the
code below.

> 
> > +	/*
> > +	 * store a failure on rename/deletion cases because
> > +	 * later chunks shouldn't patch old names
> > +	 */
> > +	if ((name == NULL) || (patch->is_rename)) {
> > +		item = path_list_insert(patch->old_name, &fn_cache);
> > +		item->util = (struct patch *) -1;
> 
> If you look at the patch->old_name _anyway_, why do you give a separate
> name parameter to this function?  The function would be much easier to
> read if you pass only patch, and use patch->new_name instead of the
> separate name parameter.  Otherwise the reader needs to scroll down and
> figure out that name is a new name by looking at the call site to
> understand what is going on.

Yeah, leftover code that was added when I ran into rename and copy
problems.

> 
> > +	}
> > +}
> > +
> >  static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
> >  {
> >  	struct strbuf buf;
> > @@ -2188,7 +2228,16 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
> >  		if (read_file_or_gitlink(ce, &buf))
> >  			return error("read of %s failed", patch->old_name);
> >  	} else if (patch->old_name) {
> > -		if (S_ISGITLINK(patch->old_mode)) {
> > +		struct patch *tpatch = in_fn_cache(patch->old_name);
> > +
> > +		if (tpatch != NULL) {
> > +			if (tpatch == (struct patch *) -1) {
> > +				return error("patch %s has been renamed/deleted",
> > +					patch->old_name);
> > +			}
> > +			/* We have a patched copy in memory use that */
> > +			strbuf_add(&buf, tpatch->result, tpatch->resultsize);
> > +		} else if (S_ISGITLINK(patch->old_mode)) {
> 
> Isn't this wrong?  Why can't this new enhancement be used while operating
> only on the index?

I don't know, can it?  You tell me.  I wasn't sure on the whole index
thing worked.

I'll respin the patch when I get some free time tomorrow or next week.

Cheers,
Don
