From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/5] Better error messages for checkout and merge.
Date: Mon,  9 Aug 2010 16:19:57 +0200
Message-ID: <1281363602-27856-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 09 16:20:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiTDh-0002Zl-Be
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 16:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756662Ab0HIOUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 10:20:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46110 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756340Ab0HIOUr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 10:20:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o79EHfvq001028
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 9 Aug 2010 16:17:41 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OiTCt-0006QF-VS; Mon, 09 Aug 2010 16:20:03 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OiTCt-0008AC-Qw; Mon, 09 Aug 2010 16:20:03 +0200
X-Mailer: git-send-email 1.7.2.1.52.g95e25.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 09 Aug 2010 16:17:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o79EHfvq001028
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1281968265.08613@H9zMCCr+7LPJ/3t4GsnrYg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152965>

This is a resurection of an old patch serie by Diane Gasselin:

http://thread.gmane.org/gmane.comp.version-control.git/149173/focus=149186

In short, when you have several untracked files that conflict with a
merge or checkout, Git currently reports just the first. After this
patch serie, it reports things like:

error: Your local changes to the following files would be overwritten by checkout:
	rep/two
	rep/one
Please, commit your changes or stash them before you can switch branches.

most of the job is done by "unpack_trees: group error messages by type",
but this needed a bit of preparation to be implementable cleanly.

Compared to previous version, there are many small cleanups, and:

* unpack_trees_options was a struct, it's now an array. This makes the
  code much cleaner whenever one tries to do clever things with it.
  That's patch "Turn unpack_trees_options.msgs into an array + enum".

* A message was previously a type + an action ("removed" or
  "overwritten"). The type now encompasses the action. This duplicates
  a few lines in the declaration of the error messages, but again
  makes the rest of the code much simpler. That's patch
  "merge-recursive: distinguish "removed" and "overwritten" messages"

* The info on whether traverse_trees should stop at the first error
  was stored in info->data, with a very fragile cast to
  (unpack_trees_options *). I added one more field in the info
  structure to get rid of this cast.

Diane Gasselin (2):
  merge-recursive: porcelain messages for checkout
  t7609: test merge and checkout error messages

Matthieu Moy (3):
  Turn unpack_trees_options.msgs into an array + enum
  merge-recursive: distinguish "removed" and "overwritten" messages
  unpack_trees: group error messages by type

 Documentation/technical/api-tree-walking.txt |    2 +
 builtin/checkout.c                           |    3 +-
 builtin/merge.c                              |    3 +-
 merge-recursive.c                            |   62 +++++++----
 merge-recursive.h                            |    7 +-
 t/t3030-merge-recursive.sh                   |    2 +-
 t/t3400-rebase.sh                            |    3 +-
 t/t3404-rebase-interactive.sh                |    3 +-
 t/t7609-merge-co-error-msgs.sh               |  125 ++++++++++++++++++++++
 tree-walk.c                                  |   11 ++-
 tree-walk.h                                  |    1 +
 unpack-trees.c                               |  148 ++++++++++++++++++++------
 unpack-trees.h                               |   34 ++++--
 13 files changed, 332 insertions(+), 72 deletions(-)
 create mode 100755 t/t7609-merge-co-error-msgs.sh

-- 
1.7.2.1.52.g95e25.dirty
