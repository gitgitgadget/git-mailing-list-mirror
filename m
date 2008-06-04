From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [WIP/RFC PATCH 0/2] Subtree checkout 1/2: introduce index prefix
Date: Wed, 4 Jun 2008 23:27:48 +0700
Message-ID: <20080604162748.GA23975@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 18:29:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3vqy-0001Pi-9d
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 18:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbYFDQ1z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2008 12:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752606AbYFDQ1z
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 12:27:55 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:4625 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbYFDQ1y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 12:27:54 -0400
Received: by wf-out-1314.google.com with SMTP id 27so134028wfd.4
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 09:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=WuCZ4SRlA0jS1lmfza/SSEMdbNRas1ms3f+pBDUbk5I=;
        b=Ka9OAkkkv4ldWt9fhMyrGN9pMwGL53OKm7Sbe3xPOuCMyL76F/SPmDbLanZb/hXe/K
         nsegm1dAS7fsZbXVyWPlIAoCUuxsuJTRquKXMsCo5+T9aK6yCsu3pDnqzAYYUfFtrhrK
         j8w43UgBUXPI+5Hj1dFrGk7OhTGP2Bh/hX/Ao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=UzgJHO5MQTvp38Vo2K+bTHlPwIV7+DoKAB0eGHPlOOopkId7JexWFWA4jUOENzpuJ9
         AkTn28t+R/0hjAxDRZnyh2eF7fmOrhht4XNzw1XgCrU3YAM281SnBEPa97SIoXljnfWE
         YATKqudeVYm+BkMe+w4SvDip8x2Tr109GviQs=
Received: by 10.142.164.10 with SMTP id m10mr52329wfe.60.1212596874258;
        Wed, 04 Jun 2008 09:27:54 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.6.88])
        by mx.google.com with ESMTPS id 22sm3242750wfd.19.2008.06.04.09.27.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Jun 2008 09:27:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed,  4 Jun 2008 23:27:48 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83793>

This is the first part for subtree checkout: restrict write access to
index.  The second part would be restrict/adjust access to working
directory so that it only needs part of full working directory to work
on. I would like to hear comments from people before heading to part 2.

As I understand, the hardest part is probably merging. My strategy is
quite simple: allow merge as long as no conflicts are outside index
prefix.

While it is done as part of subtree checkout. I think it can be also=20
used as a separate feature: working on a worktree where only a subtree
is to be worked on. One example is gentoo-x86 repository (~80k files).
I only work on a tree of dozen of files, but every time I do "git
status", ~100k stats will be issued. With this, it can be reduced to
about 20 stats.

So back to the topic. Is the approach broken? Do I miss anything that
can write outside index prefix? What else needs more test case?

Thanks

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  Introduce GIT_INDEX_PREFIX
  Add tests for index prefix

 builtin-merge-recursive.c               |    4 +-
 builtin-read-tree.c                     |    5 +
 builtin-rev-parse.c                     |    5 +
 builtin-update-index.c                  |    3 +
 cache.h                                 |    2 +
 environment.c                           |   12 ++
 read-cache.c                            |   84 ++++++++++++-
 t/t2300-index-prefix.sh                 |  207 +++++++++++++++++++++++=
++++++
 t/t2301-index-prefix-merge-recursive.sh |  221 +++++++++++++++++++++++=
++++++++
 unpack-trees.c                          |    3 +
 unpack-trees.h                          |    3 +-
 11 files changed, 545 insertions(+), 4 deletions(-)
 create mode 100755 t/t2300-index-prefix.sh
 create mode 100755 t/t2301-index-prefix-merge-recursive.sh
