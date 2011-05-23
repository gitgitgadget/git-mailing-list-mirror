From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 00/10] Push limits
Date: Mon, 23 May 2011 02:51:53 +0200
Message-ID: <1306111923-16859-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 02:52:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOJNs-0000SO-An
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 02:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628Ab1EWAwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 20:52:25 -0400
Received: from smtp.getmail.no ([84.208.15.66]:53497 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab1EWAwY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 20:52:24 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLM001Q8IFA4YA0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 May 2011 02:52:22 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 4C8811EA6098_DD9AFC6B	for <git@vger.kernel.org>; Mon,
 23 May 2011 00:52:22 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id A826D1EA2B6E_DD9AFC5F	for <git@vger.kernel.org>; Mon,
 23 May 2011 00:52:21 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLM005PMIF9TE20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 May 2011 02:52:21 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174207>

Finally, I found some time to re-roll this series. Here's a quick
overview of the changes since the previous iteration:

 - Rebased onto 'next' to include the deadlock fix from Peff and J6t.

 - Reshuffle the patch series to leave the more contentious patches
   towards the end of the series.

 - (patch #3) Implement tighter matching rules in server_supports(),
   as suggested by Junio in the previous thread.

 - Remove --max-object-count from pack-objects and limit-object-count
   capability, since object count is not considered a useful metric
   for limiting pushes. However, keep the server-side object count
   limit, since it is the only metric we can cheaply check on the
   server-side (unless we change the pack format to include pack size
   and/or commit count). This is now found in patch #10.

 - (patch #9) In pack-objects, attempt to estimate the pack size before
   we start writing out pack data. Abort as early as possible if the
   estimated pack size exceeds the pack size limit. The estimate is
   based on the in-pack size of already packed objects (assumed to be
   reused as-is). The patch does not attempt to estimate the packed
   size of currently loose objects. Therefore, whenever we're pushing
   unpacked objects, we end up underestimating the pack size. This is
   suboptimal, but ok, since we will still abort the transfer if we
   exceed the pack size limit while writing out the pack data.


Have fun! :)

...Johan


Johan Herland (10):
  Update technical docs to reflect side-band-64k capability in receive-pack
  send-pack: Attempt to retrieve remote status even if pack-objects fails
  Tighten rules for matching server capabilities in server_supports()
  receive-pack: Prepare for addition of the new 'limit-*' family of capabilities
  pack-objects: Teach new option --max-commit-count, limiting #commits in pack
  send-pack/receive-pack: Allow server to refuse pushes with too many commits
  pack-objects: Allow --max-pack-size to be used together with --stdout
  send-pack/receive-pack: Allow server to refuse pushing too large packs
  pack-objects: Estimate pack size; abort early if pack size limit is exceeded
  receive-pack: Allow server to refuse pushes with too many objects

 Documentation/config.txt                          |   27 ++++
 Documentation/git-pack-objects.txt                |   11 ++
 Documentation/technical/pack-protocol.txt         |    5 +-
 Documentation/technical/protocol-capabilities.txt |   29 ++++-
 builtin/pack-objects.c                            |   56 ++++++-
 builtin/receive-pack.c                            |   42 +++++-
 builtin/send-pack.c                               |   31 +++--
 cache.h                                           |    2 +-
 connect.c                                         |   30 ++++-
 send-pack.h                                       |    2 +
 t/t5300-pack-object.sh                            |   77 +++++++++
 t/t5400-send-pack.sh                              |  171 +++++++++++++++++++++
 12 files changed, 453 insertions(+), 30 deletions(-)

-- 
1.7.5.rc1.3.g4d7b
