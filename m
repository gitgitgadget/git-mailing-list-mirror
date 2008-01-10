From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] - Updated usage and simplified sub-command action invocation
Date: Wed, 09 Jan 2008 22:23:23 -0800
Message-ID: <7v8x2y8ahw.fsf@gitster.siamese.dyndns.org>
References: <1199938045-16289-1-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: imyousuf@gmail.com
X-From: git-owner@vger.kernel.org Thu Jan 10 07:24:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCqpe-0007I4-7a
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 07:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbYAJGXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 01:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbYAJGXd
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 01:23:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40012 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbYAJGXd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 01:23:33 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C12CB3B2B;
	Thu, 10 Jan 2008 01:23:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BB4323B2A;
	Thu, 10 Jan 2008 01:23:25 -0500 (EST)
In-Reply-To: <1199938045-16289-1-git-send-email-imyousuf@gmail.com>
	(imyousuf@gmail.com's message of "Thu, 10 Jan 2008 10:07:25 +0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70044>

imyousuf@gmail.com writes:

> From: Imran M Yousuf <imyousuf@smartitengineering.com>
>
> - manual page of git-submodule and usage mentioned in git-subcommand.sh
> were not same, thus synchronized them. In doing so also had to change the
> way the subcommands were parsed.
>
> - Previous version did not allow commands such as "git-submodule add init
> update". Thus not satisfying the following case -
>
> mkdir g; mkdir f; cd g/
> touch g.txt; echo "sample text for g.txt" >> ./g.txt; git-init;
> git-add g.txt; git-commit -a -m "First commit on g"
> cd ../f/; ln -s ../g/ init
> git-init; git-submodule add init update;
> git-commit -a -m "With module update"
> mkdir ../test; cd ../test
> git-clone ../f/; cd f
> git-submodule init update; git-submodule update update
> cd ../..; rm -rf ./f/ ./test/ ./g/

I find this too verbose with too little information.

If I am reading you correctly, what you meant was that the way
command parser was structured made subcommand names such as
"init" and "update" reserved words, and it was impossible to use
them as arguments to commands.

You could have said something like this instead:

	The command parser incorrectly made subcommand names to
	git-submodule reserved, refusing them to be used as
	parameters to subcommands.  For example,

        	$ git submodule add init update

	to add a submodule whose (symbolic) name is "init" and
	that resides at path "update" was refused.

That would have been much cleaner and easier on the reader than
having to decipher what the 20+ command shell script sequence
was doing.

I do agree that the breakage is worth fixing, though.

> +# Synopsis of this commands are as follows
> +# git-submodule [--quiet] [-b branch] add <repository> [<path>]
> +# git-submodule [--quiet] [--cached] [status] [--] [<path>...]
> +# git-submodule [--quiet] init [--] [<path>...]
> +# git-submodule [--quiet] update [--] [<path>...]

I somehow feel that syntactically the original implementation
that allowed subcommand specific options to come before the
subcommand name was a mistake.  It may be easier for users that
both "-b branch add" and "add -b branch" are accepted, but I
have to wonder if it would really hurt if we made "-b branch
add" a syntax error.

So how about reorganizing the top-level option parser like this:

        while :
        do
                case $# in 0) break ;; esac
                case "$1" in
                add | status | init | update)
                        # we have found subcommand.
                        command="$1"
                        shift
                        break ;;
                --)
                        # end of parameters
                        shift
                        break ;;
                --quiet)
                        quiet=1
                        ;;
                -*)
                        die "unknown option $1"
                esac
                shift
        done
        test -n "$command" || command=$default_command
        module_$command "$@"

And then make individual command implementations responsible for 
parsing their own options (and perhaps the common ones, to allow
"git submodule add --quiet", but that is optional), like:

        module_add () {
                while :
                do
                        case $# in 0) break ;; esac
                        case "$1" in
                        --cached)
                                cached=1
                                ;;
                        -b | --branch)
                                shift
                                branch="$1"
                                test -n "$branch" ||
                                die "no branch name after -b?"
                                ;;
                        --)
                                shift
                                break
                                ;;
                        --quiet)
                                quiet=1
                                ;;
                        -*)
                                die "unknown option $1"
                        esac
                        shift
                done
                repo=$1
                path=$2
                ...
        }

In the above illustration I did not bother eliminating cut&paste
duplication, but there may be a better way to share the piece to
parse common options across subcommands option parsers and the
toplevel one.
