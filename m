From: Junio C Hamano <junkio@cox.net>
Subject: Re: allow only a strictly defined set of references under .git/
Date: Fri, 16 Dec 2005 10:01:20 -0800
Message-ID: <7v1x0cj4zz.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0512160024q47afe0b9v1b7f217a6cecfe68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 19:02:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnJtW-0008JC-FV
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 19:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVLPSBX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 13:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbVLPSBX
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 13:01:23 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:20207 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751350AbVLPSBW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 13:01:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051216180041.NLKD15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Dec 2005 13:00:41 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13742>

Alex Riesen <raa.lkml@gmail.com> writes:

> The patch below reminded me of something:
>
>   +               /* We want to allow .git/description file and
>   +                * "description" branch to exist at the same time.
>   +                * "git-rev-parse description" should silently skip
>   +                * .git/description file as a candidate for
>   +                * get_sha1().  However, having garbage file anywhere
>   +                * under refs/ is not OK, and we would not have caught
>   +                * ambiguous heads and tags with the above test.
>   +                */
>   +               else if (**p && !access(pathname, F_OK)) {
>   +                       /* Garbage exists under .git/refs */
>   +                       return error("garbage ref found '%s'", pathname);
>   +               }
>
> Maybe we should only allow only a strictly defined set of refnames
> under $GIT_DIR? The directory is used pretty much for anything else
> (temporary message files, config, description).

I am glad somebody is paying attention.

The ref-to-object-name loop in get_sha1_basic() gets what the
user gave us, first checks it immediately under .git/ and then
under .git/refs, .git/refs/tags, .git/refs/heads, in this order.
Originally it grabbed the first match.  For the last couple of
weeks, it has been made "extra careful" to detect a case where
both .git/refs/heads/foo and .git/refs/tags/foo exists and
to reject unadorned "foo" with complaints.

I have been nagged by a suspition that the whole disambiguation
business should not be there [*1*].  I think the original
semantics of getting the first match is as easy to explain, if
not easier, as the current one, and I suspect that we do not
have to worry about .git/refs/heads/HEAD if we did so.  If
somebody is curious enough to name a branch "HEAD", the only
thing she should be aware of is this search order, and wherever
"branchname" is called for she should be able to say "HEAD" to
mean .git/refs/heads/HEAD, but places that call for an arbitrary
object name, she needs to disambiguate by saying "heads/HEAD" or
even "refs/heads/HEAD".

I suspect that git barebone Porcelain-ish carelessly uses
"git-rev-parse --verify $branchname" when it really means
"git-rev-parse --verify refs/heads/$branchname" in some places
[*2*], but if we fix them, we may not even need to have the "we
do not like HEAD" patch by Johannes (which has already been
merged).

Probably post 1.0 --- I have not assessed the extent of
confusion yet.


[Footnote]

*1* It was not in Linus version, and I consider anything I added
recently is of suspecious design value.

*2* That is, where we advertise that we get branchname as
parameter to the command.
