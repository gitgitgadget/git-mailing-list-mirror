From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-daemon server
Date: Fri, 03 Jun 2005 11:30:48 -0700
Message-ID: <7vmzq7l2cn.fsf@assigned-by-dhcp.cox.net>
References: <20050603152212.GA4598@jmcmullan.timesys>
	<7vk6lbmk01.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Fri Jun 03 20:30:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeGuR-00006K-D2
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 20:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVFCSbq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 14:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVFCSbd
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 14:31:33 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:15013 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261488AbVFCSaw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2005 14:30:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050603183050.NVLV550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Jun 2005 14:30:50 -0400
To: Jason McMullan <jason.mcmullan@timesys.com>
In-Reply-To: <7vk6lbmk01.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 03 Jun 2005 10:24:14 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

JCH> Looks very nice.  Some comments.

JCH> This being a dedicated GIT specific sync mechanism, you may want
JCH> to give more smarts to the server, so that the client can say "I
JCH> have these commits as HEADs in my forest, here are their SHA1s,
JCH> now sync me up to the head you said you have whose SHA1 is
JCH> this", implying he has all their HEADs dependents.  Of course
JCH> this can come later.

About the protocol, here is one change you may want to have even
in the initial version to futureproof yourself, and let you make
a "low hanging fruit" optimization without bumping the protocol
version up.

Make "request" capable to optionally have this format:

	request <sha1> <commit-sha1> <ce-path>

Note.  You have to make sure you have some way to quote embedded
newlines in ce-path since your protocol is mostly line based.

When this optional form is used, the requestor is telling the
responder the following:

    (1) it wants to retrieve <sha1>; this is the same as a
        request without the optional two fields.

    (2) it wants <sha1> because it is trying to complete a tree
        associated with <commit-sha1>; it already has the commit
        object itself and knows what the parents of the commit
        are.

    (3) it already has trees and blobs associated with all the
        parents of <commit-sha1>.

    (4) it knows that <sha1> resides at <ce-path> in the tree
        associated with <commit-sha1>.  As a special case, ""
        (an empty string) as <ce-path> means "the root level
        tree object associated with <commit-sha1>".

The initial implementation of a requestor does not even send
this extended form.  The initial implementation of a responder
must be able to parse this extended form, but it does not have
to do anything special about it; just do what your cmd_request()
currently does.  However, this extended request lets your later
implementation of the responder create and send delta on the
fly, by:

    (0) Look at <sha1> in the local storage.  If it is already
        deltified, do not do anything special but just send it
        out.

    (1) Look at <commit-sha1> and its parents.  Compare the
        object (either a blob or a tree) that corresponds to
        <ce-path> in the trees associated with these commits.
        Verify <sha1> is indeed what the requestor thinks it is
        while you are at it.

    (2) Try to synthesize a reasonable delta to create <sha1>
        based on the objects you find in step (1).  Upon finding
        a reasonable delta, send that as a delta object to the
        requestor.  Optionally you may want to replace the
        <sha1> found at the local store in step (0) with this
        delta.  If you have many parents, this "reasonable"
        delta does not necessarily have to be the minimal delta.

Unlike a full-blown "ihave/sendme" protocol extension, this does
not require responder side to keep much client state, and should
give you the ability to create and send a reasonable if not
minimum delta lazily.

Hmm.

