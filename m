From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] Revisiting cache-tree
Date: Mon, 20 Apr 2009 03:58:16 -0700
Message-ID: <1240225100-29960-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 13:00:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvrEM-0001Cx-I6
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 13:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471AbZDTK6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 06:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754488AbZDTK6a
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 06:58:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbZDTK62 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 06:58:28 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 94808ACEF5
	for <git@vger.kernel.org>; Mon, 20 Apr 2009 06:58:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BF9D4ACEF4 for
 <git@vger.kernel.org>; Mon, 20 Apr 2009 06:58:24 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc1.18.g66996
X-Pobox-Relay-ID: 2CA92D00-2D9A-11DE-B711-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116966>

This series consists of a fix meant for maint branch, and two performance
fix.  The second one is a refactoring of the code to support the latter.

I was doing a rather huge import as a multi-step process by doing
something like this:

	$ rm -f $GIT_DIR/index
	$ git add some ;# this one is huge
	$ git tag one $(git write-tree)
	$ git repack -a -d
	$ rm -f $GIT_DIR/index
	$ git add other ;# this one is also huge
	$ git tag two $(git write-tree)
	$ git repack -a -d

	$ git read-tree some other
	$ git tag both $(git write-tree)
	$ git repack -a -d

The binding of two distinct subtrees is done with the read-tree but it
wrote out an incorrect index (notice the lack of -m; with -m option the
command correctly does a different thing) and resulted in a corrupt tree
object.

Junio C Hamano (4):
  read-tree A B: do not corrupt cache-tree
  Move prime_cache_tree() to cache-tree.c
  read-tree -m A B: prime cache-tree from the switched-to tree
  checkout branch: prime cache-tree fully

 builtin-checkout.c  |   10 +++++++++-
 builtin-read-tree.c |   48 ++++++++----------------------------------------
 cache-tree.c        |   34 ++++++++++++++++++++++++++++++++++
 cache-tree.h        |    4 ++++
 4 files changed, 55 insertions(+), 41 deletions(-)
