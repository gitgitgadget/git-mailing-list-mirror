From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v3 0/3] Help merging when text has been normalized
Date: Thu, 24 Jun 2010 22:44:29 +0200
Message-ID: <cover.1277408598.git.eyvind.bernhardsen@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 22:44:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORtHy-0001Jz-FN
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 22:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab0FXUok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 16:44:40 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59944 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab0FXUoj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 16:44:39 -0400
Received: by wyi11 with SMTP id 11so2028120wyi.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 13:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=TEqjkvaMi1n8k7qpREHHUN3TAiRoUuXmcKMoqabumDk=;
        b=CdPc99a4HA7Kja+jvZGEgi/c7BA3iGdaBf90n1Hk2NEWLTBlqCpy2d7fKmThYyKDUv
         GXmALpYTLPFnzu+IixElOfbERue6bjNUeawbyeflhE0qvd0QtnIRJDignnkG2CM3CMLi
         NBjDyjNnozrR2sB4eJXWLRLr7wOeL2hbT8XH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=l6eaAjtZilC+9Ha10vpw1KxBJkWBbVj213Nr2G7OKE3EpCsaUPAjage7PeHrNKA5bO
         9K0dvf/Ke7qHDFGx2bPQ1RAnAO4ZDtkG7xqG5ZU+WKa0du8IfDNjAXC5D9CmX+CXRiQJ
         TLuO5nQfGRU/b1hAMrHCXEudt46gMLC8AZfNo=
Received: by 10.227.135.6 with SMTP id l6mr9535553wbt.60.1277412277833;
        Thu, 24 Jun 2010 13:44:37 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id t15sm34373334wbc.17.2010.06.24.13.44.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 13:44:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.575.g383de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149642>

Here's a slightly expanded series based on my ll-merge normalization
patch.  I've been working in a repository that uses "* text=auto" at
$dayjob, and this series helps a lot when merging older,
pre-normalization branches.

The first commit is a cleaned-up version of the previous patch.  I
borrowed Finn Arne's explanation for why it's useful for my commit
message, ASCII art and all.  The idea is pretty simple: normalization
might differ between branches, so renormalization is required to prevent
(or at least reduce) conflicts.

The second fixes a similar problem, but for delete/modify conflicts.  If
a file is normalized on a branch but deleted in another, merging the
branches will cause a conflict even though the actual content of the
file hasn't changed at all.

If the merge-base version of the file and the modified file differ they
are both normalized, and if either was changed by normalization they are
compared.  If they compare equal, the file is considered unmodified and
is deleted.

The third patch prevents normalization from expanding and then
collapsing CRLFs, saving time and memory when core.autocrlf=true or
core.eol=crlf.

- Eyvind

Eyvind Bernhardsen (3):
  Avoid conflicts when merging branches with mixed normalization
  Try normalizing files to avoid delete/modify conflicts when merging
  Don't expand CRLFs when normalizing text during merge

 cache.h                    |    1 +
 convert.c                  |   27 ++++++++++++++++----
 ll-merge.c                 |   12 +++++++++
 merge-recursive.c          |   42 ++++++++++++++++++++++++++++++-
 t/t6038-merge-text-auto.sh |   58 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 133 insertions(+), 7 deletions(-)
 create mode 100755 t/t6038-merge-text-auto.sh

-- 
1.7.1.575.g383de
