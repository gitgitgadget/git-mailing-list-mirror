From: Herman van Rink <rink@initfour.nl>
Subject: Re: Subtree in Git
Date: Wed, 13 Jun 2012 15:20:03 +0200
Organization: Initfour Websolutions
Message-ID: <4FD89383.70003@initfour.nl>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com> <nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl> <87fwbgbs0h.fsf@smith.obbligato.org> <7v8vh78dag.fsf@alter.siamese.dyndns.org> <4FA82799.1020400@initfour.nl> <nngzk9jvemb.fsf@transit.us.cray.com> <nngaa0z3p8b.fsf@transit.us.cray.com> <87bokpxqoq.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Wed Jun 13 15:20:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SenUk-0000ol-6h
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 15:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009Ab2FMNUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 09:20:15 -0400
Received: from hosted-by.initfour.nl ([83.137.144.7]:44153 "EHLO
	mail.initfour.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab2FMNUN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 09:20:13 -0400
Received: from [192.168.42.73] (initfour.xs4all.nl [80.101.157.228])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: helmo@INITFOUR.NL)
	by mail.initfour.nl (Postfix) with ESMTPSA id 7DFE31954406;
	Wed, 13 Jun 2012 15:20:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <87bokpxqoq.fsf@smith.obbligato.org>
X-Enigmail-Version: 1.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199889>

On 12-06-12 03:30, greened@obbligato.org wrote:
> <dag@cray.com> writes:
>
>> <dag@cray.com> writes:
>>
>>>> Its now available as https://github.com/helmo/git/tree/subtree-updates
>>>> The subtree merge version is still available as
>>>> https://github.com/helmo/git/tree/subtree-updates-merged
>>> Cool.  I'll take a look, probably Wednesday at the earliest.
>> Ack.  Sorry, I got sidetracked by home repair issues.  This is still on
>> my radar.  Just wanted to let you know I haven't forgotten.
> Ok, I FINALLY got a look at this (yay!).  Some comments:
>
> Can you put each of these changes in its own commit?
>
>     Collected subtree updates
>     
>     These include:
>      * a .gittrees file with meta data
>      * new sub commands (push-all, pull-all, from-submodule, prune, diff, list)
>      * Documentation updates
>
> It's hard to tell what's what with one big diff.  Each command should
> get its own commit plus more if infrastructure work has to be done.  I
> realize it's a bit of a pain to reformulate this but git rebase -i makes
> it easy and the history will be much better long-term.
>
> Each command should be described briefly in the commit log.

That would indeed be nice, but as some parts interdependent it would be
rather complicated.
And what is the use if their not fully independently testable.

If you want to fake a nice history tree then go ahead, I just don't have
the energy to go through these commits again just for that.


> Some questions/comments:
>
> - Is .gittrees the right solution?  I like the feature it provides but
>   an external file feels a bit hacky.  I wonder if there is a better way
>   to track this metadata.  Notes maybe?  Other git experts will have to
>   chime in with suggestions.

It's similar to what git submodule does. And when you add this file to
the index you can use it on other checkouts as well.

>
>
> +               # this is ugly, but I don't know of a better way to do it. My git-fu is weak.
> +               # git diff-tree expects a treeish, but I have only a repository and branch name.
> +               # I don't know how to turn that into a treeish without creating a remote.
> +               # Please change this if you know a better way!
>
> - Anyone know a better way?  :)
>
>
> +               if [ $# -eq 1 ]; then
> +                       repository=$(git config -f .gittrees subtree.$prefix.url)
> +                       refspec=$1
> +               elif [ $# -eq 2 ]; then
> +                       repository=$1
> +                       refspec=$2
> +               else
> +                       repository=$(git config -f .gittrees subtree.$prefix.url)
> +                       refspec=$(git config -f .gittrees subtree.$prefix.branch)
> +               fi
>
> - This code seems to be repeated a lot.  Maybe it should be a utility
>   function.

Yes that's there three times...
 
>
>
> <more>
> +check_not()
> +{
> +       echo
> +       echo "check: NOT " "$@"
> +       if "$@"; then
> +               echo FAILED
> +               exit 1
> +       else
> +               echo ok
> +               return 0
> +       fi
> +}
> +
> +check_equal()
> +{
> +       echo
> +       echo "check a:" "{$1}"
> +       echo "      b:" "{$2}"
> +       if [ "$1" = "$2" ]; then
> +               return 0
> +       else
> +               echo FAILED
> +               exit 1
> +       fi
> +}
> <more>
>
> - I removed all this stuff in favor of the test library.  Please don't
>   reintroduce it.  These new tests will have to be rewritten in terms of
>   the existing test infrastructure.  It's not too hard.

I've left it in to be able to verify your new tests. Once all the new
tests are passing we can get rid of the old one, not before.
And as all the old tests are contained in test.sh it should not interfere...

>
> I like the features introduced here.  The code and tests need a bit of
> cleanup and they really should be split into multiple commits.
>
> Thanks for working on this!
>
>                                    -Dave
>


-- 
Met vriendelijke groet / Regards,

Herman van Rink 
Initfour websolutions
