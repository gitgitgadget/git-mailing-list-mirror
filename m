From: Jeff King <peff@peff.net>
Subject: Re: Bug: pull --rebase with =?utf-8?B?w6kg?= =?utf-8?Q?in?= name
Date: Tue, 6 Mar 2012 03:23:03 -0500
Message-ID: <20120306082303.GC21199@sigill.intra.peff.net>
References: <FECFDD4D-6EC3-4DE1-8A08-B4477345C4AA@habr.de>
 <20120305102657.GB29061@sigill.intra.peff.net>
 <87399nqqog.fsf@thomas.inf.ethz.ch>
 <F5A485EA-7EAD-4D8B-87C4-7185F713318C@habr.de>
 <20120305115815.GA4550@sigill.intra.peff.net>
 <0E2B8DE3-1ABD-453F-BCAA-0D693ECA5987@habr.de>
 <87ipijkxlm.fsf@thomas.inf.ethz.ch>
 <20120305132913.GA15004@sigill.intra.peff.net>
 <7v8vjf2c8o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	=?utf-8?B?UmVuw6k=?= Haber <rene@habr.de>, git@vger.kernel.org,
	Will Palmer <wmpalmer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 09:23:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4pfs-0000gs-DA
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 09:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758336Ab2CFIXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 03:23:07 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38252
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755353Ab2CFIXG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 03:23:06 -0500
Received: (qmail 5363 invoked by uid 107); 6 Mar 2012 08:23:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Mar 2012 03:23:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2012 03:23:03 -0500
Content-Disposition: inline
In-Reply-To: <7v8vjf2c8o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192310>

On Mon, Mar 05, 2012 at 09:23:19AM -0800, Junio C Hamano wrote:

> I think there were talks about cross pollinating and eventually
> unifying the placeholder languages of pretty and for-each-ref, and
> if we were to do so, I agree that --pretty definitely should learn
> to do --sq. But I do not think we want to teach everything :shell;
> following the style of %w(), something more generic that would apply
> to any payload would be preferred, perhaps giving an end result like
> this:
> 
> 	git show -s --format='
> 		GIT_AUTHOR_NAME=%(sq-begin)%an%(sq-end)
>                 GIT_AUTHOR_EMAIL=%(sq-begin)%ae%(sq-end)
>         '
> 
> which would be immediately `eval`-able.

Yeah, that could work. I didn't want to teach everything :shell
individually. I was hoping eventually for a world where
"%(foo:one:two=bar)" was internally parsed into "the foo item, with
attribute one set, and attribute two set to bar". And then the "shell"
attribute would have a particular meaning for everything, whereas
in "%(authordate:format=short)", the "format" attribute would be
specific to that item.

I think that makes for a more readable syntax. However, your proposal
does allow quoting multiple entities at a time, like:

  IDENT=%(sq-begin)%an <%ae>%(sq-end)

which could be useful.

Anyway, there is not much point in discussing hypothetical syntaxes. I
think we agree that some form of this feature would be an ideal way
forward in the long term, but specifics can wait until somebody shows up
with patches.

> In any case, my reading of the conclusion you guys have already
> reached in this thread is that the issue is not even a bug in Git,
> but is a broken build/installation of sed by a third-party.  I am
> inclined to suggest any change to get_author_ident_from_commit
> helper backburnered before we teach --sq to --pretty machinery.

I think that is true. It could be considered a bug in git if we were
relying on an unportable sed construct. But it works everywhere else,
and we already go to the effort to set LANG and LC_ALL, so I am inclined
to say that it is not a portability issue in git, but a crappy sed
implementation, and the right solution is to use a better one.

We could switch the use of sed to perl (even just using 5.005-ish
features, which are pretty portable), but until now, users of
git-sh-setup don't need to rely on having perl at all.

So I'm fine with leaving it for now and telling people to fix their sed.

-Peff
