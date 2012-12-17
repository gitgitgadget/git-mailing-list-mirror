From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log --format: teach %C(auto,black) to paint it black
 only on terminals
Date: Mon, 17 Dec 2012 14:49:26 -0500
Message-ID: <20121217194926.GA5209@sigill.intra.peff.net>
References: <72BB37CB88C48F4B925365539F1EE46C182613A9@icexch-m3.ic.ac.uk>
 <72BB37CB88C48F4B925365539F1EE46C18261403@icexch-m3.ic.ac.uk>
 <20121213131329.GA5042@sigill.intra.peff.net>
 <CACsJy8AgtwtJfMXzArJLiHQtR+WNRJxRdRgUts30EN-QvgGT=g@mail.gmail.com>
 <20121215101659.GB21577@sigill.intra.peff.net>
 <7v7gojtbgr.fsf@alter.siamese.dyndns.org>
 <7vobhtm5pk.fsf_-_@alter.siamese.dyndns.org>
 <CACsJy8Dt4vEpO+EcAhWnko=XAajQ9OMgbDbVx78Eb=sZTjmKQA@mail.gmail.com>
 <20121217121354.GB21858@sigill.intra.peff.net>
 <7v4njkmq07.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Srb, Michal" <michal.srb11@imperial.ac.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 20:49:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkghA-0005rr-P2
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 20:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144Ab2LQTtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 14:49:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56953 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752792Ab2LQTta (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 14:49:30 -0500
Received: (qmail 8992 invoked by uid 107); 17 Dec 2012 19:50:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Dec 2012 14:50:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2012 14:49:26 -0500
Content-Disposition: inline
In-Reply-To: <7v4njkmq07.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211694>

On Mon, Dec 17, 2012 at 11:34:48AM -0800, Junio C Hamano wrote:

> > Yeah, that should definitely be documented. I wonder if it should
> > actually respect color.diff, which is what "log" usually uses (albeit
> > mostly for the diff itself, we have always used it for the graph and for
> > the "commit" header of each entry).
> 
> I actually do not like this patch very much.  The original motive
> behind this "auto" thing was to relieve the script writers from
> the burden of having to write:
> 
> 	if tty -s
>         then
>         	warn='%C(red)'
>                 reset='%C(reset)'
> 	else
>         	warn= reset=
> 	fi
>         fmt="${warn}WARNING: boo${reset} %s"
> 
> and instead let them write:
> 
> 	fmt="%C(auto,red)WARNING: boo%C(auto,reset) %s"
> 
> but between the two, there is no $cmd.color configuration involved
> in the first place.  I am not sure what $cmd.color configuration
> should take effect---perhaps for a "git frotz" script, we should
> allow the script writer to honor frotz.color=(auto,never,always)
> configuration, not just ui.color variable.

Since this is by definition just talking about the log traversal, I
think it makes sense to respect the log traversal option by default
(which is confusingly color.diff, of course, but that is a separate
issue). That means that scripts which just wrap a regular traversal will
do what the user is accustomed to.

If "git frotz" wants to have a separate "color.frotz" option to override
that, then they would need to implement that themselves either with or
without your patch. I do not think its presence makes things any harder.

> Also the patch as posted deliberately omits support to honor command
> line override --color=(auto,never,always), but it may be more
> natural to expect
> 
>     git show --format='%C(auto,red)%s%C(auto,reset)' --color=never
> 
> to defeat the "auto," part the script writer wrote.
> 
> Now, such a script would be run by its end users as
> 
>     $ git frotz --color=never
> 
> It has to do its own option parsing before running the underlying
> "git show" to decide if it passes "--color=never" from the command
> line for that to happen.

Yeah, _if_ it does not just pass its options directly to git-log. Which
I think a reasonable number of scripts do, as well as pretty.* aliases
(which are not really scripts, but have the same relationship with
respect to this feature). For example, "git stash list" does not use
color in its output, but could be improved to do so after your patch.

So no, I do not think you can cover every conceivable case. But having
git-log respect --color and the usual color.* variables for this feature
seems like the only sane default. It makes the easy cases just work, and
the hard cases are not any worse off (and they may even be better off,
since the script can manipulate --color instead of rewriting their
format strings, but that is a minor difference).

-Peff
