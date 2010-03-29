From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Three issues from a Subversion-to-git migration
Date: Mon, 29 Mar 2010 11:00:12 +0200
Message-ID: <201003291100.13043.trast@student.ethz.ch>
References: <20100326120906.F03BB20CD21@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 11:01:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwAq9-00078d-I7
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 11:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877Ab0C2JAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 05:00:40 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:45015 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753845Ab0C2JAk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 05:00:40 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 29 Mar
 2010 11:00:38 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 29 Mar
 2010 11:00:13 +0200
User-Agent: KMail/1.13.1 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.1; x86_64; ; )
In-Reply-To: <20100326120906.F03BB20CD21@snark.thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143448>

Eric Raymond wrote:
> 2. The git-svn migration logic does not handle unmodified SVN tag
> trees well.

The problem here is that git-svn is designed to handle incremental
updates, where it can't know whether some insane SVN user decides to
modify the tag later on.

I've used the following hack to make real tags out of SVN "tags":

git for-each-ref --format="%(refname)" refs/remotes/tags/ |
while read tag; do
    GIT_COMMITTER_DATE="$(git log -1 --pretty=format:"%ad" "$tag")" \
    GIT_COMMITTER_EMAIL="$(git log -1 --pretty=format:"%ce" "$tag")" \
    GIT_COMMITTER_NAME="$(git log -1 --pretty=format:"%cn" "$tag")" \
    git tag -m "$(git log -1 --pretty=format:"%s%n%b" "$tag")" \
    "${tag#refs/remotes/tags/}" "$tag"
done

Disclaimer: it worked last time I used it.  Haven't checked if it got
dusty since.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
