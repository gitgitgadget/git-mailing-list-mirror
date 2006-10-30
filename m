X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH (WISP) 0/5] Support shallow repositories
Date: Mon, 30 Oct 2006 20:08:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0610302006301.26682@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 30 Oct 2006 19:19:08 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30508>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GecVY-0005rW-8C for gcvg-git@gmane.org; Mon, 30 Oct
 2006 20:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161461AbWJ3TI2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 14:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161458AbWJ3TI2
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 14:08:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:5064 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1161455AbWJ3TI0 (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 14:08:26 -0500
Received: (qmail invoked by alias); 30 Oct 2006 19:08:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp046) with SMTP; 30 Oct 2006 20:08:20 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org

Hi,

Def.: Shallow commits do have parents, but not in the shallow
repo, and therefore grafts are introduced pretending that
these commits have no parents.

The basic idea is to write the SHA1s of shallow commits into
$GIT_DIR/shallow, and handle its contents like the contents
of $GIT_DIR/info/grafts (with the difference that shallow
cannot contain parent information).

This information is stored in a new file instead of grafts, or
even the config, since the user should not touch that file
at all (even I did not once edit it myself during development!).
Each line contains exactly one SHA1. When read, a commit_graft
will be constructed, which has nr_parent < 0 to make it easier
to discern from user provided grafts.

Since fsck-objects relies on the library to read the objects,
it honours shallow commits automatically.

This stuff is definitely "pu" material:

- I am not quite sure if we have to force non-thin packs when
fetching into a shallow repo (ATM they are forced non-thin). 
Comments?

- A special handling of a shallow upstream is needed. At some
stage, upload-pack has to check if it sends a shallow commit,
and it should send that information early (or fail, if the
client does not support shallow repositories). There is no
support at all for this in this patch series.

- Instead of locking $GIT_DIR/shallow at the start, just
the timestamp of it is noted, and when it comes to writing it,
a check is performed if the mtime is still the same, dying if
it is not. Is this enough?

- I have not touched the "push into/from a shallow repo" issue.
Don't even try it yet.

- If you deepen a history, you'd want to get the tags of the
newly stored (but older!) commits. I don't think this works
right now.

This series does the following:

- gets rid of the call to rev-list in upload-pack

  It is just a tiny change. It is needed so that the client can
tell the server which commits to ignore for the moment. Note that
this is bad for porting to Windows: it should be relatively easy
to spawn other programs in Win32, but is probably lot more work
to just fork _and_ maintain the memory and fd's.

- support fetching into shallow repositories

  Up until now (including this patch), we do not have tool
support to make shallow repos. This patch is separated from
the rest for your reviewing pleasure only.

- support making a shallow repository by cloning with a depth

  "git-clone --depth 20 repo" will lead to a shallow repository,
which contains only commit chains with a length of at most 20. It
also writes an appropriate $GIT_DIR/shallow.

- support deepening a shallow repository

  "git-fetch --depth 20 repo branch" will fetch branch from repo,
but stop at depth 20, updating $GIT_DIR/shallow.

- add tests to t5500

  Since t5500 conveniently provides all we need to test shallow
clones, no new test script was added, but t5500 extended.

Unfortunately, my time resources are scarce in the next few days,
but I did not want to hold this stuff back any longer.

Ciao,
Dscho
