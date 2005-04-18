From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: Yet another base64 patch
Date: Mon, 18 Apr 2005 01:13:32 -0400
Message-ID: <426341FC.7090600@dwheeler.com>
References: <Pine.LNX.4.58.0504141042450.7211@ppc970.osdl.org> <20050414191157.GA27696@outpost.ds9a.nl> <425EC3B4.6090908@zytor.com> <20050414214756.GA31249@outpost.ds9a.nl> <Pine.LNX.4.58.0504141743360.7211@ppc970.osdl.org> <425F13C9.5090109@zytor.com> <20050414205831.01039ee8.pj@engr.sgi.com> <4261DDBC.3050706@dwheeler.com> <20050416210513.1ba26967.pj@sgi.com> <42620452.4080809@dwheeler.com> <20050417181935.GD1461@pasky.ji.cz>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Jackson <pj@sgi.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 07:08:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNOUM-000385-88
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 07:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVDRFLx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 01:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVDRFLx
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 01:11:53 -0400
Received: from cujo.runbox.com ([193.71.199.138]:34472 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261674AbVDRFLk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 01:11:40 -0400
Received: from [10.9.9.11] (helo=fifi.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DNOXn-0004g8-4I; Mon, 18 Apr 2005 07:11:35 +0200
Received: from [70.17.101.238] (helo=[192.168.2.73])
	by fifi.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DNOXm-0005NF-GG; Mon, 18 Apr 2005 07:11:35 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050417181935.GD1461@pasky.ji.cz>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I said:
>>I'd look at some of the more constraining, yet still
>>common cases, and make sure it worked reasonably
>>well without requiring magic. My list would be:
>>ext2, ext3, NFS, and Windows' NTFS (stupid short filenames,
>>case-insensitive/case-preserving).

Petr Baudis replied:
> I personally don't mind getting it work on more places, if it doesn't
> make git work (measurably) worse on modern Linux systems, the code will
> not go to hell, you tell me what needs to be done and preferably give me
> the patches. ;-)

Okay, that's great.

The one potential issue I know of (after trying to read from the
firehose^Wlist archives) is that some are worried about poor filesystems
when there are a large number of objects in an object directory.

After doing some calculations, it seems to me that perhaps this
isn't really such a big deal, if there's a top directory such as
the 16-bit (2-char) top directory currently in git-pasky.
Removing the top directory would improve performance for the better
filesystems, but would be an absolute KILLER to poorer systems, so
I'd keep the 2**8 top directory just as it is in git-pasky.
It's a compromise that means people can ease into git, and then
switch when their projects grow to large sizes.
My calculations are below, but I could be mistaken; let me
know if I'm all wet.

Does anyone know of any other issues in how git data is stored that
might cause problems for some situations?  Windows' case-insensitive/
case-preserving model for NTFS and vfat32 seems to be enough
(since the case is preserved) so that the format should work,
and you can just demand that
special git files use Unix formats ("/" as dir separator,
Unix end-of-lines).  The implementation currently would need
change to work easily on Windows (dealing with binary opens at least,
and probably rewriting the shell programs for those unwilling to
install Cygwin), but those can be done later if desired
without interfering with the interface formats.


========================= Details =========================

Basically, I'd like "git" to work on:
(1) nearly ANY system on small-to-medium projects,
     even if their filesystems do linear searches in directories,
     over a lengthy time.  Ideally possibly (though poorly)
     on larger systems.
(2) work well on large projects (e.g., kernel) on _common_
     development platforms (ext2, ext3, NTFS, NFS).

It all depends on what you're optimizing for; but humor me
if those were your requirements...

Case 1:
The top (2-char) directory appears likely to make small projects
perform okay, and large projects possible, on stupid filesystems.
The one level extra directory is actually not a bad compromise
to make things "just work" on just about anything for smaller scales.
* git-paskey (a tiny project) has ~2K objects in 2weeks; at that pace,
4Kobjects/month for 10 years, you'd have 480K objects.
That's absurd for even tiny projects, and it's unlikely that
a participant in a tiny project would be willing to change
filesystems just to participate.  But then if you
divide it among 256 directories = 1875 files/directory average.
Linear search is undesirable (about 1000 entry checks on
average to find each entry), but it's nowhere near the
2^16 dir entries that made people afraid.
Switching to a 2^12 top directory, you have an average of 117 entries
in each subdir (and 4096 entries at the top), yielding
an average of (117+4096)/2 = 2106 entry checks to find an entry.
* I estimated also for the big end, using the Linux kernel;
I guesstimated 36,000 objects/month for the kernel**. Over 10 years that
accumulates 4,320,000 objects, completely insane for a flat file
on a stupid filesystem. If it has a one-level 256dir directory, that's
16875 objects/directory.  Now THAT'S painful,
though nowhere near the 2^16 limit most quoted as bad.
* For 10K objects/month, and a top dir of 2**8, you have 1,200,000
objects; each dir has 4680 entries (average lookup: 2468 entries).
Dividing into 2**12 has 292/directory, average lookup: 2194.

On 2**12 vs. 2**8, it's not clear-cut. 2**8 works best for small
projects, 2**12 for larger.  My guess is that stupid filesystems
will tend to be used primarily only on small projects, so 2**8 might
be the better choice but that's debatable.

Case 2:
Thankfully adequate systems are finally more common, and they're
common enough that for really large projects (kernel) it seems
reasonable to demand such filesystems.
Ext2 & ext3 have had htree for a while now, and it's enabled by
default on at least Fedora Core 3.  If it's off, just do:
  tune2fs -O dir_index /dev/hdFOO; e2fsck -fD /dev/hdFOO
This stuff has been around so long that it should just be
a trivial command by any developer today.
ReiserFS has hashing too.  Windows' NTFS does
tree-balancing (it appears not as good as the hashing htree
system of ext2/ext3, but it should work tolerably since it's no
longer a linear search).  One useful factoid: For good NTFS
performance with git on large projects,
you should disable short name generation on the big directories
(Microsoft recommends this when >300,000 names are in one dir).
NTFS (and VFAT32) allow filenames up to 255 chars, and
filepaths up to 260 chars, so that seems okay.
I was primarily concerned about NTFS, and that seems to have
the necessities.  This info should in some FAQ or
documentation ("Using git for large projects").

It _seems_ to me that the NFS implementations are likely to
do similar things, but I don't know.  And I've not tested
anything on real systems, which is the real test.
Anyone know more about the limits of the NFS implementations?

More directory levels could be created to make
stupid filesystems happier, but that interferes with smart filesystems.
You could try to make filesystem layout a per-user issue,
but that makes using rsync more complicated.
A link farm could be created, though those are a pain to maintain.
It DOES turn out there are many alternatives if necesary, e.g.,
configurations per object database, or automatically "fixing"
things for a local configuration as data comes in or out,
though if you can avoid that it'd be better.


** Looking at "linux-2.4.0-to-2.6.12-rc2-patchset", I count
28237 patches; "RCS file:" occurs 188119 times & I'll claim
that that approximates the number of different file objects
IF there were no intermediate files.  If on average there are
5 versions of a file before it gets into the mainline,
and 3 commits before the final mainline patch, I get
approximately this many objects in a "real" object db:
  (28237*(3+1) trees) *2 (if #commits==#trees) +
  (188119*(5+1) file objs))
= 1,354,610 objects from 2002/02/05 to 2005/04/04
= about 36,000 objects/month.


Am I missing anything?

--- David A. Wheeler
