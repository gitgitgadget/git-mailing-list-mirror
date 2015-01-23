From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] diff: make -M -C mean the same as -C -M
Date: Sat, 24 Jan 2015 07:26:59 +0900
Message-ID: <20150123222659.GA22303@glandium.org>
References: <1421978835-9921-1-git-send-email-mh@glandium.org>
 <xmqqr3ulqr09.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 23:27:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEmh9-0000gz-30
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 23:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbbAWW1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 17:27:11 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:49304 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbbAWW1J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 17:27:09 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YEmgt-0006jf-Pl; Sat, 24 Jan 2015 07:26:59 +0900
Content-Disposition: inline
In-Reply-To: <xmqqr3ulqr09.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262969>

On Fri, Jan 23, 2015 at 10:41:10AM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > While -C implies -M, it is quite common to see both on example command lines
> > here and there. The unintuitive thing is that if -M appears after -C, then
> > copy detection is turned off because of how the command line arguments are
> > handled.
> 
> This is deliberate, see below.
> 
> > Change this so that when both -C and -M appear, whatever their order, copy
> > detection is on.
> >
> > Signed-off-by: Mike Hommey <mh@glandium.org>
> > ---
> >
> > Interestingly, I even found mentions of -C -M in this order for benchmarks,
> > on this very list (see 6555655.XSJ9EnW4BY@mako).
> 
> Aside from the general warning against taking everything you see on
> this list as true

The problem is not whether what is on the list is true or not, but that
people will use what they see.

> I think you are looking at an orange and talking
> about an apple.  $gmane/244581 is about "git blame", and "-M/-C"
> over there mean completely different things.

I thought blame was using the diff option parser, and I was wrong.

(snip)
> In the context of "git blame", "-C" and "-M" control orthogonal
> concepts and it makes sense to use only one but not the other, or
> both.

In the context of blame both -C and -M |= a flags set, so one doesn't
override the other. You can place them in any order, the result will be
the same. Incidentally, -C includes the flag -M sets, so -C -M is
actually redundant. What -C and -M can be used for is set different
scores (-C9 -M8).

> But "-M" given to "git diff" is not about such an orthogonal
> concept.
> 
> Even though its source candidates are narrower than that of "-C" in
> that "-M" chooses only from the set of files that disappeared while
> "-C" also chooses from files that remain after the change, they are
> both about "which file did the whole thing come from?", and it makes
> sense to have progression of "-M" < "-C" < "-C -C".  You can think
> of these as a short-hand for --rename-copy-level={0,1,2,3} option
> (where the level 0 -- do not do anything -- corresponds to giving no
> "-M/-C").  It can be argued both ways: either we take the maximum of
> the values given to --rename-copy-level options (which corresponds
> to what your patch attempts to do), or the last one wins.  We happen
> to have implemented the latter long time ago and that is how
> existing users expect things to work.

Are they? I, for one, wasn't. It is easy to understand that --foo=1
--foo=2 is going to take the last given --foo, but do people really
expect the last of -C -M to be used? Reading the code further, I can see
that it's even more confusing than that: -C -C wins over -M, wherever it
happens. So -C -C -M == -C -C ; -C -M == -M ; -M -C == -C.

At the very least, this should be spelled out in the documentation.

Mike
