From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v4 00/18] Reroll the line log series
Date: Fri,  6 Aug 2010 00:11:39 +0800
Message-ID: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Cc: trast@student.ethz.ch, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 18:12:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh33d-0000b0-H1
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758941Ab0HEQMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:12:32 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65010 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758933Ab0HEQMb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:12:31 -0400
Received: by pwj7 with SMTP id 7so143837pwj.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 09:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=BN6561cFf7kOnEx91oMRvhLue2PR65diPFDuGmC5or4=;
        b=RQVCXhcIYhl3xnJ0UX4TFEGX3y0b4/fUMncOkp+WFQMZXhuRoOxGbmoxPVA9miMD4e
         ivDIe7T1PeOjYPIjPYcdotuZN9mbhmBYMhBsf7bcSF+j4/PokSD2g5n+j4puFfqU5Iyw
         AmVxAPJBcReyDk/AakNEOuF8JE7ScyRTsOPSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=KzJOHX2dVDu9yDJ3gyUpIaBNCTWqlW2gEv6PQEmz4wFXwWyESXD+YFMQAZRnPl98Gq
         bNoHr5sfgxAKpHt5dV4NvUwhzoHVuA4ioN+k9RMi2eB7emj7twx4CikTg+E6yQBORknC
         1iY5eVlMgRXpApnmPYWCFw8brJ484pabxKlig=
Received: by 10.142.140.19 with SMTP id n19mr9312511wfd.241.1281024750773;
        Thu, 05 Aug 2010 09:12:30 -0700 (PDT)
Received: from localhost.localdomain ([222.35.120.192])
        by mx.google.com with ESMTPS id w8sm343653wfd.19.2010.08.05.09.12.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 09:12:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.20.g388bbb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152664>

Modifications:
1. We do the parent rewriting with a more sane way. Just like the way we deal with multiple pathspec pruning, we rewrite P to its parent P^, if P^ can take all the interesting ranges from P. Otherwise, we keep P.
2. --graph will not override --full-line-diff any more. Now, they are two totally different options. You can use --full-line-diff with or without --graph.
3. Bug fix, this includes:
   * --graph outputs correct graph lines
   * mark a commit as root one if it takes no ranges
   * some other minor fix...

Bo Yang (18):
  parse-options: enhance STOP_AT_NON_OPTION
  parse-options: add two helper functions
  Add the basic data structure for line level history
  Refactor parse_loc
  Parse the -L options
  Export three functions from diff.c
  Add range clone functions
  map/take range to the parent of commits
  Print the line log
  Hook line history into cmd_log, ensuring a topo-ordered walk
  Add tests for line history browser
  Make rewrite_parents public to other part of git
  Make graph_next_line external to other part of git
  Add parent rewriting to line history browser
  Add --graph prefix before line history output
  Add --full-line-diff option
  Add test cases for '--graph' of line level log
  Document line history browser

 Documentation/blame-options.txt     |   19 +-
 Documentation/git-log.txt           |   15 +
 Documentation/line-range-format.txt |   18 +
 Makefile                            |    2 +
 builtin/blame.c                     |   89 +--
 builtin/log.c                       |  111 +++-
 diff.c                              |    6 +-
 diff.h                              |   17 +
 diffcore.h                          |    1 +
 graph.c                             |   14 +-
 graph.h                             |   10 +
 line.c                              | 1563 +++++++++++++++++++++++++++++++++++
 line.h                              |  141 ++++
 parse-options.c                     |   22 +-
 parse-options.h                     |    7 +-
 revision.c                          |   25 +-
 revision.h                          |   23 +-
 t/t4301-log-line-single-history.sh  |  619 ++++++++++++++
 t/t4302-log-line-merge-history.sh   |  163 ++++
 19 files changed, 2736 insertions(+), 129 deletions(-)
 create mode 100644 Documentation/line-range-format.txt
 create mode 100644 line.c
 create mode 100644 line.h
 create mode 100755 t/t4301-log-line-single-history.sh
 create mode 100755 t/t4302-log-line-merge-history.sh

-- 
1.7.2.20.g388bbb
