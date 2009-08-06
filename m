From: "Nick Edelen" <sirnot@gmail.com>
Subject: [PATCH 0/5] Suggested for PU: revision caching system to
 significantly speed up packing/walking
Date: Thu, 06 Aug 2009 11:55:21 +0200
Message-ID: <op.ux8i6hrbtdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jeff King" <peff@peff.net>, "Sam Vilain" <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearc
X-From: git-owner@vger.kernel.org Thu Aug 06 11:55:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYzhB-0007x8-Lu
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 11:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbZHFJz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 05:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754758AbZHFJz0
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 05:55:26 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:47691 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbZHFJzY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 05:55:24 -0400
Received: by ewy10 with SMTP id 10so642311ewy.37
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 02:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:subject:from
         :content-type:mime-version:content-transfer-encoding:message-id
         :user-agent;
        bh=A0ipXHVwk/M405wg+lQ+m9H01kIddJoGoKJPFt3WYc8=;
        b=eJchMAoYLnv7+HJit3S93zC6qKsAyMQ5UnxCpfpj6mEpOhnjWzCL5FywoxxP+vmgvY
         dpIWMl5iIOJzrATTtuxu0fbAgRdj3VqGgkrhST8oyIpj3jE1oh6g8cazCB8sf+Tz/eOI
         rFFbpbLsLfuI/ClIzSy1QeKanl/69+WNWNdHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:subject:from:content-type:mime-version
         :content-transfer-encoding:message-id:user-agent;
        b=TpTdTnY8qSeGRK/hNVwJlHxnTIZF8xxi31VDX6pKyMsoT9SAY/dH6+zc47n+6O0rml
         E0Mh/Yk5+nt/VhU+iYEY71ye3mqHtYgbH1A25blOq54hpTGQDuFxn8h1v4HSiFWi++9f
         TGdF6Luva5I8e8j4c1HC7rLqbacIBgSCCZhbM=
Received: by 10.210.28.4 with SMTP id b4mr11649775ebb.47.1249552523910;
        Thu, 06 Aug 2009 02:55:23 -0700 (PDT)
Received: from sirnot.private (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id 10sm2341081eyd.7.2009.08.06.02.55.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 02:55:23 -0700 (PDT)
User-Agent: Opera Mail/9.63 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125056>

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

 Documentation/rev-cache.txt           |   51 +
 Documentation/technical/rev-cache.txt |  336 ++++++
 Makefile                              |    2 +
 blob.c                                |    1 +
 blob.h                                |    1 +
 builtin-rev-cache.c                   |  284 +++++
 builtin.h                             |    1 +
 commit.c                              |    3 +
 commit.h                              |    2 +
 git.c                                 |    1 +
 list-objects.c                        |   49 +-
 rev-cache.c                           | 1832 +++++++++++++++++++++++++++++++++
 revision.c                            |   89 ++-
 revision.h                            |   46 +-
 t/t6015-rev-cache-list.sh             |  228 ++++
 t/t6015-sha1-dump-diff.py             |   36 +
 16 files changed, 2937 insertions(+), 25 deletions(-)
 create mode 100755 Documentation/rev-cache.txt
 create mode 100755 Documentation/technical/rev-cache.txt
 create mode 100755 builtin-rev-cache.c
 create mode 100755 rev-cache.c
 create mode 100755 t/t6015-rev-cache-list.sh
 create mode 100755 t/t6015-sha1-dump-diff.py
