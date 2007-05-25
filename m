From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Add git-submodule command
Date: Fri, 25 May 2007 15:46:15 +0200
Message-ID: <8c5c35580705250646h12f4f30bt301f4c4bdc2ad530@mail.gmail.com>
References: <11800866643203-git-send-email-hjemli@gmail.com>
	 <Pine.LNX.4.64.0705251157450.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 25 15:46:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hra7b-0003C6-OU
	for gcvg-git@gmane.org; Fri, 25 May 2007 15:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbXEYNqR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 09:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbXEYNqR
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 09:46:17 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:4909 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbXEYNqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 09:46:16 -0400
Received: by wa-out-1112.google.com with SMTP id j4so333972wah
        for <git@vger.kernel.org>; Fri, 25 May 2007 06:46:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EcZDTx+iGnbR+dQwFH4WKXgUSCo62XOK6UA4TnUbgRBlcKqAXakEZSb2hZgGOw2PWmRrWb9m7zyDsoSEiHV6cXHQ/iFb5gR+XTrgerQ/oUpoAbRNN6HIF3hn5BRyT7hSRkkHIS8HECVN46ECU3NngEbtPvC8zkJ18vdpO1wfh7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RQRqOyYLlHB0K4uNd2DvKBFFpMAt4FqRT35UBjKqFBuMfEVLTq7Y5xel4QJcUNnx8bHNQvIKek4QG1y7u9UvIANwC5rApLPz4+yYv27DkEvX8kqPTHZ7hWkZVla0GMDdYHYZqr1LWkZltriqmsF/9nzmg4bCdpY0Ng0covVG0tc=
Received: by 10.114.146.1 with SMTP id t1mr1516196wad.1180100775920;
        Fri, 25 May 2007 06:46:15 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Fri, 25 May 2007 06:46:15 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705251157450.4648@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48373>

On 5/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 25 May 2007, Lars Hjemli wrote:
>
> > There is currently no way to override the mappings in the .gitmodules
> > file, except by manually creating the subproject repository.
>
> I think that is okay. We can add that easily at a later stage, and the
> script is much easier without that logic.

Yes. And it is sort of a feature: if you've cloned the submodule using
a different (aka local) url, 'git submodule --init' will leave it
alone.

>
> > diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>
> Looks good here, I checked with asciidoc.

Thanks.

>
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > new file mode 100755
> > index 0000000..c4a1cc3
> > --- /dev/null
> > +++ b/git-submodule.sh
> > @@ -0,0 +1,163 @@
> > +#!/bin/sh
> > +#
> > +# git-submodule.sh: init, update or list git submodules
> > +#
> > +# Copyright (c) 2007 Lars Hjemli
> > +
> > +USAGE='[-i | --init | -u | --update] [-q | --quiet] [--cached] <path>...'
> > +. git-sh-setup
> > +require_work_tree
> > +
> > +init=
> > +update=
> > +quiet=
> > +cached=
> > +
> > +#
> > +# print stuff on stdout unless -q was specified
> > +#
> > +say()
> > +{
> > +     if test -z "$quiet"
> > +     then
> > +             echo -e "$@"
> > +     fi
> > +}
> > +
> > +#
> > +# Find all (requested) submodules, run clone + checkout on missing paths
> > +#
> > +# $@ = requested paths (default to all)
> > +#
> > +modules_init()
> > +{
> > +     git ls-files --stage -- $@ | grep -e '^160000 ' |
>
> Any reason you read in the stage? It does not seem that you use it.

Are there any other way to get the mode info?


>
> > +     while read mode sha1 stage path
> > +     do
> > +             test -d "$path/.git" && continue
> > +
> > +             if test -d "$path"
> > +             then
> > +                     rmdir "$path" 2>/dev/null ||
> > +                     die "Directory '$path' exist, but not as a submodule"
> > +             fi
> > +
> > +             test -e "$path" &&
> > +             die "A file already exist at path '$path'"
> > +
> > +             url=$(GIT_CONFIG=.gitmodules git-config module."$path".url)
>
> I like that command ;-)
>
> > +             test -z "$url" &&
> > +             die "No url found for submodule '$path' in .gitmodules"
> > +
> > +             git-clone "$url" "$path" ||
> > +             die "Clone of submodule '$path' failed"
> > +
> > +             $(cd "$path" && git-checkout -q "$sha1") ||
> > +             die "Checkout of submodule '$path' failed"
> > +
> > +             say "Submodule '$path' initialized"
> > +     done
> > +}
> > +
> > +#
> > +# Checkout correct revision of each initialized submodule
> > +#
> > +# $@ = requested paths (default to all)
> > +#
> > +modules_update()
> > +{
> > +     git ls-files --stage -- $@ | grep -e '^160000 ' |
>
> Same here.
>
> > +     while read mode sha1 stage path
> > +     do
> > +             if ! test -d "$path/.git"
> > +             then
> > +                     say "Submodule '$path' not initialized"
> > +                     continue;
> > +             fi
> > +             subsha1=$(cd "$path" && git-rev-parse --verify HEAD) ||
>
> Maybe it would be a better idea to use "git --git-dir="$path" rev-parse
> ..."? Just in case somebody calls this with GIT_DIR overridden...
>
> Or, unset GIT_DIR explicitely.

Hmm, that's annoying (overridden GIT_DIR). I guess 'git --git-dir
$path/.git' would be the easiest solution.


>
> > +             die "Unable to find current revision of submodule '$path'"
> > +
> > +             if test "$subsha1" != "$sha1"
> > +             then
> > +                     $(cd "$path" && git-fetch && git-checkout -q "$sha1") ||
>
> This will make a detached HEAD, right? Do you want that? (I am not really
> interested in submodules myself, so I haven't thought about it, and I
> haven't followed that monster discussion.)

Well, we might want to be smarter about this, but on the other hand:
if the user cares, he can always do 'cd $path && git checkout
$branch', since 'git submodule -u' will skip submodules with the
correct commit checked out.

>
> > +                     die "Unable to checkout revision $sha1 of submodule '$path'"
> > +
> > +                     say "Submodule '$path' reset to revision $sha1"
>
> I'd rather not say "reset", since this has a different meaning in Git, but
> rather "set to revision $sha1".

Ok.

>
> > +             fi
> > +     done
> > +}
> > +
> > +#
> > +# List all registered submodules, prefixed with:
> > +#  - submodule not initialized
> > +#  + different version checked out
> > +#
> > +# If --cached was specified the revision in the index will be printed
> > +# instead of the currently checked out revision.
> > +#
> > +# $@ = requested paths (default to all)
> > +#
> > +modules_list()
> > +{
> > +     git ls-files --stage -- $@ | grep -e '^160000 ' |
> > +     while read mode sha1 stage path
> > +     do
> > +             if ! test -d "$path/.git"
> > +             then
> > +                     say "-$sha1 $path"
> > +                     continue;
> > +             fi
> > +             revname=$(cd "$path" && git-describe $sha1)
> > +             if git diff-files --quiet -- "$path"
> > +             then
> > +                     say " $sha1 $path\t($revname)"
> > +             else
> > +                     if test -z "$cached"
> > +                     then
> > +                             sha1=$(cd "$path" && git-rev-parse --verify HEAD)
> > +                             revname=$(cd "$path" && git-describe $sha1)
> > +                     fi
> > +                     say "+$sha1 $path\t($revname)"
> > +             fi
> > +     done
> > +}
> > +
> > +
> > +while case "$#" in 0) break ;; esac
> > +do
> > +     case "$1" in
> > +     -i|--init)
> > +             init=1
> > +             ;;
> > +     -u|--update)
> > +             update=1
> > +             ;;
> > +     -q|--quiet)
> > +             quiet=1
> > +             ;;
> > +     --cached)
> > +             cached=1
> > +             ;;
> > +     --)
> > +             break
> > +             ;;
> > +     -*)
> > +             usage
> > +             ;;
> > +     *)
> > +             break
> > +             ;;
> > +     esac
> > +     shift
> > +done
> > +
> > +
> > +if test "$init" = "1"
> > +then
> > +     modules_init $@
> > +elif test "$update" = "1"
> > +then
> > +     modules_update $@
> > +else
> > +     modules_list $@
> > +fi
>
> I'll let Junio comment on that command line parsing...

Heh, I'm a shell illiterate...

>
> All in all, I like it: it is short, to the point, and it should do the job
> (maybe with a few enhancements like "--update" without arguments means
> _all_ submodules).

Well, it does (or should) update all initialized submodules, but maybe
that's not what you meant?

Thanks for the review!

--
larsh
