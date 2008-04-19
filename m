From: Johan Herland <johan@herland.net>
Subject: Re: branch description
Date: Sat, 19 Apr 2008 11:18:49 +0200
Message-ID: <200804191118.50105.johan@herland.net>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com>
 <200804161029.18601.johan@herland.net> <200804182358.31041.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Matt Graham <mdg149@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Russ Dill <russ.dill@gmail.com>,
	Stephen Sinclair <radarsat1@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 18:11:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jn9F5-00056l-1W
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 11:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbYDSJTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 05:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753263AbYDSJTd
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 05:19:33 -0400
Received: from smtp.getmail.no ([84.208.20.33]:35068 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753252AbYDSJTc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 05:19:32 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JZK00K0BF88GY00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 19 Apr 2008 11:19:20 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZK00301F7EU9B0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 19 Apr 2008 11:18:50 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZK00J6SF7EJBD0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 19 Apr 2008 11:18:50 +0200 (CEST)
In-reply-to: <200804182358.31041.jnareb@gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79901>

On Friday 18 April 2008, Jakub Narebski wrote:
> On Wed, 16 April 2008, Johan Herland wrote:
> > So far, the best proposal I've seen, is Hommey's suggestion of storing
> > the description after the sha1 in the ref file itself. 
> > Of course, git would have to be taught (a) to handle ref files with
> > descriptions, and (b) to propagate descriptions along with refs.
> 
> (c) find a place for branch descriptions in packed refs.

This shouldn't be too hard. Today, we already have one kind of "special"
lines in the packed-refs format: "peeled", which uses lines starting with
"^". I think we could add another special kind of line called "description"
which uses lines starting with "#". Multiline descriptions (if we want to
support such) would just have "#" prepended to each line, and the parser
would associate all "#"-lines with the most recently parsed ref (like it
does for the "^"-line today).

> Let me sum up here proposals where to put branch description:
> 1. Put them in branch.<name>.description in repository config. Not easily
>    (automatically) propagated for dumb transports.
> 2. Put them in-tree, which is a bad idea because branches are
>    un-versioned (or versioned separately), so branches description
>    should also be un-versioned.
> 3. Put them in GIT_DIR/info/refs_description, in some format.  It makes
>    it very easy to add support for propagation for dumb transports.
>    Native transport probably would need some extension.  Should not
>    interfere with the rest of git code.
> 4. Store description after sha1 in the ref file itself.  Automatic
>    propagation for dumb transport (whether we want it or not).  Native
>    transport as above.  Very high probabily of interfering with the rest
>    of code, especially shell part of Git.  Need to find a place for
>    descriptions in pack-refs.
> 5. Store them as value of 'refs/heads/<branch>' file in a tree for
>    a commit for a special '<description>' separate special branch; at
>    least if I understand this proposal correctly.  Something like IIRC
>    the 'notes' / 'annotations' idea was implemented (on git mailing list;
>    it never got into mainline).
> 
> 
> I think that the best proposal is (3), not (4) as you say.

The problem with (3) vs. (4) is that in (3) we must make sure that whenever
a branch is moved/renamed (e.g. "git clone", "git branch -m", probably more
as well), the corresponding description is moved/renamed as well. This is
elegantly solved in (4). But as you say, (4) may have implementation
difficulties of its own. I guess the first acceptable implementation will
win.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
