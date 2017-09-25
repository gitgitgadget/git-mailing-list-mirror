Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BD50202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 14:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964990AbdIYOat (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 10:30:49 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:57519 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934676AbdIYOas (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 10:30:48 -0400
Received: from [192.197.121.178] (helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1dwUPG-0003AU-Md
        for git@vger.kernel.org; Mon, 25 Sep 2017 10:30:47 -0400
Date:   Mon, 25 Sep 2017 10:30:40 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <20170925143040.4qgofxcdahal46r7@hopa.kiewit.dartmouth.edu>
References: <20170925000213.rilmsczdbi3jqkta@hopa.kiewit.dartmouth.edu>
 <xmqqwp4nfuv1.fsf@gitster.mtv.corp.google.com>
 <20170925031751.lg7zk6krt65dxwas@hopa.kiewit.dartmouth.edu>
 <xmqqmv5je412.fsf_-_@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmv5je412.fsf_-_@gitster.mtv.corp.google.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 192.197.121.178
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: -X theirs does not resolve symlink conflict  Was: BUG: merge -s
 theirs  is not in effect
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, 25 Sep 2017, Junio C Hamano wrote:

> Yaroslav Halchenko <yoh@onerussian.com> writes:

> > d'oh, indeed there is no git-merge-theirs  neither in debian pkg or a freshly
> > built git  and I found a rogue script in the PATH (which did nothing
> > apparently, sorry!). BUT I was originally mislead by the --help/manpage:

> Ahh, you're right.  The text does make readers expect "-s theirs" to
> exist.
> ...
>  * I hope this should help things a bit.

yes it does. Thanks.  And that is where I realized that I should have used -X
theirs (not -s theirs), as the instruction on the option for the
(recursive) merge.  And now problem is more specific:

- conflict within file content editing was resolved as instructed
  (taking "theirs" version)

- BUT symlink was not taken from "theirs" and left as unresolved conflict:

$> rm -rf /tmp/repo1; mkdir /tmp/repo1; cd /tmp/repo1; git init .; ln -s sym1 link; echo 1 > file; git add file link; git commit -m 'common'; git co -b b1 ; ln -sf b1link link; echo "b1 file" >| file; git commit -m 'b2 changes' -a; git co master; ln -sf masterlink link; echo "master file" >| file; git commit -m 'also modified in master' -a; git merge -X theirs --no-edit b1; ls -l link; cat file
warning: templates not found /home/yoh/share/git-core/templates
Initialized empty Git repository in /tmp/repo1/.git/
[master (root-commit) f0b75bc] common
 2 files changed, 2 insertions(+)
 create mode 100644 file
 create mode 120000 link
Switched to a new branch 'b1'
[b1 45c93ca] b2 changes
 2 files changed, 2 insertions(+), 2 deletions(-)
Switched to branch 'master'
[master 0ee6db2] also modified in master
 2 files changed, 2 insertions(+), 2 deletions(-)
Auto-merging link
CONFLICT (content): Merge conflict in link
Auto-merging file
Automatic merge failed; fix conflicts and then commit the result.
lrwxrwxrwx 1 yoh yoh 10 Sep 25 10:21 link -> masterlink
b1 file
changes on filesystem:                                                                                          
 link | Unmerged
cached/staged changes:
 file | 2 +-
 link | Unmerged


PS I will followup on -s theirs in a split thread
PSS Thanks for CCing me your replies
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
