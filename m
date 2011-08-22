From: =?UTF-8?Q?Marcin_Wi=C5=9Bnicki?= <mwisnicki@gmail.com>
Subject: Missing blobs after pruning dangling commits
Date: Mon, 22 Aug 2011 16:29:10 +0200
Message-ID: <CAC9GOO-cAKTvUyKvrijA8H8z4uRFkTjzJ_dqS_-aO1MYB-yaTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 22 16:29:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvVV7-000113-70
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 16:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153Ab1HVO3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 10:29:13 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34845 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab1HVO3L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 10:29:11 -0400
Received: by qwk3 with SMTP id 3so2991338qwk.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=kaJbTJ3Nq2G8Ag8fXacurQ3DOqY5Mq3xRlUYFcWHuKM=;
        b=X5suRRMp92OK5ZSOVIKx1w3GzB9uf0KoG7pD+ifeb9jeM8yzelSkUqJHOurmCOQntB
         nQuRhP96P+jaSbj492emIn/0fdLLDqx0geE/sOj2c6XUy4G8IXrzgqfokNiWHzqKx0TE
         n7wFxyxReBHmP4aZMKQPbfmwETIvU85y8Mg2c=
Received: by 10.229.28.201 with SMTP id n9mr1390229qcc.68.1314023350940; Mon,
 22 Aug 2011 07:29:10 -0700 (PDT)
Received: by 10.229.42.70 with HTTP; Mon, 22 Aug 2011 07:29:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179864>

Hello,

recently I had git-fsck report some dangling references:

$ git fsck
dangling commit 9275ee571ead7a75ba57e16ba23155a178459918
dangling commit 047bd63ae82b7540098515467f50562e374edada
dangling commit 839cee3c8e16231e6523ecf8b855ef0863787990
dangling commit f7cb119ea71cb3cc739331f2e26bf3e9fdbba24a
dangling commit 68d41b28f320aff303c5a89b25e2243ad2e526f2
dangling commit effcf50a636d2f08e21706f41eb8ae3c4c577166

This is completely local (isolated) repository.
Based on related FAQ entry ("remove old objects after filter-branch"),
I did this:

$ git reflog expire --expire=0 --all
$ git repack -ad
$ git prune

Unfortunately, now fsck complains:

$ git fsck
missing blob 6d2ddd86d4594f8c756cc31b72d61653255a3161
missing blob 6c537408f0b2226c0b6dae9b0ef0f92710fb25ed
missing blob 2db55c1e39fd80e39eccefc617b852d3ac93abe9
$ git --version
git version 1.7.6.msysgit.0

Is this a bug ?

Also, how can I find where this blob came from. I've tried grepping
all commits in original repo (from backup):

$ gitwhich() {
  git log --all --pretty=format:'%T %H' | while read tree commit; do
    git ls-tree -r $tree | grep -q $1 && echo $commit;
  done
}
$ gitwhich 2db55c1e39fd80e39eccefc617b852d3ac93abe9

but nothing was found.
