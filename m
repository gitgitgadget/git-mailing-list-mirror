From: iheffner@gmail.com
Subject: [PATCH 0/3] use constants for sideband communication channels
Date: Tue, 13 Dec 2011 10:28:48 -0800
Message-ID: <1323800931-37123-1-git-send-email-iheffner@gmail.com>
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
	"Dave Olszewski" <cxreg@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 19:29:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaX6T-0001MF-AF
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 19:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682Ab1LMS3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 13:29:20 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55547 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598Ab1LMS3T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 13:29:19 -0500
Received: by eaaj10 with SMTP id j10so1367623eaa.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 10:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=h7cz9b1OJ3VJAqsl3FiRi+UO2Zsnw23LOMfpqEroopc=;
        b=dbCmZECSit9xAw+ghP/hC4ddpwmnfU7dLMOrXSFiyPbVRUZbz287qRhXBo99xrjSYP
         3pzIZW2JR8FQW5b+3ZvhKBQhfrJVR2RB5Lwq0zyKNsbvW7TI/OXUQSTAiT3gM4sLf0gx
         zhUUWezrdlKWPCQETH5ljCtPTz3z8xhnmERVM=
Received: by 10.204.146.79 with SMTP id g15mr13140190bkv.121.1323800958087;
        Tue, 13 Dec 2011 10:29:18 -0800 (PST)
Received: from localhost.localdomain (sea02-v612-nat.marchex.com. [174.137.113.43])
        by mx.google.com with ESMTPS id 39sm1014563eei.1.2011.12.13.10.29.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 10:29:17 -0800 (PST)
X-Mailer: git-send-email 1.7.6.553.g917d7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187037>

In order to make more clear how the different channels in sidechannel.c
are to be used, I'm proposing some macros/constants which can be used in
place of the "magic numbers" that mean little or nothing to someone not
familiar with the protocol.

In working on a script to handle archiving from a bare repository a
project which contained submodules, I had a difficult time determining
how to talk between my git-upload-archive replacement and git-archive.
It did not occur to me to look at documentation for git-send-pack or
git-receive-pack when trying to understand the communication protocol.
But looking through the code and poking at an implementation, I finally
understood that I needed to send a channel identifier to say what type
of communication I was sending. I determined that there were three
possible channels. I could easily tell that channel three (3) was for
catastrophic errors on the server side.  But it was not clear what the
difference between channel 1 and channel 2 were.  Because channel 2 was
the one that appeared to be read and parsed in some manner, I assumed
that this was the "important" data channel and tried sending my data on
that channel.

I was confused and frustrated when it appeared that git-archive treated
data coming from my --exec'd git-upload-archive replacement differently
than it did when receiving data from the real git-upload-archive.
Eventually I figured out that channel 1 was for data, channel 2 was for
non-fatal messages, and channel 3 was for fatal error communications.
Having comments in sidechannel.h would have helped. But constants or
macros would have helped as well and makes the code that uses them more
clear.

Ivan


 [PATCH 1/3] add constants for sideband communication channels
 [PATCH 2/3] switch sideband communication to use constants
 [PATCH 3/3] use SIDEBAND_*_ERROR constants in pack protocol

 builtin/fetch-pack.c     |    2 +-
 builtin/receive-pack.c   |    6 +++---
 builtin/send-pack.c      |    4 ++--
 builtin/upload-archive.c |    6 +++---
 sideband.c               |    6 +++---
 sideband.h               |    6 +++++-
 upload-pack.c            |   22 +++++++++++-----------
 7 files changed, 28 insertions(+), 24 deletions(-)
