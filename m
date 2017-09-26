Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DE8F20281
	for <e@80x24.org>; Tue, 26 Sep 2017 13:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030900AbdIZNhU (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 09:37:20 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:43533 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967806AbdIZNhK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 09:37:10 -0400
Received: from hopa.wireless.dartmouth.edu ([10.31.185.85] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1dwq2u-0001gM-Iz
        for git@vger.kernel.org; Tue, 26 Sep 2017 09:37:09 -0400
Date:   Tue, 26 Sep 2017 09:37:03 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <20170926133703.7gtk5ztkhqvfxszh@hopa.kiewit.dartmouth.edu>
References: <20170925000213.rilmsczdbi3jqkta@hopa.kiewit.dartmouth.edu>
 <xmqqwp4nfuv1.fsf@gitster.mtv.corp.google.com>
 <20170925031751.lg7zk6krt65dxwas@hopa.kiewit.dartmouth.edu>
 <xmqqmv5je412.fsf_-_@gitster.mtv.corp.google.com>
 <20170925143040.4qgofxcdahal46r7@hopa.kiewit.dartmouth.edu>
 <xmqqing6cje7.fsf@gitster.mtv.corp.google.com>
 <xmqqefqucigh.fsf@gitster.mtv.corp.google.com>
 <xmqqa81ichdu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa81ichdu.fsf@gitster.mtv.corp.google.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 10.31.185.85
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: -X theirs does not resolve symlink conflict  Was: BUG: merge -s
 theirs  is not in effect
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, 26 Sep 2017, Junio C Hamano wrote:
> >> I do not recall people talking about symbolic links but the case of
> >> binary files has been on the wishlist for a long time, and I do not
> >> know of anybody who is working on (or is planning to work on) it.

> > Ah, I misremembered.

> > We've addressed the "binary files" case back in 2012 with a944af1d
> > ("merge: teach -Xours/-Xtheirs to binary ll-merge driver",
> > 2012-09-08).  I do not know offhand if it is just as easy to plumb
> > the MERGE_FAVOR_{OURS,THEIRS} bits thru the symbolic link codepath,
> > like that patch did to the binary file codepath.

> Perhaps the attached (totally untested) patch might be a good
> starting point.  I do not know if you are interested in hacking on
> Git, and I do not feel offended if you are not, but perhaps somebody

I would have felt honored to "hack on Git" but neither my C-foo is up to
par, neither there would be more time I could adequately allocate for
such endeavor.   So meanwhile I am trying to contribute in hopefully
constructive "whining" while exploiting git.

> else might get interested in seeing if this #leftoverbits is a good
> direction to go in, and finishing it with docs and tests if it is
> ;-)


>  merge-recursive.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)

> >...<

This patch worked beautifully in my usecase!:

$> rm -rf /tmp/repo1; mkdir /tmp/repo1; cd /tmp/repo1; git init .; ln -s sym1 link; echo 1 > file; git add file link; git commit -m 'common'; git co -b b1 ; ln -sf b1link link; echo "b1 file" >| file; git commit -m 'b2 changes' -a; git co master; ln -sf masterlink link; echo "master file" >| file; git commit -m 'also modified in master' -a; git merge -X theirs --no-edit b1; ls -l link; cat file                                                       
warning: templates not found /home/yoh/share/git-core/templates                                                                
Initialized empty Git repository in /tmp/repo1/.git/
[master (root-commit) d2e9010] common
 2 files changed, 2 insertions(+)
 create mode 100644 file
 create mode 120000 link
Switched to a new branch 'b1'
[b1 a2b1321] b2 changes
 2 files changed, 2 insertions(+), 2 deletions(-)
Switched to branch 'master'
[master fbb4ba7] also modified in master
 2 files changed, 2 insertions(+), 2 deletions(-)
Auto-merging link
Auto-merging file
Merge made by the 'recursive' strategy.
 file | 2 +-
 link | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
lrwxrwxrwx 1 yoh yoh 6 Sep 26 09:32 link -> b1link
b1 file

I also tried -s ours and no explicit -s, and they did as prescribed as
well

PS thanks for the CCs
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
