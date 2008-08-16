From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Sat, 16 Aug 2008 17:07:15 +0200
Message-ID: <20080816150715.GA4057@efreet.light.src>
References: <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080810112038.GB30892@cuci.nl> <20080809210733.GA6637@oh.minilop.net> <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080809210733.GA6637@oh.minilop.net> <20080810110925.GB3955@efreet.light.src> <20080816062130.GA4554@oh.minilop.net> <7vd4k9e120.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Triplett <josh@freedesktop.org>,
	Jamey Sharp <jamey@minilop.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Stephen R. van den Berg" <srb@cuci.nl>, david@lang.hm,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 17:08:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUNOH-0003uS-QG
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 17:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbYHPPH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 11:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbYHPPHZ
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 11:07:25 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:48088 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbYHPPHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 11:07:25 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 22CFD572DB;
	Sat, 16 Aug 2008 17:07:21 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id bM0G-wnALi9O; Sat, 16 Aug 2008 17:07:18 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 1940357287;
	Sat, 16 Aug 2008 17:07:16 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KUNN5-0001BY-UT; Sat, 16 Aug 2008 17:07:15 +0200
Content-Disposition: inline
In-Reply-To: <7vd4k9e120.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92548>

On Sat, Aug 16, 2008 at 02:55:51 -0700, Junio C Hamano wrote:
> Josh Triplett <josh@freedesktop.org>, Jamey Sharp <jamey@minilop.net>
> writes:
> 
> > This hook would need to provide a way to process these updates before
> > the blob or tree contents get put into place.  For example, if you check
> > out /etc/shadow, you need to apply the non-world-readable permissions
> > *before* you write out the contents.
> 
> I think such atomicity or "checkout race problem" is irrelevant.
> 
> I'd like to make a comment on this point, even though at the moment
> (especially before the real release), I am not very interested in where
> this "proposal" is going.
> 
> You mention that you would resolve attribute conflicts just the same way
> you would resolve contents conflicts, which in turn means that you would
> check out a half-merged state with conflict markers to the working tree,
> fix up the filesystem entity (both contents and presumably its attributes
> like perm bits, ownership, xa and whatnot), and mark the path resolved.
> Even without talking about attributes conflicts, what's your position on
> the time-window during which the contents of /etc/shadow and /etc/password
> have conflict markers in them?

Well, there are situations where conflicts can happen and situations where
they can't. So I think the solution is "don't merge in the live directory"
(applicable to other uses of version control in other kind of live copies
too).

> Luckily, the markers do not have sufficient number of colons, and that
> would protect your system from attempts to break into it with a phoney
> username '=======' with an empty password ;-), but I think you get the
> idea.  Anything that has to be in some consistent state that cannot see
> conflicted state in the middle should not be merged in-place [*1*], [*2*].
> 
> So please simplify your requirements and at least drop atomicity argument.

The atomicity requirement is real for some applications, like the etckeeper.

It should be restated in terms of moving the content to the work tree rather
than before writing it out -- the content can be written out to a staging
area, attributes applied and than moved into the tree. IIUC git already uses
a staging area during checkout, no?

> I am _not_ fundamentally opposed to somebody who wants to use git or any
> other SCM as a cooler representation of snapshots than a sequence of
> tarballs.  I however would be unhappy if your design and implementation
> becomes more complicated than otherwise only because you try to deal with
> the atomicity issue.  IOW, if your solution would become much simpler once
> you pare down the atomicity requirement, then I'd reject the more complex
> variant with atomicity in any second, even though I might still find the
> simpler variant that does not care about atomicity worth considering.

I don't think the atomicity requirement should make anything more
complicated. It is only a matter of running the hook applying the attributes
-- I think git should not define meaning of the attributes -- at the right
point during the checkout process.

> [Footnotes]
> 
> *1* That is why people often frown upon "using SCM to track changes of a
> live system in-place", and suggest tracking source material in SCM, and
> build material to deploy from the source and install into the final
> destination (not limited to /etc but more often so for e.g. web server
> assets) as a better practice.

Yes, unless you need to track the changes done in the live directory by other
software, which is the case for /etc. It is also the case for ikiwiki-based
web sites.

You still need to avoid merging in the live tree to avoid breaking it, but
git always allows you to create a separate staging tree for such tasks.

> *2* Also you should realize your "/etc/shadow must be non-world-readable
> from the beginning" is a very application specific wish.  What if the
> attribute you are trying to enforce is "this path must always be
> world-readable"?  Are you going to limit this "attribute enhancements" to
> what you can specify at creat(2) time only?  How would you handle "this
> path must be owned by user 'www-data' (assuming root drives git)", which
> would be done by creat(2) followed by chown(2)?

Yes, that does not make sense. But if you restate the requirement that the
attributes must be applied when the file becomes accessible in the work tree,
than it makes sense and is easily doable by writing the file to a temporary
location -- which is sufficiently protected if it is inside .git -- and
moving it into the tree as the last step. (The data is available inside
.git/objects and .git/packs, so they are only as well protected as the .git
dir itself is, so no restrictions as long as the file is inside .git).

Best regards,

Jan

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
