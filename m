From: Mike Hommey <mh@glandium.org>
Subject: [RFC PATCH 0/4] git_connect: add some flexibility
Date: Thu, 28 Apr 2016 23:12:35 +0900
Message-ID: <1461852759-28429-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 16:13:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avmgc-00012r-Sq
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 16:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbcD1OMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 10:12:48 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:45586 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515AbcD1OMp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 10:12:45 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1avmgJ-0007PH-E2; Thu, 28 Apr 2016 23:12:39 +0900
X-Mailer: git-send-email 2.8.1.5.g18c8a48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292888>

As you may be aware, I'm working on a git remote helper to access
mercurial repositories (https://github.com/glandium/git-cinnabar/).

At the moment, a small part is written in C, relying on the git code
base, but eventually, there would be more C.

As I want to get rid of the dependency on Mercurial itself, I'm planning
to implement the wire protocol parts in git-cinnabar. And while at it, I
figured I'd evaluate if I can't just rely on some git internals, from C
code. So I've turned to the git_connect function, that implements the
niceties around GIT_SSH and GIT_SSH_COMMAND, and also handles ssh client
specificities. (I'd rather not have to copy the code or reimplement it).
It also turns out to be a convenient wrapper around start_command() for
local urls.

The git commands that git_connect is invoked for all take the repository
path as their last argument. In mercurial's case, the command is:
  hg -R $path serve --stdio

which doesn't match that pattern. So one hack I was thinking about was
scan the url on my end, extract the path, replace it with "--stdio",
and pass "hg -R $path serve" as command. Unfortunately, parse_connect_url
is static, which means I'd either have to change connect.c to expose it,
or copy it. Since I'd rather avoid copying code, I figured that since I
was going to have to change connect.c, I might as well go with something
less hacky, assuming it's accepted mainline.

So following here are four patches that allow me to connect, via ssh, to
hg.mozilla.org, and access mercurial repositories there using:

  git_connect(fd, url, "hg -R %s serve --stdio",
              CONNECT_RELATIVE_SSH | CONNECT_WANT_STDERR)

And this works for local urls too, invoking `hg serve` locally.

Note that what the second patch does could be done in sq_quote_buf
instead, arguably.

I'm certainly open to any better ideas as long as they can make it to
mainline :).

Mike Hommey (4):
  git_connect: extend to take a pseudo format string for the program to
    run
  git_connect: avoid quoting the path on the command line when it's not
    necessary
  git_connect: allow a file descriptor to be allocated for stderr
  git_connect: add a flag to consider the path part of ssh urls relative

 connect.c | 52 ++++++++++++++++++++++++++++++++++++++++++++--------
 connect.h |  2 ++
 2 files changed, 46 insertions(+), 8 deletions(-)

-- 
2.8.1.5.g18c8a48
