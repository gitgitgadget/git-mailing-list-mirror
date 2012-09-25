From: Jeff King <peff@peff.net>
Subject: Re: Quickly searching for a note
Date: Mon, 24 Sep 2012 20:38:55 -0400
Message-ID: <20120925003855.GB19586@sigill.intra.peff.net>
References: <7vy5k370n7.fsf@alter.siamese.dyndns.org>
 <505CB21E.4040607@workspacewhiz.com>
 <7vtxur3zxi.fsf@alter.siamese.dyndns.org>
 <505CCD2A.8020003@workspacewhiz.com>
 <505CD2FA.80200@kdbg.org>
 <505CD7D0.2000505@workspacewhiz.com>
 <20120921233723.GA29433@sigill.intra.peff.net>
 <7v7grn3pfo.fsf@alter.siamese.dyndns.org>
 <505DE30B.2000805@drmicha.warpmail.net>
 <7vk3vl3ixv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 02:39:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGJBD-0005S5-Oo
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 02:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830Ab2IYAjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 20:39:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57465 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570Ab2IYAjB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 20:39:01 -0400
Received: (qmail 7848 invoked by uid 107); 25 Sep 2012 00:39:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Sep 2012 20:39:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2012 20:38:55 -0400
Content-Disposition: inline
In-Reply-To: <7vk3vl3ixv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206340>

On Sat, Sep 22, 2012 at 01:23:56PM -0700, Junio C Hamano wrote:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > On my mental scratch pad (yeah, that's where the bald spots are) I have
> > the following more general idea to enhance the revision parser:
> >
> > --limit-run=<script>::
> > --run=<script>:::
> > These options run the script `<script>` on each revision that is walked.
> > The script is run in an environment which has the variables
> > `GIT_<SPECIFIER>` exported, where `<SPECIFIER>` is any of the specifiers
> > for the `--format` option in the long format (the same as for 'git
> > for-each-ref').
> >
> > In the case of `--limit-run`, the return code of `<script>` decides
> > whether the commit is processed further (i.e. shown using the format in
> > effect) or ignored.
> 
> You could argue that the above is not an inpractical solution as
> long as the user of --run, which spawns a new process every time we
> need to check if a commit is worth showing in the log/rev-list
> stream, knows what she is doing and promises not to complain that it
> is no more performant than an external script that reads from
> rev-list output and does the equivalent filtering.
> 
> I personally am not very enthused.

Nor me. I experimented long ago with a perl pipeline that would parse commit
messages and allow Turing-complete grepping. I recall it was noticeably
slow. I cannot imagine what forking for each commit would be like.

Actually, wait, I can imagine it. Git has ~33K commits. Doing 'sh -c
exit' takes on the order of .002s. That's a minute of processing to look
at each commit in "git log", assuming the filtering itself takes 0
seconds.

> If we linked with an embeddable scripting language interpreter
> (e.g. lua, tcl, guile, ...), it may be a more practical enhancement,
> though.

Agreed. I just posted a patch series that gives you --pretty lua
support, though I haven't convinced myself it's all that exciting yet. I
think it would be nicer for grepping, where the conditionals read more
like regular code. Something like:

  git log --lua-filter='
    return
      author().name.match("Junio") &&
      note("p4").match("1234567")
  '

reads OK to me.

-Peff
