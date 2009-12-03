From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCHv9 01/11] fast-import: Proper notes tree manipulation
Date: Thu, 03 Dec 2009 04:45:55 +0100
Message-ID: <200912030445.55732.johan@herland.net>
References: <1259719783-4674-1-git-send-email-johan@herland.net>
 <1259719783-4674-2-git-send-email-johan@herland.net>
 <20091202203953.GE31648@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 03 04:46:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG2dz-0004xC-K4
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 04:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbZLCDpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 22:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbZLCDpx
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 22:45:53 -0500
Received: from smtp.getmail.no ([84.208.15.66]:54232 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753089AbZLCDpw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2009 22:45:52 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KU2003ME54LZ300@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 03 Dec 2009 04:45:57 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KU2003PJ54JBW20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 03 Dec 2009 04:45:57 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.3.33320
User-Agent: KMail/1.12.3 (Linux/2.6.31-ARCH; KDE/4.3.3; x86_64; ; )
In-reply-to: <20091202203953.GE31648@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134428>

(Oops. I forgot to answer a couple of your questions...)

On Wednesday 02 December 2009, Shawn O. Pearce wrote:
> Johan Herland <johan@herland.net> wrote:
> > +static unsigned int do_change_note_fanout(
> > +		struct tree_entry *orig_root, struct tree_entry *root,
> > +		char *hex_sha1, unsigned int hex_sha1_len,
> > +		char *fullpath, unsigned int fullpath_len,
> > +		unsigned char fanout)
> > +{
> > +	struct tree_content *t = root->tree;
> > +	struct tree_entry *e, leaf;
> > +	unsigned int i, tmp_hex_sha1_len, tmp_fullpath_len, num_notes = 0;
> > +	unsigned char sha1[20];
> > +	char realpath[60];
> > +	int is_note;
> > +
> > +	for (i = 0; i < t->entry_count; i++) {
> > +		e = t->entries[i];
> > +		is_note = (e->versions[1].mode & NOTE_MODE) == NOTE_MODE;
> > +		tmp_hex_sha1_len = hex_sha1_len + e->name->str_len;
> > +		tmp_fullpath_len = fullpath_len;
> > +
> > +		if (tmp_hex_sha1_len <= 40 && e->name->str_len >= 2) {
> > +			memcpy(hex_sha1 + hex_sha1_len, e->name->str_dat,
> > +				e->name->str_len);
> > +			if (tmp_fullpath_len)
> > +				fullpath[tmp_fullpath_len++] = '/';
> > +			memcpy(fullpath + tmp_fullpath_len, e->name->str_dat,
> > +				e->name->str_len);
> > +			tmp_fullpath_len += e->name->str_len;
> > +			assert(tmp_fullpath_len < 60);
> > +			fullpath[tmp_fullpath_len] = '\0';
> > +		} else {
> > +			assert(!is_note);
> > +			continue;
> > +		}
> 
> Are we rejecting a mixed content-tree here?  I thought a notes
> tree was allowed to hold anything, e.g. isn't it ok to put a
> ".gitattributes" file into a notes tree.
> 
> I think we'd do better to have at the top of our loop:
> 
> 	if (!is_note && !S_ISDIR(e->versions[1].mode))
> 		continue;
> 
> so that we ignore non-notes and non-subdirectories which might
> contain notes.

AFAICS, the current code does not reject ".gitattributes", but instead 
simply ignores it presence (i.e. does not change its fanout). However, it 
certainly does some unnecessary work (setting up hex_sha1 and fullpath) 
which is ignored in the bottom part of the loop (where it fails both the "if 
(is_note)" and the following "else if").

However, while adding a test to verify the handling of non-notes, I came 
across an unrelated crasher in the notes.c code. Will send a fix for this 
ASAP.

In any case, I think your proposed if-condition is better, and I will 
rewrite the code accordingly.

> > @@ -2080,8 +2195,10 @@ static void note_change_n(struct branch *b)
> >  			    typename(type), command_buf.buf);
> >  	}
> >
> > -	tree_content_set(&b->branch_tree, sha1_to_hex(commit_sha1), sha1,
> > -		S_IFREG | 0644, NULL);
> > +	construct_path_with_fanout(sha1_to_hex(commit_sha1), fanout, path);
> > +	b->num_notes += adjust_num_notes(&b->branch_tree, path, sha1);
> > +	mode = (is_null_sha1(sha1) ? S_IFREG : NOTE_MODE) | 0644;
> > +	tree_content_set(&b->branch_tree, path, sha1, mode, NULL);
> 
> I wonder if it wouldn't be better to compute the fan out here on
> each put.  That way if an importer drives 2,000,000 notes at once
> to us in a single commit, we don't wind up with a flat 0 fan-out
> tree and trying to perform a linear insert on each one, but instead
> will start to increase the fan out as the number of entries goes up.
> 
> Basically, tree_content_set/remove are O(N) operations on N paths
> in the tree, because their structures aren't necessarily sorted.
> IIRC at one point in time I tried to do this with a binary search but
> gave up and just did it unsorted.  At least using the fan out here
> would help partition the search space dramatically on large inserts.

This is a really good idea, but it's a bit more complicated than that:
An 'N' command may not only add new notes, but also rewrite existing notes, 
and when rewriting an existing note we must take care to _replace_ the old 
note, and not merely adding a new note at a different fanout level. The 
above code implicitly guarantees this, by calling note_change_n() with the 
'old' fanout level (which will cause the new note to overwrite the old note 
in-place).

However, as long as we remember to check for (and remove, if found) the note 
at the old fanout level, we might still be able to place the new note at the 
_current_ fanout level [1], and thus avoid the worst case you describe 
above. Hmm. I need to think some more about this...


Have fun! :)

...Johan


[1] This is actually not _completely_ right: If you have several 'N' 
commands in the same commit that act on the same note, but happen to do so 
in at least two different fanout levels, you will end up with two notes for 
the same object (at least until do_change_note_fanout() arbitrarily 
overwrites one of them with the other). However, this might be such a far-
fetched scenario, that we don't have to worry about it in practice.

-- 
Johan Herland, <johan@herland.net>
www.herland.net
