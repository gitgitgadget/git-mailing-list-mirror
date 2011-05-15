From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 0/9] Push limits
Date: Sun, 15 May 2011 23:37:11 +0200
Message-ID: <1305495440-30836-1-git-send-email-johan@herland.net>
References: <201105151942.29219.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 15 23:37:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLj0S-00004r-6I
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 23:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab1EOVhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 17:37:39 -0400
Received: from smtp.getmail.no ([84.208.15.66]:55591 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281Ab1EOVhi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 17:37:38 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL9009O8AQM0Y80@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 15 May 2011 23:37:34 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 375841EA5F3E_DD0479EB	for <git@vger.kernel.org>; Sun,
 15 May 2011 21:37:34 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 573101EA3074_DD0479DF	for <git@vger.kernel.org>; Sun,
 15 May 2011 21:37:33 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL900KSQAQK8000@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 15 May 2011 23:37:33 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <201105151942.29219.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173668>

Here's the next iteration of what started out as a simple patch to let
the server refuse pushes that exceeded a configurable limit on the
#objects in a pack.

The current patch series allows limiting pushes by
 - size of pack
 - #objects in pack
 - #commits in pack

The limits are controlled by corresponding (new) config variables:
 - receive.packSizeLimit
 - receive.objectCountLimit
 - receive.commitCountLimit

Setting one or more of these config variables causes receive-pack to
advertise the corresponding (new) capabilities:
 - limit-pack-size=<num>
 - limit-object-count=<num>
 - limit-commit-count=<num>

These capabilities are parsed by the send-pack client, which pass them
on to pack-objects, using the corresponding (mostly new) pack-objects
options:
 --max-pack-size=<num>      (extended to be usable in this context)
 --max-object-count=<num>   (new)
 --max-commit-count=<num>   (new)

When one or more of those options are given together with --stdout to
pack-objects, pack-objects will check the generated pack against those
limits, and abort the pack generation if any limit is exceeded.

In addition, the server will also verify the object count limit,
if enabled, and abort the push if the pack exceeds the limit.
Currently, the server cannot easily check the other two limits without
changing the pack format (left as an exercise to the reader... ;-]),
so exceeding the pack size limit or the commit count limit will not be
caught by the server.


Finally, a quick run-through of the patches:

 - #1 is a very minor fix to the pack protocol docs.

 - #2 attempts to retrieve and display the remote status, even when
   pack-objects fail. This patch touches the same code as the recent
   send-pack deadlock fixes, so I'd like Peff or JSixt to review them.

 - #3 - #5 teaches pack-objects some new options to impose the above
   limits on the generated pack.

 - #6 contains some general preparation for the "limit-*" capabilities.

 - #7 - #9 adds the new limits to receive-pack, send-pack, and the
   corresponding protocol capabilites.


Have fun! :)

...Johan


Johan Herland (9):
  Update technical docs to reflect side-band-64k capability in receive-pack
  send-pack: Attempt to retrieve remote status even if pack-objects fails
  pack-objects: Allow --max-pack-size to be used together with --stdout
  pack-objects: Teach new option --max-object-count, similar to --max-pack-size
  pack-objects: Teach new option --max-commit-count, limiting #commits in pack
  receive-pack: Prepare for addition of the new 'limit-*' family of capabilities
  send-pack/receive-pack: Allow server to refuse pushes with too many objects
  send-pack/receive-pack: Allow server to refuse pushing too large packs
  send-pack/receive-pack: Allow server to refuse pushes with too many commits

 Documentation/config.txt                          |   35 ++++
 Documentation/git-pack-objects.txt                |   20 +++
 Documentation/git-repack.txt                      |    6 +
 Documentation/technical/pack-protocol.txt         |    5 +-
 Documentation/technical/protocol-capabilities.txt |   30 +++-
 builtin/pack-objects.c                            |   53 +++++-
 builtin/receive-pack.c                            |   45 +++++-
 builtin/send-pack.c                               |   44 ++++--
 cache.h                                           |    2 +-
 connect.c                                         |    7 +-
 git-repack.sh                                     |   27 ++--
 send-pack.h                                       |    3 +
 t/t5300-pack-object.sh                            |  121 +++++++++++++
 t/t5400-send-pack.sh                              |  191 +++++++++++++++++++++
 14 files changed, 543 insertions(+), 46 deletions(-)

-- 
1.7.5.rc1.3.g4d7b
