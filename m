From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [RFC/PATCH] git push usability improvements and default change
Date: Thu, 12 Mar 2009 12:01:09 +0900
Message-ID: <20090312120109.6117@nanako3.lavabit.com>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
 <7vfxhmdyvn.fsf@gitster.siamese.dyndns.org>
 <20090310100400.GC11448@pvv.org>
 <7v7i2v4x2v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 04:03:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhbCy-0005Q6-D2
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 04:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbZCLDBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 23:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752617AbZCLDBz
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 23:01:55 -0400
Received: from karen.lavabit.com ([72.249.41.33]:34802 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959AbZCLDBy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 23:01:54 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id A4EF011B841;
	Wed, 11 Mar 2009 22:01:52 -0500 (CDT)
Received: from 6588.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id UF6JIVDI1Z1O; Wed, 11 Mar 2009 22:01:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=x89Q7i0QRBYDIQmYZKG7Snsz5CYQLSmfWHgef3/+1g8+5tTcBugj/D8dCkN48j/X/ziW3xIUMezcB8QQukatG/wcl5oCdrU0QXCHssGXywVfDJvoCujBDAzmvPblAgPV2766K50iEHWhRF47hcVYtGzb4Ho4goEOcbjYqAW6XR8=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7v7i2v4x2v.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112999>

Quoting Junio C Hamano <gitster@pobox.com>:

> Finn Arne Gangstad <finnag@pvv.org> writes:
>
>> On Mon, Mar 09, 2009 at 05:07:08PM -0700, Junio C Hamano wrote:
>> ...
>>>  * What's the point of having --current option, when you can already
>>> say HEAD, i.e.  $ git push origin HEAD
>>
>> It does something very different. Maybe --tracking would be a better name.
>> --current does basically this:
>> ...
>> The goal here is to be able to:
>>
>> git checkout -b junios-next origin/next
>> git push --current  <=>  git push origin junios-next:next
>>
>> git push origin HEAD would do git push origin junios-next:junios-next,
>> which was not the intention.
>
> Ok, now that sort of makes sense, and is very different from people would
> expect from --current, which I think most people would associate with
> HEAD.  "tracking" or "track back" would be a better name.

I think this proposal has deeper problems than just that.

There can be two reasons you may want to give the branch a name other than 'next':

1. Because you also have dschos-next that tracks remotes/dscho/next; or

2. Because you also have junios-next2 that also tracks remotes/origin/next.

The first case indicates that the project is using a workflow where each developer has his own publishing repository [1], and it is very unlikely that Finn Arne has push access to either your or Johannes'es public repositories.

The second case of tracking a single branch with more than one is unnecessarily confusing. If you are on junios-next and you push (and we assume that you are Junio and have push access to the remote repository), after such a push you need to update junios-next2 somehow, either by rebasing or by merging. The reason junios-next2 branch needs updating is because it has changes unrelated to what you pushed out from your junios-next branch to the outside world as 'next'.

In such a case, wouldn't it be much easier to understand and manage if you had a single 'next' branch that has changes ready to be shown to the remote 'next', and make other topic branches fork from and track your local 'next' instead?

Your changes based on the public 'next' that everybody else sees need to get first integrated and tested in your local repository before getting pushed out to the remote 'next' branch in any case.

You certainly could switch between junios-next and junios-next2 branches that both track the public 'next' branch, and make sure you will integrate everything you need to send to the public repository no matter what branch you are currently working on. Unless you do so, 'git push' will refuse to accept an update that isn't a fast-forward anyway, so it certainly possible to work with more than one local branches that track a single remote branch.

But in order to do this correctly, you need to be aware what each branch is meant to contain, and for which public branch you are developing your changes on it. I think that way of working leads to the confusion and perceived need for the "--current" option: "I don't know which remote branch the changes I made on the current branch should be pushed to, and --current option remembers it for me, so I don't have to". That new option may be solving "where to push to" part but I'm afraid the option not just leaves "I still need to know for which public branch I am supposed to make changes while on this branch" unsolved, but by making people rely on the option I think it makes the latter problem much worse.

Dedicating your local 'next' for the integration purpose to prepare what you push to your public 'next' is much easier to understand and explain to new people. Once a topic that is meant to be published on your 'next' becomes ready, you merge the branch locally to your own 'next', and you have a chance to review that you didn't accidentally included changes inappropriate for 'next' when you create the merge. You push the result out after you are happy.

And I think the above discussion holds true if the public 'next' isn't your 'next', but a branch shared with others in a central repository.

I don't understand how the new "--current" makes "sort-of" sense. It looks like it is making the command more complex and the only thing it does is to encourage a confused workflow.

[1] Your http://gitster.livejournal.com/30645.html showed different ways to collaborate very nicely. I think this is the third approach in your article.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
