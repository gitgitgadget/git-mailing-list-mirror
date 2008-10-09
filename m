From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: [RFD] Sparse checkout, unmerged entries and "reset --hard"
Date: Thu, 9 Oct 2008 20:45:18 +0700
Message-ID: <fcaeb9bf0810090645x29626b45j16d0e0e17fe93810@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 09 15:48:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knvqo-0008SD-L9
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 15:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758939AbYJINp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 09:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758935AbYJINp1
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 09:45:27 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:5190 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758928AbYJINp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 09:45:27 -0400
Received: by ik-out-1112.google.com with SMTP id c30so25463ika.5
        for <git@vger.kernel.org>; Thu, 09 Oct 2008 06:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=UKZ35dKIRKka82uAi9aS5nb3fdzUteJQ9wNXQT3sUgE=;
        b=GY5QXbD/1kNH1wqSqvG3ahYrRA2ooLdeadJOQkIdv4RqlwKmsLfanpQu6wOIKp3vPb
         b4CuiMW2c6rd2N2KO5kZjRjy5LEIEFU4SUzQl0J9wVxC15yqPg8zdDcOIls87dTbaBKf
         48dLFjs2ZrjvfymkvvicJiGE1SUVXvyMJgNCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=sY4cW8m5yjfD0EyV7JYVcK/8YAajAPlKezaw2fKDZWrRb7VZIHjvDFvT3vXDLj8woP
         df5RFOws5XSqDRVp0htNS0CKlJV241+mxHSC+GMl4EGgg/h6W+bpmxs4xPVkwW0YqW/4
         CjLgpqEq2nlsQoWOyahagBRUj0T1TsSVQ4WpY=
Received: by 10.86.61.13 with SMTP id j13mr207135fga.69.1223559918746;
        Thu, 09 Oct 2008 06:45:18 -0700 (PDT)
Received: by 10.86.95.9 with HTTP; Thu, 9 Oct 2008 06:45:18 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97849>

Hi,

There is a problem with those things and I don't know how to handle
it. In brief, in "git reset --hard" (or "git read-tree --reset"),
unmerged entries will be removed from in-memory index, so merge
process does not see them and re-add them like new entries. But with
sparse checkout, "new entries" and "merged entries" are handled
differently. This may lead to stale/orphaned entries.

The detail:

 1. unmerged entries are filtered out from cmd_read_tree() if --reset
is provided.
 2. inside unpack_trees(), [1-3]way_merge() pass src[0] (which is NULL
in unmerged cases) to merged_entry()
 3. merged_entry() sees it as "no old entry so this must be new
entry", it makes sure there is no real file in working directory, but
then the check is ignored in --reset mode.
 4. entries get added as new ones.

With sparse checkout, in the last two steps, it would check if new
entry matches default sparse pattern (which determines if the entry
should be added to working directory). In case it decides the entry
should not be added to working directory, it would remove CE_UPDATE
flag from the entry. This is fine for _true_ new entries. But in
unmerged case, it would leave a stale/orphaned entry in working
directory while it is marked no-checkout in index.

I would expect sparse checkout work correctly even in unmerged case.
That is the entry is removed from working directory (if outside sparse
pattern), staged entries are removed in index, stage 0 entry is added
with no-checkout flag.

Comments? Maybe doing a two-phase merge (unmerged entries first, the
rest later)?
-- 
Duy
