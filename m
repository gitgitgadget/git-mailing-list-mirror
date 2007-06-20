From: Junio C Hamano <gitster@pobox.com>
Subject: Re: filenames with " b" in them create confusing git diff-tree output
Date: Wed, 20 Jun 2007 12:59:40 -0700
Message-ID: <7v4pl2v1lf.fsf@assigned-by-dhcp.pobox.com>
References: <18041.3163.329391.298926@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jun 20 21:59:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I16LB-0007rg-2W
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 21:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542AbXFTT7n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 15:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756601AbXFTT7n
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 15:59:43 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:55780 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589AbXFTT7m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 15:59:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070620195941.EGLG1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Jun 2007 15:59:41 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Dvzg1X00U1kojtg0000000; Wed, 20 Jun 2007 15:59:41 -0400
In-Reply-To: <18041.3163.329391.298926@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Wed, 20 Jun 2007 21:15:39 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50563>

Paul Mackerras <paulus@samba.org> writes:

> paulus@quango:~/gitk/testrepo$ git diff-tree -r -p -C HEAD
> 71a3074e723c3e5eb599e6b3c47e3267a3cac3bc
> diff --git a/test b/foo b/test b/foo
> new file mode 100644
> index 0000000..f2e4113
> --- /dev/null
> +++ b/test b/foo
> @@ -0,0 +1 @@
> +stuff
>
> Note how there appear to be 4 filenames on the "diff --git" line.  At
> present gitk will interpret that as a diff between "test" and
> "foo b/test b/foo", since it looks for " a/" and " b/" to delimit the
> filenames.  Of course if the file got renamed it could get even more
> confusing. :)

Your example, "a/test b/foo" vs "b/test b/foo", can be and IS
parsed unambiguously by git-apply (you can try "git apply
--stat" your example).  IOW, the code to correctly handle it
already exists ;-)

If you are seeing a rename/copy you would get explicit rename
lines between "diff --git" header and "index HEXHEX..HEXHEX"
line, what we (i.e. git-apply) do is to make sure the
information we get on the "diff --git" header and those on
rename/copy lines match.  The latter is more reliable, of
course, as they are in strictly one-line-per-filename format,
and in fact we use the information from there instead of "diff
--git" line for rename patches.  And for non-rename case, you
can find all instances of "b/", and see if what follows to the
end of line of which instance of b/ does match what is between
"diff --git a/" and that "b/".

In your example, you have three possible "b/" that indicates the
beginning of a name:

	foo b/test b/foo
        test b/foo
        foo

The leading part after "diff --git a/" for the above three
possibilities are:

	test
        test b/foo
	test b/foo b/test

and you can tell the second one gives the match.

> Would there be any ill effects from quoting filenames with spaces, do
> you think?

It is very common (I would not do that personally but I do not
have a strong reason to advise against when people want to do
so) to have a space in filenames.
