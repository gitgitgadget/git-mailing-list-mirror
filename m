Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E985201CF
	for <e@80x24.org>; Wed, 17 May 2017 11:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754567AbdEQLOm (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 07:14:42 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:48498 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754491AbdEQLOj (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 07:14:39 -0400
X-AuditID: 12074411-cafff70000003efd-9b-591c309cbd95
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 2F.29.16125.C903C195; Wed, 17 May 2017 07:14:38 -0400 (EDT)
Received: from [192.168.69.190] (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HBEY1u030613
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 07:14:36 -0400
To:     Karthik Nayak <karthik.188@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Subject: Performance regression in `git branch` due to ref-filter usage
Cc:     git discussion list <git@vger.kernel.org>
Message-ID: <dfc3a334-8047-26b0-1142-81c703010507@alum.mit.edu>
Date:   Wed, 17 May 2017 13:14:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqDvPQCbS4NsrDouuK91MFrO3bGCz
        +NHSw+zA7LFz1l12j2e9exg9Pm+SC2CO4rJJSc3JLEst0rdL4MqYM/Mac8EktorJb7sZGxi/
        snQxcnJICJhILPm0mamLkYtDSGAHk0TH0VnMEM45JomLV9Yyg1SJCGhKHGidyApiswnoSizq
        aWYCsYUF3CXW7V8FZjMDxR90PAazeQXsJfoevQTrZRFQlTiy+huYLSoQIfGwcxc7RI2gxMmZ
        T1ggetUl/sy7xAxhy0tsfzuHeQIj7ywkZbOQlM1CUraAkXkVo1xiTmmubm5iZk5xarJucXJi
        Xl5qka6pXm5miV5qSukmRkjQCe5gnHFS7hCjAAejEg/vBC7pSCHWxLLiytxDjJIcTEqivPsf
        AIX4kvJTKjMSizPii0pzUosPMUpwMCuJ8FrxykQK8aYkVlalFuXDpKQ5WJTEefmWqPsJCaQn
        lqRmp6YWpBbBZGU4OJQkeNfqAzUKFqWmp1akZeaUIKSZODhBhvMADZ+iBzK8uCAxtzgzHSJ/
        ilGXY869r++ZhFjy8vNSpcR5Y0EGCYAUZZTmwc2BJYtXjOJAbwnzrgSp4gEmGrhJr4CWMAEt
        aQb5jre4JBEhJdXAKHXzXd/r6hbn3Jun7G57rAgVKlBS5Pb6kaOj0LTnofWi1fNX/+adfaMu
        xmQ3y9JK5k2/jD7rcEUufe37bXaYQzBDvEyopE7/rrtazZWzEo2ui68pZmxzWSg8+V59/QfL
        vyJ7ku1r23zXRzk+ODpla0/4o/33lHYwpdTG/w2pFTeqW8BdfilViaU4I9FQi7moOBEAPU0J
        sPECAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on reference code, I was running `git branch` under
`strace`, when I noticed that `$GIT_DIR/HEAD` was being `lstat()`ed and
`read()` 121 times. This is in a repository with 114 branches, so
probably it is being run once per branch. The extra work makes a
measurable difference to the (admittedly, short) runtime.

As recently as 2.12.3 the file was only read 4 times when running the
same command [1].

The regression bisects to

    949af0684c (branch: use ref-filter printing APIs, 2017-01-10)

It would be nice if these extra syscalls could be avoided.

I haven't checked whether other commands have similar regressions.

Michael

[1] One wonders why the file has to be read more than once, but that's a
different story and probably harder to fix.
