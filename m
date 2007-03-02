From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Quick description of possible gitattributes system
Date: Thu, 01 Mar 2007 16:09:39 -0800
Message-ID: <7vejo8o69o.fsf@assigned-by-dhcp.cox.net>
References: <200703011206.47213.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 01:10:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMvLg-0000Mk-T8
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 01:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161262AbXCBAJm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 19:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161294AbXCBAJm
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 19:09:42 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:32983 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161262AbXCBAJk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 19:09:40 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070302000938.FBTD26279.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 1 Mar 2007 19:09:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Vc9f1W0041kojtg0000000; Thu, 01 Mar 2007 19:09:39 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41154>

Andy Parkins <andyparkins@gmail.com> writes:

> +Attributes are attached to paths in one of two ways:
> +
> + - Via the .gitattributes file.  This will work in the same way as the
> +   .gitignore file.  That is, there can be multiple .gitattributes files
> +   throughout the working directory.
> +
> +   Typically the .gitattributes file will be a version controlled file,
> +   just like .gitignore.

Another point to stress here is that these are property of the
paths of the project and independent of the platform each user
happens to have a repository of the project on.  If something is
text, then it is text whether the platform is on UNIX or on DOS.

> +   It will obviously be of different format from the .gitattributes
> +   file, but the attribute names and path specification will be
> +   identical (and specified as if from the root of the repository tree).

I am in favor of also using $GIT_DIR/config format even for the
in-tree .gitattributes files.  For one thing, it makes the
syntax and quoting rules saner and more consistent (blanks in
pathname patterns and such), and we already have a parser for
it.

	[attribute "image/png"]
        	path = "*.png"

	[attribute "image/jpg"]
        	path = "*.jpg"
        	path = "*.jpeg"

	[attribute "text"]
		; anything that is image/* is non-text -- I am
                ; not sure if we want to allow this which means
                ; we need to resolve dependencies, though.
                attr = "!image/*"
		; inside list of path-patterns, the first match wins.
		path = "!this-is-not-text.txt"
        	path = "*"

	; .gitignore is a mere special case of "ignored" attribute.
	[attribute "ignored"]
        	path = "*~"
                path = "!hand-maintained.o"
                path = "*.[aso]"

Earlier, I said attributes are property of project, but that
does not mean we should forbid users to define more paths in
config.  On DOS, you might want to have:

	[attribute "ignored"]
        	path = "*.obj"

to suppliment the last entry of the above "ignored" that is
meant to catch object files, until the upstream project adds it
to the .gitattribute files.

In contrast to that attributes define property of paths of the
project, handlers define how we should behave on paths with
certain attributes in a particular repository.  So it is
important to stress that that handler sections should never
appear in in-tree .gitattributes files.  Because they are
per-repository, the same project checked out on DOS will be used
with this handler definition (which would be the built-in
default not to require the users to have one in ~/.gitconfig):

	[handler "text"]
        	input = crlf
                output = crlf

while on UNIX the input/output would be no-op.

> +----------------------------------------
> +[handler "fix-line-endings"]
> +  attribute = text/plain
> +  infilter = eol_lf
> +  outfilter = eol_local
> +----------------------------------------
> +
> +This definition creates a handler named "fix-line-endings" (don't suppose
> +they actually need names) that would run the "eol_lf" filter on check
> +in, and the "eol_local" filter on checkout.

I would suggest making handler section _match_ the attribute
names.  By "match", what I mean is to allow something like this:

	[handler "image/*"]
        	pretty = "cmd display -"

even though the attributes are "image/png", "image/jpg", etc.

> +[handler "show-images"]
> +  attribute = image/gif
> +  prettyfilter = pipe display -

I would recommend against calling them *filter.  After all, the
semantics of each handler action (such as input, output and
pretty) already determine if it needs to act as a filter or data
sink.  We do not need to say prettyfilter either; it is not even
a filter to begin with -- it is a data sink.
