From: Junio C Hamano <junkio@cox.net>
Subject: Proposed updates
Date: Sun, 28 Aug 2005 15:52:41 -0700
Message-ID: <7vslwtfzd2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 29 00:58:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9W1V-0002Lz-MF
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 00:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbVH1Wwn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 18:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbVH1Wwn
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 18:52:43 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:48371 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750896AbVH1Wwn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 18:52:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050828225241.DEGQ15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 28 Aug 2005 18:52:41 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7889>

I have two proposed updates that I consider are somewhat usable
at this point in the "pu" branch.


Revert, Cherry-Pick and Rebase
------------------------------

* I've rewritten "git revert" to use the same three-way merge
  machinery used by "git resolve".  Earlier, it was generating a
  reverse patch and applying it using "git apply", which was
  very strict about conflicting merges and you did not get any
  help resolving.  Now you get the same "files in the working
  tree with conflict marker in them" when it wouldn't have been
  able to apply the reverse patch in the earlier
  implementation.

  Suppose you have this commit ancestry, you are currently at F,
  and would want to revert D:


        A --> B--> E --> F
                 /
                /
        C --> D

  Here, "reverting D" is done by the tree-way merge that starts
  with this:

	git-read-tree -m D F C

  The meaning of this is quite straightforward when you think
  about it.  The usual merging of A and B that pivots at their
  common ancestor O is done with "git-read-tree -m O A B", and
  you read it like "We have come from O to A.  We want to apply
  the change done by a person who went from O to B to our tree."

  You can read the "read-tree" exactly the same way; it reads
  "We have come from D to F.  We want to apply the change done
  by a person who went from D to C to our tree.".

* Following the same logic, "git cherry-pick" has been written
  using "git-read-tree -m <commit>^1 <head> <commit>"; we might
  not even "have come from <commit>^1" to reach our current
  <head>, but that is OK.  Actually "git cherry-pick" and "git
  revert" are the same program, just switching the first and
  third tree given to git-read-tree.

* "git rebase" has been rewritten using "git cherry-pick".
  Earlier, it too was doing the "patch fed to 'git apply'"
  approach.  By using the three-way merge machinery, you would
  get the same "files in the working tree with conflict marker
  in them"; however "rebase" being a batch oriented operation to
  apply what is applicable first and leaving the rest for you to
  manually apply, it currently does not stop in the middle to
  ask you to resolve them manually.


MIMEfied "git mailinfo"
-----------------------

* "git mailinfo", which is the workhorse of e-mail patch
  application, has been enhanced to grok limited form of MIME
  features that are often seen on our mailing list.

     - People's names spelled in characters outside ASCII (both
       on From: header and the signed-off-by line).
    
     - Content-transfer-encoding using quoted-printable (both in
       multipart and non-multipart messages).
    
  mailinfo creates three output files: 'info' that records title
  and authorship information, 'patch' that describes the
  changes, and 'msg' that records the log message.  All of them
  are produced after unwrapping content-transfer-encoding (and
  obviously multipart).  In addition, with '-u' flag, 'info' and
  'msg' are transliterated from the original charset to utf8, so
  that the resulting commit metainformation are in utf-8.

  The implementation does not attempt to do full MIME (you
  cannot feed nested multipart to it, for example).  In a
  multipart message, the first part is assumed to contain the
  commit log message and optionally the first patch.  Subsequent
  parts may contain more patches but any log message material in
  them are ignored (more precisely, passed through to the
  'patch' output, to be discarded by the downstream patch
  application step).

  I've done a limited test and created a couple of commits using
  this, among them the tip of the current "proposed updates"
  branch.  I was mildly impressed to see that gitweb did the
  right thing for my Signed-off-by line ;-).

  Please do not consider this an endorsement to send patches in
  MIME multipart attachments when you do not have to.  They
  _are_ still frowned upon.  Spelling your name the right way is
  a different story.


-jc
