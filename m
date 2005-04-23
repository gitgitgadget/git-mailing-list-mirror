From: David Woodhouse <dwmw2@infradead.org>
Subject: Git for redundant mail servers
Date: Sat, 23 Apr 2005 16:42:41 +1000
Message-ID: <1114238562.3419.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: David Gibson <david@gibson.dropbear.id.au>, jgarzik@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 23 08:39:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPEI6-0003vp-OA
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 08:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVDWGnk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 02:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVDWGnk
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 02:43:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15063 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261498AbVDWGnh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 02:43:37 -0400
Received: from [150.203.247.9] (helo=[172.24.3.18])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DPEMW-0002aE-N7; Sat, 23 Apr 2005 07:43:34 +0100
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Random alternative use for git... we could use it to provide a cluster
of redundant mail delivery/storage servers. 

The principle is simple; you use something like a set of Maildir
folders, stored in a git repository. Any action on the mail storage is
done as a commit -- that includes delivery of new mail, or user actions
from the IMAP server such as changing flags, deleting or moving mail.
These actions are actually fairly efficient when Maildir folders are
stored in a git repository -- the IMAP model is that mails are
immutable, and flag changes are done as renames.

In the normal case where all the servers are online, each commit is
immediately pushed to each remote server. When a server is offline or
separated somehow from the rest of the group, it's going to have to do a
merge when it reconnects -- we'd implement a Maildir-specific merge
algorithm, which really isn't that hard to do.

In this case we'd probably want to make active use of the feature of git
which allows you to prune history. You don't need to keep any history
further back than the commit which will be the common ancestor when a
currently-absent member of the cluster eventually comes back. In the
common case, that will actually be no history at all, since all members
will be present.

You can then have multiple members of a cluster, each running an SMTP
server and allowing for delivery of email, and each running an IMAP
server. Clients can connect to any of the machines and receive IMAP
service, and email will continue to flow inward, as long as at least one
machine in the cluster remains alive. 

-- 
dwmw2

