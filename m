From: Jon Seymour <jon.seymour@gmail.com>
Subject: Semantics for one step undo/redo
Date: Tue, 14 Jun 2005 23:50:02 +1000
Message-ID: <2cfc403205061406507af5a66@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Jun 14 15:47:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiBji-0001Td-KT
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 15:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVFNNuV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 09:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVFNNuV
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 09:50:21 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:12642 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261203AbVFNNuD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2005 09:50:03 -0400
Received: by rproxy.gmail.com with SMTP id i8so1605116rne
        for <git@vger.kernel.org>; Tue, 14 Jun 2005 06:50:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MWQep2DonrJUT2E1N8YSD8CU1MzfMC0PdNxZLSrKL51bQ/zHY6/PfkL/igp3ARkrvhOPzwyCZeOk6/Eg+FsQC8tw1vSUiN9jaqlG7CUQeVYuogbRAxdG7Oz3glvZqcomLA+uVfMvIKCNKVTqYzXPnZBZYJYyWceGoXdNJuHvFlI=
Received: by 10.38.66.68 with SMTP id o68mr1559676rna;
        Tue, 14 Jun 2005 06:50:02 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Tue, 14 Jun 2005 06:50:02 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi.

I've implemented some undo/redo scripts which I am testing in my own
workspace before I unleash them on an wider audience. However, I
thought it would be useful to discuss the semantics of my approach on
the list.

The approach focuses on one-step undo, redo. What I mean by this is
that a given undo or redo operation can undo or redo exactly one
commit. Of course, it is possible to compose arbitrary sequences of
undo and redos with the expected results. I regard multi-commit
undos/redos to be a special case of the one-step undo/redo and so can
be neglected for the purposes of discussion.

UNDO Semantics:
    When the working tree and cache are synced with a commit, C, then
undo has the effect of returning the workspace to the state
immediately prior to the commit C.

UNDO Pre-conditions:
    - the working tree matches the cache (git-update-cache --refresh
exits with zero)
    - the cache matches the tree specified by HEAD or UNDONE_HEAD

UNDO Post-conditions
    - UNDONE_HEAD is set to the value of HEAD
    - HEAD is replaced by its left-most parent
    - HEAD's commit message is written to .nextmsg
    - the workspace tree and cache is unchanged
    - an entry containing the UNDONE_HEAD head and its parents are
written to the end git/redo-log

A tweak to the undo implementation would be to allow the user to
specify which merge branch to undo down.

REDO Semantics
    - redo will replay a previous commit but any or all of the tree,
the parents, the message may be replaced by edited values.

REDO Pre-conditions:
    - at least one entry exists in the .git/redo-log
    - the cache matches the working tree
    - .nextmsg contains the commit message
    - HEAD contains the commit id of the current predecessor (which
may differ from the logged value)

REDO Post-conditions:
    - the working tree is committed with .nextmsg as its message, the
first parent replaced by HEAD and the remaining parents read from .the
tail of .git/redo-log
    - .nextmsg is cleared
    - the last line of .git/redo-log is removed

With the scripts I have written, I can fix a commit message, 4
messages old with:

undo
undo
undo
undo
vi .nextmsg
while redo
do
      echo done
done

I think my approach differs a little from Junio's (but I haven't
analysed his deeply) in that the redolog is actually just the slightly
edited output of git-rev-list --merge-order --parents head base [ the
edits removes from the list the parallel branches that aren't actually
involved in the undo ]

Comments?

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
