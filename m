From: Joshua Redstone <joshua.redstone@fb.com>
Subject: Re: Git performance results on a large repository
Date: Mon, 6 Feb 2012 20:50:08 +0000
Message-ID: <CB55A6A4.40AFD%joshua.redstone@fb.com>
References: <CALts4TRGj1_uPX2b86GyfHHcDAUp6JSSMGmKjfS0p79DSAZ_uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	"dgma@mohsinc.com" <dgma@mohsinc.com>,
	Matt Graham <mdg149@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Greg Troxel <gdt@ir.bbn.com>, "david@lang.hm" <david@lang.hm>,
	David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 21:52:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuVXh-00067P-JS
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 21:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803Ab2BFUwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 15:52:00 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35047 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751219Ab2BFUv7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 15:51:59 -0500
Received: from pps.filterd (m0004348 [127.0.0.1])
	by m0004348.ppops.net (8.14.4/8.14.4) with SMTP id q16KmJ0G001958;
	Mon, 6 Feb 2012 12:51:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : cc : subject :
 date : message-id : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qxWfNBcX3AiI9yjgxpUHdROqWRvfKmpHFKhRQthp4ds=;
 b=eJjWRiolu2qzMOkhO+vOwkLgNSKUiVDloitwq2b/U8YOXj1fejt10+oZqz5V9Qafuc2B
 0oH9KQY+QXrOKDF05iImEQaLsLjg9nthHcjhduf2oSF2uh5/RRwD40/BveOnY3IzjAbL
 DSG0eZwnuxQnA7R/pCVOENTLqU/aAeJWKp4= 
Received: from mail.thefacebook.com (corpout1.snc1.tfbnw.net [66.220.144.38])
	by m0004348.ppops.net with ESMTP id 12tmayg5qg-4
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 06 Feb 2012 12:51:21 -0800
Received: from SC-MBX02-5.TheFacebook.com ([fe80::9dc2:cfe6:2745:44cc]) by
 sc-hub03.TheFacebook.com ([192.168.18.198]) with mapi id 14.01.0355.002; Mon,
 6 Feb 2012 12:50:08 -0800
Thread-Topic: Git performance results on a large repository
Thread-Index: AQHM4n7tcAztB0vzgUq1FZmN2PdUJJYs1JqA///3O7GAA8y9AP//9qqA
In-Reply-To: <CALts4TRGj1_uPX2b86GyfHHcDAUp6JSSMGmKjfS0p79DSAZ_uA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.14.0.111121
x-originating-ip: [192.168.18.252]
Content-ID: <6732342154B5AE49A63BB28F829FD7D6@fb.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.6.7361,1.0.260,0.0.0000
 definitions=2012-02-06_04:2012-02-06,2012-02-06,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190100>

Hi all,

Nguyen, thanks for pointing out the assume-unchanged part.  That, and
especially the suggestion of making assume-unchanged files read-only is
interesting.  It does require explicit specification of what's changed.
Hmm, I wonder if that could be a candidate API through which something
like  CoW file system could let git know what's changed.  Btw, I think you
asked earlier, but the index compresses from 158MB to 58MB - keep in mind
that the majority of file names in the repo are synthetic, so take with
big grain of salt.

Joey, it sounds like it might be good if git-mv and other commands where
consistent in how they treat the assume-unchanged bit.

David Mohs:  Yeah, it's an open question whether we'd be better off
somehow forcing the repos the split apart more.  As a practical matter,
what may happen is that we incrementally solve our problem by addressing
pain points as they come up (e.g., git status being slow).  One risk with
that approach is that it leads to overly short-term thinking and we get
stuck in a local minimum.  I totally agree that good modularization and
code health is valuable.  I think sometimes that getting to good
modularization does involve some technical work - like maybe moving
functionality between systems so they split apart better, having some
notion of versioning and dependency and managing that, and so forth.    I
suppose the other aspect to the problem is that we want to make sure we
have a good source-control story even if the modularization effort takes a
long time - we'd rather not end up in a race between long-term
modularization efforts and source-control performance going south too
fast.  I suppose this comes back to the desire that modularization not be
a prerequisite for good source-control performance.  Oh, and in case I
didn't mention it - we are working on modularization and splitting off
large chunks of code, both into separable libraries as well as into
separate services, but it's a long-term process.

Matt, some of our repos are still on SVN, many are on pure-git.  One of
the main ones that is on SVN is, at least at the moment, not amenable to
sparse checkouts because of it's structure.

Tomas, yeah, I think one of the big questions is how little technical work
can we get away with, and where's the point of maximum leverage in terms
of how much engineering time we invest.

Greg,  'git commit' does some stat'ing of every file, even with all those
flags - for example, I think one instance it does it is, just in case any
pre-commit hooks touched any files, it re-stats everything.  Regarding the
perf numbers, I ran it on a beefy linux box.  Have you tried doing your
measurements with the drop_caches trick to make sure the file cache is
totally cold?  Sorry for the dumb question, but how do I check the vnode
cache size?

David Lang and David Barr, I generated the pack files by doing a repack:
"git repack -a -d -f --max-pack-size=10g --depth=100 --window=250"  after
generating the repo.

One other update, the command I was running to get a histogram of all
files in the repo finally completed.  The histogram (counting file size in
bytes) is:

[       0.0 -        6.4): 3
[       6.4 -       41.3): 27
[      41.3 -      265.7): 6
[     265.7 -     1708.1): 652594
[    1708.1 -    10980.6): 673482
[   10980.6 -    70591.6): 19519
[   70591.6 -   453814.3): 1583
[  453814.3 -  2917451.4): 276
[ 2917451.4 - 18755519.0): 61
[18755519.0 - 120574242.0]: 4
n=1347555 mean=3697.917708, median=1770.000000, stddev=122940.890559

The smaller files are all text (code), and the large ones are probably
binary.

Cheers,
Josh



On 2/6/12 11:23 AM, "Matt Graham" <mdg149@gmail.com> wrote:

>On Sat, Feb 4, 2012 at 18:05, Joshua Redstone <joshua.redstone@fb.com>
>wrote:
>> [ wanted to reply to my initial msg, but wasn't subscribed to the list
>>at time of mailing, so replying to most recent post instead ]
>>
>> Matt Graham:  I don't have file stats at the moment.  It's mostly code
>>files, with a few larger data files here and there.    We also don't do
>>sparse checkouts, primarily because most people use git (whether on top
>>of SVN or not), which doesn't support it.
>
>
>This doesn't help your original goal, but while you're still working
>with git-svn, you can do sparse checkouts. Use --ignore-paths when you
>do the original clone and it will filter out directories that are not
>of interest.
>
>We used this at Etsy to keep git svn checkouts manageable when we
>still had a gigantic svn repo.  You've repeatedly said you don't want
>to reorganize your repos but you may find this writeup informative
>about how Etsy migrated to git (which included a health amount of repo
>manipuation).
>http://codeascraft.etsy.com/2011/12/02/moving-from-svn-to-git-in-1000-easy
>-steps/
