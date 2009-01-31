From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2009, #05; Wed, 21)
Date: Sat, 31 Jan 2009 02:36:40 -0500
Message-ID: <20090131073640.GF3033@coredump.intra.peff.net>
References: <7vab9kataf.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901220606040.3586@pacific.mpi-cbg.de> <1233384354.10045.170.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Jan 31 08:38:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTAQd-0008KS-Mj
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 08:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbZAaHgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 02:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbZAaHgo
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 02:36:44 -0500
Received: from peff.net ([208.65.91.99]:58243 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715AbZAaHgn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 02:36:43 -0500
Received: (qmail 10591 invoked by uid 107); 31 Jan 2009 07:36:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 31 Jan 2009 02:36:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Jan 2009 02:36:40 -0500
Content-Disposition: inline
In-Reply-To: <1233384354.10045.170.camel@maia.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107913>

On Sat, Jan 31, 2009 at 07:45:54PM +1300, Sam Vilain wrote:

> Is there any reason why the split has to be cast in stone at all?
> 
> ie, the code could just scan the root tree of the branch, and
> progressively descend into sub-trees based on a partial match of the
> object for which the note is to be found.  If you find a partial name
> then you expect that it is a tree and descend into it and scan for the
> rest.  If you find a complete name then you expect that it is a blob and
> open it.  If it turns out to be a tree then there are multiple notes for
> that commit.  Then I think you get the best of both worlds; you can
> start with a simple flat structure and then later someone can come along
> and make it split it when there are more than N entries in the root tree
> (where N is determined from profiling etc).

Actually, lookup is even easier than that: we iterate through the entire
tree recursively and add everything to a flat hash. So we really don't
care there what the layout is like (just take the first 40 characters of
any directory name as a hash).

But it violates the usual git principle of "content has a unique name".
What happens when I add "a/b" and you add "ab"? A dumb merge will let
both co-exist, but which one do you return for lookup?

> One would be to allow grafts to be noted.  These might want to live in a
> different place to refs/notes/commits, like refs/notes/grafts, to avoid
> performance issues and to recognise they are a different type of data.
> A second would be for commit header information - particularly the
> author field and commit description - to be amended.  I think this all
> belongs under refs/notes/commits.  These are in essence, historical
> corrections that don't need to alter the tree.

I agree that there should be multiple note hierarchies, and multiple
keys within each hierarchy. I have posted some thoughts on that before
(and you should be able to find them searching for "notes" in the list
archive), but unfortunately I have not had time to sit down and really
work out a notes implementation that matches what I posted (which I
don't think is that far from Dscho's work in next).

And I think what you are proposing (here and in the rest of your
message) is that certain notes hierarchies may have particular formats
and semantics. And that sounds reasonable to me.

-Peff
