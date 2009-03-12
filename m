From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: autoconf changes
Date: Thu, 12 Mar 2009 15:20:05 -0400
Message-ID: <1236885612-22575-1-git-send-email-bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 20:22:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhqTb-0007sz-Oa
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 20:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755670AbZCLTUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 15:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755965AbZCLTUR
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 15:20:17 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:36876 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403AbZCLTUP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 15:20:15 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253] ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1LhqRx-0004Sb-F0
	for git@vger.kernel.org; Thu, 12 Mar 2009 15:20:13 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1LhqRx-0005tX-C5
	for git@vger.kernel.org; Thu, 12 Mar 2009 15:20:13 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n2CJKCrB022659
	for git@vger.kernel.org; Thu, 12 Mar 2009 15:20:12 -0400
X-Mailer: git-send-email 1.5.5.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113111>


Hi All,

I discovered recently (when building 1.6.2 on solaris 8 sparc) that
the autoconf detection for POSIX Threads wasn't quite adequate for my
needs.  This is partly due to gcc only warning on invalid flags in
some cases (-pthread on solaris 8 sparc) but still exiting cleanly.

When I got looking at things, I found several items that I don't think
are quite right.  For example, any of the --with- options that take a
path argument didn't actually use the value supplied when testing for
features in a library.  If the user didn't also set a good
CPPFLAGS/LDFLAGS (which they should, but that's beside the point),
things like the deflateUnbound zlib function might be ignored even
when present.

I decided to dig in and modify the configure.ac file fairly heavily.
What I've put together in the forthcoming patch set does the
following:

1. Handles user arguments early in the configure script and makes the
   values that get set in config.mak.autogen available in the rest of
   the script (I find those names nicer that $with_...).  These
   settings now make it into config.log too.
2. Use the values supplied to wrap tests with a modified CPP/LD FLAGS
   pair when applicable.
3. Fixed the asciidoc test to better handle python 2.6 (I haven't
   tested with 2.4, but the change is quite simple and shouldn't be a
   problem [as someone else mentioned recently: famous last words]).
4. Allows the user to pass in compiler flags to enable POSIX Threads
   which will override the default pair of tests.
5. Tries to maintain the original actions and intents where possible.

I've tested this on solaris 8 and Linux (Ubuntu 9.04) and it seems to
do all the things I'd expect.

I hope you'll find these to be useful changes.

Thanks
-Ben
