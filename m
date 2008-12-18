From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: Re: is it possible filter the revision history of a single file into another repository?
Date: Thu, 18 Dec 2008 15:04:01 +0100
Organization: Intra2net AG
Message-ID: <200812181504.02105.thomas.jarosch@intra2net.com>
References: <8ec76080812180551p8c97a0dqa2025e67792946c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Whit Armstrong" <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 15:06:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDJVM-0001uY-Ks
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 15:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbYLROEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 09:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbYLROEM
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 09:04:12 -0500
Received: from rs02.intra2net.com ([81.169.173.116]:45829 "EHLO
	rs02.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbYLROEL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 09:04:11 -0500
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rs02.intra2net.com (Postfix) with ESMTP id 01B4F4C87;
	Thu, 18 Dec 2008 15:04:09 +0100 (CET)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id 84E222AC4B;
	Thu, 18 Dec 2008 15:04:09 +0100 (CET)
Received: from storm.localnet (storm.m.i2n [172.16.1.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id 685512AC4A;
	Thu, 18 Dec 2008 15:04:02 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27.5-41.fc9.i686; KDE/4.1.3; i686; ; )
In-Reply-To: <8ec76080812180551p8c97a0dqa2025e67792946c7@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by Intranator (www.intranator.com) with AMaViS and F-Secure AntiVirus (fsavdb 2008-12-18_09)
X-Spam-Status: hits=-1.8 tests=[ALL_TRUSTED=-1.8,BAYES_50=0.001]
X-Spam-Level: 982
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103463>

On Thursday, 18. December 2008 14:51:12 Whit Armstrong wrote:
> For instance, if my repository contains foo.c, and 100 other files.
>
> I would like to create a new and separate repository containing only
> the revision history of foo.c.
>
> Would someone mind pointing me at some documentation for this
> procedure if it exists?

This worked for me:

git filter-branch --tag-name-filter cat --index-filter \
    'git ls-files -s |grep -P "\t(DIR1|DIR2)" \
    |GIT_INDEX_FILE=$GIT_INDEX_FILE.new git update-index --index-info &&
    mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' -- --all

Run "git ls-files -s" to see the output format.
Replace the "DIR1|DIR2" with "foo.c".

Later on you might want to remove empty commits from the history:
git filter-branch --tag-name-filter cat --commit-filter 'if [ z$1 = z`git rev-parse $3^{tree}` ]; then skip_commit "$@"; else git commit-tree "$@"; fi' "$@" -- --all

If you want to run two filter-branch commands in a row
or you want to free up the space in .git afterwards:

- git for-each-ref --format='%(refname)' refs/original | xargs -i git update-ref -d {}
- git reflog expire --expire=0 --all
- git repack -a -d
- git prune

Cheers,
Thomas
