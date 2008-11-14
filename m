From: "Kyle Moffett" <kyle@moffetthome.net>
Subject: Re: Any plans to support JTA and XA in jgit?
Date: Fri, 14 Nov 2008 09:38:22 -0500
Message-ID: <f73f7ab80811140638m4045cf83p311c593aff066002@mail.gmail.com>
References: <200811132059.16616.robin.rosenberg.lists@dewire.com>
	 <491C8DBE.9080105@wellfleetsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Farrukh Najmi" <farrukh@wellfleetsoftware.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 15:39:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0zpk-0003OX-N7
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 15:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbYKNOiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 09:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbYKNOiY
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 09:38:24 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:30411 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbYKNOiX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 09:38:23 -0500
Received: by yx-out-2324.google.com with SMTP id 8so628557yxm.1
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 06:38:22 -0800 (PST)
Received: by 10.100.137.12 with SMTP id k12mr513650and.55.1226673502496;
        Fri, 14 Nov 2008 06:38:22 -0800 (PST)
Received: by 10.100.38.13 with HTTP; Fri, 14 Nov 2008 06:38:22 -0800 (PST)
In-Reply-To: <491C8DBE.9080105@wellfleetsoftware.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100979>

On Thu, Nov 13, 2008 at 3:27 PM, Farrukh Najmi
<farrukh@wellfleetsoftware.com> wrote:
> The problem I am trying to solve is this. In my service I need to store
> metadata in a relational db and content in git such that both either commit
> or not in a single transaction. If one commits and the other does not that
> is a serious integrity issue. Seems to me, two phase commit would be the
> right solution for that in the long run. This what JDBC + JMS topologies do.

That's really easy!  First tweak jgit so that *instead* of using
.git/refs, it uses your database to store references and exports them
on a routine basis to .git/refs for debugging purposes.  Then, for
each database update:

(1)  Start transaction
(2)  Commit the change to GIT (adds ref update to the transaction)
(3)  Make other metadata updates
(4)  Commit transaction

Then set up periodic garbage collection and you're done!  If the
transaction is aborted, there will simply be a bunch of random loose
objects in the git repository, which will be cleaned up the next time
you garbage collect.  The ref update will be atomic and conditional
with the rest of the transaction, and in git the *only* part that
really matters for atomicity is the ref.

Cheers,
Kyle Moffett
