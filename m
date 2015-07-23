From: Adam Kurkiewicz <popantrop@gmail.com>
Subject: Re: How to organize multiple small reusable components with Git?
Date: Thu, 23 Jul 2015 14:05:39 +0100
Message-ID: <CAA2SmNdD1W6VMe8JnfKpEdsy=WdbKja0F8i1yQ7gKUYLjemBPg@mail.gmail.com>
References: <CAMDZmAEf4afqhR4WT4e-dXjY5OWUSoE_WVGj1ztW-pA=ym9e3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Bing Tian <tianbing1212@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 15:07:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIGDy-0000Vr-LK
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 15:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbbGWNFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 09:05:50 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35287 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbbGWNFl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 09:05:41 -0400
Received: by wibxm9 with SMTP id xm9so207582637wib.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 06:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=F0QdvWVqK62/S7pQhP1tQ072+cu4y47/jv5anJkdsCw=;
        b=m/KF8B4Ip0prWoc5/hKSYgMqqCAsG67uC/oo/UFahbV8jQnhOcN5QvbDB2hA0MutRo
         EgabT+PThmXHcarmD7N5fCFNDtwOdw4jN4whSixNn/eyra3vryCnKSgaylfDER4oJ1sm
         Hrv9eksiY9+W4AZe+FHX3cRHv37Itl+s+pWBi82sgjLhzN7DKv+ar/V4DgHueH86Liun
         GGCwYEcP38uFmuQg3GO/ABdbnpO/ktrlbez78ljze1lS87gUC0o6kahxmVoQvE5yioLX
         RZ2jwLkV88pT4cTNpNM8Q4B/re3tISbPjWLI+wbre94r5Bv2mb8TlwEkm/vpRBr/n4E6
         jpSQ==
X-Received: by 10.180.104.8 with SMTP id ga8mr52605961wib.5.1437656740005;
 Thu, 23 Jul 2015 06:05:40 -0700 (PDT)
Received: by 10.27.203.193 with HTTP; Thu, 23 Jul 2015 06:05:39 -0700 (PDT)
In-Reply-To: <CAMDZmAEf4afqhR4WT4e-dXjY5OWUSoE_WVGj1ztW-pA=ym9e3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274494>

Hi Bing,
You seem to be describing a very interesting problem, similar to what
I often run into in my day job. In my day job I'm composing multiple
java microservices into a single application. We have about 7
microservices, but this number will probably grow to more than 10
before the application is feature-complete. Because microservices are
mutually independent and unaware of each other (however, they _do_
share knowledge of message formats exchanged on the message queue), we
have a very acute problem of composing entire system together. The
problem is two-fold:

1) how do you know which set of the versions of components gives you a
working system?
2) how do you keep track of a record of [the sets of the versions of
components] which give you a working system?

Part 1) is much more difficult than part 2). Although part 1) lies
outside of the scope of version control I'd like to pay your attention
to it nonetheless. In principle with 10 versions of 10 components you
have 10 billion possibly valid configurations of the system. In such
circumstance it is very helpful to use such good SE practices like
depcrecation warnings, semantic versioning and clean distinction
between interface and its implementation. You can also do it the linux
kernel way by simply never introducing backwards-incompatible changes.
If you want to read up about semantic versioning, here's the link to
the standard:
http://semver.org/

Part 2) is really what git can help you with:

One way to deal with this is to manage each component in a separate
git repository (thus version each component separately) and have a
thin parent project, which imports all other projects as submodules.
The way submodules work is through storing each submodule as a
separate directory. You can go to each of the submodule directories,
checkout a particular commit which you want to be marked as a part of
your system and mark each component with usual command "git add
<submodule_dir>". That obviously assumes that you've already solved
Part 1) and you know what versions of components give you a working
system. You can repeat this process for each submodule and once you're
happy commit the result in the parent project and push to the remote.
You can also do usual git things such as tags for example.

I'm not sure how much I like this solution though: having multiple
repositories seems to be an overkill for most cases. Behaviour of
submodules has been startling on a few occasions (for example `git
submodule update` can actually take you back in time rather than
forward). I've also experienced several peculiar and difficult to
pinpoint issues on windows. Although I haven't used it much, git
subtrees seems to be much nicer alternative. You can read about them
here:
http://blogs.atlassian.com/2013/05/alternatives-to-git-submodule-git-subtree/

As to your original idea about having multiple separate directories,
I'm not sure I like it at all. By splitting the versions of your
components into separate directories you loose a lot of benefits of
version control. With multiple directories you won't be able to apply
hotfixes to multiple versions of the component for example without
rewriting the logic of cherry-pick.

Cheers,
Adam

On 23 July 2015 at 12:20, Bing Tian <tianbing1212@gmail.com> wrote:
> I am using git to manage some circuit components.
> Each component is small and I plan to create a "component" project in
> Git to hold all the small components.
> Each component may have several released version, such as
> Comonent1_V1, Component1_V2, Comonent2_V1, Component2_V2.
> And for future reuse, I may use Component1_V1+Component2_V2, or
> Component1_V2+Component2_V1 in my local directory.
> So, I plan to create several directories, each for one version of one
> component. I looks like followings:
> Components
>      |------Component1
>      |                 |------------------Version1(Dir)
>      |                 |------------------Version2(Dir)
>      |-------Component2
>                        |------------------Version1(Dir)
>                        |------------------Version2(Dir)
>
> I want to know, is the above a suitable way in Git?   Are there some
> risks for my project and Git?
> Any suggestions to cover this case in Git?
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
