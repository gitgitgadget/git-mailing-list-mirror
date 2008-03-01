From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] git-submodule: New subcommand 'summary' (1) -
 code framework
Date: Fri, 29 Feb 2008 23:28:44 -0800
Message-ID: <7vk5km7vir.fsf@gitster.siamese.dyndns.org>
References: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
 <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 08:30:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVMAR-0002jD-7s
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 08:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070AbYCAH27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 02:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752785AbYCAH27
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 02:28:59 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39942 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbYCAH26 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 02:28:58 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2EB1A2245;
	Sat,  1 Mar 2008 02:28:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D21A72244; Sat,  1 Mar 2008 02:28:52 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75627>

Ping Yin <pkufranky@gmail.com> writes:

> Following patches teach git-submodule a new subcommand 'summary' to show
> commit summary of user-cared (i.e. checked out) submodules since a given
> commit (default HEAD) of super project.
>
> For a submodule in question, a series of commits will be shown as the path
> from the src commit to the dst commit, where the src commit is from the given
> super project commit, and the dst commit is from the index or working tree
> (switched by --cached).
>
> .Example: a super project with modified/deleted/typechanged submodules sm1 to sm5.

Overlong lines.  What's the dot before "Example"?

>  # * sm2 5c8bfb5...000000:
>  #   <one line message for F
>  #
>  # * sm3 354cd45...3f751e5:
>  #   Warn: sm3 doesn't contain commit 354cd45

Nice touch.  This can happen even there is no repository corruption.
E.g. you can have a checkout of supermodule at a revision newer than your
last "git fetch" in sm3.

>  # * sm4 354cd34(submodule)->235efa(blob):
>  #   <one line message for G
>  #
>  # * sm5 354cd34(blob)->235efa(submodule):
>  #   >one line message for H
>  #
> ...
> Illustration for output of deleted sm2 is similar.
>
> sm3 and sm4 are submodules with typechanging (blob<->submodule).

Are they?  I think you meant 4 and 5.

> This patch just gives the framework. It just finds the submodules to be
> shown as follows.
>
> --------------------------------------------
>  $ git submodule summary
>  # Submodules modifiled: sm1 sm2 sm3 sm4 sm5
>  #
> --------------------------------------------

Probably it would be a better organization to show only this in the commit
log message for [1/3] and describe how the output is enhanced in the log
message of the commit as the code builds more .

> @@ -320,7 +320,69 @@ set_name_rev () {
>  	) )
>  	test -z "$revname" || revname=" ($revname)"
>  }
> +#
> +# Show commit summary for submodules in index or working tree relative to the given commit
> +#
> +# If '--cached' is given, show summary between index and given commit,
> +# or between working tree and given commit

Overlong lines again.

> +# @ = [head counting commits from (default 'HEAD'),] requested paths (default to all)
> +#

What's "@ =" convention?

> +cmd_summary()
> +{

We seem to have '{' on the same line for shell functions in our scripts.

> +	# parse $args after "submodule ... summary".
> +	while test $# -ne 0
> +	do
> +		case "$1" in
> +		--cached)
> +			cached=1
> +			;;

If you do this "cached="$1" instead here, then you do not need to do ... 

> +	cache_option=${cached:+--cached}

... this.

> +
> +	if rev=$(git rev-parse --verify "$1^0" 2>/dev/null)
> +	then
> +		head=$rev
> +		shift
> +	else
> +		head=HEAD
> +	fi

Hmph, is showing diff with anything other than HEAD useful?  What happens
if the user says "git submodules status HAED" by mistake?

> +
> +	cwd=$(pwd)
> +	cd_to_toplevel
> +
> +	# Get modified modules cared by user
> +	modules=$(git diff $cache_option --raw $head -- "$@" |

When scripting, please do not use "git diff" unless absolutely necessary.
Its output is not meant for script consumption and can be made more "user
friendly" as user request comes in.  Instead, use "git diff-index" here.

> +		grep '^:160000\|:[0-9]\+ 160000' |

This looks troublesome.

 - [0-9] is obviously wrong and [0-7] is what you meant;
 - \| and \+ are not BRE but GNU.

It probably is more portable if written like this:

	grep -e '^:160000 ' -e '^:[0-7]* 160000 '

> +	# TODO: quote module names containing space or tab

Yeah, the scripted version is bound to have a lot of issues with funny
characters, but let's not worry about it too much.  It is something we can
fix later and more easily when we rewrite it in C (or Perl), but first get
the feature right and stable.

> +	test -n "$modules" &&
> +	echo "# Submodules modified: "$modules &&
> +	echo "#"
> +	cd "$cwd"

Hmph, is there any point to try coming back there?  You could have even
done the cd-to-toplevel inside of $( ... ) construct which is run inside a
subshell, so...
