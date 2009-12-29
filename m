From: Fyn Fynn <fynfynn@gmail.com>
Subject: Re: Possible bug in 1.6.6 with reset --hard and $GIT_WORK_TREE
Date: Tue, 29 Dec 2009 13:09:20 -0800
Message-ID: <1a04eebf0912291309u7a222d9ch7e0926d30a5899b7@mail.gmail.com>
References: <1a04eebf0912282247p6975a96el8076cb39378bd104@mail.gmail.com>
	 <fcaeb9bf0912290038u77a5e83cqe2f3cbfab05af263@mail.gmail.com>
	 <20091229200426.6117@nanako3.lavabit.com>
	 <fcaeb9bf0912290336m69303c3es8138c4e6497b801a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 22:09:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPjJn-0002SH-SN
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 22:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbZL2VJY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2009 16:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751986AbZL2VJX
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 16:09:23 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:36741 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbZL2VJV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Dec 2009 16:09:21 -0500
Received: by ywh6 with SMTP id 6so11573178ywh.4
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 13:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cQY5x4Nf7SpLZ2A0xXL7TDMEq2x7jY4SJWsZ+G6lEVw=;
        b=fRV3e5TLXPGraiklA+zBFMwtLtUk/+rG03acDIKrCw1hMFfjHaSQwNVN0cZCkvQkM/
         9ntn6XW58aYvQ9JoqfEOuzfA2y88FBZi4g5AUE2bF02QfqoZsWkdZkHYnXzD7BN/QYsp
         aPA71xXlo2yh7hxkjdQfYcciTnTr8y4MIC5og=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ui+Ur7kcv9kgRGPOpQ5w74KZUSwnnCmSHUGMFG6tmJQ6+tQJRvVw92acvx3aefaoL8
         ubsQPyl4d/HpQGZx3MtLX0hOg2561V9spcsROs/JnFFav+mtAtmoQA5MpjGGsR3HOQkk
         bKGQE6RegBPRjXe6J5pBSqF/zAbATKu9CeU3Y=
Received: by 10.100.243.30 with SMTP id q30mr22149334anh.121.1262120961031; 
	Tue, 29 Dec 2009 13:09:21 -0800 (PST)
In-Reply-To: <fcaeb9bf0912290336m69303c3es8138c4e6497b801a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135821>

I went over the 952dfc6 patch, and it seems like it was designed to
fix a specific bug - the one demonstrated by Nanako Shiraishi above.

Nowhere there do I see an intention to prevent the action described in
the original post. And even if there was such intention, it should
have been made explicit by providing a proper error message: the
current one simply ignores the fact that we provided GIT_WORK_TREE,
and is thus incorrect since the work tree can be found.

Moreover, if there is an intention to prevent resetting from outside
the worktree (why?), then probably "checkout -f" should be limited as
well.

But it is more likely that the breaking of the original action between
1.6.4 and 1.6.6 came about as an untended consequence of 952dfc6,
which oversimplified by assuming that the worktree can only be found
if we're inside it, ignoring the possibility that GIT_WORK_TREE was
provided.

Thus, the current state should be considered a bug.

--

=46ynn

On Tue, Dec 29, 2009 at 3:36 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> On 12/29/09, Nanako Shiraishi <nanako3@lavabit.com> wrote:
>> Quoting Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
>>
>> =A0> On 12/29/09, Fyn Fynn <fynfynn@gmail.com> wrote:
>> =A0>> The exact same git reset command that works in 1.6.4, fails to=
 work
>> =A0>> =A0under 1.6.6:
>> =A0>>
>> =A0>> =A0$ GIT_WORK_TREE=3D$HOME/rawdata/ GIT_DIR=3D$HOME/rawdata/.g=
it
>> =A0>> =A0/usr/local/git-1.6.6/bin/git reset --hard
>> =A0>> =A0fatal: hard reset requires a work tree
>> =A0>> =A0$ GIT_WORK_TREE=3D$HOME/rawdata/ GIT_DIR=3D$HOME/rawdata/.g=
it
>> =A0>> =A0/usr/local/git-1.6.4/bin/git reset --hard
>> =A0>> =A0HEAD is now at 77ec73f...
>> =A0>>
>> =A0>> =A0What gives?
>> =A0>
>> =A0> A recent patch by Jeff (952dfc6 (reset: improve worktree safety=
 valves
>> =A0> - 2009-12-04)) makes sure that "git reset --hard" will not work
>> =A0> outside worktree (which is right).
>>
>>
>> Sorry, but I don't understand why it is *right*. Isn't 'git reset --=
hard' supposed to make all the files in the working tree match the HEAD=
, no matter where you start from?
>
> It is generally "right" to work from inside worktree, the way Git
> worked before GIT_WORK_TREE came. In case of "git reset --hard", yes
> it'd be best if Git could just go to worktree and reset it. I forgot
> that "git reset --hard" does not take pathspec. The situation may be =
a
> bit more complicated with "git status" (which also handles worktree a=
s
> a whole) because you may need to represent the filename output to be
> relative to current working directory, not the GIT_WORK_TREE. Using
> GIT_WORK_TREE from outside worktree is imo stretching git to its
> limits.
> --
> Duy
>
