From: Junio C Hamano <gitster@pobox.com>
Subject: [Discussion] cherry-picking a merge
Date: Thu, 15 Nov 2007 00:00:45 -0800
Message-ID: <7v3av86iqa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 09:01:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsZet-0005H0-9h
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 09:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449AbXKOIAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 03:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbXKOIAu
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 03:00:50 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:58132 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbXKOIAu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 03:00:50 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D3A312EF;
	Thu, 15 Nov 2007 03:01:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 747C594D87;
	Thu, 15 Nov 2007 03:01:09 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65080>

Earlier "git cherry-pick" learned the "-m <parent-number>"
option to allow cherry-picking a merge commit.

When you have this history:

  ---o---o---C---A---M
      \             /
       o---o-------B

You can replay the change between A and M (in other words, the
effect of merging B into A) on top of C to create a new commit,
with:

        $ git cherry-pick -m 1 M

In the current implementation, the resulting commit has a single
parent C.  This is quite similar to a squash merge of B into C.

When you think about it, as long as the topological relationship
between A and B is very similar to that of C and B (iow,
"merge-base A B" and "merge-base C B" are the same), the effect
should be the same as a real merge between B and C, shouldn't it?

  ---o---o---C---A---M
      \       \     /
       o---o---\---B
                \   \
                 `---X

I am wondering if it makes sense to record the result of
"cherry-pick -m" as a real merge between the current HEAD and
all the other parents of the cherry-picked merge except the one
that is named with the <parent-number>.
