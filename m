From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 0/8] Improve git-status --ignored
Date: Mon, 18 Mar 2013 21:28:20 +0100
Message-ID: <514778E4.1040607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 18 21:28:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHgfr-0001gW-Tb
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 21:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683Ab3CRU2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 16:28:23 -0400
Received: from mail-ea0-f182.google.com ([209.85.215.182]:54944 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947Ab3CRU2W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 16:28:22 -0400
Received: by mail-ea0-f182.google.com with SMTP id q15so2792494ead.13
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 13:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:content-type:content-transfer-encoding;
        bh=VNUn1T3ahQJNXZdHx8Iq/licq2TI2oLtJkKyayuEl4s=;
        b=hR9jEPQ/swdwbauGnuNazodzrzppLWYSOr6wY2JfIL6qDeJ9/RqmNdWkPxvIhcCsRK
         PrNjzDaCHTCtuTVy4L2VmqdscRFE/WlQzOfow1DeI/sJ6Cem8KtmKHG9DYf/lcT90VFE
         AqcbcM/ctcCrPgyGKwG3b5H98k0mlFjgrBvZVtG62tn+Y589BaYq/L8kxq52DKusFcC/
         WibxUcNUmzVaQ6QRY10xxfF+s/ttioJe+EqBeuPaJQ6gBUKBXl/4Rc4ng+OHi7RsBEjO
         MAOMQ+Yh5HXLWbxR2VHJ5QIIEszJD0pMxmsaNmo/rEvX0jYIFdHPyxA64469LSUx8zPy
         3D9A==
X-Received: by 10.14.207.73 with SMTP id m49mr52819073eeo.24.1363638501166;
        Mon, 18 Mar 2013 13:28:21 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id q5sm29260910eep.11.2013.03.18.13.28.19
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 13:28:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218440>

This patch series addresses several bugs and performance issues in .gitignore processing that came up in the inotify discussion.

Also available here:
https://github.com/kblees/git/tree/kb/improve-git-status-ignored
git pull git://github.com/kblees/git.git kb/improve-git-status-ignored


Patches 1 - 4 fix bugs in 'git-status --ignored' and add appropriate test cases.

Patches 5 - 7 eliminate the is_path_excluded API, in favor of a slightly improved and faster is_excluded. This speeds up 'git-ls-files --cached --ignored' by factor 5 - 6.

Patch 8 finally skips excluded checks for tracked files. With the bugs and is_path_excluded out of the way, it should be obvious that this can safely be done unconditionally without introducing regressions. Speeds up 'git-status [--ignored]' by factor 1.4 - 2.


I still believe that 'git-status --ignored' shouldn't list "ignored tracked" directories, to be consistent with the listing of untracked directories, and because "ignored tracked" contradicts the very definition of ignored content in gitignore(5).

Cheers,
Karsten


Karsten Blees (8):
  dir.c: git-status --ignored: don't drop ignored directories
  dir.c: git-status --ignored: don't list files in ignored directories
  dir.c: git-status --ignored: don't list empty ignored directories
  dir.c: git-status --ignored: don't list empty directories as ignored
  dir.c: move prep_exclude and factor out parts of last_exclude_matching
  dir.c: unify is_excluded and is_path_excluded APIs
  dir.c: replace is_path_excluded with now equivalent is_excluded API
  dir.c: git-status: avoid is_excluded checks for tracked files

 builtin/add.c              |   5 +-
 builtin/check-ignore.c     |   6 +-
 builtin/ls-files.c         |  15 +-
 dir.c                      | 351 +++++++++++++++++----------------------------
 dir.h                      |  22 +--
 t/t7061-wtstatus-ignore.sh | 104 +++++++++++++-
 unpack-trees.c             |  10 +-
 unpack-trees.h             |   1 -
 8 files changed, 243 insertions(+), 271 deletions(-)

-- 
