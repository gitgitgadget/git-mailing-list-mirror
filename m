From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4 0/9] stash: modifiy handling of stash-like references
Date: Tue, 10 Aug 2010 10:04:39 +1000
Message-ID: <1281398688-21008-1-git-send-email-jon.seymour@gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 02:06:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OicM9-0001R6-FN
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 02:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757315Ab0HJAF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 20:05:56 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38370 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757268Ab0HJAFz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 20:05:55 -0400
Received: by pzk26 with SMTP id 26so3864421pzk.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 17:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wR+j1sYMQIr4YPgbwxfo2Q5hymav3maOOOflOLD1Nm0=;
        b=V8RRxyuVlCzoI1erBu6RD8BFyar/DjWXIyaRJIDZw7Vq9LDOu2zsOf42QuMMFclxrP
         6DID8nHbEMt4B9gIyzalRtP+joscp9Y/0ypNslstF8jk/VE2OW0nlK1t+wRSxHFE8XAv
         2BNPCgTz366lgY+cwXIPj4cyFz4OPlqSj/WF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OEUxr7kEKdbGm+TI41fvMY6zPofX2xKq2Paf/OAJ+Qz18QoHLan2EJ6krEe/uM3C3b
         y9qrtxxsM1/tydlW57xbuR5rURD9ESL8JuOj+h0z6N5u78iChgBl7Gl5LPtXuPhd17uL
         KQ35w9ZJt48uEyRxMioTFCYNfs1ISN/c5vcl4=
Received: by 10.142.200.21 with SMTP id x21mr14304697wff.207.1281398755349;
        Mon, 09 Aug 2010 17:05:55 -0700 (PDT)
Received: from localhost.localdomain ([120.16.203.103])
        by mx.google.com with ESMTPS id x18sm7096974wfd.8.2010.08.09.17.05.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 17:05:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.53.gddb82
In-Reply-To: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153058>

This series teaches git stash branch and git stash show to be more tolerant of 
stash-like references that are not actually stash entry references, while 
teaching git stash pop and git stash drop to be less tolerant of stash-like 
references that are not actually stash entry references.

Junio: I did not adopt your suggestion to make git stash drop more tolerant
of invalid stash references since failing early might help a user
to spot an incorrect assumption about the state of their working tree
and stash stack - silently handling this case might hide such an incorrect
assumption. However, if you would prefer git stash drop to behave that
way, I'll rework the series accordingly.

The first 3 commits refactor the existing code without significantly 
changing existing behaviour.

The next 4 commits modify existing behaviour to be more (or less) tolerant 
of stash-like references, as required.

The last 2 commits update the tests and documentation to reflect the modified behaviour.

Thanks to Johannes Sixt for suggesting improvements to the tests.

This series in unchanged from v3 except for patch 8 which improves the tests and
patch 9 which enhances the documentation to indicate which commands require
a stash entry reference and which are happy to use just a stash-like
commit.

Jon Seymour (9):
  stash: refactor - create pop_stash function
  stash: extract stash-like check into its own function
  stash: introduce is_stash_ref and assert_stash_ref functions.
  stash: teach git stash pop to fail early if the argument is not a
    stash ref
  stash: teach git stash drop to fail early if the specified revision
    is not a stash reference
  stash: teach git stash branch to tolerate stash-like arguments
  stash: teach git stash show to always tolerate stash-like arguments.
  t3903-stash.sh: tests of git stash with stash-like arguments
  Documentation: git stash branch now tolerates non-stash references.

 Documentation/git-stash.txt |   37 +++++++++--------
 git-stash.sh                |   92 +++++++++++++++++++++++++++++++------------
 t/t3903-stash.sh            |   77 ++++++++++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+), 43 deletions(-)
