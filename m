From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] refs.c: Write reflogs for notes just like for
 branch heads
Date: Tue, 30 Mar 2010 13:19:32 -0400
Message-ID: <20100330171932.GE17763@coredump.intra.peff.net>
References: <d6c334ec855bf04d9edb432b9cdc3590ab96d6e9.1269867675.git.git@drmicha.warpmail.net>
 <0f06a30f395c14307066d0e4365fc61a294997db.1269867675.git.git@drmicha.warpmail.net>
 <201003291625.22977.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Mar 30 19:19:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwf6V-0000Uf-0a
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 19:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502Ab0C3RTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 13:19:46 -0400
Received: from peff.net ([208.65.91.99]:44818 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546Ab0C3RTo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 13:19:44 -0400
Received: (qmail 22756 invoked by uid 107); 30 Mar 2010 17:20:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 30 Mar 2010 13:20:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Mar 2010 13:19:32 -0400
Content-Disposition: inline
In-Reply-To: <201003291625.22977.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143580>

On Mon, Mar 29, 2010 at 04:25:22PM +0200, Johan Herland wrote:

> > This is actually inspired by Jeff's novel notes use. I think there
> > are use cases where a notes log makes sense (notes on commits) and
> > those where it does not (metadata/textconv). In both cases having a
> > reflog is useful. So, the next step is really to allow notes trees
> > without history, which also takes care of the pruning issue. I know
> > how to do this, I just have to decide about the configuration
> > options.
> 
> I noticed that Jeff's proof-of-concept wrote notes trees without making 
> notes commits, and although it seemed like a bug at first, it does - as 
> you say - provide a rather nice way to store notes trees without 
> history.

No, it was very much intentional.

However, I think the next iteration will wrap the tree in an actual
commit, but just keep each commit parentless. That will provide a nice
spot for metadata like the cache validity information.

I like the idea of having a reflog, just because you could use it to
salvage an old cache if you were playing around with your helper's
options (or debugging your helper :) ). The usual 90-day expiration
time is perhaps too long, though.

> Note that I haven't explicitly designed the notes feature with this in 
> mind, so it's wise to add testcases for expected behaviour once we 
> start use history-less notes trees.
> 
> Thinking about it, the notes code itself (notes.h/.c) only wants a notes 
> _tree_ object, so will probably work fine with history-less notes 
> trees. But builtin/notes.c with its public commit_notes() function may 
> be another story...

I was planning on using my own cache-specific helper instead of
commit_notes() anyway, so that shouldn't be a problem. By using a commit
wrapper, I don't think any of the display code should be confused (since
they need to handle the case of a root note commit anyway). Once I have
some example trees, I can poke at them with the existing notes code and
see how they behave (and how we _want_ them to behave, since I'm not
sure yet what sort of cache introspection, if any, would be useful).

-Peff
