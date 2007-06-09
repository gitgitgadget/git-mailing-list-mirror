From: Johan Herland <johan@herland.net>
Subject: [PATCH 0/21] Refactor the tag object (take 2)
Date: Sat, 09 Jun 2007 02:10:36 +0200
Message-ID: <200706090210.36270.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706081018.34207.johan@herland.net>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 02:10:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwoXY-0003Ng-Tg
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968638AbXFIAKr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762465AbXFIAKr
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:10:47 -0400
Received: from smtp.getmail.no ([84.208.20.33]:45288 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754089AbXFIAKq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:10:46 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00905DTSGJ00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:10:40 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000GUDTOZL30@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:10:36 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC00FXADTORBE0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:10:36 +0200 (CEST)
In-reply-to: <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49526>

This patch series implements part of the ground work for the 'notes'
feature discussed earlier in the thread "[PATCH 00/15] git-note: A
mechanism for providing free-form after-the-fact annotations on commits".

The following patches refactors the tag object by:
1. Unifying parsing and verification of tag objects (patches 1-9)
2. Do better and more thorough verification of tag objects (patches 10-13)
3. Making the "tagger" header mandatory as far as possible (patch 14)
4. Making the "tag" header optional (patch 15)
5. Introducing a new optional "keywords" header (patch 16)
6. Auxiliary changes supporting the above (patches 17-21)

This patch series replaces the earlier patch series of the same name
(plus the current bugfixes on top of that series). It's also much easier
on the eyes for those with 80 chars wide displays. Also, the selftest
suite should run successfully at any point in this patch series.

Here's the shortlog:

Johan Herland (21):
      Remove unnecessary code and comments on non-existing 8kB tag object restriction
      Return error messages when parsing fails.
      Refactoring to make verify_tag() and parse_tag_buffer() more similar
      Refactor verification of "tagger" line to be more similar to verification of "type" and "tagger" lines
      Make parse_tag_buffer_internal() handle item == NULL
      Refactor tag name verification loop to use index 'i' instead of incrementing pointer 'tag_line'
      Copy the remaining differences from verify_tag() to parse_tag_buffer_internal()
      Switch from verify_tag() to parse_and_verify_tag_buffer() for verifying tag objects in git-mktag
      Remove unneeded code from mktag.c
      Free mktag's buffer before dying
      Rewrite error messages; fix up line lengths
      Use prefixcmp() instead of memcmp() for cleaner code with less magic numbers
      Collect skipping of header field names and calculation of line lengths in one place
      Add proper parsing of "tagger" line, but only when thorough_verify is set
      Make tag names (i.e. the tag object's "tag" line) optional
      Introduce optional "keywords" on tag objects
      Update comments on tag objects in mktag.c
      git-fsck: Do thorough verification of tag objects
      Documentation/git-mktag: Document the changes in tag object structure
      git-mktag tests: Expand on mktag selftests according to the new tag object structure
      Add fsck_verify_ref_to_tag_object() to verify that refname matches name stored in tag object

 Documentation/git-mktag.txt |   41 +++++--
 builtin-fsck.c              |   41 +++++++
 builtin-log.c               |    2 +-
 mktag.c                     |  147 +++++-------------------
 t/t3800-mktag.sh            |  231 ++++++++++++++++++++++++++++++++++---
 tag.c                       |  268 +++++++++++++++++++++++++++++++++++--------
 tag.h                       |    5 +-
 7 files changed, 540 insertions(+), 195 deletions(-)


Have fun!

...Johan
