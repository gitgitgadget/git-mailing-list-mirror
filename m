Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35FCA20248
	for <e@80x24.org>; Mon, 18 Mar 2019 17:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfCRR4h convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 18 Mar 2019 13:56:37 -0400
Received: from kautler.net ([85.214.242.4]:51898 "EHLO kautler.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfCRR4h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 13:56:37 -0400
X-Greylist: delayed 1680 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Mar 2019 13:56:36 EDT
Received: from mail-pf1-f175.google.com ([209.85.210.175])
        by h1362875.stratoserver.net with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.69)
        (envelope-from <Bjoern@kautler.net>)
        id 1h5w3u-0007Hj-JD
        for git@vger.kernel.org; Mon, 18 Mar 2019 18:28:34 +0100
Received: by mail-pf1-f175.google.com with SMTP id i19so11744521pfd.0
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 10:28:34 -0700 (PDT)
X-Gm-Message-State: APjAAAXxtuNlxCOXzh5WYTXmlVYV3aspPR4CjEnwGfH+41I8s1KxLsUM
        VzSPafpIEmVHbzPgYJjyalB94e3UIplh3HZ9TAE=
X-Google-Smtp-Source: APXvYqw3LD144aBObHATwrWvvZjS3zD+cI3a7D+UG6f8lEYDoVyGP4nNcXg6cw6CJqzlQOvf/OlRvTw2rQGjvr4A7GE=
X-Received: by 2002:a17:902:834b:: with SMTP id z11mr21002974pln.257.1552930108207;
 Mon, 18 Mar 2019 10:28:28 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Bj=C3=B6rn_Kautler?= <Bjoern@kautler.net>
Date:   Mon, 18 Mar 2019 18:28:16 +0100
X-Gmail-Original-Message-ID: <CAKChYSo9x5k0Ly2CNs5tbZ+jMdxBmDLZ9gm_645pwXZsCQ4ySg@mail.gmail.com>
Message-ID: <CAKChYSo9x5k0Ly2CNs5tbZ+jMdxBmDLZ9gm_645pwXZsCQ4ySg@mail.gmail.com>
Subject: fast-import should fail on invalid unsupported paths
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

with this simple recipe, you get a non-usable repository:

mkdir foo
cd foo
git init --bare repo
cd repo
git fast-import <<"EOM"
commit refs/heads/master
committer <foo@bar.baz> 0 +0000
data 3
foo
M 644 inline foo/.git/bar
data 3
baz
EOM
cd ..
git clone repo worktree

This actually happened when a user tried to port an SVN repository to
a Git repository and had ".git" paths in the SVN repository.
Using KDEs svn2git utility fast-import accepted the invalid path, but
then when trying to checkout during the clone operation, you get the
error message

Cloning into 'worktree'...
done.
error: Invalid path 'foo/.git/bar'

and the worktree stays empty.

I think fast-import should refuse to import paths Git cannot handle
properly later on, so that the migration fails early and the frontend
that generates the fast-import stream can be fixed / configured to not
include such invalid paths.

Regards
Björn
