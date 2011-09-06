From: Wang Hui <Hui.Wang@windriver.com>
Subject: [PATCH v2 0/5] sha1_file: remove only current repository can have relative path limitation
Date: Tue, 6 Sep 2011 18:24:00 +0800
Message-ID: <1315304645-12009-1-git-send-email-Hui.Wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
To: <gitster@pobox.com>, <git@vger.kernel.org>, <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue Sep 06 12:24:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0sp5-0003wz-8k
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 12:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552Ab1IFKYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 06:24:00 -0400
Received: from mail.windriver.com ([147.11.1.11]:61484 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299Ab1IFKX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 06:23:58 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p86ANmJR005015
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 6 Sep 2011 03:23:48 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.220) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.1.255.0; Tue, 6 Sep 2011 03:23:48 -0700
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180787>

Hi Junio & Martin,

In the V1, Junio said we should investigate why the limitation is originally
designed. This limitation is introduced by Martin in the 2006, so add him
at this time, hope he can share some information and knowledge for this
question although he is not seen in the maillist recently.

Below is my investigation:

In the link_alt_odb_entry(), each alt object path will be added to the struct
alternate_object_database and linked to a list, but we don't permit a same dir
is added twice, otherwise it will easily introduce lots of trouble like
dead-loop reference. To compare if two directories are same, original design
is using memcmp() to directly compare directory path names, this method can't
give a accurate result if paths include .. and multiple slash, e.g. ../../a
and ../../b/../a is the same dir, but this method will report they are
different. Knowing the reason, i implement a new direcotry comparison function
to replace the old one, then we can safely remove multi-level relative
alternates limitation now.


0001 is a simple cleanup patch, has no relation with multi-level relative
limitation.
0002 is a bug fix, has no relation with multi-level relative limitation.
Without this fix, all tests under t/ can work well so far, this is because we
are lucky that the ent->base[pfxlen+1] is 0, if it is not 0, we will see lots
of fails. After apply this fix, it is safe now.
0003 introduce a new directory comparison function to replace the old one.
0004 remove the multi-level relative alternates limitation
0005 change and add testcase to validate multi-level relative alternates.


after apply those 5 patches, all testcase under t can pass.

Hui Wang (5):
      sha1_file cleanup: remove redundant variable check
      sha1_file: remove a buggy value setting
      sha1_file: improve directories comparison method
      sha1_file: remove relative entries limitation
      t5710: add testcase for multi-level relative alternates

 abspath.c                 |   26 ++++++++++++++++++++++++++
 cache.h                   |    1 +
 sha1_file.c               |   22 +++++++---------------
 t/t5710-info-alternate.sh |   21 +++++++++++++++++++--
 4 files changed, 53 insertions(+), 17 deletions(-)
