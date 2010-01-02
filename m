From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 4/4] reset: use "unpack_trees()" directly instead of "git read-tree"
Date: Sat, 2 Jan 2010 06:41:41 +0100
Message-ID: <201001020641.41921.chriscool@tuxfamily.org>
References: <20091230055008.4475.95755.chriscool@tuxfamily.org> <7vtyv6o18q.fsf@alter.siamese.dyndns.org> <7vhbr6mhn9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 06:39:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQwhl-0001q6-SN
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 06:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066Ab0ABFjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 00:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878Ab0ABFjI
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 00:39:08 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53899 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807Ab0ABFjH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 00:39:07 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 75C78818036;
	Sat,  2 Jan 2010 06:38:52 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6135A818019;
	Sat,  2 Jan 2010 06:38:49 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vhbr6mhn9.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136015>

Hi and happy new year!

On vendredi 01 janvier 2010, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > At least disallowing means that the user _is notified_ and has to
> > manually deal with the situation.  Pretending it succeeded by resetting
> > only the index while still leaving the conflicted state in the work
> > tree intact is a bit worse in that sense.
> >
> >> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> >> index c9044c9..b40999f 100644
> >> --- a/Documentation/git-reset.txt
> >> +++ b/Documentation/git-reset.txt
> >> @@ -122,7 +122,7 @@ entries:
> >>         X       U     A    B     --soft  (disallowed)
> >>                                  --mixed  X       B     B
> >>                                  --hard   B       B     B
> >> -                                --merge (disallowed)
> >> +                                --merge  X       B     B
> >
> > IOW, I think the result should be "B B B" instead of "X B B" in this
> > case.
>
> A squashable fix-up on top of your patch to match the wish in the part
> you quoted from 9e8ecea (Add 'merge' mode to 'git reset', 2008-12-01)
> would look like this, I think.
>
> It does three things:
>
>  - Updates the documentation to match the wish of original "reset
> --merge" better, namely, "An unmerged entry is a sign that the path
> didn't have any local modification and can be safely resetted to whatever
> the new HEAD records";
>
>  - Updates read_index_unmerged(), which reads the index file into the
>    cache while dropping any higher-stage entries down to stage #0, not to
>    copy the object name recorded in the cache entry.  The code used to
>    take the object name from the highest stage entry ("theirs" if you
>    happened to have stage #3, or "ours" if they removed while you kept),
>    which essentially meant that you are getting random results and didn't
>    make sense.
>
>    The _only_ reason we want to keep a previously unmerged entry in the
>    index at stage #0 is so that we don't forget the fact that we have
>    corresponding file in the work tree in order to be able to remove it
>    when the tree we are resetting to does not have the path.  In order to
>    differentiate such an entry from ordinary cache entry, the cache entry
>    added by read_index_unmerged() records null sha1.
>
>  - Updates merged_entry() and deleted_entry() so that they pay attention
>    to cache entries with null sha1 (note that we _might_ want to use a
>    new in-core ce->ce_flags instead of using the null-sha1 hack). They
>    are previously unmerged entries, and the files in the work tree that
>    correspond to them are resetted away by oneway_merge() to the version
>    from the tree we are resetting to.
>
> Please take this with a grain of salt as I am under slight influence of
> CH3-CH2-OH while writing it, and I usually almost never drink.

I like this patch. It seems to improve the behavior of the --keep option for 
unmerged entries too.

The previous behavior was:

    working index HEAD target         working index HEAD
    ----------------------------------------------------
     X       U     A    B     --keep   X       B     B
     X       U     A    A     --keep   X       A     A

and now it is:

    working index HEAD target         working index HEAD
    ----------------------------------------------------
     X       U     A    B     --keep  (disallowed)
     X       U     A    A     --keep   X       A     A

And I think it is better, as it is more consistent with the behavior when 
there are no unmerged entries.

The only problem is that when it fails the error message is something like:

    error: Entry 'file1' would be overwritten by merge. Cannot merge.
    fatal: Could not reset index file to revision 'HEAD^'.

which is not very nice.

I will send a RFC patch series so people interested can test this.

Thanks,
Christian.
