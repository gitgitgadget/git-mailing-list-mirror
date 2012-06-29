From: Phil Hord <phil.hord@gmail.com>
Subject: Re: git clone submodules recursive and reference
Date: Fri, 29 Jun 2012 16:19:35 -0400
Message-ID: <CABURp0rhsq8at8=8yDgDr4nt1Y4_t=yR=9dzKFpK59ZE6A5mnQ@mail.gmail.com>
References: <CAFj+z055ZZc-Am+pEMgjRvHgoxKSRBjnHhABCseC45+8YswKWg@mail.gmail.com>
 <4F91B22A.9000507@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Samuel Maftoul <samuel.maftoul@gmail.com>,
	git <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 29 22:20:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Skhfd-00029f-67
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 22:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932875Ab2F2UT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 16:19:57 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:51834 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932874Ab2F2UT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 16:19:56 -0400
Received: by ghrr11 with SMTP id r11so3133230ghr.19
        for <git@vger.kernel.org>; Fri, 29 Jun 2012 13:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PDTTdb9xE9nPa4TiUqUhaPbyGAvbcObP7zo+P34792Q=;
        b=feus51Nh51/kf0bvDoPcTIzBI4eBe5Cle0dQKHuNAp7K9j2lCFie3Fcccr3XFIZrXE
         szLJlm2isCmsu23wKbTf3VsO49EYZtD01PMefd8jG8svVOr2Oq3H807m4HB/K6iafEaQ
         wHyWkMfS1vjL9SzE/WemuUKOG9EYQRjpTktl0FvitbP8Wo104T2EQkbDKEOlb4Q4gZFq
         T+z6N67lO6sVmjYuYdjBFxGwXJxyt2FP6imNpyLe4IJ4/sU/Hirae5bcXYGkcOFRqOtB
         1bYiL7Efu/Q+ZAw8dFzuAO2/ux5nBy9NMb/XDlOu0OhuIz9NOa3d1HfEURYvFWmajHGw
         o/+Q==
Received: by 10.100.243.23 with SMTP id q23mr1403382anh.37.1341001195723; Fri,
 29 Jun 2012 13:19:55 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Fri, 29 Jun 2012 13:19:35 -0700 (PDT)
In-Reply-To: <4F91B22A.9000507@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200828>

On Fri, Apr 20, 2012 at 2:59 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 20.04.2012 17:12, schrieb Samuel Maftoul:
>> Hello,
>>
>> I'm using git clone --reference, it works like a charm !
>>
>> Now, I have submodules, so I call git clone with both --recursive and
>> --reference, works only for the repo itself, submodules are being
>> cloned without the "--reference" option.
>>
>> With GIT_TRACE=1 I can see this for the initial repo:
>>
>> trace: built-in: git 'clone' '--recursive' '--reference' [...]
>>
>> And this for the submodules:
>>
>> trace: built-in: git 'clone' '-n' [...]
>>
>> for every submodules.
>>
>> Is this an intended behavior ?
>
> Hmm, to me it looks like passing the --reference option to the clone
> run in the submodules doesn't make much sense, as that would make
> all submodules and the superproject use the same alternates. And as
> far as I know sharing objects between different repositories is not
> supported.

Suppose we had an option for submodules which would use the _relative_
submodule URL to augment the --reference path.  Would that be tenable,
or do we need some extra option?

On my Jenkins server, I have a local mirror of my repos on my Gerrit
server.  I intentionally set the mirror paths up to match the layout
of the Gerrit forest of repositories.  Thus, my relative URLs work for
local clones from this mirror as well.

Currently I am doing something like this:

myrepo=/tmp/test-mirror1
mirror=/var/lib/jenkins/mirror/superproject.git
remote=gerrit:superproject.git

#-- Clone fresh from local mirrors
git clone --recursive ${mirror} ${myrepo}
cd ${myrepo}

#-- Switch to the remote server URL
git config remote.origin.url ${remote}
git submodule sync

#-- Checkout remote updates
git pull --ff-only --recurse-submodules origin
git submodule update


In my tests, this is about twice as fast[*1*] doing it the normal way:

git clone --recursive ${remote} ${myrepo}


But I would like to just do it like this:

git clone --reference=${mirror} --recursive ${remote}  ${myrepo}

It would be silly for all the submodules to use that reference as-is,
except in the weird case where you've pull the remote objects from
several repositories into one bare container.  I would argue we don't
need to support the weird case at all, or only with some --weirdo
switch added on.  Except there is already precedent for doing this
"the weird way":

git submodule update --recursive --reference=/var/mirror/foo

There's nothing there that stops the the absolute reference being used
for each submodule, and that's glaringly discongruent to my proposed
addition to git-clone.  So I can think of two ways to move forward
with the relative-reference idea.

1. Use another switch to turn this behavior on
    git clone --reference=${mirror} \
              --submodule-relative-references \
              --recursive ${remote} ${myrepo}

2. Use a different switch name for 'reference':
    git clone --reference-forest=${mirror} \
              --recursive ${remote} ${myrepo}

Does someone have an opinion to guide me?

>> How can I force the clones for submodules to be executed with the
>> --reference option ?
>
> You'd have to use "git clone" without the --recursive option and
> then do a "git submodule update --init --reference ...".

Or the way I did it, but my method has its flaws.

Phil

[*1*] While it is twice as fast, it is subject to some fatal errors if
my mirrored repos are out of sync. That is, if a mirrored submodule
does not include the commit which is gitlinked from the
super-project's HEAD, then the original recursive clone will fail;
then I lose my speedup and possibly error out as well.  --references
does not suffer this same malady.
