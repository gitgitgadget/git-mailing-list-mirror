From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git submodule vs GIT_WORK_TREE
Date: Tue, 26 Jun 2012 20:27:24 +0200
Message-ID: <4FE9FF0C.8050409@web.de>
References: <CAD77+gTVLsEOgWo+WDafzNOYOwSZQ2KkgBuibBXemVmGu_Fzgw@mail.gmail.com> <7vobo6cazk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 20:27:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjaUA-0003Gy-HM
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 20:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600Ab2FZS1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 14:27:30 -0400
Received: from mout.web.de ([212.227.15.3]:59468 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136Ab2FZS13 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 14:27:29 -0400
Received: from [192.168.178.48] ([79.193.92.179]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MdLo7-1SSBxP2VJz-00IMzY; Tue, 26 Jun 2012 20:27:24
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <7vobo6cazk.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:He7eOMoCH41D6bXFW8eD1LN726sD6UBCeIPtMoWXRDm
 +LwS0vPbsqZlT0AER9tHWFTiJjz1wiGxulo0OUFm/jR0D/ulEB
 xHih0YnMeZIBt+y3ChWfLL9NLWt3mckylSgJYsqoO/4HTvBgxR
 KodCClczC011jT58cK7D6ASi77luGCptnm/MjveXu/DXR1cUYI
 qgk3ptqCdZMboVgxpBXoQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200666>

Am 26.06.2012 18:07, schrieb Junio C Hamano:
> Richard Hartmann <richih.mailinglist@gmail.com> writes:
> 
>> As you are most likely aware, `git submodule` allows you to access a
>> separate git repository in a sub-directory, e.g. $submodule, while
>> $GIT_WORK_TREE forces git to operate in a specific directory. Combine
>> the two and the result is less than ideal. git is forced to operate in
>> $GIT_WORK_TREE while it should operate on $GIT_WORK_TREE/$submodule,
>> instead.

Richard, could you please tell us what git commands behave strange
in what way and what your expectations were? A short test shows e.g.
"git submodule foreach" operates on $(pwd)/submodule even though
GIT_WORK_TREE is set while at the same time git status shows the same
submodule as missing because it is looking for it in $GIT_WORK_TREE.
Is that what you are talking about?

> The end user should not be asked to anything special.
> 
> When the user exports GIT_WORK_TREE to tell git that the root of the
> working tree the user wants to work on resides there (which is
> needed when the user exports GIT_DIR to tell git that the user wants
> to work on that repository), that wish obviously applies only to
> that repository.  If git decides to visit the working tree of a
> different repository (e.g. a checkout of a submodule bound to the
> project GIT_WORK_TREE points at), even if it is done in response to
> the user action (e.g. like passing "--recurse-submodules" option),
> it should adjust GIT_WORK_TREE and GIT_DIR to be appropriate for
> operations in the submodule repository while doing so.  If the more
> recent "recursive" behaviour forgets to do so, it simply is a bug.

I'm not sure what you mean by "appropriate for operations in the
submodule repository". Should the submodule work tree be searched
for under $GIT_WORK_TREE of the superproject or under $(pwd)?

As far as I can see all submodule code consistently clears all
environment variables used by git before descending into a
submodule (at least since February 2010 and 5ce9086dd). Maybe we
should change that so it sets the GIT_WORK_TREE environment to
"$GIT_WORK_TREE/submodule" to be consistent?
