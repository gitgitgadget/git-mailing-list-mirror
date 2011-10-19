From: mhagger@alum.mit.edu
Subject: [RFC 00/13] Checking full vs. partial refnames
Date: Wed, 19 Oct 2011 22:55:03 +0200
Message-ID: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 22:55:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdAf-0003R0-JU
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 22:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883Ab1JSUzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 16:55:24 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:60883 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733Ab1JSUzX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 16:55:23 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGd4c-000423-0L; Wed, 19 Oct 2011 22:49:14 +0200
X-Mailer: git-send-email 1.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183948>

From: Michael Haggerty <mhagger@alum.mit.edu>

There are many places where it is necessary to determine whether a
refname is a complete, valid, top-level reference name in the "refs/"
tree, one of the special refnames like "HEAD" or "FETCH_HEAD", or
whether it is potentially a valid fragment of a refname that can be
DWIMed into a true reference.  Until now such checks have been
incomplete and/or scattered around.

The first three patches in this series beef up check_refname_format()
(and adds another static function, parse_refname_prefix()) with the
ability to make such checks when the REFNAME_FULL flag is used.

The fourth patch removes the checking of refnames passed to
add_extra_ref(), allowing the function to tolerate oddities like
"refs/tags/3.1.1.1^{}".

The rest of the patches consist of wild-assed guesses about some
callers of check_refname_format() that I suppose can use the
REFNAME_FULL option, thereby tightening up what they accept.  About
all I can say is that the test suite passes with these patches
applied.  But recent experience indicates that the test suite has a
lot of holes.  Therefore, it would be great if experts would look over
these suggestions.

There are many other callers of check_refname_format() that I haven't
touched, because I'm not even brave enough to make wild-assed guesses
about them.  (Since I left them without the REFNAME_FULL option, they
rather allow too many references through than too few.)  It would be
great if a more experienced developer would look at the other callers
and decide which need to be changed.

BTW, this patch series does *not* fix the specific problem that Junio
mentioned (that "git update-ref tmp/junk HEAD" does not reject the
bogus refname), nor probably many others.  The gruelling work is not
this patch series; it is the effort of tracking down all of the code
paths that might try to pass bogus refnames to the refs API.

This patch series applies on top of jc/check-ref-format-fixup, and
also rebases smoothly to the current "next".

Michael Haggerty (13):
  check_refname_component(): iterate via index rather than via pointer
  parse_refname_prefix(): new function
  Teach check_refname_format() to check full refnames
  add_ref(): move the call of check_refname_format() to callers
  receive-pack::update(): use check_refname_format(..., REFNAME_FULL)
  strbuf_check_branch_ref(): use check_refname_format(...,
    REFNAME_FULL)
  one_local_ref(): use check_refname_format(..., REFNAME_FULL)
  expand_namespace(): the refname is full, so use REFNAME_FULL option
  new_branch(): verify that new branch name is a valid full refname
  strbuf_check_tag_ref(): the refname is full, so use REFNAME_FULL
    option
  replace_object(): the refname is full, so use REFNAME_FULL option
  resolve_ref: use check_refname_format(..., REFNAME_FULL)
  filter_refs(): the refname is full, so use REFNAME_FULL option

 Documentation/git-check-ref-format.txt |   14 ++++
 builtin/check-ref-format.c             |    4 +
 builtin/fetch-pack.c                   |    2 +-
 builtin/receive-pack.c                 |    2 +-
 builtin/replace.c                      |    2 +-
 builtin/tag.c                          |    2 +-
 environment.c                          |    2 +-
 fast-import.c                          |    2 +-
 refs.c                                 |  124 ++++++++++++++++++++------------
 refs.h                                 |   12 ++-
 remote.c                               |    2 +-
 sha1_name.c                            |    2 +-
 t/t1402-check-ref-format.sh            |   31 ++++++++
 13 files changed, 143 insertions(+), 58 deletions(-)

-- 
1.7.7
