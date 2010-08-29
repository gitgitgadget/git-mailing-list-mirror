From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 00/13] remote helper improvements
Date: Sat, 28 Aug 2010 22:45:27 -0500
Message-ID: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 05:46:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpYqm-0006e4-DA
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 05:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857Ab0H2DqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 23:46:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38975 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766Ab0H2DqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 23:46:09 -0400
Received: by iwn5 with SMTP id 5so3824467iwn.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 20:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=fjt4RcSx417ZDlKF2iyHgJVm86aG8agxilFnx1iNImY=;
        b=oGEHTfKgR4RHApAS+vRK1R8HXNX78cg1ZZPVosYFoQrYpRyCCuDvYTSIBBZWP/U2FK
         hGDFYjqCTi+tE3GV+LjqebateKpCcgUtxWZiwCEIvdWRLXSlwtCKELnSXhIvPXfQdJlk
         pBTC0kOAIzKxeXaOPjeDeHmXzsSFbKRJQxvzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=hTbSfRvPrx7aVnpzg/jkUQii0UIQUmYspCVoY5+YRbuBDnhq7UGAn6wZuuUlAuUl2H
         er4L3pPk3eSZiGmisSm7Jan1GumtSGelQSVoyqrrYOGc3nSzQv7HyIv907qG2VXUjrti
         fBMwYCD1AlIsF5IjiwSdBnAm6Er1kixUbBx7o=
Received: by 10.231.10.132 with SMTP id p4mr3322761ibp.67.1283053568143;
        Sat, 28 Aug 2010 20:46:08 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-237-184-184.dsl.chcgil.sbcglobal.net [76.237.184.184])
        by mx.google.com with ESMTPS id n20sm5647049ibe.17.2010.08.28.20.46.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 20:46:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.240.g6a95c3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154669>

I had a week and then some stray days here and there to do some more
work on git-remote-hg, the result of which is this series. It takes
the 'import' and 'export' commands out of their 'toy' stage, and gets
them ready for real usage. Although 'git-remote-testgit' is still the
only thing using them, 'git-remote-hg' is nearing completion, I hope
to send out an RFC for it Real Soon Now (TM).

Sverre Rabbelier (13):
      fast-import: add the 'done' command
      fast-export: support done feature

These two are very important to the rest of the series, most of the
clean up relies on the 'done' command to make 'import/export' part of
the remote helper protocol not suck.

      transport-helper: check status code of finish_command
      remote-curl: accept empty line as terminator

If nothing else is applied, these two should be taken out together
and applied separately.

      transport-helper: factor out push_update_refs_status
      transport-helper: update ref status after push with export

This is not very fleshed out yet, (the second patch in particular),
but without this 'git push' to a remote that uses the 'export'
capability will always say 'everything up-to-date'.

      transport-helper: use the new done feature to properly do imports
      transport-helper: export should disconnect too

These two make the 'import' and 'export' command re-entrant. That is,
now the remote helper infrastructure could issue other commands after
issuing an 'import' or 'export' command.

      transport-helper: change import semantics

This is another cleanup to the protocol, without this it is more or
less impossible to import multiple refs.

      transport-helper: Use capname for gitdir capability too

This is a candidate for for maint, the current implementation is just
plain wrong.

      transport-helper: implement marks location as capability

Another protocol cleanup.

      git-remote-testgit: only push for non-local repositories
      git-remote-testgit: fix error handling

Both of these are maint candidates, they are bugfixes.

 Documentation/git-fast-export.txt  |    4 ++
 Documentation/git-fast-import.txt  |   17 ++++++-
 builtin/fast-export.c              |    9 +++
 fast-import.c                      |    5 ++
 git-remote-testgit.py              |   50 +++++++++++++------
 git_remote_helpers/git/importer.py |    5 +-
 remote-curl.c                      |    3 +
 transport-helper.c                 |   97 +++++++++++++++++++----------------
 8 files changed, 127 insertions(+), 63 deletions(-)
