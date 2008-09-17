From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI,GITK) 0/8] Encoding support in GUI
Date: Thu, 18 Sep 2008 01:07:31 +0400
Message-ID: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 23:11:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg4Ho-0003CH-4H
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 23:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbYIQVI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 17:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbYIQVI6
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 17:08:58 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:64041 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbYIQVI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 17:08:57 -0400
Received: by mu-out-0910.google.com with SMTP id g7so2497212muf.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 14:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=j19VYXPymTLr/wV5mnNDGLeNG/oAtsJ8wYII3g5fPOI=;
        b=SjQD5sUVVtnoqtsH55f15FGClDq4Z3kCUNbjT7BedKAeQZZnYWd/kFXt/2974f4g+H
         GuP6I+B0UVce6+Vz8Wec0ODRiJo5ZtRwyYCeUWDD3p9hVlAZLWIPHxU+vxTSSsxuJp6l
         rJ/Fjsbc3UcQlV+py/SKmhMi4tjGFtvpf8Gbc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=OtB1THC43V5tEPB7JdvI0WtkwP/tb5R4jeAd8APUOb2mM7R9pSWk8Yb4vZxO7G0FeG
         xxtok4EyWibjBXD7MIH5b+p4FNCCLoi9IdRIZaSLsn9C1zYAv8JGAUHhZaysfXieNUt/
         DncAn2bCuNTLqu2LCuGSJFYUHoLurblaHJrDQ=
Received: by 10.180.230.6 with SMTP id c6mr2350113bkh.27.1221685735321;
        Wed, 17 Sep 2008 14:08:55 -0700 (PDT)
Received: from localhost.localdomain ( [92.255.85.78])
        by mx.google.com with ESMTPS id z10sm17426586fka.15.2008.09.17.14.08.53
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Sep 2008 14:08:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96137>


Currently GUI tools don't provide any support for
viewing files that contain non-ASCII characters. This set of
patches addresses that issue. The git-gui part of the series
is based on patches that are currently in the 'pu' branch
of the git-gui repository.


File encoding can be specified in the following ways:

1) It defaults to the current locale encoding.
2) It can be overridden by setting the gui.encoding option.
3) It can be further set on per-file basis by specifying
   the 'encoding' attribute in gitattributes.
4) Finally, git-gui allows directly selecting encodings
   through a popup menu.


The last item is a necessity to compensate for the fact that
now staging/unstaging hunks would not work, if the selected
encoding is incompatible with the actual data:

While most single-byte character sets are mutually compatible,
all multibyte encodings, including utf-8, have the concept
of invalid byte sequences, and thus are not completely
reversible. Because of this, git-gui won't be able to apply
hunks that contain such sequences, and the user would have to
specify the encoding correctly, or fallback to ISO-8859-1.


Since git apparently cannot work with filenames in non-locale
encodings anyway, I did not try to do anything about it apart
from fixing some obvious bugs.

There are also some bugs in handling of commit encodings in gitk,
but they are out of the scope of this series.



GIT-GUI:
	git-gui: Cleanup handling of the default encoding.
	---
	git-gui.sh       |    1 +
	lib/blame.tcl    |    2 +-
	lib/diff.tcl     |   11 ++++++-----
	lib/encoding.tcl |   14 ++++++++++++++
	lib/option.tcl   |   24 ++++++++++++++++++++++++
	5 files changed, 46 insertions(+), 6 deletions(-)

	git-gui: Add a menu of available encodings.
	---
	lib/encoding.tcl |  133 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
	lib/option.tcl   |   13 +++++-
	2 files changed, 142 insertions(+), 4 deletions(-)

	git-gui: Allow forcing display encoding for diffs using a submenu.
	---
	git-gui.sh       |    8 ++++++++
	lib/diff.tcl     |    9 +++++++++
	lib/encoding.tcl |   29 +++++++++++++++++++++++++++--
	3 files changed, 44 insertions(+), 2 deletions(-)

	git-gui: Optimize encoding name resolution using a lookup table.
	---
	lib/encoding.tcl |   82 +++++++++++++++++++++++++++++++++++-------------------
	1 files changed, 53 insertions(+), 29 deletions(-)

	git-gui: Support the encoding menu in gui blame.
	---
	lib/blame.tcl |   17 +++++++++++++++++
	1 files changed, 17 insertions(+), 0 deletions(-)


GITK:
	gitk: Port new encoding logic from git-gui.
	---
	gitk |   50 +++++++++++++++++++++++++++++++++++++++++++++++---
	1 files changed, 47 insertions(+), 3 deletions(-)

	gitk: Implement file contents encoding support.
	---
	gitk |   19 ++++++++++++++++---
	1 files changed, 16 insertions(+), 3 deletions(-)

	gitk: Support filenames in the locale encoding.
	---
	gitk |   16 +++++++++++-----
	1 files changed, 11 insertions(+), 5 deletions(-)
