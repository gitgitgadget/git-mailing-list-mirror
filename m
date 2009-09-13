From: Owen Taylor <otaylor@redhat.com>
Subject: Patches for git-push --confirm and --show-subjects
Date: Sun, 13 Sep 2009 19:31:21 -0400
Message-ID: <1252884685-9169-1-git-send-email-otaylor@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 01:31:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmyXl-0001Gx-TR
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 01:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbZIMXbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 19:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753860AbZIMXbX
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 19:31:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50925 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753841AbZIMXbX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 19:31:23 -0400
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8DNVQfe030237
	for <git@vger.kernel.org>; Sun, 13 Sep 2009 19:31:26 -0400
Received: from localhost.localdomain (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8DNVPIx026475
	for <git@vger.kernel.org>; Sun, 13 Sep 2009 19:31:26 -0400
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128426>

Here's a first try at something like what was discussed. Various notes:

 * I didn't try to implement --confirm for rsync and http pushes; it would
   require completely different code and it sounds like they will eventually
   be switched to the "push_refs" code path as well.

 * I picked the name --show-subjects for the that option because
   --show-commits/--log-commits implied a closer connection to 'git show'
   or 'git log'. --show-subjects implies (to me) something more free-form.

 * --show-subjects might actually benefit from having a short option
   but I omitted that for now.

 * I ripped off a big hunk of code from builtin-fmt-merge-msg.c to do the
   commit synopsis without completely understanding it. There are quite
   a few differences from the original and it was beyond my knowledge of
   the git code base to figure out whether some shared utility could be
   added.

   Along with differences in the input parameters and the output, there's
   one "bug fix" I made to the code - in the orginal, if you have exactly
   21 commits it will show:

     (21 commits):
      <commit 1>
      <commit 2>
      [...]
      <commit 20>
     ...

   So the last commit is pointlessly substituted with '...'; that's more
   annoying if you are showing just a few commits, so I fixed it in the
   adapted code.

 * Passing three booleans 'int verbose, int show_subjects, int porcelain'
   between functions in transport.c is somewhat error-prone, but I didn't
   want to switch to flags, since it would have made the patches here
   less incremental.

 * The interaction between --confirm and --show-subjects and --porcelain
   is a bit tricky, but I think what I ended up with right - the basic
   idea is that that '--confirm --porcelain' should let the user confirm
   then output what actually got done to the wrapper script on stdout in
   porcelain format. Didn't try to describe the details in the docs.

 * My first attempt at changing the git code, so probably some stupidity
   in there somewhere :-)
