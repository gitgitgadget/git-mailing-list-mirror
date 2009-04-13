From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation/CodingGuidelines: improve header includes
 rules
Date: Tue, 14 Apr 2009 00:34:33 +0200
Message-ID: <20090414003433.39cbdea2.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Nathaniel P Dawson <nathaniel.dawson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 00:37:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtUmc-0007m1-6M
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 00:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbZDMWfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 18:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754313AbZDMWfn
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 18:35:43 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:57528 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754475AbZDMWfm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 18:35:42 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 889A5818062;
	Tue, 14 Apr 2009 00:35:32 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with SMTP id B1102818072;
	Tue, 14 Apr 2009 00:35:29 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116496>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/CodingGuidelines |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

	Sorry for the delay but I have been busy with other things.

	The goal of these rule is to codify the current practice and
	to keep things simple to use for the developer while keeping
	some sanity.

	So there are 4 rules and I hope it's enough:

	- The first one was already in the document but is strenghtened
	a bit.

	- The second one existed informaly.

	- The third one means that for example if we have "revision.h"
	that includes "diff.h" and "commit.h", then it's ok to include
	"revision.h" in a C file, only if at least one feature from
	"revision.h" is actually used in the C file.

	It is not ok to include "revision.h" if features from "diff.h"
	and "commit.h" are used but no feature from "revision.h" is
	used.

	But on the other hand if features from bith "revision.h" and
	"diff.h" are used in a C file, then the rule does not state that
	"diff.h" has to be included if "revision.h" is included. So in
	practice this means that it would be ok to remove an include of
	"diff.h" if "revision.h" is included.

	- The fourth and last rule tries to keep things simple to use
	for the developper and quite sane. Here are some part of an email
	I already sent. This will hopefully explain why I think this rule
	is needed:

	> Well, I wanted to say that for a header file frotz.h in the
	> project:
	>
        > $ cat >1.c <<\EOF
        > #include "cache.h"
        > #include "frotz.h"
        > EOF
        > $ cc -Wall -c 1.c
        >
	> should not fail.
	>
	> (Ok, in practice, let's say that something like:
	>
	> $ cc -Wall -DSHA1_HEADER='<openssl/sha.h>' -c 1.c
	>
	> should not fail.)
	>
	> I think [the fact that the above fails] may become a problem if
	> a header needs more headers to be included before it, and those
	> latter headers again need more headers and so on.
	>
	> The advantage of having and using "cache.h" is that things are
	> quite simple. 
	> You include cache.h and then a few more headers for special
	> features you need, and, here you go, you can code up something
	> quite interesting without worrying too much about includes.
	> (Though the compilation time is perhaps a little longer than it
	> could be.)
	>
	> If we loose this simplicity because we don't take care or for
	> some theoretical reason, then I think we have lost everything
	> that really matters.

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index b8bf618..181cb2d 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -115,10 +115,6 @@ For C programs:
 
  - When you come up with an API, document it.
 
- - The first #include in C files, except in platform specific
-   compat/ implementations, should be git-compat-util.h or another
-   header file that includes it, such as cache.h or builtin.h.
-
  - If you are planning a new command, consider writing it in shell
    or perl first, so that changes in semantics can be easily
    changed and discussed.  Many git commands started out like
@@ -132,3 +128,25 @@ For C programs:
 
  - When we pass <string, length> pair to functions, we should try to
    pass them in that order.
+
+About header file includes:
+
+ - The first #include in C files, except in platform specific
+   "compat/" implementations, should be "git-compat-util.h" or
+   "cache.h" or "builtin.h".
+
+ - System header files should be included in "git-compat-util.h",
+   except for specific system headers like "syslog.h" in "daemon.c".
+   (This is because for portability reasons we want the compiler to
+   always see the same system headers in the same order.)
+
+ - After the first #include in a C file, only header files containing
+   features that are actually used in the C file should be included.
+   (This means that it is not ok to include an header file only
+   because this header file includes other header files with features
+   that are used in the C file.)
+
+ - Git header files, when they are included in a C file after
+   "cache.h", should not require any other header file to be included
+   before them for the C file to compile cleanly. (This is because we
+   want to keep it simple to use features defined in our headers.)
-- 
1.6.2.2.572.g4420a
