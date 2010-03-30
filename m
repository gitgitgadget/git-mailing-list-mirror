From: Eli Barzilay <eli@barzilay.org>
Subject: Re: git check-attr in bare repositories
Date: Tue, 30 Mar 2010 00:53:39 -0400
Message-ID: <19377.33747.838003.360864@winooski.ccs.neu.edu>
References: <m3iq8jn3ar.fsf@winooski.ccs.neu.edu>
	<20100328014208.GA23015@progeny.tock>
	<19376.50971.397375.810974@winooski.ccs.neu.edu>
	<19376.53419.640007.930897@winooski.ccs.neu.edu>
	<20100329231501.GA28194@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 06:53:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwTSV-0004yc-F4
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 06:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637Ab0C3Exm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 00:53:42 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:42639 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290Ab0C3Exl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 00:53:41 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1NwTSN-0008KE-RQ; Tue, 30 Mar 2010 00:53:39 -0400
In-Reply-To: <20100329231501.GA28194@progeny.tock>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143543>

On Mar 29, Jonathan Nieder wrote:
> Eli Barzilay wrote:
> > On Mar 29, Eli Barzilay wrote:
> >> On Mar 27, Jonathan Nieder wrote:
> [in a bare repository]
> 
> >>>  GIT_INDEX=tmp-index git check-attr "$@" &&
> [...]
> >> I tried that, but it doesn't work.  (I used GIT_INDEX_FILE.)
> 
> Yes, not sure how I confused myself.
> 
> git explicitly guards against that in attr.c.
> 
> 	/*
> 	 * Read from parent directories and push them down
> 	 */
> 	if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {

Ugh...!


> That check comes from v1.5.6-rc3~9^2 (Ignore .gitattributes in bare
> repositories, 2008-06-08).  This is consistent with how bare
> repositories generally work: they are guarded against use with a
> populated index, since what filesystem tree would that index track?

Well, I've seen more than a few places that say that git attributes
are the right choice to use for svn properties...  (I think that I
also asked a question about this here.)

There are a number of technicalities that make git attributes a poor
substitute for svn properties -- mainly the fact that they limited in
contents (basically just short strings, no quoting, no newlines), and
the fact that they're not tracked with the files (as in svn, where
moving a file somewhere will move its properties with it).  Both of
these are not too bad for what we use them (files don't move often,
and we use short strings only).  But having no access to them on the
server (without a costly checkout) is making it even more problematic,
to the point that coming up with our own home cooked thing is easier
than using git attributes.  Given that they're not intended for
end-user consumption (eg, `check-attr' being an internal helper) it
looks like we're not giving up much anyway.


> To support your use case, it would be nice for check-attr to learn a
> --direction option.  Maybe it would be safe to let check-attr read
> from the index in bare repositories by default anyway, since the
> index is usually missing anyway.

Well, using the index this way seems like a kind of a hack anyway, so
I'm not sure that there is any reason to do this.  If anything, I'd
like it if `check-attr' could just use the repository directly instead
of the index (or a work tree) in a bare repository.  Without that, and
the best solution that I see in the short term, it should throw an
appropriate error instead of just producing an "unspecified".

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
