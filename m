From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Misusing git: trimming old commits
Date: Thu, 9 May 2013 11:40:44 -0400
Message-ID: <CACPiFC+XKVzNk2fm4beer0xD6yBnVW6QXCrSFm2w8T2r68xGvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 09 17:41:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaSyG-0002QG-WA
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 17:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755707Ab3EIPlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 11:41:07 -0400
Received: from mail-qa0-f54.google.com ([209.85.216.54]:57740 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159Ab3EIPlF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 11:41:05 -0400
Received: by mail-qa0-f54.google.com with SMTP id o13so1726122qaj.6
        for <git@vger.kernel.org>; Thu, 09 May 2013 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=oQkH8C8StM/Qmp/EM8Wsy1VI8qhhJO+rrjg6OQ/Ig9A=;
        b=0ps/RG98opeAUc8GJ3PCtPPQp1n3qR71M/ey/0gts49wfu4zJRzHALDA33Oo1SBRB4
         s5MAPe7liVWx9wW1O7ZMaSfDymykBKQWtQEHb4f1NLx4edzDH46iHonQtX+4hTpmTTwb
         kdLXHl8mXFZ3rMmLgojrkHHr1QLNRFIPhBmhG4Q15Jb3RCWKowXhSuJ0wFOu6sVmgq+N
         ib51iedG4zSALOKEeUC29O2vxzsdAoY15j45Kz68Gi0zGVaObI4cdpnQa+K/kFojLtGr
         hhFjs8WRoedVtyRwFw+aAc1xHVgUYYf4G3H6mPdEVQ7vdC5A2V1anq5ohS2mI1a/xNMq
         L+Bw==
X-Received: by 10.229.59.14 with SMTP id j14mr685509qch.29.1368114064245; Thu,
 09 May 2013 08:41:04 -0700 (PDT)
Received: by 10.49.96.201 with HTTP; Thu, 9 May 2013 08:40:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223738>

I am misusing git as a store-and-forward tool to transfer reports to a
server in a resilient manner.

The context is puppet (and ppg, I've spammed the list about it... ).
The reports are small, with small deltas, but created frequently.

With the exaction of the final destination, I want to expire reports
that are old and successfully transferred.

My current approach is (bash-y pseudocode):

  git push bla bla || exit $?
  prunehash=$(git log -n1 --until=one.month.ago --pretty=format:%H)
  test -z "$prunehash" && exit 0
  # prep empty commit
  # skip git read-tree --empty, we get the same with
  export GIT_INDEX_FILE=/does/not/exist
  empty_tree="$(git write-tree)"
  unset GIT_INDEX_FILE
  empty_commit="$(git commit-tree -m empty "$empty_tree")"
  echo "${prunehash} ${empty_commit}" >> .git/info/grafts
  git gc
  # TODO: cleanup stale grafts :-)

is this a reasonable approach?



m
--
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
