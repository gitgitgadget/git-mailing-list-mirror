From: Joshua Redstone <joshua.redstone@fb.com>
Subject: Re: Debugging git-commit slowness on a large repo
Date: Tue, 20 Dec 2011 00:51:16 +0000
Message-ID: <CB1518AB.2D649%joshua.redstone@fb.com>
References: <CB0BCE02.2CD42%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?iso-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Tomas Carnecky <tom@dbservice.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 01:52:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcnwN-0002Qm-2z
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 01:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667Ab1LTAwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 19:52:18 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51482 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753267Ab1LTAwR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 19:52:17 -0500
Received: from pps.filterd (m0004347 [127.0.0.1])
	by m0004347.ppops.net (8.14.4/8.14.4) with SMTP id pBK0olNh011744;
	Mon, 19 Dec 2011 16:51:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : cc : subject :
 date : message-id : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=13EJRCq6QTkNyQ8KibdlhZno47ag2dzVgcrxy3DPa0o=;
 b=XKrOCFo3/d70Uk9lzFskp7bqaRut+r52o0aISikE3iedZyuo3+fAQO6QWnxFh03PtIfF
 fCnYwb74IYXLAp/AQYN2jANXdOangqon2CVL2IB9HFFcRSl+DcUARAeKUoKrRkl4K9DL
 QAysGD3AuwuTHXXrgoK8+Xa6w2mcfVInSuY= 
Received: from mail.thefacebook.com (corpout1.snc1.tfbnw.net [66.220.144.38])
	by m0004347.ppops.net with ESMTP id 11tdf0g66e-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 19 Dec 2011 16:51:19 -0800
Received: from SC-MBX02-5.TheFacebook.com ([fe80::9dc2:cfe6:2745:44cc]) by
 sc-hub03.TheFacebook.com ([192.168.18.198]) with mapi id 14.01.0355.002; Mon,
 19 Dec 2011 16:51:17 -0800
Thread-Topic: Debugging git-commit slowness on a large repo
Thread-Index: AQHMsUiE0jGAmaiuRkyp0eiAE6mrR5XJxzCAgAXbCACAAIurgIAA1D+AgAC14ACAAPMrAIAAAj6AgAZIqACACwpvAA==
In-Reply-To: <CB0BCE02.2CD42%joshua.redstone@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.13.0.110805
x-originating-ip: [192.168.18.252]
Content-ID: <7C67D43697540D4B9F9713BDC48682D0@fb.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.5.7110,1.0.211,0.0.0000
 definitions=2011-12-19_08:2011-12-19,2011-12-19,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187486>

I've managed to speed up git-commit on large repos by 4x by removing some
safeguards that caused git to stat every file in the repo on commits that
touch a small number of files.  The diff, for illustrative purposes only,
is at:

    https://gist.github.com/1499621


With a repo with 1 million files (but few commits), the diff drops the
commit time down from 7.3 seconds to 1.8 seconds, a 75% decrease. The
optimizations are:

1. Remove call to refresh_cache_or_die that stats every file in the repo,
i think the purpose is to detect any changes between git-add and
git-commit.

2. Pass missing_ok=true to cache_tree_update. This causes the tree
generation code to not stat every file in the repo to verify it still
exists as a git object.

3. Remove pair discard_cache/read_cache_from, which rereads the index
file. I think this was in case a pre-commit hook changed the set of things
being committed.

It may be worth making some of these flag-enabled.



Josh


On 12/12/11 4:15 PM, "Joshua Redstone" <joshua.redstone@fb.com> wrote:

>Sorry for the poor formatting of the stack trace.
>
>I've written two scripts to reproduce the slow commit behavior that I see.
> I've posted both to:
>   https://gist.github.com/1469760
>
>To repro, first create a dir with lots of files (it defaults to creating 1
>million files in 1000 dirs):
>
>$ loadGen.py --baseDir=./bigdir
>
>then, run the simulator scripts to generate and commit a series of small
>changes to the repo:
>
>$ git reset --hard HEAD && simulate.py ./bigdir git
>
>The git reset is to clean up any cruft left over from a previous partial
>invocation of simulate.py
>
>Note that loadGen.py defaults to creating 1 million files and committing
>them in one commit.  With a flash drive this took < 30 min, and subsequent
>small commits in simulate.py took about 6 seconds.  With a hard-drive,
>it's taking > 1hr (still waiting for it to finish).
>
>Cheers,
>Josh
>
>
>On 12/8/11 4:17 PM, "Joshua Redstone" <joshua.redstone@fb.com> wrote:
>
>>Btw, I also tried doing some very poor-man's profiling on "git commit"
>>without any of the readtree/writetree/updateindex commands.
>>
>>Around 50% of the time was in (bottom few frames may have varied)
>>
>>#1  0x00000000004c467e in find_pack_entry (sha1=0x1475a44 ,
>>e=0x7fff2621f070) at sha1_file.c:2027
>>#2  0x00000000004c57b0 in has_sha1_file (sha1=0x7fe2cd9c7900 "00") at
>>sha1_file.c:2567 
>>                 
>>                 
>>#3  0x000000000046e4af in update_one (it=<value optimized out>,
>>cache=<value optimized out>, entries=<value optimized out>, base=<value
>>optimized out>, baselen=<value optimized out>, missing_ok=<value
>>optimized
>>out>, dryrun=0) at cache-\
>>tree.c:333       
>>                 
>>                 
>>            
>>#4  0x000000000046e278 in update_one (it=<value optimized out>,
>>cache=<value optimized out>, entries=<value optimized out>, base=<value
>>optimized out>, baselen=<value optimized out>, missing_ok=<value
>>optimized
>>out>, dryrun=0) at cache-\
>>tree.c:285       
>>                 
>>                 
>>            
>>#5  0x000000000046e278 in update_one (it=<value optimized out>,
>>cache=<value optimized out>, entries=<value optimized out>, base=<value
>>optimized out>, baselen=<value optimized out>, missing_ok=<value
>>optimized
>>out>, dryrun=0) at cache-\
>>tree.c:285       
>>                 
>>                 
>>            
>>#6  0x000000000046e278 in update_one (it=<value optimized out>,
>>cache=<value optimized out>, entries=<value optimized out>, base=<value
>>optimized out>, baselen=<value optimized out>, missing_ok=<value
>>optimized
>>out>, dryrun=0) at cache-\
>>tree.c:285       
>>                 
>>                 
>>            
>>#7  0x000000000046e278 in update_one (it=<value optimized out>,
>>cache=<value optimized out>, entries=<value optimized out>, base=<value
>>optimized out>, baselen=<value optimized out>, missing_ok=<value
>>optimized
>>out>, dryrun=0) at cache-\
>>tree.c:285       
>>                 
>>                 
>>            
>>#8  0x000000000046e278 in update_one (it=<value optimized out>,
>>cache=<value optimized out>, entries=<value optimized out>, base=<value
>>optimized out>, baselen=<value optimized out>, missing_ok=<value
>>optimized
>>out>, dryrun=0) at cache-\
>>tree.c:285       
>>                 
>>                 
>>            
>>#9  0x000000000046e869 in cache_tree_update (it=<value optimized out>,
>>cache=<value optimized out>, entries=dwarf2_read_address: Corrupted DWARF
>>expression.      
>>                 
>>) at cache-tree.c:379
>>                 
>>                 
>>            
>>#10 0x000000000041cade in prepare_to_commit (index_file=0x781740
>>".git/index", prefix=<value optimized out>, current_head=<value optimized
>>out>, s=0x7fff26220d00, author_ident=<value optimized out>) at
>>builtin/commit.c:866
>>#11 0x000000000041d891 in cmd_commit (argc=0, argv=0x7fff262213a0,
>>prefix=0x0) at builtin/commit.c:1407
>>                 
>>                 
>>#12 0x0000000000404bf7 in handle_internal_command (argc=4,
>>argv=0x7fff262213a0) at git.c:308
>>                 
>>                 
>>#13 0x0000000000404e2f in main (argc=4, argv=0x7fff262213a0) at git.c:512
>>                 
>>                 
>>            
>> 
>>
>>
>>And 30% of the time was in:
>>
>>#0  0x00000034af2c34a5 in _lxstat () from /lib64/libc.so.6
>>                 
>>                 
>>            
>>#1  0x00000000004abe0f in refresh_cache_ent (istate=0x780940,
>>ce=0x7f8462a34e40, options=0, err=0x7fff6dd9f588) at
>>/usr/include/sys/stat.h:443
>>                 
>>#2  0x00000000004ac1a0 in refresh_index (istate=0x780940, flags=<value
>>optimized out>, pathspec=<value optimized out>, seen=<value optimized
>>out>, header_msg=0x0) at read-cache.c:1133
>>                 
>>#3  0x000000000041b60a in refresh_cache_or_die (refresh_flags=<value
>>optimized out>) at builtin/commit.c:331
>>                 
>>                 
>>#4  0x000000000041bc39 in prepare_index (argc=0, argv=0x7fff6dda0310,
>>prefix=0x0, current_head=<value optimized out>, is_status=<value
>>optimized
>>out>) at builtin/commit.c:414
>>                 
>>#5  0x000000000041d878 in cmd_commit (argc=0, argv=0x7fff6dda0310,
>>prefix=0x0) at builtin/commit.c:1403
>>                 
>>                 
>>  
>>
>>
>>Josh
>>
>>
>>On 12/8/11 4:09 PM, "Joshua Redstone" <joshua.redstone@fb.com> wrote:
>>
>>>On 12/7/11 5:39 PM, "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> wrote:
>>>
>>>>On Thu, Dec 8, 2011 at 5:48 AM, Joshua Redstone
>>>><joshua.redstone@fb.com>
>>>>wrote:
>>>>> Hi Duy,
>>>>> Thanks for the documentation link.
>>>>>
>>>>> git ls-files shows 100k files, which matches # of files in the
>>>>>working
>>>>> tree ('find . -type f -print | wc -l').
>>>>
>>>>Any chance you can split it into smaller repositories, or remove files
>>>>from working directory (e.g. if you store logs, you don't have to keep
>>>>logs from all time in working directory, they can be retrieved from
>>>>history).
>>>
>>>It's not really feasible to split it into smaller repositories.  In
>>>fact,
>>>we're expecting it to grow between 3x and 5x in number of files and
>>>number
>>>of commits.
>>>
>>>>
>>>>> I added a 'git read-tree HEAD' before the git-add, and a 'git
>>>>>write-tree'
>>>>> after the add.  With that, the commit time slowed down to 8 seconds
>>>>>per
>>>>> commit, plus 4 more seconds for the read-tree/add/write-tree ops.
>>>>>The
>>>>> read-tree/add/write-tree each took about a second.
>>>>
>>>>read-tree destroys stat info in index, refreshing 100k entries in
>>>>index in this case may take some time. Try this to see if commit time
>>>>reduces and how much time update-index takes
>>>>
>>>>read-tree HEAD
>>>>update-index --refresh
>>>>add ....
>>>>write-tree
>>>>commit -q
>>>
>>>I added the "update-index --refresh" and the time for commit became more
>>>like 0.6 seconds.
>>>In this setup: read-tree takes ~2 seconds, update-index takes ~8
>>>seconds,
>>>git-add takes 1 to 4 seconds, and write-tree takes less than 1 second.
>>>
>>>>
>>>>> As an experiment, I also tried removing the 'git read-tree' and just
>>>>> having the git-write-tree.  That sped up commits to 0.6 seconds, but
>>>>>the
>>>>> overall time for add/write-tree/commit was still 3 to 6 seconds.
>>>>
>>>>overall time is not really important because we duplicate work here
>>>>(write-tree is done as part of commit again). What I'm trying to do is
>>>>to determine how much time each operation in commit may take.
>>>>-- 
>>>>Duy
>>>
>>
>
