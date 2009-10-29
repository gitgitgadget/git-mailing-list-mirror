From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v4 14/26] Add stateless RPC options to upload-pack,
	receive-pack
Date: Thu, 29 Oct 2009 08:26:29 -0700
Message-ID: <20091029152629.GY10505@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org> <1256774448-7625-15-git-send-email-spearce@spearce.org> <7vd446dfx4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 16:26:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3WtW-0008ME-O2
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 16:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258AbZJ2P0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 11:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755239AbZJ2P0Z
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 11:26:25 -0400
Received: from george.spearce.org ([209.20.77.23]:60020 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234AbZJ2P0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 11:26:24 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 96727381D3; Thu, 29 Oct 2009 15:26:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vd446dfx4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131599>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > When --stateless-rpc is passed [...]
> > When --advertise-refs is passed [...]
> 
> Is the idea to first run with --advertise-refs to get the set of refs, and
> then doing another, separate run with --stateless-rpc, assuming that the
> refs the other end advertised does not change in the meantime, to conclude
> the business?

Yes.
 
> I suspect that two separate invocations on a (supposedly) single
> repository made back-to-back can produce an inconsistent response in
> verious situations (e.g. somebody pushing in the middle, or the same
> hostname served by more than one mirrors) and the other end can get
> confused.

Yes, that can happen.

> I do not think there is any way to avoid it, short of adding to the second
> request some "cookie" that allows the second requestee to verify that the
> request is based on what he would give to the requester if this request
> were the first step of the request made to him, iow, his state did not
> change in the middle since the first request was made (either to him or to
> the equivalent mirror sitting next to himm).

There isn't a lot we can do, you are right.

One approach is to use an HMAC and sign each advertised SHA-1
during the initial --advertise-refs phase.  Requesters then present
the SHA-1 and the HAMC signature in each "want" line, and the
--stateless-rpc phase validates the signatures to ensure they came
from a trusted party.

The major problem with this approach is the private key management.
All mirrors of that repository need to have a common private key
so they can generate and later verify that HMAC signature.  This is
additional complexity, for perhaps not much gain.

A different approach is to have the --stateless-rpc phase validate
the want lines against its refs (like we do now), but if the validate
fails (no ref exactly matches) support walking backwards through the
last few records in the reflog, or through that ref's own history
for a few hundred commits, to see if the want SHA-1 appears in the
recent prior past.

Obviously when walking the reflog we would need to use a time bound,
e.g. "only examine last record if more recent than 5 minutes ago".
This way a force push to erase something will still erase it, but
a client who had just recently observed the prior SHA-1 can still
complete their fetch request, just as with native git:// they could
do that due to the prior SHA-1 being held in the git-upload-pack's
private memory.

Also, obviously when walking the commit history of a ref (to see
if the want'd SHA-1 is merged into one or more reachable refs)
we don't want to walk backwards too far, as it costs CPU time on
the server side, but we also don't want to walk too few commits.
E.g. pushes for me tend to be in the 20 commit range, while Linus
probably pushes a thousand commits or more in a single merge.
Finding the right balance may be tricky.

> I wouldn't worry too much about this if the only negative effect could be
> that the requestor's second request may result in an error, but I am
> wondering if this can be used to attack the requestee.

I don't think it can be used to attack the server.  The only impact
I can see is the client gets confused and gets an error response
from the server when the server aborts due to the invalid "want"
line sent during that 2nd (or any subsequent) request.

-- 
Shawn.
