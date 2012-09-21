From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: How do I run tests under Valgrind?
Date: Sat, 22 Sep 2012 01:01:32 +0530
Message-ID: <CALkWK0=nMxNfmAaBTmXeADQubTayC_2_ut5Nq3QXba9yfQr9yA@mail.gmail.com>
References: <CALkWK0m_9OsAfG_pF3hUDW+EKCyZCn9NiDKKEW6AEOMmAw=yuA@mail.gmail.com>
 <20120917172022.GA1179@sigill.intra.peff.net> <CALkWK0m378ApSwa1xiYUqEjMny5m0wt3KacqdDRU1qt=cw6k8g@mail.gmail.com>
 <20120917173531.GB1179@sigill.intra.peff.net> <CALkWK0kDPGY_3v5SLPtyf+azUwA7msvQOvA+MaCgueZ71i2yGw@mail.gmail.com>
 <20120917174439.GD1179@sigill.intra.peff.net> <CALkWK0mkBbY7dUyaZAqqKE3ZMfE_xU6em_KCOKM9nsTjUP-9pA@mail.gmail.com>
 <20120917182957.GF1179@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 21:32:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF8xH-0005DQ-9V
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 21:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494Ab2IUTby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 15:31:54 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:62804 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541Ab2IUTbx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 15:31:53 -0400
Received: by qaas11 with SMTP id s11so1548661qaa.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ql4Uz7u+gXzBo02ilF3b19O/oJYnsFQYtmDLmopcSLg=;
        b=rF34pXIJzUSANrklD0O9mokRGy/mFdUoWber9bAWi3scPqaDXCxtYjpVK+fwy4y4x/
         dI6LhQyR5JBSd9vgYzr1QZ+ZefKXXlkVjsxiNfpNNRxfgkHiHyGxIfWh56g4ljVZgNUL
         3idy4uPjMc3jPybSdAz0VClfUCmeogOzdbgp9AXFIMHs2Rp4KmE/Xge2H9KNxwmHelqs
         yaENYFSavdBLzkguIfFNuFQEMgpoMkeo2lmz3lATJeIG8J1KBIrU6rJgh6bvi4P+1FfP
         cGpydFyxakUz/dRODaG2/Zij9/CVgyJa3KmhwZTQ47F8XhrC6Q585iMEP8EF1BWxQugR
         nwRw==
Received: by 10.224.10.11 with SMTP id n11mr14611302qan.23.1348255912428; Fri,
 21 Sep 2012 12:31:52 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Fri, 21 Sep 2012 12:31:32 -0700 (PDT)
In-Reply-To: <20120917182957.GF1179@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206152>

Hi Peff,

I was able to reproduce the problem on all my machines, and I consider
this very disturbing.  However, I was successfully able to corner the
issue. I have an overtly long $PATH that's not getting split properly
by `IFS=:` in one corner case -- in other words, this shell script
fails to execute properly when called with `--tee` (just set a really
long $PATH and try):


    case "$GIT_TEST_TEE_STARTED, $* " in
    done,*)
    	# do not redirect again
    	;;    #!/bin/sh

    case "$GIT_TEST_TEE_STARTED, $* " in
    done,*)
    	# do not redirect again
    	;;
    *' --tee '*|*' --va'*)
    	mkdir -p test-results
    	BASE=test-results/$(basename "$0" .sh)
    	(GIT_TEST_TEE_STARTED=done ${SHELL-sh} "$0" "$@" 2>&1;
    	 echo $? > $BASE.exit) | tee $BASE.out
    	test "$(cat $BASE.exit)" = 0
    	exit
    	;;
    esac

    OLDIFS=$IFS
    IFS=:
    for path in $PATH
    do
        ls "$path"/git-* 2> /dev/null |
        while read file
        do
    	echo $file
        done
    done

I'm still trying to figure out what exactly the problem is, and how to patch it.

Thanks.

Ram
