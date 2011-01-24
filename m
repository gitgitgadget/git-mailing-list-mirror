From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC] Add bad-branch-first option for git-bisect
Date: Mon, 24 Jan 2011 10:53:15 +0100
Message-ID: <AANLkTimUkv9+g_+wFcyGhwMjE9zYAKjMn32GL-WOVmoe@mail.gmail.com>
References: <4D3CDDF9.6080405@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, apenwarr@gmail.com
To: Shuang He <shuang.he@intel.com>
X-From: git-owner@vger.kernel.org Mon Jan 24 10:53:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhJ6w-00030m-Jf
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 10:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab1AXJxR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jan 2011 04:53:17 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37305 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606Ab1AXJxQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jan 2011 04:53:16 -0500
Received: by wwa36 with SMTP id 36so4086445wwa.1
        for <git@vger.kernel.org>; Mon, 24 Jan 2011 01:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+O7NDK2d7yJm/QaoRJ5SGue6deggvTkQJjZ8xiM0AII=;
        b=W+/mHg1hWj5+lAs8nsx25Dbh+iUHAjg1/ETX+LrTuXdTARX0Z8nlTgKtX+VPdgPHos
         zQlwl/ambE3zilgJpuFlbvDQ00T8OteSHw4C0oFwcQyET/obv3yH0DAc7RtYUmDq4UNi
         euAjf4pRV6VkGeOj2z0O9zc97vbmTVZbAFm5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HrBd0r0DAK6H49BuSq8e6463wGbmi1tSvzOIt4eOkcCaBCrMlXZPi8Q7k2Ls63UoDN
         fX8Nu6tey5WFLSaBih1VAvHy3QyTUBv6YvlX0BdF22kLhxFGqvRTTmmrmdrPrE0PQx2r
         umzpQAsd4nnTb06aFXKWF1JX4bJ8BU5ITBuNg=
Received: by 10.216.1.145 with SMTP id 17mr3354215wed.50.1295862795100; Mon,
 24 Jan 2011 01:53:15 -0800 (PST)
Received: by 10.216.30.65 with HTTP; Mon, 24 Jan 2011 01:53:15 -0800 (PST)
In-Reply-To: <4D3CDDF9.6080405@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165443>

Hi,

On Mon, Jan 24, 2011 at 3:03 AM, Shuang He <shuang.he@intel.com> wrote:
> Hi
> =A0 =A0 The default git-bisect algorithm will jump around the commit =
tree,
> on the purpose of taking least steps to find the first culprit commit=
=2E
> We may find it sometime would locate a old culprit commit that we're =
not
> concerned about anymore.

Yes, it can be a problem.

> =A0 =A0 In most software development, there's one or two main branch =
which
> is maintained for release, and a bunch of feature branches are create=
d
> for new feature development or bug fix. =A0For the reason that someti=
me
> git-bisect will locate a old culprit commit would be:
> =A0 =A0 =A0 =A0 1. Quality of those branches may not match the main b=
ranch,
> some functionality are broken at first and fixed later on the feature
> branch. If git-bisect jump to there by chance, git-bisect will only f=
ind
> that old
> culprit commit which only exists on that feature branch

If the quality of these branches is too bad, I think they should not
have been merged in the first place.
If they are not merged (and not marked as good), then git bisect will
not look at them, since it will look only at commits that are
ancestors of the bad commit it is given.

Or if one is merged but it causes too many problems, then perhaps a
replacement commit could be used to unmerge the branch.

Another possibility is to have in a file a list of commits that are
the last commits on these branches before the merge commits, and do a:

git bisect good $(cat good_commits_file.txt)

at the beginning of each bisection.

So I think the long term solution in this case is not what your are sug=
gesting.

> =A0 =A0 =A0 =A0 2. Some of those branches may not synchronized with m=
ain
> branch in time. =A0Say feature1 is broken when feature2 branch is cre=
ated, and
> feature1 is fixed just a moment later after feature2 branch is create=
d,
> and when feature2's development is done, and developer want to merge
> feature2 branch back to master branch, feature2 will be firstly
> synchronized to master branch tip, then merge into master. =A0For the=
 same
> reason addressed in issue 1, this will also lead git-bisect into wron=
g
> direction.

I am not sure what you mean by " feature2 will be firstly synchronized
to master branch tip", and I think this should mean a rebase that
would fix the bug if feature1 has already been merged into the master
branch.

But anyway in this case, I think that git bisect will find that the
first bad commit is the last commit in the branch, just before it was
merged. And by looking at the branch graph it should be quite easy to
understand what happened.

And then the obvious thing to do is to decide to just start a new
bisection like it was started the first time but with an added "git
bisect good <merge_commit>", where <merge_commit> is the commit that
merges the branch.

> =A0 =A0 In all, we think we do not care about branches that we're not
> currently working, unless we're sure the regression is caused by that
> branch.
>
> =A0 =A0 To address those issue, we propose to add a new config option=
:
> =A0 =A0 =A0 =A0 core.bisectbadbranchfirst::
> =A0 =A0 =A0 =A0 =A0 =A0 With this algorithm, git-bisect will always t=
ry to select
> commits
> =A0 =A0 =A0 =A0 =A0 =A0 that on the same branch current bad commit si=
ts. And will
> fall back
> =A0 =A0 =A0 =A0 =A0 =A0 to default git-bisect algorithm when bad-bran=
ch-first
> algorithm does
> =A0 =A0 =A0 =A0 =A0 =A0 not apply
> =A0 =A0 =A0 =A0 +
> =A0 =A0 =A0 =A0 This setting defaults to "false".

I am not opposed to an option to bisect on the first parents of the
bad commit only. And after a very fast look at your patch it seems to
be what it does. By the way Avery Pennarun's gitbuilder
(https://github.com/apenwarr/gitbuilder) does the same thing. So I
know some people are interested in such a feature.

But here are some suggestions/comments:

- your explanations about why it could be useful should be improved,
- the name "bisectbadbranchfirst" seems wrong to me, because git
branches are just some special tags; "firstparentsonly" would be a
better name,
- before having a config option for it, why not have it first as an
option to "git bisect start",
- if there is a config option, then there should probably be an option
to "git bisect start" to use the regular algorithm,
- it seems to me that bisecting only on first parents could fail only
if some "good" commits are not ancestors of the bad commit, and if the
bug is fixed on a branch where such a commit is; so I don't see the
point in defaulting to the usual algorithm in this case because in
this case the usual algorithm just stops,
- perhaps the message given when the first bad commit is found should
be changed a little bit when this option is used.

Maybe I am missing something, because as I said I didn't read your
patch carefully, but in this case please try to give a concrete
example.

Thanks,
Christian.
