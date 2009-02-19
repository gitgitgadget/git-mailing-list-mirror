From: Kyle Moffett <kyle@moffetthome.net>
Subject: Re: [RFC/PATCHv2] git submodule split
Date: Thu, 19 Feb 2009 18:04:36 -0500
Message-ID: <f73f7ab80902191504p2745d2c0m20a9762013fb4501@mail.gmail.com>
References: <431341160902121350x45076c8cj26afab0b7a51cac5@mail.gmail.com>
	 <1234578258-48870-1-git-send-email-git@randomhacks.net>
	 <7v3aeh3a84.fsf@gitster.siamese.dyndns.org>
	 <431341160902132117s1696c975mbf20dfbdc65a7df3@mail.gmail.com>
	 <8c5c35580902140103o3e5dd091qe2a18ca52b6fe44a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Eric Kidd <git@randomhacks.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Ping Yin <pkufranky@gmail.com>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 00:06:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaHy4-0005j4-Ih
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 00:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755064AbZBSXEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 18:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755014AbZBSXEj
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 18:04:39 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:58291 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722AbZBSXEi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 18:04:38 -0500
Received: by yx-out-2324.google.com with SMTP id 8so265308yxm.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 15:04:36 -0800 (PST)
Received: by 10.100.119.17 with SMTP id r17mr169102anc.130.1235084676699; Thu, 
	19 Feb 2009 15:04:36 -0800 (PST)
In-Reply-To: <8c5c35580902140103o3e5dd091qe2a18ca52b6fe44a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110764>

On Sat, Feb 14, 2009 at 4:03 AM, Lars Hjemli <hjemli@gmail.com> wrote:
> On Sat, Feb 14, 2009 at 06:17, Eric Kidd <git@randomhacks.net> wrote:
>> On Fri, Feb 13, 2009 at 11:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Eric Kidd <git@randomhacks.net> writes:
>>>> ...
>>>> If the submodule has moved around the source tree, specify one or more
>>>> values for alternate_dir.  To specify the URL of the newly created
>>>> repository (for use in .gitmodules), use the --url parameter.
>>>
>>> Unfortunately, I do not think we have designed fully (nor implemented at
>>> all) behaviour to check out different points of history that has the same
>>> submodule moved around in the superproject tree.
>>>
>>> There were several unconcluded discussions done in the past (and I admit I
>>> participated in a few of them), but it may be hard to use the resulting
>>> repository out of this tool.
>>
>> Thank you for looking at this proposal!
>>
>> I think that the resulting repository is usable (though it could
>> certainly be better). In particular, the following commands will
>> always give you a working checkout:
>>
>>  git checkout any-version
>>  git submodule update --init
>>
>> The unit tests for git-submodule-split.sh actually walk through the
>> entire history and run 'git submodule update --init' at each revision.
>> This works correctly because git-submodule-split creates the necessary
>> .gitmodules entries for each revision, and includes the
>> submodule.*.url value that you specify.
>>
>> Unfortunately, this means that whenever the submodule moves to a new
>> location in the tree, 'git submodule --init' will actually have to
>> clone it again. That's not a perfect situation, but it will work for
>> reasonably small submodules.
>
> <hand-waving>
> I didn't look at the patch, but if the submodule uses a single
> module-name while moving around, the re-cloning problem would by
> solved if the submodule git-dir was stored inside the git-dir of the
> containing repository  (by using the git-file mechanism). Maybe I
> should try to finally implement this...
> </hand-waving>

We use submodules at my workplace to keep track of a variety of
closely-related projects (branched from each other).  On account of
some deficiencies in the interface of the GIT we're using (including a
few that are still present), we have a bunch of custom scripts to
clone and check out the whole mess, but it goes something like this:

In super/.git/config in a checkout:

    [remote "origin"]
        fetch = +refs/heads/*:refs/remotes/origin/*
        push = +refs/heads/*:refs/heads/kmoffett-branches/*
        fetch = +refs/projects/heads/*:refs/projects/remotes/origin/*
        push = +refs/projects/heads/*:refs/projects/heads/kmoffett-branches/*

    [submodule "projects/FOO"]
        url = ./projects/FOO/.git


In super/.gitmodules:

    [submodule "projects/FOO"]
        path = projects/FOO
        url = ./projects/FOO/.git


In sub/.git/config (IE: super/projects/FOO/.git/config)

    [remote "origin"]
        url = ../..
        push = +refs/heads/*:refs/projects/heads/FOO/*
        fetch = +refs/projects/heads/*:refs/remotes/parent/*
        fetch = +refs/projects/remotes/*:refs/remotes/*

    [remote "parent"]
        ${same as remote.origin}


In sub/.git/objects/info/alternates (IE:
super/projects/FOO/.git/objects/info/alternates)

    ../../../../.git/objects


In this environment, basically *all* objects are kept in the
"superproject".  When doing a local commit into a subproject, the new
objects are first stored there (is there any way to change that?), but
on the first "git push" in the subproject they will be pushed up to
the parent's objects directory and the next GC of the child project
will clean them up.  All of the child branches are stored in
"refs/projects", so they don't show up by default in various "git
branch", etc, commands, but it's trivial to ensure they get pushed and
pulled appropriately.

Essentially the "superproject" consists of our project-management
environment, with the subprojects being each individual project, which
may be entirely independent.  There is a relatively tight feature
coupling between the per-project scripts and the version of the
management environment, so this works out relatively nicely for our
uses.

A clone by default will only get the superproject, if you want
subprojects you have to add the appropriate branch refs to the
.git/config file (as seen in the above example).  This is handy if
you're only working on one of the particular projects.  Having them
all as separate branches cloned from each other does make it very easy
to diff/merge/cherry-pick between them, even though they are
effectively independent.

Cheers,
Kyle Moffett
