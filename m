From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH v2 0/5] Speed up string search routines
Date: Sun, 21 Aug 2011 00:40:03 +0200
Message-ID: <20110820224003.GA2199@fredrik-Q430-Q530>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bonzini@gnu.org, dpotapov@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 21 00:40:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuuDD-0007ng-5S
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 00:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232Ab1HTWkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 18:40:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53303 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153Ab1HTWkI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 18:40:08 -0400
Received: by bke11 with SMTP id 11so2936857bke.19
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 15:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=mJHYvW+BTL3vZFbRkeMHdvJ5N7l3kxSAdrjIoKiF+ME=;
        b=D9Fb+Si3XXuwt8ddgLNqYvgaV1pW0rY8b3xvheuG1uiMwYzNkYamtV4OIwFQDafZ+M
         AbQjHhKNhBJsD98euQit43fXpHRDRAyg58xskRhkOR9bgxLUOD7393wo1AEc9eId0EPu
         gPjbXeqLRZvGFhUiebls/gBSzx5dgWIAPCvFU=
Received: by 10.204.135.141 with SMTP id n13mr316678bkt.288.1313880007071;
        Sat, 20 Aug 2011 15:40:07 -0700 (PDT)
Received: from fredrik-Q430-Q530 (c83-250-151-53.bredband.comhem.se [83.250.151.53])
        by mx.google.com with ESMTPS id m24sm1444581bkm.0.2011.08.20.15.40.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 20 Aug 2011 15:40:06 -0700 (PDT)
Content-Disposition: inline
User-Agent: StGit/0.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179786>

This is v2 of a series sent a long time ago, in February 2010. The
patches speed up git grep and pickaxe by using the string search
routines from GNU grep.

Changes since v1:

* Rebased on top of current master.

* obstack.[ch] is now in compat/ (comment by Junio)

* kwset.[ch] is from the latest GNU grep commit which uses GPLv2. The
  newer commits uses GPLv3, which is incompatible with GPLv2 used by
  Git. There are no significant changes between the two. (pointed out
  by Dmitry Potapov and Paolo Bonzini)

* Two new tests for git grep are fixed by this code, see patch 5 for
  details.

In v1 Paolo pointed out that the kwset code is never used with more
than one string and therefore a much simpler Boyer-Moore search would
be sufficient (a kwset containing only one string uses a Boyer-Moore
search). However, the Boyer-Moore search implemented in kwset cannot
deal with case-insensitive searches, so the more complicated code is
still there.

---

Fredrik Kuivinen (5):
      Add obstack.[ch] from EGLIBC 2.10
      Add string search routines from GNU grep
      Adapt the kwset code to Git
      Use kwset in pickaxe
      Use kwset in grep


 Makefile               |    4 
 compat/obstack.c       |  441 +++++++++++++++++++++++++++
 compat/obstack.h       |  509 ++++++++++++++++++++++++++++++++
 diffcore-pickaxe.c     |   34 +-
 grep.c                 |   66 +++-
 grep.h                 |    2 
 kwset.c                |  771 ++++++++++++++++++++++++++++++++++++++++++++++++
 kwset.h                |   63 ++++
 t/t7008-grep-binary.sh |    4 
 9 files changed, 1860 insertions(+), 34 deletions(-)
 create mode 100644 compat/obstack.c
 create mode 100644 compat/obstack.h
 create mode 100644 kwset.c
 create mode 100644 kwset.h
