From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Achieving efficient storage of weirdly structured repos
Date: Fri, 4 Apr 2008 16:57:34 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0804041634180.14670@woody.linux-foundation.org>
References: <7BE3E865-C30D-49B8-A1D9-898109514990@sun.com> <alpine.LFD.1.00.0804031402530.14670@woody.linux-foundation.org> <1207351858.13123.52.camel@work.sfbay.sun.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Roman Shaposhnik <rvs@sun.com>
X-From: git-owner@vger.kernel.org Sat Apr 05 01:58:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jhvnb-0003H7-UJ
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 01:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbYDDX5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 19:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbYDDX5l
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 19:57:41 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36151 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751339AbYDDX5k (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Apr 2008 19:57:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m34NvZbl024193
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 4 Apr 2008 16:57:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m34NvYjd015393;
	Fri, 4 Apr 2008 16:57:35 -0700
In-Reply-To: <1207351858.13123.52.camel@work.sfbay.sun.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.383 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78825>



On Fri, 4 Apr 2008, Roman Shaposhnik wrote:
> 
> That turned out to be a perfect suggestion. Thank you. I'm now the
> happiest camper ever. And I'm also also pretty dumbfounded ;-)

Ok, the dumbfounded we can help with.

> Here's what happened. 
> 
> I started with a a repository filled with "loose" (one object per file)
> objects (the reason I needed it was for the ease of sleuthing through
> individual objects and it was created by git-unpack-objects from that
> initial 1.1Gb pack). And I tried to pack it exactly like you
> suggested:
>    $ git-pack-objects --depth=100 --window=100 --delta-base-offset --progress pack < objects

Well, that's not exactly like I suggested, that's a *really* old-fashioned 
way.

But the part you left off was what the "objects" file contained?

In particular, "git pack-objects" can take just a raw list of objects, and 
it will *work*, but without the naming information and without the 
ordering information on the objects, the end result will generally suck.

So how did you generate the "objects" file? You can do it by just listing 
every single loose object you have, and it will work, but the end result 
won't be very pretty.

>    Total 1159628 (delta 386980), reused 0 (delta 0)
> 
> and it payed off reasonably well:
>     $ du -s NB-clone
>     670M NB-clone

So what git-repack-objects will do is that it will *try* to figure out a 
good and likely pairing of objects, and it uses the type and the size of 
the objectf rot it, but it obviously didn't find very good deltas. In 
fact, only about 35% of all objects are deltas at all!

Which is why I suspect that your object list was just the raw list of 
objects.

> His comments made me try something that I didn't consider to be of any 
> use -- repacking a freshly packed pack with the *same* --depth=100 
> --window=100:
>     $ git repack -a  -f --window=100 --depth=100 

Well, "git repack" doesn't just list the objects and then repack them, it 
also

 - lists them with the filename they were reachable from (if they are 
   trees or blobs)
 - sorts them topologically (ie most reachable objects first).

And that first thing will generate a *much* better packing, because now 
the packing algorithm can look at the filename, and generate a much better 
guess about which objects to try to delta against each others. And now you 
have

>     Total 1159628 (delta 614516), reused 0 (delta 0)

Ie you got a much better 60% delta ratio, and obviously a much smaller 
pack. But it's not just smaller, because the resulting pack will also have 
the objects in topological order, so that objects that are "new" 
(ie more closely reachable from the top-of-tree) will be at the front of 
the pack, so you'll also generally have better IO patterns in the packfile 
itself.

> Now, don't get me wrong: I'm as happy as a clam. The repository is now
> *smaller* than the Mercurial's and because the structure of the
> tree is so weird Git gets major points here. The only question that
> is still bothering me is: how did it happen? Why did repacking 
> a repository with exactly the same set of objects and the only
> difference being where these objects resided (former case filesystem,
> the later case an intermediate pack) made so huge a difference?

That location thing really shouldn't have mattered (since you used "-f", 
which throws it away).  So I think it was all from how you generated the 
list of objects. But since I don't know how you did that, I cannot 
guarantee anything.

> Is there any documentation that describes the heuristics involved in
> creating a pack?

It's been explained a few times on the mailing list, but I don't know if 
there is some write-up.

The git pack format is a bit more relaxed than any other SCM format I know 
about, since it literally is just a "bunch of objects with deltas randomly 
between them". So a pack can look just about any way it wants - there are 
no real ordering requirements (--delta-base-offset does require that the 
delta follows the base, but even that is really just a trivial practical 
"because otherwise you could never know what the offset in the pack-file 
was" issue rather than anything else).

So you can order the objects and make deltas just about any way you want. 
What "git repack" will do is to sort objects by <type, namehash, length>, 
and then walk the list with the window of the specified size to see the 
best pairing it can do.

The "namehash" is just designed so that files that have the same name sort 
together (and it's also not a real "hash" - it's really a meaningless 
number, but one that is designed so that even if the names aren't exactly 
the same, they sort closer together if they end in similar character 
sequences - so a file that moves from one directory to another but keeps 
the same basename will sort source and destination together).

See "type_size_sort()" in builtin-pack-objects.c to see what's up.

(The preferred_base thing is just to keep objects we actually want to 
*keep* in the pack separated from the objects we may be using for 
references - but that is only used for transferring objects over the wire, 
never for standalone packs).

Oh. And now I notice that there is *some* documentation on this in 

	Documentation/technical/pack-heuristics.txt

but that's pretty old (not that I think it has really changed) and not 
very deep. Just taken from some #irc discussion.

> P.S. Oh, and here's one extra tiny question that I also have: what
> does the output:
>    Total 1159628 (delta 614516), reused 0 (delta 0)
> really mean?

It just means that there were a million objects total, the pack was 
created with 614k of them as deltas against other objects, and none of 
them were re-used from previous packs.

You'll see that when you do incremental repacks, 99% of all the objects 
and deltas get re-used from the old pack, which is how we can make 
repacking fairly efficient. That's imporant because the native git 
protocol format itself is just a pack-file (plus the handshake to figure 
out what both sides have, of course). So a "git clone" implies a repack.

		Linus
