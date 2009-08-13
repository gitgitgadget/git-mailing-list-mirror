From: "Nick Edelen" <sirnot@gmail.com>
Subject: [PATCH 0/6 (v3)] Suggested for PU: revision caching system to
 significantly speed up packing/walking
Date: Thu, 13 Aug 2009 12:24:23 +0200
Message-ID: <op.uyli6p2dtdk399@sirnot.belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.net>,
	"Michael J Gruber" <git@drmic
X-From: git-owner@vger.kernel.org Thu Aug 13 12:30:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbXZI-0003Zl-RK
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 12:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbZHMK3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 06:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbZHMK3y
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 06:29:54 -0400
Received: from mail-ew0-f227.google.com ([209.85.219.227]:62871 "EHLO
	mail-ew0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbZHMK3x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 06:29:53 -0400
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Aug 2009 06:29:43 EDT
Received: by mail-ew0-f227.google.com with SMTP id 27so684318ewy.40
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 03:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:subject:from
         :content-type:mime-version:content-transfer-encoding:message-id
         :user-agent;
        bh=49t2t+UXEn8n82p7hn25jvYaCFHVAIqpNnMRiVY240M=;
        b=s5HHW8CwjGhT4AT+60dVGoBKfwmSoVxXN8Mlb8Bu/UV4SmUFqXRXk+j61YIit0RWFk
         XGWRZkPrueJkypvTDpzpDCrYqH0Z7nRJy2RdMQOs8v1Bi02+Hn24XtQpKRXjPMDLHJZI
         FcsdYU88oyL8cbrpjjjBKxmro7DLMhonWe0TI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:subject:from:content-type:mime-version
         :content-transfer-encoding:message-id:user-agent;
        b=UKzPkjudygIW4BcCOHL1+gBSWTJ3o0RO1tLU0+a6jHHuOHdXd2jMH4s+XxTws51Cfu
         iZELUfwrZT/2gKBwS/tvJXRleHbCZTfMDBCrBKPg+6MuoKI8z8OzckeeRLnwSQrXuXd6
         ce3rdK+W8moM7DfzNP5t2JxLojdkM/PJVf51k=
Received: by 10.211.179.6 with SMTP id g6mr1423492ebp.65.1250159070279;
        Thu, 13 Aug 2009 03:24:30 -0700 (PDT)
Received: from sirnot.belkin (client-86-0-116-245.nrth.adsl.virgin.net [86.0.116.245])
        by mx.google.com with ESMTPS id 24sm2276467eyx.53.2009.08.13.03.24.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Aug 2009 03:24:29 -0700 (PDT)
User-Agent: Opera Mail/9.63 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125797>

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
What I've changed in this revision set:
 - revise and add much to the documentation
 - add support for cache pointers, sorta like object alternates
 - change --noobjects to --no-objects
 - default --ignore-size to revcache.ignoresize if set, 50MB if not
   (pack.windowmemory tended to be too large and too variable for slice usage)
 - change init_rci to init_rev_cache_info
 - modify make_cache_slice to send back actual starts/ends
 - change coag_ to fuse_
 - prefix structures with rev-cache-specific identifier
 - increase size of merge_nr (split_nr?)
 - replace paths_to_dec and children_to_close with single tracking stack in
   path generation
 - add fuse to gc based on configuration variable gc.revcache
 - bailout on obscenely large merges/branches (i.e. more than we can handle)
 - tweak struct bitfields for greater portability
 - replace parse_size with git's version
 - revise fuse to directly use object stores rather than load them into memory
 - move structures to own header
 - fix permissions
 - clean up patchset

I didn't completely remove the bitfields from the structures, but altered them
to each fit in a single byte.  Completely removing them would cause a lot of
trouble, and I figure eliminating the byte-overlap would make for sufficient
portability for storage that's supposed to be transient anyway.

 Documentation/git-rev-cache.txt       |  144 +++
 Documentation/technical/rev-cache.txt |  594 +++++++++
 Makefile                              |    2 +
 builtin-gc.c                          |    9 +
 builtin-rev-cache.c                   |  322 +++++
 builtin.h                             |    1 +
 commit.c                              |    2 +
 git.c                                 |    1 +
 list-objects.c                        |   49 +-
 rev-cache.c                           | 2217 +++++++++++++++++++++++++++++++++
 rev-cache.h                           |  100 ++
 revision.c                            |   89 ++-
 revision.h                            |   44 +-
 t/t6015-rev-cache-list.sh             |  251 ++++
 tree.h                                |    1 +
 15 files changed, 3801 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/git-rev-cache.txt
 create mode 100644 Documentation/technical/rev-cache.txt
 create mode 100644 builtin-rev-cache.c
 create mode 100644 rev-cache.c
 create mode 100644 rev-cache.h
 create mode 100755 t/t6015-rev-cache-list.sh
