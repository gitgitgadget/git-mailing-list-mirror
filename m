From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCHv3 0/9] Removing deprecated parsing macros
Date: Sat,  3 Aug 2013 13:51:17 +0200
Message-ID: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sat Aug 03 13:51:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5aMb-0004LB-6n
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 13:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515Ab3HCLvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 07:51:04 -0400
Received: from mail-ea0-f176.google.com ([209.85.215.176]:61207 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab3HCLvA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 07:51:00 -0400
Received: by mail-ea0-f176.google.com with SMTP id q16so754802ead.7
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=KZk4M0Ys5bcSxW+NIUxyP3PoCcLGDKC2BgoWrZunExw=;
        b=gXv/pI44onx1DgAvZA53KtvbpbLV1zShqt1CKPjBDHPhU7/hGboRz+WtI5TsfJmVfy
         dbsSA3zBdVVLnnnVyuVyzIiTue3KaPlPGgisRgsxkvHumGdU2o1PJfHaLkDTXpvXK43r
         IasxU2r9gT4nw3BlgAjBxWTsKH1rwAzyFMb7AkbzPjQGE0TrTVbRRjFROnm4tYnco8mC
         1MMX+kJWhpy3+FzhzeqDuJUstPEWn+k6YyTvZY9e3U5sl0fAHhi9+G94NBPYkU6fqVwJ
         N7q63kMhmlEYnC/ELvVQ7iweOhG+SNi5dDhkme3odZe8vkrkYFLiLHL1sOxTEaWN9fAK
         Fbrw==
X-Received: by 10.15.41.205 with SMTP id s53mr893526eev.63.1375530659029;
        Sat, 03 Aug 2013 04:50:59 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id j2sm18893126eep.6.2013.08.03.04.50.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 04:50:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.16.g7fca822.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231582>

Suggested changes by Eric Sunshine included.

Within the builtin/ folder all occurrences of OPT_BOOLEAN have been removed.
Now we only need to review the usage of it in parse-options as used in
OPT__VERBOSE, OPT__QUIET, OPT__DRY_RUN and OPT__FORCE.
Most likely we could just use OPT_SET_INT there and then OPT_BOOLEAN is 
gone.

The patch 1 and 2 are not intended to change any semantics,
but were the most work, because of the checking for each place not
changing the semantics.

Patch 3 introduces -q the shortform of --quiet for log and format-patch 

Patch 4,5 are unspectacular, just improving readability.

Patch 6 is indeed the only occurence, where I needed to use OPT_COUNTUP
for OPT_BOOLEAN. Personally I'd change it there as well, but it's plumbing.

Patch 7 makes git config a little more flexible (allowing --global 
multiple times).

Patch 8 is a change in the plumbing layer, what I'd call a bugfix,
not urgent, but still.

Patch 9 introduces the new OPT_CMDMODE to revert. Junio suggested to 
change the OPT_CMDMODE a little and use the short parameter as the value
assigned to the command variable. This patch shows, why it might not be a
good idea, as the options there do not have short parameters.


Stefan Beller (9):
  Remove deprecated OPTION_BOOLEAN for parsing arguments
  Replace deprecated OPT_BOOLEAN by OPT_BOOL
  log, format-patch: parsing uses OPT__QUIET
  checkout: remove superfluous local variable
  branch, commit, name-rev: ease up boolean conditions
  hash-object: Replace stdin parsing OPT_BOOLEAN by OPT_COUNTUP
  config parsing options: allow one flag multiple times
  checkout-index: Fix negations of even numbers of -n
  revert: use the OPT_CMDMODE for parsing, reducing code

 Documentation/git-format-patch.txt |  1 +
 builtin/apply.c                    | 24 +++++++--------
 builtin/bisect--helper.c           |  8 ++---
 builtin/blame.c                    |  8 ++---
 builtin/branch.c                   | 13 ++++----
 builtin/check-attr.c               |  8 ++---
 builtin/check-ignore.c             | 12 ++++----
 builtin/checkout-index.c           |  8 ++---
 builtin/checkout.c                 | 27 ++++++++---------
 builtin/clean.c                    |  6 ++--
 builtin/clone.c                    | 23 +++++++-------
 builtin/commit.c                   | 48 ++++++++++++++---------------
 builtin/config.c                   |  8 ++---
 builtin/describe.c                 | 20 ++++++------
 builtin/fast-export.c              | 10 +++---
 builtin/fetch.c                    | 24 +++++++--------
 builtin/fsck.c                     | 16 +++++-----
 builtin/gc.c                       |  4 +--
 builtin/grep.c                     | 38 +++++++++++------------
 builtin/hash-object.c              |  8 ++---
 builtin/log.c                      | 17 +++++------
 builtin/ls-files.c                 | 24 +++++++--------
 builtin/ls-tree.c                  |  6 ++--
 builtin/merge-base.c               | 10 +++---
 builtin/merge-file.c               |  2 +-
 builtin/merge.c                    | 12 ++++----
 builtin/mv.c                       |  2 +-
 builtin/name-rev.c                 | 14 ++++-----
 builtin/notes.c                    | 12 ++++----
 builtin/push.c                     |  6 ++--
 builtin/remote.c                   | 28 ++++++++---------
 builtin/replace.c                  |  6 ++--
 builtin/reset.c                    |  2 +-
 builtin/rev-parse.c                |  4 +--
 builtin/revert.c                   | 62 +++++++++-----------------------------
 builtin/rm.c                       |  6 ++--
 builtin/shortlog.c                 | 12 ++++----
 builtin/show-branch.c              | 28 ++++++++---------
 builtin/show-ref.c                 | 15 +++++----
 builtin/tag.c                      |  4 +--
 builtin/update-ref.c               |  4 +--
 parse-options.h                    |  5 ++-
 42 files changed, 278 insertions(+), 317 deletions(-)

-- 
1.8.4.rc0.16.g7fca822.dirty
