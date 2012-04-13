From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] submodules: recursive fetch also checks new tags for submodule
 commits
Date: Fri, 13 Apr 2012 18:25:16 +0200
Message-ID: <4F88536C.2090003@web.de>
References: <1334154569-26124-1-git-send-email-marcnarc@xiplink.com> <20120412055216.GC27369@sigill.intra.peff.net> <4F8737C8.1020501@web.de> <4F873CD0.4050204@xiplink.com> <4F873E2C.6080808@web.de> <20120412210542.GD21018@sigill.intra.peff.net> <20120413070423.GA16292@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 18:25:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIjJW-0002fG-9l
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 18:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525Ab2DMQZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 12:25:28 -0400
Received: from fmmailgate06.web.de ([217.72.192.247]:32942 "EHLO
	fmmailgate06.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab2DMQZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 12:25:27 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate06.web.de (Postfix) with ESMTP id 043C81211767
	for <git@vger.kernel.org>; Fri, 13 Apr 2012 18:25:20 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.152.192]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MXYjm-1Sp7zS0sVS-00WZDa; Fri, 13 Apr 2012 18:25:20
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <20120413070423.GA16292@sigill.intra.peff.net>
X-Provags-ID: V02:K0:UbLNb1IbaGr/eOJz2GjZLqQlPPDNuoKsN7Z4VLY4eoK
 XqAfq5B1ldH+khbdy1RopwU4j1PayslhnBfnzVpYj/6L6nQNFT
 d09j7rrDyDBMQJ7S7zkCgjERgawgYW/di3l6xkk/qMjmFolTtc
 LfM7R17bRI9R08tq+KU2sQwWSlQQCD5QMWYz5GQEdalaB5FlJj
 XQ5pzsmQrL/WZMvuovpzQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195424>

Since 88a21979c (fetch/pull: recurse into submodules when necessary) all
fetched commits are examined if they contain submodule changes (unless
configuration or command line options inhibit that). If a newly recorded
submodule commit is not present in the submodule, a fetch is run inside
it to download that commit.

Checking new refs was done in an else branch where it wasn't executed for
tags. This normally isn't a problem because tags are only fetched with
the branches they live on, then checking the new commits in the fetched
branches for submodule commits will also process all tags. But when a
specific tag is fetched (or the refspec contains refs/tags/) commits only
reachable by tags won't be searched for submodule commits, which is a bug.

Fix that by moving the code outside the if/else construct to handle new
tags just like any other ref. The performance impact of adding tags that
most of the time lie on a branch which is checked anyway for new submodule
commit should be minimal, as since 6859de4 (fetch: avoid quadratic loop
checking for updated submodules) all ref-tips are collected first and then
fed to a single rev-list.

Spotted-by: Jeff King <peff@peff.net>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 13.04.2012 09:04, schrieb Jeff King:
> OK, I checked. Yes, we handle this just fine. After my 6859de4, we
> collect the ref tips before and after the fetch and run only a single
> rev-list. So processing the tags will result in just an extra
> interesting commit, which was either:
> 
>   1. accessible by another fetched branch, in which case it was going to
>      be processed as interesting anyway
> 
>   2. not accessible, in which case we have fixed a bug. :)
> 
> So I think we should check all incoming refs, including tags.

Thanks for you analysis!


 builtin/fetch.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 65f5f9b..cfb43df 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -300,11 +300,11 @@ static int update_local_ref(struct ref *ref,
 		else {
 			msg = "storing head";
 			what = _("[new branch]");
-			if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
-			    (recurse_submodules != RECURSE_SUBMODULES_ON))
-				check_for_new_submodule_commits(ref->new_sha1);
 		}

+		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
+		    (recurse_submodules != RECURSE_SUBMODULES_ON))
+			check_for_new_submodule_commits(ref->new_sha1);
 		r = s_update_ref(msg, ref, 0);
 		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
 			    r ? '!' : '*',
-- 
1.7.10.131.gd0e498
