From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Dose git-fetch need --reference option like git-clone?
Date: Sun, 11 Nov 2007 01:19:36 -0800
Message-ID: <7vfxzdgmvr.fsf@gitster.siamese.dyndns.org>
References: <46dff0320711110009y713c7d38q7b1457c92daecef6@mail.gmail.com>
	<20071111083840.GA17231@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yin Ping <pkufranky@gmail.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 10:20:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir8z1-00050Q-Pj
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 10:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbXKKJTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 04:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753445AbXKKJTo
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 04:19:44 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:43302 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbXKKJTm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 04:19:42 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 5186B2F2;
	Sun, 11 Nov 2007 04:20:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id BEF0793840;
	Sun, 11 Nov 2007 04:19:59 -0500 (EST)
In-Reply-To: <20071111083840.GA17231@glandium.org> (Mike Hommey's message of
	"Sun, 11 Nov 2007 09:38:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64437>

Mike Hommey <mh@glandium.org> writes:

> It would probably be reasonable to have this on git-remote. Anyways, you
> can easily do it yourself by editing .git/objects/info/alternates and
> adding /path/to/remoteACloned in it. You can happily git fetch after
> that.

Not really.

There are two parts in the --reference dance git-clone plays:

 - After the reference clone is done, obviously because you are
   avoiding to actually transfer the data, you need to set up
   alternates to permanently borrow from the reference
   repository.

 - Because the fetch/clone procedure considers an object that is
   locally accessible (either it locally exists, or exists in an
   alternate object store) "complete" (meaning, there is no need
   to fetch the objects that are reachable from it) ONLY when it
   is reachable from one of the refs in the repository, the
   above alone would not prevent fetch/clone from actually
   transferring the objects.  For this reason, git-clone copies
   the refs that exist in the reference repository as temporary
   refs.  This ensures that the objects that the clone borrows
   from the reference repository are considered "complete"
   during the clone process.

The original design of git differenciated the object store (that
is, .git/objects/) and a repository (.git).  A repository has an
object store associated with it, but the design allowed an
object store to be shared among multiple repositories by
symlinking.  This is why alternates point at objects/ directory
of the reference repository, not one level above.

Today, no git tool creates such a "shared object store" layout,
so if the original design were "an object store belongs only to
one repository, and the ../refs directory relative to it always
is the only set of refs that defines the completeness of the
objects within it.  No sharing of object store across
repositories using symlink is allowed", we could redefine the
completeness rule to also follow the alternates and doing so
would eliminate the need for the latter "temporary ref" trick
git-clone plays.  But until we officially declare that a set of
old repositories that uses the "shared object store" layout are
not supported (and give a reasonably migration path), we
unfortunately cannot do so.
