From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: filter-branch IO optimization
Date: Fri, 12 Oct 2012 19:20:23 +0200 (CEST)
Message-ID: <b94baafd-3813-49c6-9848-97bf11960bb9@zcs>
References: <d4a00074-5134-4314-aa61-f222f41712bb@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 12 19:20:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMiub-0006ap-31
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 19:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695Ab2JLRU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 13:20:26 -0400
Received: from zcs.vnc.biz ([83.144.240.118]:29102 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932587Ab2JLRUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 13:20:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 0D89A460003;
	Fri, 12 Oct 2012 19:20:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PJgc-qoBaN9P; Fri, 12 Oct 2012 19:20:23 +0200 (CEST)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 915C5460001;
	Fri, 12 Oct 2012 19:20:23 +0200 (CEST)
In-Reply-To: <d4a00074-5134-4314-aa61-f222f41712bb@zcs>
X-Originating-IP: [91.43.215.119]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207560>

Hi folks,

now finally managed the index-filter part.
The main problem, IIRC, was that git-update-index didn't
automatically create an empty index, so I needed to explicitly
copy in (manually created it with an empty repo).

My current filter code is:

if [ ! "$GIT_AUTHOR_EMAIL" ] && [ ! "$GIT_COMMITTER_EMAIL" ]; then
	export GIT_AUTHOR_EMAIL="nobody@none.org"
	export GIT_COMMITTER_NAME="nobody@none.org"
elif [ ! "$GIT_AUTHOR_EMAIL" ]; then
	export GIT_AUTHOR_EMAIL="$GIT_COMMITTER_EMAIL"
elif [ ! "$GIT_COMITTER_EMAIL" ]; then
	export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_NAME"
fi

if [ ! "$GIT_AUTHOR_NAME" ] && [ ! "$GIT_COMMITTER_NAME" ]; then
	export GIT_AUTHOR_NAME="nobody@none.org"
	export GIT_COMMITTER_NAME="nobody@none.org"
elif [ ! "$GIT_AUTHOR_NAME" ]; then
	export GIT_AUTHOR_NAME="$GIT_COMMITTER_NAME"
elif [ ! "$GIT_COMITTER_NAME" ]; then
	export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
fi

cp ../../../../scripts/index.empty $GIT_INDEX_FILE.new

git ls-files -s |
    sed "s-\t\"*-&addons/-" |
    grep -e "\t*addons/$module" |
    ( export GIT_INDEX_FILE=$GIT_INDEX_FILE.new ; git update-index --index-info )

mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE


Now another problem: this leaves behind thousands of now empty
merge nodes (--prune-empty doesnt seem to catch them all),
so I loop through additional `git filter-branch --prune-empty`
runs, until the ref remains unchanged.

This process is even more time-consuming, as it takes really many
passes (havent counted them yet).

Does anyone have an idea, why a single run doesnt catch that all?


cu
