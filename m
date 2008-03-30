From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible d/f conflict bug or regression
Date: Sun, 30 Mar 2008 16:46:29 -0700
Message-ID: <7v4panyduy.fsf@gitster.siamese.dyndns.org>
References: <200803290813.08419.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, krh@redhat.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 01:47:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg7FI-0005kS-0B
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 01:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbYC3Xqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 19:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754739AbYC3Xqq
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 19:46:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38612 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754655AbYC3Xqp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 19:46:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0A47D14C6;
	Sun, 30 Mar 2008 19:46:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E0DE214BD; Sun, 30 Mar 2008 19:46:36 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78528>

Christian Couder <chriscool@tuxfamily.org> writes:

> mkdir testdir &&
>         cd testdir &&
>         touch foo &&
>         git init &&
>         git add . &&
>         git commit -m 'Initial commit.' &&
>         rm foo &&
>         mkdir foo &&
>         git commit -a -m 'Test.'
>
> I get:
>
> Initialized empty Git repository in .git/
> Created initial commit 3f945ca: Initial commit.
>  0 files changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 foo
> fatal: unable to index file foo

I haven't had time to fully clean-up the patch series, but I have a fix
for this (and a bit broader set of cases).  "git add -u" shares the same
issue as the "git commit -a" at the last step in your sequence.

"commit -a" and "add -u" are about "check the index and work tree to
see if anything that is in the index is changed in the work tree, and
update the entry (either remove or add)".  When we are looking at an
existing index entry "foo", possible cases include:

 - it has not been changed (=> do nothing);
 - it is not there anymore (=> do "git update-index --add --remove foo")
 - its contents or executableness changed (ditto);
 - its type changed (e.g. reg-to-symlink) (ditto);

If you did "rm foo; mkdir foo", then that is "it is not there anymore"
case.

If you did "rm foo; mkdir foo; (cd foo && git init)", and worked in this
new foo/ repository to cause its HEAD to point at a commit, then that is
"its type changed to a gitlink" case (iow, you added a submodule).

The above two cases are not handled properly; the breakage is in
diff-files but non-cached diff-index shares the same issue.  The root
cause is not Kristian's "rewrite commit in C", but is much more older
"gitlink to support submodules" series, that started at f35a6d3 (Teach
core object handling functions about gitlinks, 2007-04-09).

Will send the patches out tonight but I have to tend some other chores
first.
