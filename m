Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62081F437
	for <e@80x24.org>; Sun, 29 Jan 2017 00:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbdA2AkG (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jan 2017 19:40:06 -0500
Received: from havoc.proulx.com ([96.88.95.61]:55528 "EHLO havoc.proulx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752609AbdA2AkF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2017 19:40:05 -0500
Received: from dismay.proulx.com (localhost [127.0.0.1])
        by havoc.proulx.com (Postfix) with ESMTP id 8EEAB7F5
        for <git@vger.kernel.org>; Sat, 28 Jan 2017 17:39:57 -0700 (MST)
Received: by dismay.proulx.com (Postfix, from userid 1000)
        id CB93BD20BAB; Sat, 28 Jan 2017 17:29:32 -0700 (MST)
Date:   Sat, 28 Jan 2017 17:29:32 -0700
From:   Bob Proulx <bob@proulx.com>
To:     git@vger.kernel.org
Subject: git-daemon shallow checkout fail
Message-ID: <20170129002932.GA19359@dismay.proulx.com>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am trying to understand a problem with shallow checkouts through the
git-daemon.  The server side fails trying to create a shallow_XXXXXX
file in the repository.  But of course it can't due to no permissions
from the git-daemon user.

However the problem driving me crazy is that this only fails this way
on one machine.  Unfortunately failing on the machine I need to use.
If I try this same setup on any other machine I try then there is no
failure and it works okay.  Therefore I conclude that in the failing
case it is trying to write a shallow_XXXXXX file in the repository but
in all of the passing cases it does not.  I browsed through the
git-daemon source but couldn't deduce the flow yet.

Does anyone know why one system would try to create shallow_XXXXXX
files in the repository while another one would not?

Trying to be unambiguous here is my test case:

  mkdir /run/git
  chmod 755 /run/git
  chown nobody:root /run/git
  cd /run/git && env -i HOME=/run/git PATH=/usr/local/bin:/usr/bin:/bin su -s /bin/sh -c "git-daemon --export-all --base-path=/srv/git --verbose" nobody
  [18340] Ready to rumble

That sets up the test case.  Have any bare git repository in /srv/git
for use for cloning.

  git clone --depth 1 git://localhost/test-project.git
  Cloning into 'test-project'...
  fatal: The remote end hung up unexpectedly
  fatal: early EOF
  fatal: index-pack failed

And the server side says:

  [26071] Request upload-pack for '/test-project.git'
  [26071] fatal: Unable to create temporary file '/srv/git/test-project.git/shallow_xKwnvZ': Permission denied
  [26055] [26071] Disconnected (with error)

Of course git-daemon running as nobody can't create a temporary file
shallow_XXXXXX in the /srv/git/test-project.git because it has no
permissions by design.  But why does this work on other systems and
not work on my target system?

  git --version  # from today's git clone build
  git version 2.11.0.485.g4e59582

Thanks!
Bob
