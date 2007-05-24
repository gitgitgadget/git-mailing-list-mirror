From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Thu, 24 May 2007 16:29:20 -0700
Message-ID: <56b7f5510705241629n192a41adi4c0d63c53cf8472b@mail.gmail.com>
References: <46528A48.9050903@gmail.com>
	 <7v7iqz19d2.fsf@assigned-by-dhcp.cox.net>
	 <56b7f5510705231655o589de801w88adc1aa6c18162b@mail.gmail.com>
	 <7vps4ryp02.fsf@assigned-by-dhcp.cox.net>
	 <20070524071235.GL28023@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 25 01:29:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrMkK-0004AE-9N
	for gcvg-git@gmane.org; Fri, 25 May 2007 01:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbXEXX3X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 19:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbXEXX3X
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 19:29:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:37971 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbXEXX3W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 19:29:22 -0400
Received: by ug-out-1314.google.com with SMTP id j3so986131ugf
        for <git@vger.kernel.org>; Thu, 24 May 2007 16:29:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XdJW93KOfH97E0dIsg4/9nuGHCGjAcDQt0CRdvA8PuL0aP1FVlg+B8zXiFzTe38i6LzUp7gwKXVIQ9ay2q0A1Uoz3Rz6n29TRQSRcxYjCl1F5dob9PQEOTEVtXJmwBx1wgRL+iuvl3OmH6gR/jgxhtTVWQx1CA3CK2Si5r8eNE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hi2ud59KviEbPFy16EN2T63uU33JzDSWEsuQuS/R39QbuJAPJN4oQkS44JJt0avquRfTLHkdOiRlMCXHn+3sNqOSfVqZM+XE2VfSAxn1O5l7T0PgvkQFx6GBBFhZOCMdHqLYkWH5Crc4hEIlS5va7PI9s6LdirqUJaSgVK9cCSE=
Received: by 10.78.193.5 with SMTP id q5mr686094huf.1180049360940;
        Thu, 24 May 2007 16:29:20 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Thu, 24 May 2007 16:29:20 -0700 (PDT)
In-Reply-To: <20070524071235.GL28023@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48317>

On 5/24/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Junio C Hamano <junkio@cox.net> wrote:
> > "Dana How" <danahow@gmail.com> writes:
> > > We have three options in this case:
> > > (1) Drop the object (do not put it in the new pack(s)).
> > > (2) Pass the object into the new pack(s).
> > > (3) Write out the object as a new loose object.
> > > Option (1) is unacceptable.  When you call git-repack -a,
> > > it blindly deletes all the non-kept packs at the end.  So
> > > the megablobs would be lost.
> > Ok, I can buy that -- (1) nor (2) are unacceptable and (3) is
> > the only sane thing to do for a previously packed objects that
> > exceed the size limit.
>
> I still don't buy the idea that these megablobs shouldn't be packed.
> I understand Dana's pain here (at least a little bit, my problems
> aren't as bad as his are), but I also hate to see us run away from
> packfiles for these really sick cases just because we have some
> issues in our current packfile handling.
>
> Packfiles give us a lot of benefits:
>
>  1) less inode usage;
I agree with Geert that blowing an inode on a 100MB+ object
is no big deal.
>  2) transport can write directly to local disk;
>  3) transport can (quickly) copy from local disk;
For (2) and (3) see comments on next para plus NFS discussion.
>  4) testing for existance is *much* faster;
This is true.  But I don't care about this cost if it
is only incurred on large objects which are leaf nodes
in the git "data relationship tree" (tags->commits->trees->blobs) anyway.
>  5) deltafication is possible;
Again Geert made a good argument that didn't occur to me that
you definitely DON'T want to do deltification on such large objects.
Junio recently added delta/nodelta attribute; this would be useful
to me,  but unfortunately I have several continua of files,  each with
the same suffix,  but with largely varying sizes, so attributes won't
help me unless the name globs in .gitattributes are expanded to full
expressions similar to find(1) [i.e. include testing based on size,
perms, type],  which I think would be insane.

> Now #3 is actually really important here.  Don't forget that we
> *just* disabled the fancy "new loose object format".  It doesn't
> exist.  We can read the packfile-like loose objects, but we cannot
> write them anymore.  So lets say we explode a megablob into a loose
> object, and its 800 MiB by itself.  Now we have to send that object
> to a client.  Yes, that's right, we must *RECOMPRESS* 800 MiB for
> no reason.  Not the best choice.  Maybe we shouldn't have deleted
> that packfile formatted loose object writer...
I completely agree with your argument.  I do not suggest that repositories
that communicate with others via packs should use this feature.
Our repositories will communicate via alternates/NFS in one direction
and probably packs in the other.  In the latter case the packs would
be generated with maxblobsize=0. See comments on next para.

> Now one argument to work around that recompression problem would
> be to NFS share out the loose objects directory, and let clients
> mount that volume and add it to their .git/objects/info/alternates
> list.  But this doesn't work in the very general distributed case,
> such as me getting huge files from kernel.org.  Last I checked,
> the kernel.org admins did not offer up NSF mounts.  Besides, the
> round-trip latency between me and kernel.org is too large for it
> to be useful anyway over NFS.  :)
The NFS case is exactly what I want to use.  I want each repo to
have their own packfiles to reduce load on the central alternate,
but these local repos would not include megablobs.  I do not have
as strong a feeling about whether the central alternate should
pack its megablobs or not [but I don't want to do it if it costs me
deltification for everybody], but I need a way to exclude megablobs
from getting into local packs.  WIth such exclusion,  git-gc/repack
is extremely quick.  There is NO WAY this can be true if
several GB have to be copied around,  which again comes from Geert.

I think this conversation does suggest one alteration to my patch:
as submitted it writes out a loose object if the object is packed
and has no loose object.  It should really do this only if the
object is packed LOCALLY and has no loose object.

> So I think this "explode out megablobs" is a bad idea.  Its violating
> other things that make us fast, like #3's being able to reuse large
> parts of an existing packfile during transfer.
As I said,  your true argument doesn't apply in my case.

> Dana pointed out the megablobs make access slower because their
> packfile indexes must still be searched to locate a commit; but if
> the megablob packfile(s) contain only blobs then there is no value
> in looking at those packfiles.
>
> We might be able to fix this by altering the sort_pack function
> in sha1_file.c to not only order by mtime, but also by the ratio
> of the size of the .pack to the number of objects stored in it.
> Any packfile with a high size/object ratio is likely to be what
> Dana has been calling a "metadata" pack, holding things like tags,
> commits, trees and small blobs.  Its these packfiles that we want
> to search first, as they are the most likely to be accessed.
>
> By pushing the megablob packs to the end of our packed_git search
> list we won't tend to scan their indexes, as most of our objects
> will be found earlier in the search list.  Hence we will generally
> avoid any costs associated with their indexes.
Good argument and I submitted a patch to do this.
Let's see who chokes on the floating arithmetic ;-)

> Huge packfiles probably should be scheduled for keeping with a .keep
> automatically.  We probably should teach pack-objects to generate a
> .keep file if the resulting .pack was over a certain size threshold
> (say 1.5 GiB by default) and teach git-repack to rename the .keep
> file as it also renames the .idx and .pack.
I have experimented with this,  and Jakub Narebski made related
suggestions.  I find this quite hokey,  but even if I do it in my central
alternate,  I still do not want to be packing megablobs in individual user's
repos EVER,  and need some way to exclude them.

> Better that we degrade gracefully when faced with massive inputs
> than we do something stupid by default and make the poor user pay
> for their mistake of not throughly reading plumbing documentation
> before use.
Unnecessary copying of several GB is not degrading gracefully in my view.
In fact having repack.maxblobsize = 2000 (K) in the default "config"
strikes me as degrading much more gracefully than what the code
would currently do.

This silly patch took my packfile sets from 12GB+ to 13MB,
and it's difficult to describe how relieved I now feel.

It's also difficult for me to believe that a setup that treats 12GB
(almost) equally is going to be as efficient as one which concentrates on 13MB.
That's three orders of magnitude,  a point I've made before.

But I think you have an understandable motivation:
you want packfiles to be as good as possible,  and any escape
mechanism from them decreases the motivation to "fix" packing.
Now I agree with this, which is why I just submitted some other patches,
but I don't share your goal of the universality of all packfiles --
just the ones used for transport.  Don't your packv4 plans introduce
mods which won't be used for transport as well?

> Now I would agree that we should punt on deltification of anything
> that is just too large, and let the user decide what too large means,
> and default it around 500 or 1024 MiB.  But I would still stuff it
> into a packfile.
>
> Maybe it still makes sense to have a limit on the maximum size of a
> loose object to pack, but I think that's only to avoid the sick case
> of a very simple no-argument "git repack" taking a long while because
> there's 8 loose objects and 6 of them are 900 MiB image files.
Perhaps we _will_ make progress if we all agree to describe
my situation as "sick" ;-) .  In this paragraph you seem to agree that
there is some argument for keeping megablobs from _entering_ packs?

One reason I like my patch is because I do view megablobs
as perverting the system,  and just keeping them out of the optimized
packfile system is a big step forward.

> Once in a packfile, I'd keep it there, even if the user decreases
> the threshold, as the advantages of it being in the packfile outweigh
> the disadvantages of it being in the packfile.  And there's like no
> advantage to being loose once packed.
To (almost) follow this suggestion I would need git-fast-import to respect
repack.maxblobsize as well.  Is that OK with you?

I previously offered to Junio that the "write loose object" thing
could be restricted:  it would only happen if -f were supplied to
git-repack,  otherwise the bad blob would pass through to the new pack.
Does this "reduction in strength" make this feature more palatable to you?

If the stats on a repo change significantly,  "write loose object"
becomes more important if you have to make a significant reduction
to repack.maxblobsize (or specify it for the first time).

I don't agree that once in a packfile,  a blob should stay there.
Its presence is degrading access to "normal" blobs co-habiting with it.
So you will want to repack to separate them in different packs
(the various .keep-related ideas) or just write them out loose.

To conclude:
the patch wrote out a new loose object when it was previously
packed and is larger then repack.maxblobsize.
I could change this to only happen when the object is
(1) packed AND
(2) locally packed AND
(3) -f/--no-object-reuse was specified to git-repack/git-pack-objects.
The previous behavior that a megablob never _enters_ the pack
would remain unchanged.

This more restrictive behavior would be sufficient for me,
and I think I *need* it at least in the users' repositories
in an NFS/alternates setup.

What do you think?

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
