From: Dirk Wallenstein <halsmit@t-online.de>
Subject: [PATCH 0/3] git-branch-head: recognize all refs pointing to the current branch head as such
Date: Wed, 25 Feb 2009 11:17:17 +0100
Message-ID: <cover.1235499771.git.halsmit@t-online.de>
Cc: Dirk Wallenstein <halsmit@t-online.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 11:36:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcH7z-00083o-Kj
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 11:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbZBYKfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 05:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753354AbZBYKfG
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 05:35:06 -0500
Received: from mailout03.t-online.de ([194.25.134.81]:52366 "EHLO
	mailout03.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbZBYKfF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 05:35:05 -0500
X-Greylist: delayed 1045 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Feb 2009 05:35:04 EST
Received: from fwd03.aul.t-online.de 
	by mailout03.sul.t-online.de with smtp 
	id 1LcGpd-0002UC-00; Wed, 25 Feb 2009 11:17:37 +0100
Received: from localhost.localdomain (Jr26KZZSYhiVNIHK+O2CscMGLdxZf+eZuzm0YmmcrpioY8S1IHB9vSYDmDUfwXSw-7@[84.139.85.50]) by fwd03.t-online.de
	with esmtp id 1LcGpL-0Hjvd20; Wed, 25 Feb 2009 11:17:19 +0100
X-Mailer: git-send-email 1.6.1
X-ID: Jr26KZZSYhiVNIHK+O2CscMGLdxZf+eZuzm0YmmcrpioY8S1IHB9vSYDmDUfwXSw-7
X-TOI-MSGID: 67743200-3386-4237-a856-c55c51181e0b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111440>

With git-show-branch I would like to specify "HEAD" or "<branchname>" on 
the command line and have it flagged with '*'. A prerequisite for this 
is that multiple columns can be flagged with '*'. 
That is what the first patch does.

Currently the following is true:
* if you have a detached head and specify "HEAD" it is flagged with '*'
* on a branch, the only ref argument that is flagged with '*' is the 
  name of the branch (like "master"), and not 'HEAD' nor `git rev-parse HEAD`.
* no arguments (neither heads nor non-heads) are reduced to only one ref if 
  they point to the same object (except for identical refs)

The only problem of a sha1-only based solution for branch head determination 
(comparing the sha1 of the current head and the specified ref) that I can 
think about is that, if some other branch head shares the sha1 of the current
branch head (immediately after creation), one could name the other branch and
it would be flagged as current branch head.

If that is too much of a problem, I propose an exceptions for the case when
exactly "HEAD" is specified, and optionally if a sha1 is specified and matches
head (`git rev-parse HEAD`). To not mix up different solutions in the 
posted patches I go with the sha1-only based proposal. 
That is the second patch.

Maybe, with a detached head, nothing should be flagged as branch head. 
If that is the case, the problem seems to be the retval from resolve_ref(), 
which returns its argument unmodified if called with "HEAD" (and not NULL). 
A local fix for that is in the third patch, which simply checks for that case.

The switch '--current' uses rev_is_head() to find out if the branchname has 
been specified on the command line, and adds such a column if not. That seems
alright, as with this patch, you can now easily spot all columns that refer to
the branch head.

Some example calls of rev_is_head() while being on branch "callDemo":
Normal:
	head=refs/heads/callDemo ; headlen=19 ; name=HEAD     ; head_sha1=968d629 ; sha1=968d629
	head=refs/heads/callDemo ; headlen=19 ; name=callDemo ; head_sha1=968d629 ; sha1=968d629
With '--current' (this adds a "<branchname>" column if it is not specified on the command line) :
	head=refs/heads/callDemo ; headlen=19 ; name=HEAD ; head_sha1=968d629 ; sha1=<none>
	head=refs/heads/callDemo ; headlen=19 ; name=callDemo ; head_sha1=968d629 ; sha1=<none>
With a detached head, with and without '--current' (without the third patch of 
this thread. With that patch, head is a pointer to an empty string):
	head=HEAD ; headlen=4 ; name=HEAD ; head_sha1=14706b5 ; sha1=<none>
	head=HEAD ; headlen=4 ; name=HEAD ; head_sha1=14706b5 ; sha1=14706b5
	head=HEAD ; headlen=4 ; name=callDemo ; head_sha1=14706b5 ; sha1=968d629


And an example of what would be the outcome of these patches while being on 
branch "sha1BasedOnly":
    git (sha1BasedOnly) $ ./git-show-branch --current HEAD^^ HEAD HEAD^ `git rev-parse HEAD` master
	! [HEAD^^] git-show-branch: allow for multiple branch head columns
	 * [HEAD] git-show-branch: avoid any column to be flagged as branch head if head is detached
	  ! [HEAD^] git-show-branch: sha1 based branch head determination
	   * [8e3c6fcd00a6a809bf1cca383a09c8d077c945d6] git-show-branch: avoid any column to be flagged as branch head if head is detached
	    ! [master] Merge branch 'for-junio' of git://source.winehq.org/~julliard/git/git
	     * [sha1BasedOnly] git-show-branch: avoid any column to be flagged as branch head if head is detached
	------
	 * * * [HEAD] git-show-branch: avoid any column to be flagged as branch head if head is detached
	 *+* * [HEAD^] git-show-branch: sha1 based branch head determination
	+*+* * [HEAD^^] git-show-branch: allow for multiple branch head columns
	------ [master] Merge branch 'for-junio' of git://source.winehq.org/~julliard/git/git




Dirk Wallenstein (3):
  git-show-branch: allow for multiple branch head columns
  git-show-branch: sha1 based branch head determination
  git-show-branch: avoid any column to be flagged as branch head if
    head is detached

 builtin-show-branch.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)
