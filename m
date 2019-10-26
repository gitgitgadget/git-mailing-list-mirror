Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06F7E1F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 23:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfJZXy3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 19:54:29 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:51218 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbfJZXy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 19:54:29 -0400
X-Greylist: delayed 2456 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Oct 2019 19:54:28 EDT
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92.3)
        (envelope-from <mh@glandium.org>)
        id 1iOVFS-0001Xm-43
        for git@vger.kernel.org; Sun, 27 Oct 2019 08:13:30 +0900
Date:   Sun, 27 Oct 2019 08:13:30 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: Support for non-ascii urls broken in some cases, help needed for
 Windows
Message-ID: <20191026231330.yfzml5wrmavtntph@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I don't actually know of any git hosting that lives on a non-ascii
domain and with non-ascii parts in the path, but I nevertheless gave it
a shot because I was wondering how a conversion of git-cinnabar to
python 3 should handle them.

Multiple problems arose when trying `git clone https://テスト.com`:
- with NO_GETTEXT set, setlocale is never called, and when curl calls
  libidn for conversion of the domain name, it fails with
  "Failed to convert テスト.com to ACE; could not convert string to
  UTF-8" because, while the string *is* UTF-8, it thinks it's ASCII and
  wants to convert it somehow.

  Calling setlocale(LC_CTYPE, "") before the curl request happens fixes
  this. It feels like git_setup_gettext in the NO_GETTEXT case should
  take care of this.

- On Windows with a Japanese locale, it fails with the same error.
  Earlier versions of git failed with a different error message. I
  suspect 090d1e84771bb4a310e3fe8291ec71b0ddb03d4f is involved in the
  change in error message but I'm not sure. Anyways, I think the problem
  here is that what git gets as input from the command line is not UTF-8,
  and curl fails to convert it however it tries to. However, for
  non-ascii path parts, it seems a conversion to UTF-8 happens correctly
  at some stage, so I'm not entirely sure. That is,
  `git clone http://localhost:8000/テスト` does send a UTF-8 テスト to
  the HTTP server (which, interestingly, is not what
  `curl http://localhost:8000/テスト` does).

I'm happy to look at fixing the NO_GETTEXT unix part, but I'm not
equipped to build git for windows the way it's shipped to look at it
there.

Mike
