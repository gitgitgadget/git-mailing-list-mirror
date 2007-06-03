From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 4/3] Simplify naming (versioning) of non-release tig tarball and rpm file
Date: Sun, 3 Jun 2007 23:12:59 +0200
Message-ID: <200706032312.59756.jnareb@gmail.com>
References: <200705281054.05376.jnareb@gmail.com> <200706021952.28426.jnareb@gmail.com> <20070603091126.GA1419@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Jun 04 01:19:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuzM0-00071L-Gj
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 01:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbXFCXTL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 19:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbXFCXTL
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 19:19:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:5595 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbXFCXTK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 19:19:10 -0400
Received: by ug-out-1314.google.com with SMTP id j3so615810ugf
        for <git@vger.kernel.org>; Sun, 03 Jun 2007 16:19:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=W14LG+vNI+lFBW9oObIK0gIhEtwhw1ca0XfPZKmZ/2fransPDuYUIGBn3ollODPMcgYS16gXGxOo80cxLFHWXI7eIjcctghs538xZzPNf+F1EVmse5S6P1mal71hIc3ubDyRJqeuv26tISwNuFRiLuzBAfaACO6/UY/ujGPrPOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mx5DZ3XxoWI6nKe8DUnuv04C5F+xWiT4Z6jXf6jezW/dlQuE1/u2/k6sma5RSYHnspopR6RWw3wdCfGtUp3tKyUuenLkUifqdtl8yKa7glAJR9W1PYmmRrKYmbSY0b5QDz0KkwuD72S0gy6SxxjUn2z5zQcQ3sDnHGZihK8Sijg=
Received: by 10.67.10.12 with SMTP id n12mr2684093ugi.1180912749103;
        Sun, 03 Jun 2007 16:19:09 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id j9sm7782622mue.2007.06.03.16.19.06;
        Sun, 03 Jun 2007 16:19:07 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070603091126.GA1419@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49050>

On Sun, 3 Jun 2007, Jonas Fonseca wrote:
> Jakub Narebski <jnareb@gmail.com> wrote Sat, Jun 02, 2007:

>> This is proposal to simplify naming of non-release tarballs and rpm file,
>> both for tig and also for git itself. Instead of using whole git-describe
>> output as version number in tarball/rpm name (BTW. it would be nice to
>> have command line switch to git-describe which would return old output,
>> without number of commits since given tag) use tag part as version number,
>> and number of commits since (plus optional marking dirty) as release
>> number.
>> 
>> What do you think about this?
> 
> I like the simpler and less confusing names. How about the simpler
> version below?

This version would work for tig now, but is not very generic. See also
comments below.

> BTW, I also added `make dist DIST_VERSION=X.Y` to make it easy to force
> a version. I used it when building the documentation in the release
> branch.

Nice idea.
 
>> diff --git a/Makefile b/Makefile
>> index b49d7f8..1e67586 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -17,7 +17,13 @@ ifdef DIST_VERSION
>>  VERSION	= $(DIST_VERSION)
>>  endif
>>  
>> -RPM_VERSION = $(subst -,.,$(VERSION))
>> +# $(GITDESC) looks like either x.y, or like x.y-z-g<sha1>
>> +SPLIT_VERSION := $(shell echo $(GITDESC) | \
>> +                   sed -e 's/^\(.*\)-\([0-9]\+\)-\(g[0-9a-f]\+\)$$/\1 \2 \3/g')
>> +RPM_VERSION = $(subst -,.,$(word 1,$(SPLIT_VERSION)))
>> +RPM_RELEASE = $(strip \
>> +              $(subst -,.,$(if $(word 2,$(SPLIT_VERSION)),\
>> +                               $(word 2,$(SPLIT_VERSION)),0)$(WTDIRTY)))
>>  
>>  LDLIBS	= -lcurses
>>  CFLAGS	= -Wall -O2 '-DVERSION="$(VERSION)"'
> 
> diff --git a/Makefile b/Makefile
> index 91cb097..622a916 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -17,7 +17,11 @@ ifdef DIST_VERSION
>  VERSION = $(DIST_VERSION)
>  endif
>  
> -RPM_VERSION = $(subst -,.,$(VERSION))
> +# Split the version "TAG-OFFSET-gSHA1-DIRTY" into "TAG OFFSET"
> +# and append 0 as a fallback offset for "exact" tagged versions.
> +RPM_VERLIST = $(filter-out g% dirty,$(subst -, ,$(VERSION))) 0
> +RPM_VERSION = $(word 1,$(RPM_VERLIST))
> +RPM_RELEASE = $(word 2,$(RPM_VERLIST))$(if $(WTDIRTY),.dirty)
>  
>  LDLIBS	= -lcurses
>  CFLAGS	= -Wall -O2

I'd like to note that I wanted to make _generic_ version of generating
RPM_VERSION and RPM_RELEASE from the output of git-describe (also with
marking that working directory was in dirty state). Your simpler version
works for tags used in tig repository, but for example not necessarily
so for git repository.


I assume that "version tags" are of the form

  [<prefix>]<version>

where optional <prefix> is "v" for git and linux repositories, "tig-"
for tig repository, "gitgui-" for git-gui repository. <version> starts
with a number, and usually consists of numbers separated by dots, but
it can contain also alphanumeric suffix, for example "-rc1", "-pre7",
"b" (c.f. v0.99.9b tag in git repository), etc. I assume that <version>
is the part that starts with the number.

This means that git-describe output is either of the form

  [<prefix>]<version>

(if there is exact match), or of the form

  [<prefix>]<version>-<number of additional commits>-g<abbreviated sha-1>


For exact match (release tarball) I'd like to have

  RPM_VERSION = $(subst -,.,<version>)
  RPM_RELEASE = 0

and for non-exact match to have

  RPM_VERSION = $(subst -,.,<version>)
  RPM_RELEASE = <number of additional commits>.g<abbreviated sha-1>

The "g<abbreviated sha-1>", which was missing from my (and yours)
proposal is needed because we can have multiple branches, and the
part before "-g<abbreviated sha-1>" could be the same for different
commits (on different branches, e.g. 'master' and 'next').

For "make dist" run from a dirty tree we want to have ".dirty" suffix
added to RPM_RELEASE.

Example: if git-describe returns v1.4.3-rc2-21-g0a7a9a1 in a dirty tree
(with uncommitted changes) I'd like to have 1.4.3.rc2 as version number
and 21.g0a7a9a1.dirty as release number, so tarball would be named
git-1.4.3.rc2-21.g0a7a9a1.dirty.tar.gz


Now to the implementation. I wanted to do the above using only Makefile
functions, if not for two complications. First I didn't know how to
get second-to-last word, or how to remove last word from variable;
trick with filter-out could work there. Second in generic version is
quite hard to distinguish using only make functions between exact and
non-exact match for arbitrary versioning (tagging versions) scheme.


P.S. Perhaps instead of RPM_VERSION we should (re)use DIST_VERSION,
and instead of RPM_RELEASE use DIST_RELEASE?

-- 
Jakub Narebski
Poland
