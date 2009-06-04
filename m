From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 0/7] [GSoC2009] Revision cache / git-daemon caching plan
Date: Fri, 5 Jun 2009 02:18:47 +1200
Message-ID: <cover.1244125127.git.sam@vilain.net>
Cc: Nick Edelen <sirnot@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 07:46:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCSFv-0001n0-Eb
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 07:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbZFEFpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 01:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755008AbZFEFpV
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 01:45:21 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:57206 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754819AbZFEFpE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 01:45:04 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1003)
	id 7CDBF21D11E; Fri,  5 Jun 2009 17:45:00 +1200 (NZST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120752>

This patch series describes the structure of the object list cache
on-disk format.  It is built successively from a very simple design -
just an object list - to a version that allows for as many rev-list
operations to be accelerated as possible, and potentially immediate
startup of full clone operations in the common case; ie skipping the
"Counting Objects" and "Compressing Objects" phase once a matching
index is found.

The plan will be to implement each step incrementally, with a test-*.c
file along the way which tests the API provided by the revision cache
API.  While the revision cache format will change along the way, this
will not require an index format deprecation cycle, as integration with
the rest of git will not happen until the format is settled.

The plan is to aim for one of these API milestones completed per week.
When complete, each commit will contain tests for the level of cache
that it delivers.  Later milestones include joining the dots -
integrating with the 'rev-list' machinery and most importantly,
'pack-objects'.

Errata: the 'object list' and 'contents hash' will probably be
re-worked to keep a separate SHA-1 and topological index list, to
re-use existing fan-out code.  This will be incorporated into the next
version.

Sam Vilain (7):
  revision-cache: define revision cache as simple list of revisions
  rev-cache: add on-disk format for fast reachability lookup
  rev-cache: add 'end' objects for caching 'uninteresting' lookups
  rev-cache: allow multiple 'start' objects per index
  revision cache: maps of 'new' objects
  revision cache: allow foreign 'start' commits
  revision cache: be even stricter with sort order

 Documentation/technical/revision-cache.txt |  416 ++++++++++++++++++++++++++++
 1 files changed, 416 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/revision-cache.txt
