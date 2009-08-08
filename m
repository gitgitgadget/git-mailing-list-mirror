From: "Nick Edelen" <sirnot@gmail.com>
Subject: [PATCH 0/6 (v2)] Suggested for PU: revision caching system to
 significantly speed up packing/walking
Date: Sat, 08 Aug 2009 09:31:29 +0200
Message-ID: <op.uyb1uryftdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.net>,
	"Michael J Gruber" <git@drmic
X-From: git-owner@vger.kernel.org Sat Aug 08 09:31:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZgP2-0007W5-Kk
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 09:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbZHHHbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 03:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754566AbZHHHbg
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 03:31:36 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:49896 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754515AbZHHHbg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 03:31:36 -0400
Received: by ey-out-2122.google.com with SMTP id 9so629316eyd.37
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 00:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:subject:from
         :content-type:mime-version:content-transfer-encoding:message-id
         :user-agent;
        bh=Zt3FLma3gJGQ/VbyJYBvKRzDIsVdEWoE9Lfst5Hjnik=;
        b=gkcFQWZEBU90ZtpYpMeZKK1ckxS1TfJZvnvtwAdVUjFFMde7EL+SNTeMhQCMpQkpyG
         GQ8MNKQfTo/je2pPc33neoZaM/0UR8BoiIGJk9NjQ/5XB5I8xIwA0WOEkoKhFQgTvVvM
         +HaCI0TSgFXDkzhW+aUhmrwznvN5E79YSf8CA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:subject:from:content-type:mime-version
         :content-transfer-encoding:message-id:user-agent;
        b=twU/a5bfPaTp2y2p5qTn/0e34wWNTQNnVN//lgOO3KJWCR5IXDLbHgHTs03fypCwHf
         u4SFtd6KJ34kINE6Xjxrzw4TxC6B59pOWhrX6VU3QoEneURMV86Cr6rdN0RE2sil43XA
         Ux5kmpxZqZl+12CLqy/nel1Rqrx5VsiKSiT1Q=
Received: by 10.210.87.2 with SMTP id k2mr2425780ebb.96.1249716695405;
        Sat, 08 Aug 2009 00:31:35 -0700 (PDT)
Received: from sirnot.private (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id 7sm4356878eyb.10.2009.08.08.00.31.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Aug 2009 00:31:35 -0700 (PDT)
User-Agent: Opera Mail/9.63 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125254>

SUGGESTED FOR 'PU': (patchset v2)

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
This is a revised patchset; the biggest changes are:
 - elimination of python dependency
 - revision of documentation
 - addition of name caching (patch 6)

 Documentation/git-rev-cache.txt       |   96 ++
 Documentation/technical/rev-cache.txt |  379 ++++++
 Makefile                              |    2 +
 blob.c                                |    1 +
 blob.h                                |    2 +
 builtin-rev-cache.c                   |  309 +++++
 builtin.h                             |    1 +
 commit.c                              |    3 +
 commit.h                              |    2 +
 git.c                                 |    1 +
 list-objects.c                        |   49 +-
 rev-cache.c                           | 2041 +++++++++++++++++++++++++++++++++
 revision.c                            |   89 ++-
 revision.h                            |   47 +-
 t/t6015-rev-cache-list.sh             |  246 ++++
 tree.h                                |    1 +
 16 files changed, 3244 insertions(+), 25 deletions(-)
 create mode 100755 Documentation/git-rev-cache.txt
 create mode 100755 Documentation/technical/rev-cache.txt
 create mode 100755 builtin-rev-cache.c
 create mode 100755 rev-cache.c
 create mode 100755 t/t6015-rev-cache-list.sh
