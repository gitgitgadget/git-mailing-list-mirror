From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [RFC] More diff possibilities in gitweb
Date: Sun, 18 Mar 2007 16:02:16 +0100
Message-ID: <20070318150216.GB9607@auto.tuwien.ac.at>
References: <20070317151731.GA32571@auto.tuwien.ac.at> <ethnog$cf6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 18 16:02:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSwtp-00083B-3r
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 16:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbXCRPCT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 18 Mar 2007 11:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbXCRPCT
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 11:02:19 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:46583 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081AbXCRPCS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 11:02:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 96B2C70E9D9B;
	Sun, 18 Mar 2007 16:02:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6vWQ4rVvizQd; Sun, 18 Mar 2007 16:02:16 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id DA22570FAF5B; Sun, 18 Mar 2007 16:02:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ethnog$cf6$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42497>

On Sat, Mar 17, 2007 at 10:51:51PM +0100, Jakub Narebski wrote:
> Martin Koegler wrote:
>=20
> > The whole is implemented in JavaScript on the client side (tested w=
ith
> > IE 6 and Mozilla). On the server side, only the JavaScript file is
> > included in the output (see below).=20
>=20
> I'd rather not use JavaScript for that, but perhaps add in the histor=
y
> view (shortlog, history) selectbox to select commits (for shortlog, a=
nd
> history of a directory) or versions of a blob/file (history of a file=
)
> like in an "info" view e.g. in MoinMoin wiki:
>   http://git.or.cz/gitwiki/GitSurvey?action=3Dinfo
> JavaScript can be used to beautify this like e.g. MediaWiki engine
> does:
>   http://en.wikipedia.org/w/index.php?title=3DDarcs&action=3Dhistory=20
> (to allow selection of diff only in forward direction).

Let's focus on the UI first:

Using a select box, as shown above, exposes only a small part of all
possible combinations, eg. how to compare commits on different
branches.

In my solution, I add to each link to a compareable object (commit,
tree, blob) two new link, eg: link "commit" becomes "commit (base |
diff)". "base" stores the ID of the object in a cookie. "diff"
retrieves the cookie and compares it with it's associated object.

Currently, only few combinations are implemented. Future version could
integrate tags (as an tag links to one commit). Additionally,
comparing tags/commits with a tree could be enabled, as a tag/commit
link to one tree.

Storing the base object in a cookie enables the user to use multiple
windows/tabs showing, eg. different branches. He can select in on
window the base object, switch to an other window, where he selects
the diff option. He can also go back in the browser history, without
losing his selection.

Any sugesstions, how the UI can be improved or designed better?

To the implementation:

The whole thing can be implemented without any JavaScript on the
server side. For an out of tree implementation, my prototype is
simpler to maintain, as it needs only a few small changes to gitweb.

If there is an interesst in this feature (and nobody opposes including
it), I can reimplement it in perl.

I would do it in the following way:
1) introduce git_treediff
2) Add the generation of a base and diff link to each object
3) If a base link is selected, the server sends a Set-Cookie header
and redirects to the page, where it came from. So maybe the broser can
fetch the page out of its cash in some situation.
4) If a diff link is selected, based on the base object in the cookie,
the url to do the diff and redirects the browser to it. This should
simplify caching.

If depending on cookies is a problem for some out there, the base
object can be passed in the URLs as fallback. It would require, that
the select base object is included in every link, which gitweb
generates.

mfg Martin K=F6gler
