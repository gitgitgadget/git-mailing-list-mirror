Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3945F211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 18:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbeLFSCI (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 13:02:08 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:52072 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLFSCI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 13:02:08 -0500
X-Greylist: delayed 1567 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Dec 2018 13:02:07 EST
Received: from [10.31.178.119] (helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <yoh@onerussian.com>)
        id 1gUxZ9-0001Eu-F9
        for git@vger.kernel.org; Thu, 06 Dec 2018 12:35:59 -0500
Date:   Thu, 6 Dec 2018 12:35:54 -0500
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <20181206173554.GH4633@hopa.kiewit.dartmouth.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 10.31.178.119
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: [wishlist] git submodule update --reset-hard
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git Gurus,

I wondered what would be your take on my wishlist request to add
--reset-hard option, which would be very similar to regular "update" which
checks out necessary commit, but I want it to remain in the branch.

Rationale: In DataLad we heavily rely on submodules, and we have established
easy ways to do some manipulations across full hierarchies of them. E.g. a
single command could introduce a good number of commits across deep hierarchy
of submodules, e.g. while committing changes within deep submodule, while also
doing all necessary commits in the repositories leading to that submodule so
the entire tree of them stays in a "clean" state. The difficulty comes when
there is a need to just "forget" some changes.  The obvious way is to e.g. 

   git reset --hard PREVIOUS_STATE

in the top level repository.  But that leaves all the submodules now in
the undesired state.  If I do

  git submodule update --recursive

I would end up in the detached HEADs within submodules.  

What I want is to retain current branch they are at (or may be possible
"were in"? reflog records might have that information)

Example:

# Have to use datalad install  since  git clone --recurse-submodules
# seems to not consider alternative locations for submodules' .git/
# with url being just a relative path, and where submodules aren't 
# all residing up under toplevel URL .git/

	$> datalad install -r http://datasets.datalad.org/labs/gobbini/.git
	[INFO   ] Cloning http://datasets.datalad.org/labs/gobbini/.git into '/tmp/gobbini' 
	install(ok): /tmp/gobbini (dataset)                                                                             
	[INFO   ] Installing <Dataset path=/tmp/gobbini> recursively 
	[INFO   ] Cloning http://datasets.datalad.org/labs/gobbini/famface/.git into '/tmp/gobbini/famface' 
	[INFO   ] Cloning http://datasets.datalad.org/labs/gobbini/famface/data/.git into '/tmp/gobbini/famface/data'   
	[INFO   ] access to dataset sibling "datasets.datalad.org" not auto-enabled, enable with:                       
	| 		datalad siblings -d "/tmp/gobbini/famface/data" enable -s datasets.datalad.org 
	[INFO   ] Cloning http://datasets.datalad.org/labs/gobbini/famface/data/scripts/mridefacer/.git [2 other candidates] into '/tmp/gobbini/famface/data/scripts/mridefacer' 
	action summary:                                                                                                 
	  install (ok: 4)

so I have a hierarchy in a good state and all checked out in master
branch

	$> cd gobbini

	$> git submodule status --recursive       
	 b9071a6bc9f7665f7c75549c63d29f16d40e8af7 famface (heads/master)
	 e59ba76b42f219bdf14b6b547dd6d9cc0ed5227f famface/data (BIDS-v1.0.1-3-ge59ba76b)
	 5d8036c0aaeebb448a00df6296ddc9f799efdd1f famface/data/scripts/mridefacer (heads/master)

	$> git submodule foreach --recursive cat .git/HEAD                 
	Entering 'famface'
	ref: refs/heads/master
	Entering 'famface/data'
	ref: refs/heads/master
	Entering 'famface/data/scripts/mridefacer'
	ref: refs/heads/master


and if I do roll back

	$> git reset --hard HEAD^^^        
	HEAD is now at 9b4296d [DATALAD] aggregated meta data
	changes on filesystem:                                                                                          
	 famface | 2 +-

and default update --recursive

	$> git submodule update --recursive
	Submodule path 'famface': checked out '2569ab436501a832d35afbbe9cc20ffeb6077eb1'
	Submodule path 'famface/data': checked out 'f1e8c9b8b025c311424283b9711efc6bc906ba2b'
	Submodule path 'famface/data/scripts/mridefacer': checked out '49b0fe42696724c2a8492f999736056e51b77358'

I end up in detached HEADs

	$> git submodule status --recursive 
	 2569ab436501a832d35afbbe9cc20ffeb6077eb1 famface (2569ab4)
	 f1e8c9b8b025c311424283b9711efc6bc906ba2b famface/data (BIDS-v1.0.1)
	 49b0fe42696724c2a8492f999736056e51b77358 famface/data/scripts/mridefacer (49b0fe4)


I do see that there is a "custom command" way to do it via
"submodule.<name>.update" config setting, but that is not easy to use for my
case since all the `<name>` would be different to specify !git reset --hard for
all of them via config option and I could not find any way to "glob" config
(like submodule.*.update).  But in effect that is probably what I need:

	# restarting from a clean state here
	$> git -c submodule.famface.update='!git reset --hard' submodule update --recursive    
	HEAD is now at 2569ab4 [DATALAD] aggregated meta data
	Submodule path 'famface': 'git reset --hard 2569ab436501a832d35afbbe9cc20ffeb6077eb1'
	Submodule path 'famface/data': checked out 'f1e8c9b8b025c311424283b9711efc6bc906ba2b'
	Submodule path 'famface/data/scripts/mridefacer': checked out '49b0fe42696724c2a8492f999736056e51b77358'

	$> git submodule status --recursive                                                
	 2569ab436501a832d35afbbe9cc20ffeb6077eb1 famface (heads/master)
	 f1e8c9b8b025c311424283b9711efc6bc906ba2b famface/data (BIDS-v1.0.1)
	 49b0fe42696724c2a8492f999736056e51b77358 famface/data/scripts/mridefacer (49b0fe4)


Corner cases I see which might make it trickier for a full blown
solution (might be relevant to current state as well for other
strategies):

-  If between those commits we got an additional submodule added (in
   immediate repository or within one of the subdatasets), ideally it
   should also be wiped out

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
