Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13A3F207DF
	for <e@80x24.org>; Fri,  9 Sep 2016 22:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755556AbcIIW6V (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 18:58:21 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:44517 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754666AbcIIW6U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 18:58:20 -0400
X-Greylist: delayed 2312 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Sep 2016 18:58:20 EDT
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
        by smtp.onerussian.com with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1biU98-0005Jf-Dy
        for git@vger.kernel.org; Fri, 09 Sep 2016 18:19:42 -0400
Received: from yoh by washoe.onerussian.com with local (Exim 4.84)
        (envelope-from <yoh@onerussian.com>)
        id 1biU98-0005Ja-8e
        for git@vger.kernel.org; Fri, 09 Sep 2016 18:19:42 -0400
Date:   Fri, 9 Sep 2016 18:19:42 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     git@vger.kernel.org
Subject: git clone http://  fails some times with "Request for d53.. aborted"
Message-ID: <20160909221942.GS9830@onerussian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

even when (v 2.7.0) ran on the box where the server is, so
unlikely to be network issue

or from my laptop (v 2.9.3) with ok but wifi with a weakish signal to the
access point:

$> ( set -e; for s in {1..100}; do rm -rf fbirn_phaseIII ; git clone http://datasets.datalad.org/nidm/fbirn_phaseIII/.git; done; )
Cloning into 'fbirn_phaseIII'...
Checking connectivity... done.
Cloning into 'fbirn_phaseIII'...
error: Request for d53302dfc7ad13b786923927021039d21a10d5bd aborted
error: Unable to find d53302dfc7ad13b786923927021039d21a10d5bd under http://datasets.datalad.org/nidm/fbirn_phaseIII/.git
Cannot obtain needed tree d53302dfc7ad13b786923927021039d21a10d5bd
while processing commit 22dd4c49417cad6f4082ac2aebef45da8b6e473d.
error: fetch failed.

even if I build fresh 2.10.0, discovered that we can trace now CURL calls

$> export PATH=$HOME/proj/misc/git:$PATH
$> git version
git version 2.10.0
$> ( set -e; for s in {1..100}; do rm -rf fbirn_phaseIII ; GIT_TRACE_CURL=/tmp/git-trace-curl-failed.log git clone http://datasets.datalad.org/nidm/fbirn_phaseIII/.git &&  mv /tmp/git-trace-curl-failed.log /tmp/git-trace-curl-good.log || exit 1; done; ) 
Cloning into 'fbirn_phaseIII'...
warning: templates not found /home/yoh/share/git-core/templates
... a few more ...
Cloning into 'fbirn_phaseIII'...
warning: templates not found /home/yoh/share/git-core/templates
error: Request for d53302dfc7ad13b786923927021039d21a10d5bd aborted
error: Unable to find d53302dfc7ad13b786923927021039d21a10d5bd under http://datasets.datalad.org/nidm/fbirn_phaseIII/.git
Cannot obtain needed tree d53302dfc7ad13b786923927021039d21a10d5bd
while processing commit 22dd4c49417cad6f4082ac2aebef45da8b6e473d.
error: fetch failed.
( set -e; for s in {1..100}; do; rm -rf fbirn_phaseIII; GIT_TRACE_CURL= git  )  18.70s user 8.01s system 34% cpu 1:16.84 total

NB 
- note that it is d53302dfc7ad13b786923927021039d21a10d5bd all the time!
- that one corresponds to a tree
$> git show d53302dfc7ad13b786923927021039d21a10d5bd
tree d53302dfc7ad13b786923927021039d21a10d5bd

1ec/
da9/
- I do not see that object being reported as failed to be found on the server:

$> grep d5/3302dfc7ad13b786923927021039d21a10d5bd /var/log/apache2/datasets.datalad.org-error.log
$> grep d5/3302dfc7ad13b786923927021039d21a10d5bd /var/log/apache2/datasets.datalad.org-access.log
129.170.31.34 - - [09/Sep/2016:14:14:25 -0400] "GET /nidm/fbirn_phaseIII/.git/objects/d5/3302dfc7ad13b786923927021039d21a10d5bd HTTP/1.1" 200 72
...
- and the logs say that only "good" run had it requested:

$> zgrep 3302dfc7ad13b786923927021039d21a10d5bd git-trace-curl-*.log.gz     
git-trace-curl-good.log.gz:18:09:13.749268 http.c:517              => Send header: GET /nidm/fbirn_phaseIII/.git/objects/d5/3302dfc7ad13b786923927021039d21a10d5bd HTTP/1.1


and here are those two GIT_TRACE_CURL traces from good and bad runs -- may be
someone with a better clue could figure it out or any other information I
should provide to help pin point why that "request for d5... aborted" ;)

http://www.onerussian.com/tmp/git-trace-curl-good.log.gz
http://www.onerussian.com/tmp/git-trace-curl-failed.log.gz

Thanks in advance and please CC me in replies
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
