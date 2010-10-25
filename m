From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH v7 1/3] Introduce bulk-move detection in diffcore.
Date: Mon, 25 Oct 2010 22:12:27 +0200
Message-ID: <20101025201227.GB3347@home.lan>
References: <1287868022-24872-1-git-send-email-ydirson@altern.org>
 <1287868022-24872-2-git-send-email-ydirson@altern.org>
 <7veibeitip.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Yann Dirson <ydirson@free.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 22:12:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PATPP-00004r-Dk
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 22:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757749Ab0JYUMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 16:12:36 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:52940 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757646Ab0JYUMg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 16:12:36 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 0D56DD48056;
	Mon, 25 Oct 2010 22:12:28 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PATP9-0001TA-Pf; Mon, 25 Oct 2010 22:12:27 +0200
Content-Disposition: inline
In-Reply-To: <7veibeitip.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159969>

On Mon, Oct 25, 2010 at 01:08:46AM -0700, Junio C Hamano wrote:
> Yann Dirson <ydirson@altern.org> writes:
> 
> > The output of raw diff is displayed as "Rnnn a/* b/".  Those cannot be
> > confused with renames of files named "whatever/*" with a literal star
> > character, from the full-zero SHA1's.
> 
> I do not particularly like this asterisk here.  It is ambiguous with the
> case where you renamed a directory whose name is '*' below a/ to a new
> directory whose name is 'b', isn't it?  Using 0{40} as a differentiator
> like you did is probably a good idea, but then I do not see a sound reason
> you would need nor want that asterisk.

It all boils down to one of the original motivations of this patch:
allowing exporters like git-svn to provide the right level of
information on directory renames, instead of only telling svn that the
git-svn user has renamed all individual files separately.

It is only later that I realized that the larger picture was about
bulk moves, and directory renames were only a subset of those.  So to
be able here to provide the right level of information to git-svn, we
need a separate syntax for the special case of dir renaming - and it
appeared natural to me to use something as close as possible to the
usual syntax used for the operation:

git mv foo bar => rename directory "foo" to "bar"
git mv foo/* bar/ => move all contents of "foo" to pre-existing "bar"

(I would still add trailing slashed to the first form for the sake of
ambiguity, obviously).

Now I'm not 100% happy with using 0{40} as differentiator - eg. we may
some day find out that it is indeed useful to output the tree hashes
there.

OTOH, the quoting rules for diff output are quite minimalist, I don't
know whether adding "*" as a character that requires quotes around the
filename would be acceptable: then we'll be able to differentiate
"foo/*" from "foo/"* or "foo"/* (quotes here for emphasis, for
interaction with other possible special chars) - the current code
would have a strong bias towards "foo/"*, but neither seem very sexy
to me (but since they would only appear in "pathologic" situations, do
we care ?)

[off-topic] while playing with (un)quoted filenames I noticed spaces
do not cause quoting, which can cause its own problems, like (not)
making a visual distinction between file "foo" and file "foo " in diff
output - not that it would be good practice, but someone can always
shoot itself in the foot, and it appears we have not thought yet on
how to help him not to shoot himself in this particular way.


> > +Bulk move of all files of a directory into a different one can get
> > +detected using the `\--detect-bulk-moves` option.  This adds an
> > +additional pass on top of the results of per-file rename detection.
> > +They are reported with NULL SHA1 id, in addition to the file renames:
> > +
> > +------------------------------------------------
> > +:040000 040000 0000000... 0000000... R100	a/*	b/
> > +:100644 100644 0123456... 1234567... R90	a/file0	b/file3
> > +:100644 100644 0123456... 1234567... R100	a/file1	b/file1
> > +:100644 100644 0123456... 1234567... R100	a/file2	b/file2
> 
> This is kind of interesting.  Let's address two issues that should be
> uncontroversial:

OK.

> These obvious two complaints behind us, there is one more interesting
> thing in the above, which is _not_ a complaint.
> 
> What about renaming of a/file0 to b/file3?  Is this part of "all files
> from directory A moved to directory B"?

The move+rename is "part of" the bulk rename in that the file is moved
from/two the same dirs as its siblings, but I acknowledge that it is
more than that.

>  IOW, is the goal of this series
> to use the "A/* -> B/" to label the change as bulk directory rename, if
> the preimage has A/{1,2,3} and the postimage has their moved contents in
> B/{one,two,three}?

Yes.  But --hide-bulk-move-details would not hide them, as they would
not be strictly included in the bulk move.  Desite their name change,
they are however a confirmation that the contents of A/ was move to B/.


> I am wondering about the utility of such an extra information.  If there
> were no "a/file0 -> b/file3" entry in the example, I would imagine that we
> could use this "a/* -> b/" information to move "a/file5" to "b/file5" when
> rebasing this patch to apply to a different preimage that had files other
> than file{1,2} in directory "a", and I would further imagine that might be
> a wonderful thing.

I imagined that as well, and that situation would not be a problem:
since "a/file0 -> b/file3" would be there in the rebased patch,
"apply" would be able to spot the possible conflict.

OTOH, I had the vision of "merge does automatic moves" when starting
this project, but got convinced on-list that there are always cases
where the "automatic move" on merge would be wrong, and that we should
report a conflict instead.

That would mostly shift the problem to: how do we provide support for
easily solving this type of problem (regardless of how we want to
represent them, which may not be trivial either).


> But if the new "a/* -> b/" hint only gives "things from A/ have migrated
> to B/ but I can give no information on what name they took under their new
> home", that may probably reduce the utility of this feature.

It would still mean that "ALL things from A/ have migrated", and does
not imply anything more, just like the fact that a file was renamed
does not prevent us to say that while moving it was also modified.

-- 
Yann
