From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [RFC] [PATCH 0/5] Implement 'prior' commit object links
Date: Tue, 25 Apr 2006 15:54:21 +1200
Message-ID: <20060425035421.18382.51677.stgit@localhost.localdomain>
X-From: git-owner@vger.kernel.org Tue Apr 25 06:33:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYFF6-0000TO-1a
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 06:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWDYEdh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 00:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWDYEdh
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 00:33:37 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:54231 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751025AbWDYEdh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 00:33:37 -0400
Received: from samv by mail1.catalyst.net.nz with local (Exim 4.50)
	id 1FYFF2-0004GN-9U
	for git@vger.kernel.org; Tue, 25 Apr 2006 16:33:36 +1200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19126>

This patch series implements "prior" links in commit objects.  A
'prior' link on a commit represents its historical precedent, as
opposed to the previous commit(s) that this commit builds upon.

This is a proof of concept only; there is an outstanding bug (I put
the prior header right after parent, when it should really go after
author/committer), and room for improvement no doubt remain elsewhere.
Not to mention my shocking C coding style ;)

Examples of use cases this helps:

 1. heads that represent topic branch merges

    This is the "pu" branch case, where the head is a merge of several
    topic branches that is continually moved forward.

    topic branches     head
      ,___.   ,___.
     | TA1 | | TB1 |
      `---'   `---'    ,__.
         ^\_____^\____| H1 |
                       `--'

    + some topic branch changes and a republish:

      ,___.   ,___.
     | TA1 | | TB1 |
      `---'   `---'^   ,__.
        |^\_____^\____| H1 |
        |       |      `--'
      ,_|_.   ,_|_.      P
     | TA2 | | TB2 |     |
      `---'   `---'^     |
        ^       ^        |
      ,_|_.     |        |
     | TA3 |    |        |
      `---'     |      ,__.
         ^\______\____| H2 |
                       `--'

    key:  ^ = parent   P = prior

 2. revising published commits / re-basing

    This is what "stg" et al do.  The tools allow you to commit,
    rewind, revise, recommit, fast forward, etc.

    In this case, the "prior" link would point to the last revision of
    a patch.  Tools would probably

 3. sub-projects

    In this case, the commit on the "main" commit line would have a
    "prior" link to the commit on the sub-project.  The sub-project
    would effectively be its own head with copied commits objects on
    the main head.

 4. tracking cherry picking

    In this case, the "prior" link just points to the commit that was
    cherry picked.  This is perhaps a little different, but an idea
    that somebody else had for this feature.

Sam.
