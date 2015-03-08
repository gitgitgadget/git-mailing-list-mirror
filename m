From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 0/4] git-credential-store: XDG user-specific config file support
Date: Sun,  8 Mar 2015 15:58:48 +0800
Message-ID: <1425801532-8483-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 08:59:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUW7J-0000iO-9a
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 08:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbbCHH7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 03:59:11 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:45748 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbbCHH7E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 03:59:04 -0400
Received: by padbj1 with SMTP id bj1so30533641pad.12
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 23:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gK6f1jSsOnYnKu7TK22/7q51/xjtcgfmVfSyJuQkZEw=;
        b=Xs9iTxyT2Yn8f8E0CBLpEVuPAA3SWnqg3U2ANkSd7XZGxdjEE2j+3tkQNGwePHF4yM
         7TSefLG+otibpPaff7zSym0SMjY52tQmhtbd2A2zTDZV2nCWzqubW8Xx+PFSPMqQGcq4
         XoP6UpQVn2H4gvL/wX0NMamjxbawHaz/FPoRx8LZygqm8FV0YE9/QBYd5+qVjiFtbZrj
         9c61ubtUvnmVV3RC8Hrfym6EdhIYa60ZbqGdqisttLU7NqynwOF+4eik4bQ8U0NCyiI6
         NiPgx/NZDBzDVuUlnquFzlS5mHjYV5LwgkqbPiVEGmGI21dqdV8i80I10leLtQMRiWaD
         cEyg==
X-Received: by 10.66.227.169 with SMTP id sb9mr1761722pac.11.1425801544159;
        Sat, 07 Mar 2015 23:59:04 -0800 (PST)
Received: from yoshi.chippynet.com ([101.127.143.183])
        by mx.google.com with ESMTPSA id d9sm14199416pdk.3.2015.03.07.23.58.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2015 23:59:00 -0800 (PST)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YUW6z-0002Dn-BZ; Sun, 08 Mar 2015 15:58:57 +0800
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265042>

The previous patch series can be found at [1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/264682

The changes are as follows:

* Code refactor: instead of a gigantic blob of code in main(),
  store_credential(), remove_credential() and lookup_credential() have been
  modified to take a string_list of precedence-ordered file paths. Although in
  this patch only support for XDG_CONFIG_HOME (user-specific config files) are
  implemented, this opens the door for support of XDG_CONFIG_DIRS (system-wide
  config files) to be implemented as well.

* parse_credential_file() returns the value of found_credential at all times.
  (Thanks Junio for pointing this out)

* parse_credential_file(), and thus "get" ignores unreadable/non-existing files
  instead of warning the user. This is done to follow the XDG base dir spec,
  which states that: "if for any reason a file in a certain directory is
  unaccessible, e.g. because the directory is non-existant, the file is
  non-existant or the user is not authorized to open the file, then the
  processing of the file in that directory should be skipped."[2]

[2] http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html

* "store" now only write to a single file instead of writing to one and erasing
  from the rest, unlike the behavior in the 1st patch, as the complexity
  introduced by implementing this behavior is probably unnecessary. If the user
  really wanted all matching credentials to be erased, the user can simply just
  issue an erase. (Thanks Matthieu, Junio and Jeff for this suggestion)

* ~/.git-credentials now has greater precedence than the xdg credentials file.
  This is to be consistent with the behavior of git-config.

* Support for $XDG_CONFIG_HOME/git/credentials has been documented in
  git-credentials-store.

The changes for the tests are as follows:

* Instead of repeating ${XDG_CONFIG_HOME:-$HOME/.config} all over
  the place, add tests that test for $HOME/.config/git/credentials (when
  XDG_CONFIG_HOME is unset) and for $XDG_CONFIG_HOME/git/credentials with a
  custom $XDG_CONFIG_HOME directory set. This is to test that the new code
  respects the $XDG_CONFIG_HOME environment variable. (Thanks Junio)

* Use test_path_is_missing to test if files exist. (Thanks Matthieu)

* All code is now within test_expect_success and will now fail if any
  error occurs in the code block through the use of "&&". Furthermore, tests do
  not rely on previous tests passing as the credential files are overwritten in
  each test. (Thanks Matthieu and Junio for your code review)

The most current version of the patch queue is published in the xdg branch
at [3]. I try to push -f regularly.

For your feedback, please.

[3] https://github.com/pyokagan/git

Paul Tan (4):
  git-credential-store: support multiple credential files
  git-credential-store: support XDG_CONFIG_HOME
  docs/git-credential-store: document XDG file and precedence
  t0302: test credential-store support for XDG_CONFIG_HOME

 Documentation/git-credential-store.txt | 37 +++++++++++++-
 credential-store.c                     | 86 +++++++++++++++++++++----------
 t/t0302-credential-store.sh            | 92 ++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+), 29 deletions(-)

-- 
2.1.4
