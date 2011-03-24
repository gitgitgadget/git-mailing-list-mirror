From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] diffcore-rename: don't consider unmerged path as
 source
Date: Wed, 23 Mar 2011 20:52:46 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1103232043530.30954@debian>
References: <1300412548-1724-1-git-send-email-martin.von.zweigbergk@gmail.com> <7vk4fsucce.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 01:52:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2YnJ-00020y-K7
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 01:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933517Ab1CXAww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 20:52:52 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:59137 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933467Ab1CXAwv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 20:52:51 -0400
Received: by vxi39 with SMTP id 39so6604861vxi.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 17:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=Pa5oLsuma34V1Y6szLV5dDp+8ALzI8Zt8yRahhtdo0Y=;
        b=EHpJxPr2QdboQK4kaEm3qYynpyQkbRCXlMzDvbX7NfgvlNU7ZIYx8x8j40RQHZygMM
         YDigpafjRwDp51bj0GSGwdqu+srWZeRXQKa0X/jEJyjik126g8H8y5ptvfRoJt7LoEM5
         dGYM+OUhFOSwxPSG3WvtfnBl79+OZAT7CYH+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=T/vrq/tzKWtvsSQ+/J0aGO/BDF0S0AV8HTnS4Q0T0tYxc3Bx5QITEnKdvhe2g9Cyjp
         V+Br9rlzjVS3sMpHmHAlx+sJVXkelH0bFJuBzHWq9g/vLjqheHAzhJHxnp8/1st4XxxI
         7+sCc/141IRAlX1HYlSHKAehi2pstmBorfppg=
Received: by 10.52.90.10 with SMTP id bs10mr7827376vdb.23.1300927970071;
        Wed, 23 Mar 2011 17:52:50 -0700 (PDT)
Received: from [192.168.1.100] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id 8sm1820899vdd.30.2011.03.23.17.52.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Mar 2011 17:52:48 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <7vk4fsucce.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169885>

On Mon, 21 Mar 2011, Junio C Hamano wrote:

> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
> 
> > This is the first time I look at the diff code, so please review
> > carefully. I think the changes make sense, but I really don't know the
> > code enough to be sure.
> >
> > Also not sure about the "while at it" stuff...
> >
> > The test cases assume that the paths will be printed in a certain
> > order. Can I rely on that?
> 
> I re-read the patch and found that the core of the patch, i.e. the change
> to diffcore-rename.c, is basically sound.
> 
> I'd like to see the commit log message to describe the cause of the
> breakage better.  Perhaps something like this:
> 
>   Since e9c8409 (diff-index --cached --raw: show tree entry on the LHS for
>   unmerged entries., 2007-01-05), an unmerged entry should be detected by
>   using DIFF_PAIR_UNMERGED(p), not by noticing both one and two sides of
>   the filepair records mode=0 entries. However, it forgot to update some
>   parts of the rename detection logic.
> 
>   This only makes difference in the "diff --cached" codepath where an
>   unmerged filepair carries information on the entries that came from the
>   tree.  It probably hasn't been noticed for a long time because nobody
>   would run "diff -M" during a conflict resolution, but "git status" uses
>   rename detection when it internally runs "diff-index" and "diff-files"
>   and gives nonsense results.
> 
>   In an unmerged pair, "one" side can have a valid filespec to record the
>   tree entry (e.g. what's in HEAD) when running "diff --cached". This can
>   be used as a rename source to other paths in the index that are not
>   unmerged. The path that is unmerged by definition does not have the
>   final content yet (i.e. "two" side cannot have a valid filespec), so it
>   can never be a rename destination.
> 
>   Use the DIFF_PAIR_UNMERGED() to detect unmerged filepair correctly, and
>   allow the valid "one" side of an unmerged filepair to be considered a
>   potential rename source, but never to be considered a rename destination.

Thanks. I really appreciate it. My commit message did feel a little
lazy and I didn't know the history.

> Please split changes to wt-status.c (indentation and symbolic constant)
> and builtin/commit.c (symbolic constant) to a single commit that is
> separate from this fix, as we would want to backport the fix to older
> maintenance tracks.

Ah, of course. I did think this should go to maint, so it seems stupid
not to have split it. Will do.

> Also, please don't add a new test script 7510 that conflicts what is
> already in flight ('pu' has t/t7510-commit-notes.sh).

Sorry, I missed that and thanks for the help below. I have not had
much time lately, but I will do my best to send a re-roll in not too
long.

>  Instead, tack
> something like the following (and your diff-index tests) at the end of
> t/t7060-wtstatus.sh, as you should be able to do this without actually
> running a merge.
> 
> Answering the last question in the comment part of your message, the paths
> are supposed to be shown in the name order, so your comparison (and the
> comparison below) should be the right thing to do.
> 
> Thanks.
> 
> 
> 
> test_expect_success 'rename & unmerged setup' '
> 	git rm -f -r . &&
> 	cat "$TEST_DIRECTORY/README" >ONE &&
> 	git add ONE &&
> 	test_tick &&
> 	git commit -m "One commit with ONE" &&
> 
> 	echo Modified >TWO &&
> 	cat ONE >>TWO &&
> 	cat ONE >>THREE &&
> 	git add TWO THREE &&
> 	sha1=$(git rev-parse :ONE) &&
> 	git rm --cached ONE &&
> 	(
> 		echo "100644 $sha1 1	ONE" &&
> 		echo "100644 $sha1 2	ONE" &&
> 		echo "100644 $sha1 3	ONE"
> 	) | git update-index --index-info &&
> 	echo Further >>THREE
> '
> 
> test_expect_success 'rename & unmerged status' '
> 	git status -suno >actual &&
> 	cat >expect <<-EOF &&
> 	UU ONE
> 	AM THREE
> 	A  TWO
> 	EOF
> 	test_cmp expect actual
> '
> 
