From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-send-mail in sh
Date: Fri, 25 Nov 2005 03:15:44 -0800
Message-ID: <7v7jaxou5b.fsf@assigned-by-dhcp.cox.net>
References: <4386DD45.6030308@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 25 12:16:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfbYW-00085J-3z
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 12:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbVKYLPr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 06:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbVKYLPr
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 06:15:47 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:30899 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751430AbVKYLPq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 06:15:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051125111435.MXKY26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 25 Nov 2005 06:14:35 -0500
To: Andreas Ericsson <ae@op5.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12737>

Andreas Ericsson <ae@op5.se> writes:

> It's better than the perl version because;

Good.

> It's worse than the perl version because;
> 1. It doesn't thread the patch-series (which I personally prefer anyway 
> since it's easier to follow a thread on a particular patch that way).

I think that is an improvement, actually ;-)

> 2. The patches sent within the same second arrive in random order.

I think you can fudge the "Date: " yourself.  Count the number
of messages you are going to send out, grab the wallclock time
before starting to send the first message, subtract that number
of seconds and give it to the first message, add 1 second and
give it to the second message, and so on.

3. It does not CC signers and authors.  Although I personally
consider not doing it "better", some people _might_ want to keep
that behaviour as an option.

> # Instead of applying the 8942 chars long RFC-exact regex to
> # match recipients email addresses against, we're satisfied with
> # a simple @ somewhere inside an argument and just assume that
> # people won't try anything obviously stupid

This is probably adequate in practice.  I have not seen an
e-mail address other than local-part@domain (RFC2822-speak
"addr-spec") form of mailbox on the kernel list for some time.

> function usage() {
> 	echo "Usage: git submit upstream@email.org <commit-ish> [<commit-ish>]"
> 	exit 1
> }

I'm old fashioned and tend to omit noise word "function".

The original format-patch parameters are my fault, but I'd
rather see newly written commands done like this:

	"git-send-email" <param>+

        <param> = <patch> | <addressee> | <commits>
        <patch> = <anything that passes "test -f">
	<addressee> = <RFC2822 addr-spec>
        <commits> = ".." <top> | <bottom> ".." <top> | <commit>
	<bottom> = <extended SHA1 expression>
	<top>    = <extended SHA1 expression>
	<commit> = <extended SHA1 expression>

 * ..<top> is a shorthand of "origin"..<top> (the choice of
   "origin" might be debatable, but probably sane).

 * <bottom>..<top> pair is to format changes in <top> but not in
   <bottom>; typically <top> is the name of a topic branch, and
   <bottom> is typically "origin".  This is to encourage the use
   of topic branches.

 * <commit> is a shorthand for <commit>^1..<commit>; this is to
   allow you to quickly pick just one commit and send it out.

> function abort() {
> 	echo "Aborting."
> 	exit 0
> }

Abort but exit 0?  You do not seem to be using it though ;-).

> commits=0
> if [ "$com1" ]; then
> 	if [ -z "$com2" ]; then
> 		com2="$com1"
> 		com1=HEAD
> 	fi
>
> 	commits=$(git rev-list $com1 ^$com2 | wc -l)
> fi

You do not want to count commits like this.  format-patch drops
patches that are already in upstream even if they are recorded
as diffrent commit objects, so the number you get from rev-list
is just an upper bound, and may not match the number of commits
that would be formatted.

> [ $commits -eq 0 -a -z "$patches" ] && usage

And I'd probably drop this one as well; you can have the check
before sending things out, right?

> # [ "$email" ] || git repo-config --get patch_email_address

Storing the default addressee in the config is a good idea,
since typically e-mail submissions are to a single address.

> [ $commits -gt 1 ] && opts=-n

You can always say -n if you want to do this; format-patch -n
with a single patch would not say [PATCH 1/1].

> for patch in $(git format-patch $opts $com2 $com1 | sed 's/^* //'); do
> 	patches="$patches $patch"
> done

This is the first script I saw that uses the standard output
from format-patch, and I do not think nobody else used it so
far.  If the standard output from format-patch is useful like
this, I would like to drop the '* ' prefix from it, so that you
do not have to sed it out.

You would probably want to do "format-patch -o $tmpdir" at least
not to smudge the toplevel directory.
