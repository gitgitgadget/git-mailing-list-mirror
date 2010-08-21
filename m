From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v6 0/9] detached-stash: regularise handling of stash arguments by git stash
Date: Sat, 21 Aug 2010 14:08:55 +1000
Message-ID: <1282363744-4924-1-git-send-email-jon.seymour@gmail.com>
Cc: j6t@kdbg.org, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 21 06:09:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmfOi-0006eW-Go
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 06:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099Ab0HUEJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 00:09:32 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:37067 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab0HUEJa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 00:09:30 -0400
Received: by pxi10 with SMTP id 10so1481994pxi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 21:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=WJisGZs3RYBocD17aqbykWb8X4eOUuPnT5IK+obZe+g=;
        b=NiKd7GHjfIjz7mbgjWsh7A8OiNWmQcmWIb9l26TiAAJNROvV3p7uPaIeHHx8qBIjTv
         664tGH9JaWuwJjXN8jfzn7Oei1jBg5dizZjC1JPWT8rqwOteVP+Iara/mityOTGd4pm9
         zt8MvStTFzk/SLLKMAS1EEndEmDGYpV7DB2gM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=I6o4QVQMGVLxZiw4aQjCA/iPKYpAItVi5rU4YfUuy6yFAiCgB2y6RUOboW3ocltE/C
         +c9N8j+AyqXLKfF+N9/czAya81901ebZjImcMVi00qPsXcw6DIIF8mrTnUu4mrTm5szG
         LDgBp78dvmbCBmyVu5X4XjxcpIFt3edndGpg4=
Received: by 10.142.232.13 with SMTP id e13mr1895879wfh.87.1282363770179;
        Fri, 20 Aug 2010 21:09:30 -0700 (PDT)
Received: from localhost.localdomain (124-169-98-91.dyn.iinet.net.au [124.169.98.91])
        by mx.google.com with ESMTPS id z1sm4208931wfd.3.2010.08.20.21.09.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 21:09:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.110.g34f32
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154098>

This patch introduces a common flags and revision parsing function to the following git stash commands:
 * apply
 * branch
 * pop
 * drop
 * show

With these changes, git stash now:
 * allows non-stash log entry references to passed to 'stash branch' provided they are stash-like
 * relaxes the requirement that a stash log currently entry exists for 'stash show' or 'stash branch' 
 * does not attempt to drop the specified revision if it doesn't look like a stash log entry reference
 * fails 'stash pop' and 'stash drop' early if the specified revision is not a stash log entry reference
 * fails early if more than one stash-like commit is specified
 * fails early if the specified revision is of the form ref@{n} and ref exists, but ref@{n} does not exist
 * reports various error conditions that can occur across multiple commands with consistent error messages.

The implementation of several commands is simplified to a lesser or greater degree by taking
advantage of the new common parsing and validation function, parse_flags_and_rev(). 

This revision incorporates feedback and corrections from Johannes Sixt and Junio Hamano. 

Version 5 differed from Version 4 by introducing a common parsing function and refactoring to
take advantage of that.

Version 6 differs from Version 5 by cleaning up and rationalising the new tests and splitting
out a commit (2/9) that is only required to work around an issue with git rev-parse. 

2/9 of this series may be elided if this series is applied on top of the series:

   "rev-parse: improve reporting of invalid log references"

Jon Seymour (9):
  detached-stash: introduce parse_flags_and_revs function
  detached-stash: work around git rev-parse failure to detect bad log refs
  detached-stash: simplify stash_apply
  detached-stash: simplify stash_drop
  detached-stash: refactor git stash pop implementation
  detached-stash: simplify git stash branch
  detached-stash: simplify git stash show
  detached-stash: tests of git stash with stash-like arguments
  detached-stash: update Documentation

 Documentation/git-stash.txt |   16 ++-
 git-stash.sh                |  223 ++++++++++++++++++++++++++++---------------
 t/t3903-stash.sh            |  112 ++++++++++++++++++++++
 3 files changed, 268 insertions(+), 83 deletions(-)

-- 
1.7.2.1.110.g34f32
