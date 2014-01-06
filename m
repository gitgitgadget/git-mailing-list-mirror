From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] remote-hg: do not fail on invalid bookmarks
Date: Mon, 06 Jan 2014 14:52:08 +0100
Message-ID: <52CAB508.5010002@web.de>
References: <1388316602-22443-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	=?ISO-8859-1?Q?=22tbo_?=
	 =?ISO-8859-1?Q?=3E=3E_Torsten_B=F6gershausen=22?= <tboegi@web.de>
To: Antoine Pelisse <apelisse@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 06 14:52:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0AbO-0007ZQ-JJ
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 14:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351AbaAFNwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 08:52:18 -0500
Received: from mout.web.de ([212.227.15.4]:57661 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbaAFNwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 08:52:16 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0M7Eb0-1VEEgK3yvm-00x1Hq for <git@vger.kernel.org>;
 Mon, 06 Jan 2014 14:52:15 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1388316602-22443-1-git-send-email-apelisse@gmail.com>
X-Provags-ID: V03:K0:x6CZNXnFH7GejN5rlTrpPbiZNkq5+01gti9md3U67a1IHJtSiBS
 4TyWEtinwMhuc7iJMqSbClMHsnpIemqPOTqUj20uYuiy9gNy/863Ao+r3eHCMLOECiUGFsC
 VeD8z1IP0dvIo989DySm3kU7qgEPisuX5kWaSu5rNuz7VfP5IqPmiS8wT3nEMypsXnvIr/J
 YLqeiuXbpun561lSE46kg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240005>

On 2013-12-29 12.30, Antoine Pelisse wrote:
> Mercurial can have bookmarks pointing to "nullid" (the empty root
> revision), while Git can not have references to it.
> When cloning or fetching from a Mercurial repository that has such a
> bookmark, the import will fail because git-remote-hg will not be able to
> create the corresponding reference.
> 
> Warn the user about the invalid reference, and continue the import,
> instead of stopping right away.
> 
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-hg | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index eb89ef6..12d850e 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -625,6 +625,9 @@ def list_head(repo, cur):
>  def do_list(parser):
>      repo = parser.repo
>      for bmark, node in bookmarks.listbookmarks(repo).iteritems():
> +        if node == '0000000000000000000000000000000000000000':
> +            warn("Ignoring invalid bookmark '%s'", bmark)
> +            continue
>          bmarks[bmark] = repo[node]
>  
>      cur = repo.dirstate.branch()
> 
(Side note: ap/remote-hg-skip-null-bookmarks)

When I run the test-suite like this:
~/projects/git/git.pu/contrib/remote-helpers$ debug=t verbose=t make test-hg-hg-git.sh

All 11 test cases fail on my systems (Debian Wheezy and Mac OS X):
[snip]
WARNING: Ignoring invalid bookmark 'master'
To hg::../hgrepo-git
 ! [remote rejected] master -> master
error: failed to push some refs to 'hg::../hgrepo-git'
not ok 1 - executable bit
#	
[snip]
