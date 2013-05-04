From: Johan Herland <johan@herland.net>
Subject: [PATCH 0/7] Make "$remote/$branch" work with unconventional refspecs
Date: Sun,  5 May 2013 01:55:42 +0200
Message-ID: <1367711749-8812-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 05 01:56:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYmJ5-0005dx-RD
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 01:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817Ab3EDXzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 19:55:55 -0400
Received: from mail-bk0-f49.google.com ([209.85.214.49]:47747 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab3EDXzy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 19:55:54 -0400
Received: by mail-bk0-f49.google.com with SMTP id e19so1164307bku.36
        for <git@vger.kernel.org>; Sat, 04 May 2013 16:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=Lr+IQTbSxW1e+cleOFBbEmqKs5zXPW+lSppwne3lwnY=;
        b=Eza4BtJ6Prrd4Mina23y/UxFRh7I+2bFz1zu3Yf57e6bTLADc69eR/fSW9NK/CAhO5
         UGgQkAJhRN6d/Da33/Sa+cUmVT032VA/dkZKVsO+Dyl1Bgo96kIsa0dT1dsKDlNHO+vb
         p5PIxtKeS6oNQ3H69gMX/JBd4adsocgyxp2Lo+fVGLJWeTGlp9clxtAMF1Ln9HIMrSUP
         5rmIgyJ/aFBhoVmYsYPyriJ/fEv9C4mzITJ9+zfFacLrXZ1js7gQ0WJ43Kd2FPqMJs2F
         Uj7eMuuc2E8lKW/D64GuZXbfcPfNQkhF5lSPEWRIKPRT49MwvXfK6U2YLCT4DCynKrAp
         URIg==
X-Received: by 10.205.75.3 with SMTP id yy3mr5897896bkb.80.1367711753222;
        Sat, 04 May 2013 16:55:53 -0700 (PDT)
Received: from localhost.localdomain (p5DC5A30A.dip0.t-ipconnect.de. [93.197.163.10])
        by mx.google.com with ESMTPSA id iy11sm3810775bkb.11.2013.05.04.16.55.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 04 May 2013 16:55:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223382>

The "$remote/$branch" syntax can be interpreted in two subtly different
ways:

 1. A shorthand name for the remote-tracking branch corresponding to a
    specific $branch from a specific $remote.

 2. A refname fragment, which - when appended to "refs/remotes/" -
    yields the remote-tracking branch corresponding to a specific
    $branch from a specific $remote.

For the current default/conventional refspecs, both interpretations are
true and equally valid. However, when configuring non-default refspecs
(such as the +refs/heads/*:refs/remotes/origin/heads/*), it becomes
obvious that the current code follows the latter interpretation: The
"$remote/$branch" shorthand will no longer work, and you are forced to
use "$remote/heads/$branch" instead.

I argue that the former interpretation is what most users intuitively
expect, and that we should work towards making Git follow the same
interpretation:

Instead of prepending "refs/remotes/" to convert "$remote/$branch" into
a full refname, we should find "$remote" in the repo config, and then
map "refs/heads/$branch" through $remote's fetch refspec(s), to find
the remote-tracking branch that properly corresponds to the specific
$branch in the $remote repo.

This goal is achieved by the final patch in this series, and most of
the preceding patches serve as preliminary changes and refactoring to
support this.

Patch #1 is the exception in that it is a self-contained bugfix for a
scanf-related problem I ran across while working on the patch series.

Patches #2 and #3 introduce a new test intended to verify Git's
usability when working with remote ref namespaces (which rely on
setting up unconventional refspecs). For now, this test is fairly
thin, but it should be expanded as we find more problems with these
kinds of setups.

Patches #4 and #5 are pure refactorings to reorganize the code that
expands shorthand names to full refnames and vice versa. The idea
is to associate the patterns that are used to expand/shorten ref
names with the actual function that does the expansion/shortening,
so that we can later add patterns that uses different expand/shorten
functions.

Patch #6 teaches Git to realize when - in the context of communication
with a remote repo - it's expanding shorthand refs into either local
refnames, or remote refnames. It is important that any expansion rules
relying on local repo configuration are not allowed to expand shorthand
names on behalf of the remote repo.

Finally, patch #7 introduces a new rule and associated expand/shorten
functions mapping "$remote/$branch"-type shorthand names to/from their
remote-tracking branch counterparts, by using the configured refspecs
as described above. This rule is obviously only applied to local refs,
as it would be wrong for a repo to use its local config to dictate a
ref expansion in a remote repo.

The series has been build on recent 'next', and although it also
applies cleanly to v1.8.3-rc1, it will cause a test failure in
t7900, since it depends on the jh/checkout-auto-tracking topic, which
is currently cooking.


Have fun! :)

...Johan


Johan Herland (7):
  shorten_unambiguous_ref(): Allow shortening refs/remotes/origin/HEAD to origin
  t7900: Start testing usability of namespaced remote refs
  t7900: Demonstrate failure to expand "$remote/$branch" according to refspecs
  refs.c: Refactor rules for expanding shorthand names into full refnames
  refs.c: Refactor code for shortening full refnames into shorthand names
  refname_match(): Caller must declare if we're matching local or remote refs
  refs.c: Add rules for resolving refs using remote refspecs

 cache.h                                        |   4 -
 refs.c                                         | 260 +++++++++++++++++--------
 refs.h                                         |  14 ++
 remote.c                                       |  15 +-
 t/t6300-for-each-ref.sh                        |  12 ++
 t/t7900-working-with-namespaced-remote-refs.sh | 133 +++++++++++++
 6 files changed, 342 insertions(+), 96 deletions(-)
 create mode 100755 t/t7900-working-with-namespaced-remote-refs.sh

-- 
1.8.1.3.704.g33f7d4f
