From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCHv4 2/4] Add infrastructure for ref namespaces
Date: Thu, 2 Jun 2011 16:36:19 -0700
Message-ID: <20110602233619.GA1931@leaf>
References: <1306887870-3875-1-git-send-email-jamey@minilop.net>
 <1306887870-3875-2-git-send-email-jamey@minilop.net>
 <7vfwnrdfam.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 01:36:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSHRV-0005VR-Ki
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 01:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449Ab1FBXgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 19:36:36 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44896 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab1FBXgg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 19:36:36 -0400
X-Originating-IP: 217.70.178.134
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 0415817206D;
	Fri,  3 Jun 2011 01:36:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at #File managed by puppet, do not edit
	locally
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id sMyCdwxeMYx0; Fri,  3 Jun 2011 01:36:32 +0200 (CEST)
X-Originating-IP: 131.252.166.156
Received: from leaf (unknown [131.252.166.156])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 48669172084;
	Fri,  3 Jun 2011 01:36:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vfwnrdfam.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174988>

On Thu, Jun 02, 2011 at 03:44:33PM -0700, Junio C Hamano wrote:
> Jamey Sharp <jamey@minilop.net> writes:
> 
> > Note that namespaces which include a / will expand to a hierarchy of
> > namespaces; for example, GIT_NAMESPACE=foo/bar will store refs under
> > refs/namespaces/foo/refs/namespaces/bar/.  This makes GIT_NAMESPACE
> > behave hierarchically, and avoids ambiguity with namespaces such as
> > foo/refs/heads.
> 
> Sorry, but I fail to see what problem you are trying to solve here.  I am
> not suggesting that it would be better to do things in a way different
> from what your patch does, but what problem will you have if you stored
> the branch head for baz in refs/namespaces/foo/bar/refs/heads/baz given
> the namespace foo/bar, and how does it solve that problem to store it
> instead at refs/namespaces/foo/refs/namespaces/bar/refs/heads/baz?

Two reasons.  First, if you use GIT_NAMESPACE=foo (which puts its refs
under refs/namespaces/foo/refs/{heads,tags}), and also used
GIT_NAMESPACE=foo/refs/heads, that would put its refs under
refs/namespaces/foo/refs/heads/refs/{heads,tags}, which would make them
potentially conflict with foo's references.  So, for instance, you could
end up with directory/file conflicts in the refs directory.  Using
hierarchies avoids any possible conflicts and corner cases there.

Second, by making the namespaces hierarchical, we provide a kind of
composability, similar to that suggested by the analogy to chroots.
With the way we've constructed them, cloning a repo with
GIT_NAMESPACE=foo/bar has the same effect as cloning a repo with
GIT_NAMESPACE=foo and cloning from that repo with GIT_NAMESPACE=bar.

> > +int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
> 
> Just a naming and interface preference, but I would have called this
> for-each-ref-in-namespace, perhaps giving the namespace as a parameter.

for_each_ref_in and other variants already exist for that purpose;
for_each_namespaced_ref exists to automatically uses GIT_NAMESPACE.
Happy to rename it if you have another preference, but I don't think it
makes sense to support passing in arbitrary namespaces when the callers
only use it to access the currently requested namespace.  If some
situation arises in later code that needs to handle arbitrary
namespaces, it seems easy enough to provide a more generalized function
at that point, but doing so now would just make the existing callers
more complex by forcing them to do the call to get_git_namespace()
rather than allowing for_each_namespaced_ref to do it.

As far as naming, though, we have no preference whatsoever about the
color of the bikeshed. :)

- Josh Triplett
