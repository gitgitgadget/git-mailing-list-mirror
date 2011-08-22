From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH v2 0/1] git-clone: fix relative path problem in the alternates
Date: Mon, 22 Aug 2011 17:05:56 +0800
Message-ID: <1314003957-9455-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 22 11:06:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvQSN-0004ND-Rz
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 11:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027Ab1HVJGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 05:06:03 -0400
Received: from mail.windriver.com ([147.11.1.11]:59603 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab1HVJF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 05:05:59 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p7M95tVb001142
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 22 Aug 2011 02:05:55 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.220) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.1.255.0; Mon, 22 Aug 2011 02:05:55 -0700
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179852>


Hi Junio,

In the V2 version, i use strbuf_xxxx() to help to parse alternates file
and change relative paths to absolute paths according to your suggestion,
now the strbuf operations are safer.

When updating new content to the lockfile, i choose to write whole content at
one time instead of update it line by line. The reason is:

1. we will conditionally update the lockfile, if original alternates doesn't
include relative path, we don't need to update the lockfile. This logic can't
easily be handled line by line.
2. current git system only provides add_to_alternates_file()in the sha1_file.c
to update lockfile, this function can add a line to lockfile but can't empty
and write lockfile, we need to add a similar function to empty and write to
lockfile, and we must guarantee the first line update will call this function,
then remaining update line call add_to_alternates_file(), this logic is a
little complicated comparing to update whole content at one time.
3. current existing add_to_alternates_file() will unconditionally append
"/objects" at each new added line, that need us to parse and  remove
"/objects" from each line read out from source alternates, this is a little
bit complicated.

If we choose update lockfile at one time, we can add a new function to
implement this requirement and overcome all above complexity.


Hui Wang (1):
      clone: replace relative paths in the alternates

 builtin/clone.c |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
 cache.h         |    1 +
 sha1_file.c     |   11 +++++++++++
