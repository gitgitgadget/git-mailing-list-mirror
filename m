From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] Reinstate the helpful message when `git pull --rebase`
 fails
Date: Thu, 08 Oct 2015 22:35:08 +0200
Organization: gmx
Message-ID: <cover.1444336120.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Brendan Forster <shiftkey@github.com>, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 08 22:35:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkHuN-0005Ji-ND
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 22:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758453AbbJHUfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 16:35:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:58071 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756123AbbJHUfP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 16:35:15 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Mcxtm-1a1GWd2Wig-00IF4n; Thu, 08 Oct 2015 22:35:09
 +0200
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:LtWXW2N9kRWtZXMGUcOLT4Fg5Jf4ePUCPTddTgA8eqZhUckXdv3
 mq58xmedjU4DKQ2yaxMykG79ZFaeWU8KShAyk7IGegJCz05W4rDeXK5SIEq8av+0VbrTrOE
 fmXnDaL7BU+3UfOA31tUjb7u0OS2UtFIMLLEhvfZq1iTMLPB4Xib+U/dsEsYpaManbP+21z
 0xHnK7SecLrv+iqukd7zg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BSX6URCHgdw=:yVuZGivxteC1EOHw/Ks1L3
 +uEAlkuILPUBFueIuGgNvTcn41S1tvszFSDxNOhbGkdFH9BRmyCkGVXoijsz0zacuu/c+q9dC
 OZC+GvqTzh5SX50v83vK4HkJiujqzekW6cxF9PAOznllnQ0ULW1ScQUZkW/aF7GhBz5pDXsiz
 S/Zron4KvMYZ002EC4/TniGUZiwBCHYhdFOVZFtWTmskI+HEic6GvAG5eNMAbMfb3mjGlHGs5
 IPmgWaxIUGCy91jm6X6p/ZPKKY/UitXdCv5QuRq21bFQpTP+RUA/u7a85aYLps6lZXn+UmSxj
 Vjd11RkdzHFb923gSKoOfI8X5JGjdMg94M74HydRQQc/QqLyt3QeuOYw2sMRAYgX8PXZFV1sy
 45hhTvBVbsd61Y4E5/M7xzYxdfesxPrFWUEAx0Prn9jduooUlljNf2gSmvkfnGWKBLgCbwZw4
 hfG7OaT9qghBnih3hrn9gL57aQdxVONVHJyTsfeJXXwAhgQHzafamknLkRGL1r3HuiEx09/27
 0D/kg2SQ2yqy9pFbM8dDYpyjUMq9nuduo7ik+MCdjHqnJF9WjY5suarfr+i+FFFSQXRYue+Rr
 L80+UMzJrhGRgy1jXJULy5Qch6Sw29aaajRGRQpXgCS1zCQQDZQTJi2QYH4SDGVFIzqtr01/L
 Dc8BgXc7XBoKx2EGbq185uWzMzkoel+4CK/vLtT5E5tJlLa8noell+USTHFj74RfCDUtz7/jd
 1sob22WpaIA0Fk1rrSuB8ojRA611iH4hfTS9gwgXd4LucpG0kp8S2jvfC+issoLmFxrNXbVS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279275>

Brendan Forster noticed that we no longer see the helpful message after
a failed `git pull --rebase`. It turns out that the builtin `am` calls
the recursive merge function directly, not via a separate process. But
that function was not really safe to be called that way, as it die()s
pretty liberally.

As a consequence, the code that wanted to see whether the merge failed
is not even executed, and the helpful message advising how to fix the
mess is not displayed.

This topic branch fixes this.

Please note that there are a couple of unhandled die() calls in
merge-recursive.c, most of which indicate code paths that should
never be reached (except in the case of a bug).

But there are two other functions that can die(): `update_file_flags()`
(which returns void) and `merge_file_1()`.

The latter function is already nested quite deeply so that the code
would have to be made much uglier to handle the `gentle` flag. It is
also not quite clear to me whether those error cases can be hit in a
regular `git pull --rebase` (which is what I really care about most).

As `update_file_flags()` is called by functions returning void and
that are again called in turn by other functions that also return void,
fixing this part is more involved, so I would like to avoid it, unless
it is deemed absolutely necessary to address in this patch series.


Johannes Schindelin (2):
  merge_recursive_options: introduce the "gentle" flag
  pull --rebase: reinstate helpful message on abort

 builtin/am.c      |  1 +
 merge-recursive.c | 44 +++++++++++++++++++++++++++++++++++---------
 merge-recursive.h |  1 +
 3 files changed, 37 insertions(+), 9 deletions(-)

-- 
2.6.1.windows.1
