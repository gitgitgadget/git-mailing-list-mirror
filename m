Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E4751F453
	for <e@80x24.org>; Wed, 17 Oct 2018 08:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbeJQQjY (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 12:39:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:43218 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726691AbeJQQjX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 12:39:23 -0400
Received: (qmail 16681 invoked by uid 109); 17 Oct 2018 08:44:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Oct 2018 08:44:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18229 invoked by uid 111); 17 Oct 2018 08:43:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Oct 2018 04:43:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2018 04:44:43 -0400
Date:   Wed, 17 Oct 2018 04:44:43 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?54mb5pet?= <niuxu16@nudt.edu.cn>
Cc:     git <git@vger.kernel.org>
Subject: Re: Recommendations for updating error() to error_errno()
Message-ID: <20181017084443.GD31932@sigill.intra.peff.net>
References: <6849fb3c.10199.166802c8ef3.Coremail.niuxu16@nudt.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6849fb3c.10199.166802c8ef3.Coremail.niuxu16@nudt.edu.cn>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 11:58:15AM +0800, 牛旭 wrote:

> Our team works on enhance logging practices by learning from historical log revisions in evolution.
> And we find three patches that update error(..., strerror(errmp)) to error_errno(...).
> 
> While applying this rule to git-2.14.2, we find 9 missed spot in file refs/files-backend.c, 1 in apply.c, 2 in trace.c, 4 in dir-iterator.c:.
> 
> Here are the missed spots:
> 1) Line 1734 in file git-2.14.2/refs/files-backend.c:
> ret = raceproof_create_file(path.buf, rename_tmp_log_callback, &cb);
> if (ret) {
> 	if (errno == EISDIR)
> 		error("directory not empty: %s", path.buf);
> 	else
> 		error("unable to move logfile %s to %s: %s",
> 			tmp.buf, path.buf,
> 			strerror(cb.true_errno));

This cannot be converted naively. Using error_errno() will always show
the value of "errno", but here we are using a saved value in
cb.true_errno.

It might work to do:

  errno = cb.true_errno;
  error_errno(...);

but you would first have to check if the function is depending on the
value of errno for other reasons (not to mention that it kind of defeats
the purpose of error_errno() being a shorthand).

> 2) Line 1795 in file git-2.14.2/refs/files-backend.c: 
> if (log && rename(sb_oldref.buf, tmp_renamed_log.buf)) {
> 	ret = error("unable to move logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
> 			oldrefname, strerror(errno));
> 	goto out;
> }

But this one, for example, would be fine.

-Peff
