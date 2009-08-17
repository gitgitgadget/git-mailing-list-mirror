From: "Nick Edelen" <sirnot@gmail.com>
Subject: [PATCH 0/6 (v4)] revision caching mechanism to significantly speed up
 packing/walking (last version)
Date: Mon, 17 Aug 2009 14:31:15 +0200
Message-ID: <op.uys3qdnntdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.net>,
	"Michael J Gruber" <git@drmic
X-From: git-owner@vger.kernel.org Mon Aug 17 14:32:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md1OI-0002Yp-AI
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 14:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbZHQMbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 08:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbZHQMbU
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 08:31:20 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:58439 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbZHQMbT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 08:31:19 -0400
Received: by ewy10 with SMTP id 10so2899380ewy.37
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 05:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:subject:from
         :content-type:mime-version:content-transfer-encoding:message-id
         :user-agent;
        bh=h62RIPRdSkOTnqZPgKhQ85rgOl+tdzphNPxvCJr/NjY=;
        b=KZRG5RdIMwhA4CMNPOiyaVn2v9UQJdbBtrF5I5lW/Ju+i3uj3oTJCJB7OfTn52+LTJ
         UIseYf/VH1eGxdGB+NvQ+7+WBcsR86V6e8e+iRmQPUGy9OJsI84LGgwMgDhQmW1ISAl6
         x/AndKjS0yoPei5mCnLPIZtlb8AWHRKFZRQWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:subject:from:content-type:mime-version
         :content-transfer-encoding:message-id:user-agent;
        b=iyNCpFM/MGvGVQZC4oE3f/9k8Qq+EE8xAp5dTlyyIu94CeuLEWy/FSulfUxcY0Wzit
         shjnpc8HG8w1iNPbU4so27jB2Zo1ze22p0lO/pA+T9hRJ9mVjsvdngKX1Z+4Gz3LiRx3
         lTi3ep4kwd6SFvigp4wyO9ZmzM481nwhzmIBI=
Received: by 10.210.68.14 with SMTP id q14mr3534977eba.16.1250512279415;
        Mon, 17 Aug 2009 05:31:19 -0700 (PDT)
Received: from sirnot.private (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id 28sm10561249eye.4.2009.08.17.05.31.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 05:31:19 -0700 (PDT)
User-Agent: Opera Mail/9.63 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126164>

SUGGESTED FOR 'PU':

Traversing objects is currently very costly, as every commit and tree must be 
loaded and parsed.  Much time and energy could be saved by caching metadata and 
topological info in an efficient, easily accessible manner.  Furthermore, this 
could improve git's interfacing potential, by providing a condensed summary of 
a repository's commit tree.

This is a series to implement such a revision caching mechanism, aptly named 
rev-cache.  The series will provide:
 - a core API to manipulate and traverse caches
 - an integration into the internal revision walker
 - a porcelain front-end providing access to users and (shell) applications
 - a series of tests to verify/demonstrate correctness
 - documentation of the API, porcelain and core concepts

In cold starts rev-cache has sped up packing and walking by a factor of 4, and 
over twice that on warm starts.  Some times on slax for the linux repository:

rev-list --all --objects >/dev/null
 default
   cold    1:13
   warm    0:43
 rev-cache'd
   cold    0:19
   warm    0:02

pack-objects --revs --all --stdout >/dev/null
 default
   cold    2:44
   warm    1:21
 rev-cache'd
   cold    0:44
   warm    0:10

The mechanism is minimally intrusive: most of the changes take place in 
seperate files, and only a handful of git's existing functions are modified.

Hope you find this useful.

 - Nick
---
BOMBS AWAY!!!

To clarify my magnificent muddying of this final update I'm flash flooding y'all with a mint patchset!  This probably isn't deserving of it's own version, but it's the last one and I've confuddled everyone enough already.

SO, what's changed from the last one?
 - fixed whitespace errors
 - cleaned up header definitions
 - implemented _ondisk versions of structs for ensured portability
 - fixed typo

Sorry again for the size of the patches, but like I said earlier they're not so much patches as files -- the changes in existing git files are actually pretty small.  Since most everything in the patches is intertwined I couldn't split it up a bunch more without having non-functioning patches.

I promise this is the last one :-P

 Documentation/git-rev-cache.txt       |  144 ++
 Documentation/technical/rev-cache.txt |  614 +++++++++
 Makefile                              |    2 +
 builtin-gc.c                          |    9 +
 builtin-rev-cache.c                   |  322 +++++
 builtin.h                             |    1 +
 commit.c                              |    2 +
 git.c                                 |    1 +
 list-objects.c                        |   49 +-
 rev-cache.c                           | 2314 +++++++++++++++++++++++++++++++++
 rev-cache.h                           |  124 ++
 revision.c                            |   90 +-
 revision.h                            |   44 +-
 t/t6015-rev-cache-list.sh             |  251 ++++
 14 files changed, 3942 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/git-rev-cache.txt
 create mode 100644 Documentation/technical/rev-cache.txt
 create mode 100644 builtin-rev-cache.c
 create mode 100644 rev-cache.c
 create mode 100644 rev-cache.h
 create mode 100755 t/t6015-rev-cache-list.sh
