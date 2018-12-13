Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1452920A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 17:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeLMRTZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 12:19:25 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:47405 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeLMRTY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 12:19:24 -0500
Received: from [10.31.188.88] (helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <yoh@onerussian.com>)
        id 1gXUdu-0002he-Sd
        for git@vger.kernel.org; Thu, 13 Dec 2018 12:19:23 -0500
Date:   Thu, 13 Dec 2018 12:19:17 -0500
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     git <git@vger.kernel.org>
Message-ID: <20181213171917.GC4633@hopa.kiewit.dartmouth.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 10.31.188.88
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: [wishlist] support of cloning recursively from non-bare submodule
 hierarchies?
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Example - on http://datasets.datalad.org we have a few hundred datasets
organized into a hierarchy as git submodules.  Each  git submodules carries its
own .git/ directory so they are "self sufficient" and we could readily assess
their sizes, and "cut the tree" at any level without looking for the
supermodule somewhere high up in the tree.

.gitmodules typically has relative paths for the url and path for the
submodules there, the form which I think we chose because it used to work (I
could be utterly wrong! but I think it was done in an informed fashion)
for git clone --recursive:

	$> curl http://datasets.datalad.org/labs/gobbini/famface/.gitmodules
	[submodule "data"]
		path = data
		url = ./data

and possibly outside:

	$> curl http://datasets.datalad.org/labs/gobbini/famface/data/.gitmodules 
	[submodule "scripts/mridefacer"]
		path = scripts/mridefacer
		url = https://github.com/yarikoptic/mridefacer

But unfortunately git doesn't even consider such (valid AFAIK) situation
while cloning where url has to have .git suffix but repository is not bare and
a relative "data" path (or "./data" url) is referring to the worktree.

	$> git clone --recursive http://datasets.datalad.org/labs/gobbini/famface/.git 
	Cloning into 'famface'...
	remote: Counting objects: 61, done.
	remote: Compressing objects: 100% (54/54), done.
	remote: Total 61 (delta 14), reused 0 (delta 0)
	Unpacking objects: 100% (61/61), done.
	Submodule 'data' (http://datasets.datalad.org/labs/gobbini/famface/.git/data) registered for path 'data'
	Cloning into '/tmp/famface/data'...
	fatal: repository 'http://datasets.datalad.org/labs/gobbini/famface/.git/data/' not found
	fatal: clone of 'http://datasets.datalad.org/labs/gobbini/famface/.git/data' into submodule path '/tmp/famface/data' failed
	Failed to clone 'data'. Retry scheduled
	Cloning into '/tmp/famface/data'...
	fatal: repository 'http://datasets.datalad.org/labs/gobbini/famface/.git/data/' not found
	fatal: clone of 'http://datasets.datalad.org/labs/gobbini/famface/.git/data' into submodule path '/tmp/famface/data' failed
	Failed to clone 'data' a second time, aborting

on the server I use the "smart HTTP" git backend, but not sure if that is the one to blame, since
I do not see in the logs any attempt to get the /data from not under .git/:

	10.31.188.88 - - [13/Dec/2018:12:18:38 -0500] "GET /labs/gobbini/famface/.git/info/refs?service=git-upload-pack HTTP/1.1" 200 681 "-" "git/2.20.0.rc2.403.gdbc3b29805"
	10.31.188.88 - - [13/Dec/2018:12:18:38 -0500] "POST /labs/gobbini/famface/.git/git-upload-pack HTTP/1.1" 200 69276 "-" "git/2.20.0.rc2.403.gdbc3b29805"

	==> datasets.datalad.org-error.log <==
	[Thu Dec 13 12:18:38.673447 2018] [core:info] [pid 7570:tid 140683541153536] [client 10.31.188.88:32794] AH00128: File does not exist: /srv/datasets.datalad.org/www/labs/gobbini/famface/.git/data/info/refs

	==> datasets.datalad.org-access-comb.log <==
	10.31.188.88 - - [13/Dec/2018:12:18:38 -0500] "GET /labs/gobbini/famface/.git/data/info/refs?service=git-upload-pack HTTP/1.1" 404 485 "-" "git/2.20.0.rc2.403.gdbc3b29805"

	==> datasets.datalad.org-error.log <==
	[Thu Dec 13 12:18:38.689277 2018] [core:info] [pid 7572:tid 140683574724352] [client 10.31.188.88:32796] AH00128: File does not exist: /srv/datasets.datalad.org/www/labs/gobbini/famface/.git/data/info/refs

	==> datasets.datalad.org-access-comb.log <==
	10.31.188.88 - - [13/Dec/2018:12:18:38 -0500] "GET /labs/gobbini/famface/.git/data/info/refs?service=git-upload-pack HTTP/1.1" 404 485 "-" "git/2.20.0.rc2.403.gdbc3b29805"


-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
