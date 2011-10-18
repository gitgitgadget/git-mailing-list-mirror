From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 2/2] push: teach --recurse-submodules the on-demand
 option
Date: Tue, 18 Oct 2011 22:58:43 +0200
Message-ID: <4E9DE883.9050105@web.de>
References: <1313791728-11328-1-git-send-email-iveqy@iveqy.com> <1313791728-11328-3-git-send-email-iveqy@iveqy.com> <7vmxemls8z.fsf@alter.siamese.dyndns.org> <20111017190749.GA3126@sandbox-rc> <7vr52bjljd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 22:59:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGGlD-0004p9-Sp
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 22:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092Ab1JRU7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 16:59:38 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:40759 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926Ab1JRU7h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 16:59:37 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate03.web.de (Postfix) with ESMTP id 4822D1A4C09F5
	for <git@vger.kernel.org>; Tue, 18 Oct 2011 22:58:44 +0200 (CEST)
Received: from [192.168.178.43] ([79.247.255.167]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0McneT-1RXWeA2OKP-00HiqI; Tue, 18 Oct 2011 22:58:43
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <7vr52bjljd.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:855eTPjkVAno4ZSZ/eS5Mzu/KDkj3RCJGsWumixVE85
 ZJbdDxu4bSmz1b1nCJ+/CXeEMYi8u4M6aHMN1tdRzWz58DLtE1
 QkAKIhjtJQ4qt7EyOOS4g6ChVXuJ2JHPMNo/slztof12r/SP7z
 bBr0xUAiyC9/zrPmmhhU/aQUTZm/PKS8JrsmzcPZQY82uWRbYr
 C8Mx/BtfqajJ7xcKI/+Bg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183904>

Am 18.10.2011 00:33, schrieb Junio C Hamano:
> I would personally want to put a freeze on "recursively do anything to
> submodule" topic (including but not limited to "checkout") for now, until
> we know how we would want to support "floating submodule" model. For
> existing code in-flight, I would like to see us at least have a warm and
> fuzzy feeling that we know which part of the code such a support would
> need to undo and how the update would look like before moving forward.

Makes sense.

> There are two camps that use submodules in their large-ish projects.
> 
> One is mostly happy with the traditional "submodule trees checked out must
> match what the superproject says, otherwise you have local changes and the
> build product cannot be called to have emerged from that particular
> superproject commit" model. Let's call this "exact submodules" model.
> 
> The other prefers "submodule trees checked out are whatever submodule
> commits that happen to sit at the tips of the designated branches the
> superproject wants to use" model. The superproject tree does not exactly
> know or care what commit to use from each of its submodules, and I would
> imagine that it may be more convenient for developers. They do not have to
> care the entire build product while they commit---only the integration
> process that could be separate and perhaps automated needs to know.
>
> We haven't given any explicit support to the latter "floating submodules"
> model so far. There may be easy workarounds to many of the potential
> issues, (e.g. at "git diff/status" level, there may be some configuration
> variables to tell the tools to ignore differences between the commit the
> superproject records for the submodule path and the HEAD in the
> submodule), but with recent work on submodules such as "allow pushing
> superproject only after submodule commits are pushed out", I am afraid
> that we seem to be piling random new things with the assumption that we
> would never support anything but "exact submodules" model.

It's not about never supporting anything else, but right now we are
scratching our own itch ;-)

> Continuing the
> development that way would require retrofitting support for "floating
> submodules" model to largely undo the unwarranted assumptions existing
> code makes. That is the reason why I would like to see people think about
> the need to support the other "floating submodules" model, before making
> the existing mess even worse.

If you configure diff.ignoreSubmodules=all and fetch.recurseSubmodules=false
and write a script fetching and checking out the branch(es) of your choice
in the submodule(s) you run each time you want to update the branch tip
there, you should be almost there with current Git. But yes, we could do
better.

> The very first step for floating submodules support would be relatively
> simple. We could declare that an entry in the .gitmodules file in the
> superproject can optionally specify which branch needs to be checked out
> with something like:
> 
> 	[submodule "libfoo"]
> 		branch = master
>                 path = include/foo
>                 url = git://foo.com/git/lib.git
>                 
> and when such an entry is defined, a command at the superproject level
> would largely ignore what is at include/foo in the tree object recorded in
> the superproject commit and in the index. When we show "git status" in the
> superproject, instead of using the commit bound to the superproject, we
> would use include/foo/.git/HEAD as the basis for detecting "local" changes
> to the submodule.

Yup. And the presence of the "branch" config could tell "git submodule
update" to fetch and advance that branch to the tip every time it is run.
And it could tell the diff machinery (which is also used by status) to
ignore the differences between a submodule's HEAD and the SHA-1 in the
superproject (while still allowing to silence the presence of untracked
and/or modified files by using the diff.ignoreSubmodules option) and
fetch would just stop doing any on-demand action for such submodules.
Anything I missed?

> We could even declare that the gitlink for such a
> submodule should record 0{40} SHA-1 in the superproject, but I do not
> think that is necessary.

Me neither, e.g. the SHA-1 which was the submodules HEAD when it was added
should do nicely. And that would avoid referencing a non-existing commit
in case you later want to turn a floating submodule into an exact one.
