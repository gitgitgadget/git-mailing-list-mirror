From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 0/4] remote HEAD improvements take 2
Date: Fri, 13 Feb 2009 03:54:31 -0500
Message-ID: <1234515275-91263-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, peff@peff.net,
	gitster@pobox.com, barkalow@iabervon.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 09:56:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXtqC-0003ao-33
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 09:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbZBMIyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 03:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbZBMIyj
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 03:54:39 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:49917 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbZBMIyi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 03:54:38 -0500
Received: by yx-out-2324.google.com with SMTP id 8so587057yxm.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 00:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=nIQLJjIj86amtjTDQpCETr7TVy7ndVugyj7Ic1gsdcs=;
        b=MlcRc8WVr8UtqrthO/k7IoX4QdlrpQT4vvxbTlp2dyZgwDP9Q8sHsEoVM0vx8E4B9r
         SHitdlkw45LmkS/m+5lmJrQEQb5AfGCFOYmKXn4U2ydOmdEfsrAhnJR+30qPkGcu8IJ+
         88EOBxZg+U1kEcFGAkRaFaYExpmt7yNm7HYxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=aypD24K8s3nYJd/dtbPoLcCAfX5TKYtowL7PXlUkk+6Ab3K3k9wExTj8+1hpnshlJR
         iCBgkGy+EZpVFJkKYInhlFcYUjV/aNLwYJwfaOSG6gTQd0vbXCfeXdv933Iiue6gi2zd
         BB8k7M3rpWIeI+6Ugo/HVdYkmIr6RivhFpEnI=
Received: by 10.100.144.11 with SMTP id r11mr2507184and.24.1234515277294;
        Fri, 13 Feb 2009 00:54:37 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d24sm2170345and.50.2009.02.13.00.54.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 00:54:36 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.209.g7c178
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109729>

There is currently no porcelain for dealing with remote HEADs (i.e.
$GIT_DIR/remotes/<remote>/HEAD). This series:

1) Refactors locate_head() from builtin-clone.c to remote.c so it can be used
   by builtin-remote.c as well. I also renamed it to guess_remote_head().

   Daniel suggested having it specifically check that it returns a ref from
   refs/heads/, but I wasn't sure what impact that might have (good or
   bad...), so I punted on that change.

2) Teaches git remote show to display the remote HEAD:

  $ git remote show origin

* remote origin
  URL: git://git.kernel.org/pub/scm/git/git.git
  HEAD: master

3) Teaches git remote a new "set-head" verb:

  To set a remote HEAD explicitly:
  $ git remote set-head <name> <branch>

  To set a remote HEAD to match the upstream repo:
  $ git remote set-head <name> -a

  To delete a remote HEAD:
  $ git remote set-head <name> -d

  I changed it from "sethead" to "set-head" per Jeff.

  I also remembered to update git-completion.bash this time.

4) Documents the new set-head verb. I also correct the git remote man page
   w/respect to the "-m <master>" option. The man page implied that the remote
   HEAD was set automatically when adding a remote (a la git clone), but this
   is not true. And, since I couldn't find anywhere else that the point of
   having a remote HEAD is documented, I documented it here.

Jay Soffian (4):
  builtin-clone: move locate_head() to remote.c so it can be re-used
  builtin-remote: move duplicated cleanup code its own function
  builtin-remote: teach show to display remote HEAD
  builtin-remote: add set-head verb

 Documentation/git-remote.txt           |   20 ++++++-
 builtin-clone.c                        |   41 +-------------
 builtin-remote.c                       |   96 +++++++++++++++++++++++++++++---
 contrib/completion/git-completion.bash |    2 +-
 remote.c                               |   37 ++++++++++++
 remote.h                               |    9 +++
 6 files changed, 156 insertions(+), 49 deletions(-)
