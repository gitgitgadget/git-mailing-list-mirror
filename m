From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] builtin/describe.c: ignore untracked changes in submodules
Date: Tue, 14 Sep 2010 22:30:09 +0200
Message-ID: <4C8FDB51.6010009@web.de>
References: <CC-1wlyJRzGfkPwn1Ra8d4Ot7mMnUGxYChGZHdqp-lQ5URlUFhNp4Ilyrh4bGk1dWF6drZXvim0@cipher.nrlssc.navy.mil> <7vy6bajvnd.fsf@alter.siamese.dyndns.org> <1094265482.7527324.1284144028114.JavaMail.fmail@mwmweb047> <AANLkTinMf-_vk2-gRazf-8FNykZoNbVwmu_+c+5ht8rY@mail.gmail.com> <1258122337.8606899.1284400767503.JavaMail.fmail@mwmweb047> <150763691.8130046.1284401891268.JavaMail.fmail@mwmweb048> <7v7hipb5ht.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 22:30:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovc96-0002fi-Ap
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 22:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617Ab0INUaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Sep 2010 16:30:16 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:46654 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607Ab0INUaM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 16:30:12 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 9D8F31685AD55;
	Tue, 14 Sep 2010 22:30:10 +0200 (CEST)
Received: from [93.246.48.208] (helo=[192.168.178.29])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #24)
	id 1Ovc8o-0008Ax-00; Tue, 14 Sep 2010 22:30:10 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <7v7hipb5ht.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+XZBLLiwtugWdvXGNS8Sewb4SHBBK19qNZqjVX
	9kt0K4NvP9GZiqJqCMR1iT14N4uOUVdbmPM20fM2QldweBswN2
	YZRhhXonRVOEsETTPjuw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156208>

Am 14.09.2010 01:14, schrieb Junio C Hamano:
> What makes untracked paths in the superproject different from the ones in
> a submodule?

That you can have a different state for each path inside the superproject
(modified, untracked etc.) while you can't have that for the paths in the
submodule (when looked at from the superproject): There is only a single
state available for the whole submodule, it's either modified or it isn't.
So IMO a modified submodule should tell the user: "There is a change in
this submodule so that when you commit/push your superproject now, others
might run into problems when fetching it; you want to be sure this is not
the case before doing that". And this is just the same thing you could
say about a file in the superproject when it shows up as modified, no?
And for submodules this definition must also include new yet untracked
files, as they are very likely to be missing in every but your work tree.


> "git diff" cannot be it as it does not show untracked paths
> in the superproject, so you are talking about "the user cannot tell from
> the 'git status' output", right?

Nope, it's "git diff" too. The thing that got me started working on this
topic was that "git gui" and "gitk" were quiet about submodules which
had modified tracked files and/or new untracked files, which lead to
real world problems where I work. And both use diff-index and diff-files
to get the paths they should display *and* to display the actual changes.
(And as "git diff" uses the same machinery under the hood as "git status"
does, everything fell into place pretty easily)

And I argue that this is sane behavior, as I'm sure other tools rely on
"git diff" or "git status" too to check if there are modifications to the
work tree (or they call run_diff_files() or run_diff_index() directly to
do that). So all of these should agree on what they are saying about the
state of a submodule, or things will get interesting. (Same goes for
describe, it should append the "-dirty" when "git status" or "git diff"
say a submodule is modified)

And this approach works really well at my dayjob. Since we are using it,
me and my colleagues are really happy with it, because we can't forget to
commit changes inside a submodule anymore. So judging from this real life
experience "ignore=none" is a very sane default.

But I admit that this change in behavior can be strange for long time
submodule users when they first encounter it. And if they still don't
like the new behavior after some consideration, they can disable it
easily using the new configuration options. But one of the advantages I
really liked when I started using git was that is was not able to forget
to commit new files anymore. So I suspect ignore=none is especially
useful for new users of submodules, because it is on the safe side, and
therefore should be the default setting. You can later turn the 'noise'
down if you want (just like some users do when using the "-uno" option
to "git status" if they don't want to be told about untracked files in
the superproject or its submodules).
