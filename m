From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Don't use $author_name undefined when $from contains no /\s</.
Date: Thu, 19 Oct 2006 12:03:45 -0700
Message-ID: <7vk62wruum.fsf@assigned-by-dhcp.cox.net>
References: <87vemgn1s2.fsf@rho.meyering.net>
	<7vbqo8uvkn.fsf@assigned-by-dhcp.cox.net>
	<878xjckw7x.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bug-diffutils@gnu.org,
	Paul Eggert <eggert@cs.ucla.edu>
X-From: git-owner@vger.kernel.org Thu Oct 19 21:04:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GadBd-0005rV-V6
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 21:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946390AbWJSTDr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 15:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946393AbWJSTDr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 15:03:47 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:26856 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1946388AbWJSTDq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 15:03:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061019190345.LBEM18180.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Thu, 19 Oct 2006 15:03:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cK3o1V0141kojtg0000000
	Thu, 19 Oct 2006 15:03:49 -0400
To: Jim Meyering <jim@meyering.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29379>

Jim Meyering <jim@meyering.net> writes:

> There were two differences, both involving removed trailing blanks.
> The first was a part of the diff: a line consisting of a single space
> denoting an empty line in the context.  I understood that those types
> of lines may safely be truncated (removing the trailing blank),
> and in fact, GNU diff -u (cvs) now does this by default:
>
> 2006-09-05  Paul Eggert  <eggert@cs.ucla.edu>
>
>         * NEWS: diff -u no longer outputs trailing white space unless the
>         input data has it.  Suggested by Jim Meyering.
>         * doc/diff.texi (Detailed Unified): Document this.
>         * src/context.c (pr_unidiff_hunk): Implement this.

Gaah.  Paul, why did you have to break this?  I see no good
reason, other than saving a single byte from the output stream
perhaps.

Leading ' ' at the context line is _not_ trailing white space;
it is a metadata just like a leading '+' or '-' is.

We could certainly update git-apply to understand it and we
probably would need to do so to cope with patch generated with
this *broken* GNU diff behaviour.

I see why some people consider why it _might_ be a good change.
A broken MUA tend to have trouble with lines that has only
whitespaces, so if a patch application program (patch or
git-apply) wants to deal with such a broken MUA, accepting a
totally empty line as if it is a line that has a single
whitespace at the beginning would save us from grief in some
cases.

However, I am not sure what "unless input data has it" means.
Does that mean if you have a line that has only one TAB (perhaps
caused by broken autoindent in the editor), that is "input data"
and is output as "SP TAB LF"?  If that is the case, then I do
not think dropping the leading SP only for an empty line makes
any sense.  A broken MUA would happily munge a line "SP TAB LF"
just as it would eat a line "SP LF".  Worse, such a MUA would
munge "+ TAB LF" into "+ LF", making the result of patch
application to be something the original patch author did not
intend to have.

If anything, this new behaviour makes the situation *actively*
worse.

By deciding to keep "SP TAB LF", you are saying that you _care_
about that trailing TAB in the patch and whitespace breakage
affects your payload in a bad way in your particular
application.  If that is the case, you would want to detect any
whitespace breakage a MUA might have caused before applying that
patch, and a broken context line that ought to be "SP LF" but
somehow comes out from MUA as "LF" would have served us as a
coalmine canary to help us detect the breakage.  Paul's change
to GNU diff is to kill that canary and I do not see any benefit
for doing so.

Why?

Please revert the patch, pretty please?
