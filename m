From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [BUG, PATCH 0/3] Fix {blame,cat-file} --textconv for cases with symlinks
Date: Sat, 18 Sep 2010 21:25:03 +0400
Message-ID: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 18 19:23:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ox18e-0005BL-1V
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 19:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421Ab0IRRX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 13:23:29 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:33038 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab0IRRX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 13:23:28 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 9E762FF66F; Sat, 18 Sep 2010 21:23:27 +0400 (MSD)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.72)
	(envelope-from <kirr@roro3.zxlink>)
	id 1Ox1A0-0001cc-OC; Sat, 18 Sep 2010 21:25:12 +0400
X-Mailer: git-send-email 1.7.3.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156465>

Recently I've spot a bug in git blame --textconv, which was wrongly
calling pdftotext (my *.pdf conversion program) on a symlink.pdf, and I
was getting something like

    $ git blame -C -C regular-file.pdf
    Error: May not be a PDF file (continuing anyway)
    Error: PDF file is damaged - attempting to reconstruct xref table...
    Error: Couldn't find trailer dictionary
    Error: Couldn't read xref table
    Warning: program returned non-zero exit code #1
    fatal: unable to read files to diff

That errors come from pdftotext run on symlink.pdf being extracted to
/tmp/ with one-line plain-text content pointing to link destination.

First 2 patches demonstrate the problem (and are ready to go into git.git),
though third, while working for me, is only an RFC.

Thanks,
Kirill


Kirill Smelkov (3):
  tests: Prepare --textconv tests for correctly-failing conversion
    program
  blame,cat-file: Demonstrate --textconv is wrongly running converter
    on symlinks
  RFC: blame,cat-file --textconv: Don't assume mode is ``S_IFREF |
    0664''

 builtin.h                        |    2 +-
 builtin/blame.c                  |   33 ++++++++++++++-------
 builtin/cat-file.c               |    2 +-
 sha1_name.c                      |    3 +-
 t/t4042-diff-textconv-caching.sh |   25 ++++++++--------
 t/t8006-blame-textconv.sh        |   57 +++++++++++++++++++++++++++++++++----
 t/t8007-cat-file-textconv.sh     |   38 ++++++++++++++++++++++---
 7 files changed, 122 insertions(+), 38 deletions(-)

-- 
1.7.3.rc2
