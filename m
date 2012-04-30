From: mhagger@alum.mit.edu
Subject: [RFC 0/7] Make check_refname_format() more flexible
Date: Tue,  1 May 2012 01:02:48 +0200
Message-ID: <1335826975-3093-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 01:03:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOzch-0000Mi-Iw
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 01:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757175Ab2D3XDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 19:03:08 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41736 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756674Ab2D3XDH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 19:03:07 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0D9D4.dip.t-dialin.net [79.192.217.212])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3UN2xb9028766;
	Tue, 1 May 2012 01:02:59 +0200
X-Mailer: git-send-email 1.7.10
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196628>

From: Michael Haggerty <mhagger@alum.mit.edu>

Here are some patches that I have had kicking around for a while to
make check_refname_format() more flexible.  In particular, they add a
REFNAME_FULL option (for checking that the reference name is a valid
full reference name (i.e., either starts with "refs/" or is ALL_CAPS)
and a REFNAME_RELAXED option (which relaxes the rules to the level
that they only prevent "dangerous" refnames, not just confusing ones).

REFNAME_RELAXED is the name I chose instead of REFNAME_NONSTRICT as
discussed on the mailing list.  (I decided that "REFNAME_NONSTRICT"
looks too much like "REFNAME_STRICT" when reading quickly over it,
plus it avoids double negatives.)

Patch 2 fixes a big with the handling of the REFNAME_DOT_COMPONENT
option.  (I believe that this option is anyway obsoleted by the
changes that removed extra_refs; I'll double-check.)

The patches also do some refactoring, like extracting a new function
parse_refname_prefix().  If some of these fixes will be needed on
older branches, then they should be redone without the refactorings.

Ideally all of the options to check_refname_format() should be covered
by tests; on the other hand I don't think it is a good idea to cruft
up the interface to "git check-ref-format" with options that are
probably not useful outside of the test suite.  Is there a precedent
for how to add tests for such code?

Michael Haggerty (7):
  check_refname_component(): iterate via index rather than via pointer
  check_refname_component(): fix check with REFNAME_DOT_COMPONENT
  parse_refname_component(): accept a length parameter
  parse_refname_component(): parse until terminator
  parse_refname_prefix(): new function
  check_refname_format(): add REFNAME_FULL option
  check_refname_format(): implement REFNAME_RELAXED option

 Documentation/git-check-ref-format.txt |   14 ++++
 builtin/check-ref-format.c             |    4 +
 refs.c                                 |  136 +++++++++++++++++++++++---------
 refs.h                                 |   16 +++-
 t/t1402-check-ref-format.sh            |   31 ++++++++
 5 files changed, 158 insertions(+), 43 deletions(-)

-- 
1.7.10
