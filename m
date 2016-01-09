From: Mike Hommey <mh@glandium.org>
Subject: Re: Should notes handle replace commits?
Date: Sat, 9 Jan 2016 09:25:10 +0900
Message-ID: <20160109002510.GA30050@glandium.org>
References: <20160108012830.GA2110@glandium.org>
 <xmqqh9in25py.fsf@gitster.mtv.corp.google.com>
 <20160108214939.GA22801@glandium.org>
 <xmqqziwfzl2s.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 01:25:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHhLg-0001e2-JX
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jan 2016 01:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbcAIAZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 19:25:19 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:38326 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbcAIAZS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 19:25:18 -0500
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <mh@glandium.org>)
	id 1aHhLC-000898-1e; Sat, 09 Jan 2016 09:25:10 +0900
Content-Disposition: inline
In-Reply-To: <xmqqziwfzl2s.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283591>

On Fri, Jan 08, 2016 at 03:51:39PM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > On Fri, Jan 08, 2016 at 12:09:45PM -0800, Junio C Hamano wrote:
> >> > So the question is, is this the behavior this should have?
> >> 
> >> The behaviour is a natural consequence of what graft and replace are
> >> about (i.e. "telling Git what the parents of a commit are" vs
> >> "telling Git what the contents of a commit are"), so the answer to
> >> the "should" question is a resounding "yes".
> >
> > It's not only about contents, except for a very broad definition of
> > contents that includes ancestry.
> 
> That is not broad at all.  A Git commit knows about its parents in
> exactly the same way as it knows about its tree and its own log
> message.  Hashing all of them together, without considering which
> part is "broad", gives us the content-addressible filesystem, which
> is "stupid content tracker", aka Git.
> 
> Perhaps you would see what is going on more clearly if you replace
> your "git log" with "git rev-list".
> 
> If your pre-graft/pre-replace histories were
> 
> 	A (first)  <--- B (second)  <--- C (third)	master
> 	X (rFirst) <--- Y (rSecond) <--- Z (rThird)	old
> 
> then your "graft" tells Git "B's parent is Z, not A.  If you run
> "rev-list master", it will give you "C B Z Y X".  The discrepancy
> (relative to the true history) brought in by "grafting" is that
> nowhere in "cat-file commit B" you would find Z, even though "log"
> and "rev-list" pretends as if Z is a (and the) parent of B.
> 
> Your "replace" tells Git "A records what Z records".  If you run
> "rev-list master", it will give you "C B A Y X".
> 
> A fake history made by "replace" does not have the same discrepancy
> as "grafting"; "cat-file commit B" names A as its parent, and asking
> what A is gives what actually is in Z, i.e. "cat-file commit A"
> shows what "cat-file commit Z" would give you.  The discrepancy with
> the reality "replacing" gives you is that hashing what you got from
> "cat-file commit A" does not hash to A (it obviously has to hash to
> Z).
> 
> > From my POV, replace is more about
> > "telling Git that this commit (and its parents) is really that one (and
> > its parents)".
> 
> Your "POV" does not match reality; replace is about telling Git to
> give contents recorded for object Z when anybody asks the contents
> recorded for object A.

It's not that different to me, but my point is that (almost) everything
about A redirects to Z, as you point out, _except_ notes.

So while `cat-file commit A` gives you what `cat-file commit Z` would,
`notes show A` doesn't give you what `notes show Z` would. And that's
this "inconsistency" that bothers me.

Mike
