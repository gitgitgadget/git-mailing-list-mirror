From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH/RFC] fast-import: disallow empty branches as parents
Date: Thu, 21 Jun 2012 01:34:00 +0600
Message-ID: <1340220841-753-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 21:33:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShQex-0003jt-4K
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 21:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757908Ab2FTTdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 15:33:43 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57121 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757885Ab2FTTdn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 15:33:43 -0400
Received: by lbbgm6 with SMTP id gm6so1029780lbb.19
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 12:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=0pOB/DM/H0jjJJTMBeYfz6+d2f38yqvyVn/X/mYGxhU=;
        b=cOgbNCW7AtgdtKcq3vnE5uUrf4jZgKTKu86dwr+EyR5UeH3eABT83SWG4OVZn0Vpu3
         yO0+q4R+sZChaaMqtng8zJOIiSwG6Zii7e/ZQOxw+FfFglq9FmTzx3V93VW0Tbu8z5pz
         4lCSU/asEqZ/Gq2iDNX1aql2/HVmWzdP3wRST6Hcq+Zf9K/Z/vwWxlIweVkCIozCU7p5
         YrfI8wBJK11H4nVFaxLDAaRkRF3ohPne+9keFzbl9lKBPa9mDbC8Auirwfw/MiO1puIJ
         Pn9qELOXqlkfHXLKhoTW+cK/RC4LLMVEBDaZCWPhhSBOUy/W17MPCBxjihjKHjc1Lx2m
         dBwA==
Received: by 10.152.122.12 with SMTP id lo12mr23721346lab.3.1340220821554;
        Wed, 20 Jun 2012 12:33:41 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id sm7sm41453450lab.5.2012.06.20.12.33.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 12:33:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200339>

Combinations of "reset", "commit" with "from" and/or "merge" commands
may make fast-import to produce bad objects (null_sha1 parents) or
accept bad inputs (ones asking for empty branches as parents).

Fix this and add some tests.


One RFC here: does following use case make any sense/should it be allowed?

    commit refs/heads/master
    ...
    from something
    merge refs/heads/master

1. If "from" is omitted or equals refs/heads/master we end up with duplicated parents.
2. And if something is not master we allow to pick a new first parent path.

"2" seems quite legal, while "1" looks worse. Though "1" is not directly related to
this patch and can be reproduced via a simple "merge X X" command for example.


Dmitry Ivankov (1):
  fast-import: disallow empty branches as parents

 fast-import.c          |   49 +++++++++++++++++++++++++++++------------------
 t/t9300-fast-import.sh |   48 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 19 deletions(-)

-- 
1.7.3.4
