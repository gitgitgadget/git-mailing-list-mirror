From: Junio C Hamano <junkio@cox.net>
Subject: Re: Implementing branch attributes in git config
Date: Sun, 07 May 2006 15:24:47 -0700
Message-ID: <7v4q01jwwg.fsf@assigned-by-dhcp.cox.net>
References: <1147037659.25090.25.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 00:25:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcrga-0001ah-0q
	for gcvg-git@gmane.org; Mon, 08 May 2006 00:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWEGWYw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 18:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWEGWYw
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 18:24:52 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:21957 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932234AbWEGWYw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 18:24:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060507222451.OPZB25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 May 2006 18:24:51 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1147037659.25090.25.camel@dv> (Pavel Roskin's message of "Sun,
	07 May 2006 17:34:19 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19721>

Pavel Roskin <proski@gnu.org> writes:

> In particular, git-repo-config leaves the config file locked in the
> regex is wrong:
>
> $ git-repo-config branch.fetch "master:origin" +
> Invalid pattern: +
> $ git-repo-config branch.fetch "master:origin" +
> could not lock config file
>
> To fix it, just add "close(fd); unlink(lock_file);" after "Invalid
> pattern" in config.c.

I'd give Johannes the first refusal right to deal with this and
not touch repo-config.c myself for now, since I suspect I
tempted him enough to restructure it ;-).

> I don't quite understand what pattern is needed to add an entry.  "foo"
> seems to work fine, I don't know why.

I think the value regexp is "replace the ones that match this",
and the convention he came up with is to use "^$" to append (see
some examples in t/t1300-repo-config.sh).

In any case, Documentation/git-repo-config.txt mentions
value_regex without explaining what the semantics is.  This
needs to be fixed, probably like the attached patch.

> That problem with multiple values is that they are quite fragile and
> require special options to access them.  Since regex is used, dots in
> the branch names need to be escaped.  Probably more escapes are needed.

I have a suspicion that using regex while is more powerful and
expressive might be a mistake and it would be easier for users
(both Porcelain and end-users) to use fnmatch() patterns.

> Such limitations make it unpractical to use branch names in section or
> key names.  I'd like to have it fixed.

I thought that is what the "for blah" convention is for (BTW
"for" is not a keyword, just a convention).

Also the syntax is a bit confusing.  I initially was confused,
after looking at your example:

	[branch]
        	fetch = "localbranch:remotebranch"

that the colon separated value was a usual refspec, but it
isn't.  The LHS is the name of the current branch, and RHS is
the name of the remotes/ file, which is not a remote _branch_ at
all.  Perhaps something like this is semantically clearer, aside
from names -- I am bad at coming up with them:

	[branch]
		defaultremote = origin for master
                defaultremote = private for test

to mean, "we use remotes/origin when on master branch by
default".  Also we would want to use remote.origin.{url,fetch}
configuration item as well, so the "file existence" check you do
in this part of the patch is wrong.

>  case "$#" in
>  0)
> -	test -f "$GIT_DIR/branches/origin" ||
> -		test -f "$GIT_DIR/remotes/origin" ||
> -			die "Where do you want to fetch from today?"
> -	set origin ;;
> +	get_config_rem_branch
> +	test -f "$GIT_DIR/branches/$fetch_branch" ||
> +		test -f "$GIT_DIR/remotes/$fetch_branch" ||
> +			die "No remote branch \"$fetch_branch\""
> +	set "$fetch_branch" ;;
>  esac

We should instead let the existence check do the right thing for
"$1" when it is used; after all the default "origin" may not
exist, and I suspect we do not probably check that (or if we do
already, the above check is totally unnecessary).

I haven't thought things through but I have a suspicion that
get_config_rem_branch might belong to git-parse-remote.sh not
git-fetch.sh.

-- >8 --
diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
index fd44f62..660c18f 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -23,10 +23,11 @@ You can query/set/replace/unset options 
 actually the section and the key separated by a dot, and the value will be
 escaped.
 
-If you want to set/unset an option which can occur on multiple lines, you
-should provide a POSIX regex for the value. If you want to handle the lines
-*not* matching the regex, just prepend a single exclamation mark in front
-(see EXAMPLES).
+If you want to set/unset an option which can occur on multiple
+lines, a POSIX regexp `value_regex` needs to be given.  Only the
+existing values that match the regexp are updated or unset.  If
+you want to handle the lines that do *not* match the regex, just
+prepend a single exclamation mark in front (see EXAMPLES).
 
 The type specifier can be either '--int' or '--bool', which will make
 'git-repo-config' ensure that the variable(s) are of the given type and
