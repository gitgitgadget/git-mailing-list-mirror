From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Tue, 14 Oct 2014 19:09:45 +0200
Message-ID: <543D58D9.5060606@web.de>
References: <1413090791-14428-1-git-send-email-max@max630.net> <CACsJy8BUtkWKE+P_sHgpAY6wJ9tpzxZRtZHULiLoO=dGnBjkHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>, Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Tue Oct 14 19:10:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe5bk-0003O1-Ud
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 19:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308AbaJNRJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 13:09:57 -0400
Received: from mout.web.de ([212.227.17.11]:59705 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753373AbaJNRJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 13:09:56 -0400
Received: from [192.168.178.41] ([79.211.118.64]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MSads-1Xll6H1Q8K-00RVwx; Tue, 14 Oct 2014 19:09:49
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <CACsJy8BUtkWKE+P_sHgpAY6wJ9tpzxZRtZHULiLoO=dGnBjkHQ@mail.gmail.com>
X-Provags-ID: V03:K0:S6vnUlDHtLE5CJV8xqitcZSpgkpL1MPGEbA5ncP+cP4hNTA+UyK
 faZzsoqUIwdxti9I1LFN/OabmwirSzr+TaQqaASFRnPKRLtBLIbsO27425jQyOTPVMlK1FV
 PWoGOe/sMa0901lhoQgVanmTtH/nRjkTtsom7kNiWsTDgLo6v1mQouwT7kwFVlOvWlLaGGY
 2SYfyUZxoW3n6kow9+wMA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.10.2014 um 14:17 schrieb Duy Nguyen:
> On Sun, Oct 12, 2014 at 12:13 PM, Max Kirillov <max@max630.net> wrote:
>> These are fixes of issues with submodules with use of multiple working
>> trees.
>
> I think the patches look fine from the nd/multiple-work-trees writer's
> perspective. I know too little about submodules to judge if this is
> the right way and not that way..

Sorry, I was too busy to review this work until now, but here we go:

If I understand multiple work trees correctly, everything except work
tree local stuff is redirected into GIT_COMMON_DIR. This is a very cool
feature I'd love to see on our CI server to reduce disk footprint and
clone times, especially for submodules!

But I can't see how that can work by just sharing the modules directory
tree, as that contains work tree related files - e.g. the index - for
each submodule. AFAICS sharing them between work trees will work only
if the content of the modules directory is partly present in GIT_DIR -
for work tree related files - and only the common stuff is taken from
GIT_COMMON_DIR (Or did I just miss the magic that already does that?).
And I didn't try to wrap my head around recursive submodules yet ...

Until that problem is solved it looks wrong to pass GIT_COMMON_DIR into
submodule recursion, I believe GIT_COMMON_DIR should be added to the
local_repo_env array (and even if it is passed on later, we might have
to append "/modules/<submodule_name>" to make it point to the correct
location).

But maybe I'm missing something?
