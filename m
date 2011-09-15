From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 00/22] Clean up refname checks and normalization
Date: Thu, 15 Sep 2011 23:10:21 +0200
Message-ID: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:11:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JDC-0005wW-IE
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934964Ab1IOVLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:11:03 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40054 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934950Ab1IOVLA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:11:00 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J8a-00019o-G0; Thu, 15 Sep 2011 23:06:24 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181498>

This patch series cleans up refname checks and normalization in a
different way than v1 and v2.  (Unnormalized refnames are those that
have extra leading slashes or runs of repeated slashes between
components, like "//refs/heads///master".)

As discussed on the mailing list [1], adding consistent support for
unnormalized refnames everywhere was becoming a bottomless pit, so
instead I am taking the opposite approach--only accept normalized
refnames.  Support for unnormalized refnames was broken anyway, so it
shouldn't be missed.

There is only one command that is now meant to accept unnormalized
refnames:

    $ git check-ref-format --normalize //refs/heads///master
    refs/heads/master
    $

This command can be used to normalize refnames for use elsewhere.

I have added a few internal checks that refnames have the correct
format; more tests should still be added.  But this patch series is
getting quite long already, so I would like to submit it.

During the development of this patch series, I discovered that
fetch_with_import() in remote-helper.c sometimes passes NULL to
read_ref(), and thereby to resolve_ref().  The two commits labeled
"remote: *" fix this in a naive way.  But somebody more familiar with
this code should check whether the fix is OK and more specifically
whether this is a symptom of a bigger problem in the remote-helper
code.

I should mention that this cleanup is preparation for my main goal:
storing ref caches hierarchically.  But there is still a lot of
tangled up and seemingly redundant code in refs.c, so it might be a
while before I get to the main project.

[1] http://permalink.gmane.org/gmane.comp.version-control.git/181268

Michael Haggerty (22):
  t1402: add some more tests
  git check-ref-format: add options --allow-onelevel and
    --refspec-pattern
  Change bad_ref_char() to return a boolean value
  Change check_ref_format() to take a flags argument
  Refactor check_refname_format()
  Do not allow ".lock" at the end of any refname component
  Make collapse_slashes() allocate memory for its result
  Inline function refname_format_print()
  Change check_refname_format() to reject unnormalized refnames
  resolve_ref(): explicitly fail if a symlink is not readable
  resolve_ref(): use prefixcmp()
  resolve_ref(): only follow a symlink that contains a valid,
    normalized refname
  resolve_ref(): turn buffer into a proper string as soon as possible
  resolve_ref(): extract a function get_packed_ref()
  resolve_ref(): do not follow incorrectly-formatted symbolic refs
  remote: use xstrdup() instead of strdup()
  remote: avoid passing NULL to read_ref()
  resolve_ref(): verify that the input refname has the right format
  resolve_ref(): emit warnings for improperly-formatted references
  resolve_ref(): also treat a too-long SHA1 as invalid
  resolve_ref(): expand documentation
  add_ref(): verify that the refname is formatted correctly

 Documentation/git-check-ref-format.txt |   53 ++++++--
 builtin/check-ref-format.c             |   61 ++++++---
 builtin/checkout.c                     |    2 +-
 builtin/fetch-pack.c                   |    2 +-
 builtin/receive-pack.c                 |    2 +-
 builtin/replace.c                      |    2 +-
 builtin/show-ref.c                     |    2 +-
 builtin/tag.c                          |    4 +-
 cache.h                                |   34 +++++-
 connect.c                              |    2 +-
 environment.c                          |    2 +-
 fast-import.c                          |    7 +-
 git_remote_helpers/git/git.py          |    2 +-
 notes-merge.c                          |    5 +-
 pack-refs.c                            |    2 +-
 refs.c                                 |  222 +++++++++++++++++++-------------
 refs.h                                 |   21 +++-
 remote.c                               |   55 ++------
 sha1_name.c                            |    4 +-
 t/t1402-check-ref-format.sh            |  120 +++++++++++++++--
 transport-helper.c                     |   10 +-
 transport.c                            |   16 +--
 walker.c                               |    2 +-
 23 files changed, 408 insertions(+), 224 deletions(-)

-- 
1.7.6.8.gd2879
