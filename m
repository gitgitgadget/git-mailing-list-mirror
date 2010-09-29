From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [BUG, PATCH v5 0/3] Fix {blame,cat-file} --textconv for cases with symlinks
Date: Wed, 29 Sep 2010 15:35:21 +0400
Message-ID: <cover.1285758714.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 13:34:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0uvc-00072Z-Pq
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 13:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583Ab0I2LeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 07:34:16 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:59089 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466Ab0I2LeP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 07:34:15 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1P0uuL-0003ex-J5; Wed, 29 Sep 2010 15:33:10 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1P0uwY-0001QT-GD; Wed, 29 Sep 2010 15:35:26 +0400
X-Mailer: git-send-email 1.7.3.19.g3fe0a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157553>

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


Please apply and thanks,
Kirill


P.S. I'm sorry if this time there is again some bug on my side...


v5:

 o Avoid touching t4042 at all
 o Change $@ to $1 in textconv helper directly in patch1

v4:

 o add prereq on SYMLINKS in tests
 o Use consistent pattern for detecting and converting binaries (was 'bin:' and
   'bin: ')
 o avoid using $@ in textconv helper - it gets only one argument

v3:

 o Slightly changed patches descriptions as per comment by Matthieu, and added
   Matthieu's Reviewed-by.

v2:

 o Incorporated suggestions by Matthieu and Jeff (details in each patch)

Kirill Smelkov (3):
  tests: Prepare --textconv tests for correctly-failing conversion
    program
  blame,cat-file: Demonstrate --textconv is wrongly running converter
    on symlinks
  blame,cat-file --textconv: Don't assume mode is ``S_IFREF | 0664''

 builtin.h                    |    2 +-
 builtin/blame.c              |   33 +++++++++++++++-------
 builtin/cat-file.c           |    2 +-
 sha1_name.c                  |    2 +
 t/t8006-blame-textconv.sh    |   62 +++++++++++++++++++++++++++++++++++++-----
 t/t8007-cat-file-textconv.sh |   38 ++++++++++++++++++++++---
 6 files changed, 114 insertions(+), 25 deletions(-)

-- 
1.7.3.19.g3fe0a
