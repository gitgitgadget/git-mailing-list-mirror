From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 23/23] checkout: retire --ignore-other-worktrees in
 favor of --force
Date: Tue, 7 Jul 2015 04:24:05 -0400
Message-ID: <CAPig+cSSooqUcR_gW6vQP5Ws5v9p47bt7JWX4HgAyD6mFZynDA@mail.gmail.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
	<1436203860-846-24-git-send-email-sunshine@sunshineco.com>
	<xmqqlhetyszz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 10:24:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCOAw-00068T-28
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 10:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756653AbbGGIYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 04:24:19 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36454 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756649AbbGGIYG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 04:24:06 -0400
Received: by ykdr198 with SMTP id r198so170977188ykd.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=oVrLn31UAfuh6UdOVOvqNHzTIg0Y9inb2a8NiOH36OQ=;
        b=byaGWNGq/sNAmRMpCpP+5HZxjccuom6dvM6Xaurwwo3WtFroDdJ4Xy7G9Hy6xTIBDj
         jtrNRhdFpAqxd7SNs51/IXYfTBFP+RXyqrRZZikapHEwcBqqI7TbhiF6gCq9xNr90vUV
         nDQNKoGYBm5WXq8WbrWzIPPt9nZB8Hobu8H4oA5xq77sYIplOmRSfKplb/sWTIVsyWam
         0bn+7lfcHn0Oo+TwayRZWXvzBoX+ao3SKeohzuMi4/L6R1Ha0YHC0+zK3dIQgghs5uRy
         P1Axyrk0wLPkcRXhg5k41f8dnmSW79hrSA4K9FT3v3oZt/QiK9jJL1vHYh1tlLLl3fBV
         7g0g==
X-Received: by 10.129.76.140 with SMTP id z134mr3639707ywa.17.1436257445366;
 Tue, 07 Jul 2015 01:24:05 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 7 Jul 2015 01:24:05 -0700 (PDT)
In-Reply-To: <xmqqlhetyszz.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: zEzP4n7ibgah8CgzhlrrpY4e5OA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273491>

On Mon, Jul 6, 2015 at 3:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> As a safeguard, checking out a branch already checked out by a different
>> worktree is disallowed. This behavior can be overridden with
>> --ignore-other-worktrees, however, this option is neither obvious nor
>> particularly discoverable. As a common safeguard override, --force is
>> more likely to come to mind. Therefore, overload it to also suppress the
>> check for a branch already checked out elsewhere.
>
> I hate to be asking this again but why is it a good idea to allow
> 'ignore-other-worktrees' in the first place (let alone making it
> more discoverable)?  You'll have multiple working trees, either
> using the new "git worktree" or using the old contrib/workdir, for
> one of the two reasons:
>
>  * You need a separate work area to build a new history.
>
>  * You need a separate work area to expand the contents of a
>    specific commit.
>
> Here "create binary by running make" falls into the latter category;
> as far as Git is concerned, you are only looking at, not extending
> the history of any specific branch.
>
> If you are extending the history of some branch, then you would want
> to be on that branch.  Why would you want to have another worktree
> that will get into a confusing state once you create that commit on
> the checked out branch in this newly created worktree?
>
> Wasn't the whole point of making the primary repository aware of the
> secondary worktrees via the "linked checkout" mechanism because that
> confusion was the biggest sore point of the old contrib/workdir
> implementation?

Having never used contrib/get-new-workdir, and not being involved in
the choice, nor recall seeing justification for disallowing the a
branch to be checked out in multiple locations, I lack insight to
answer. I do recall Mark pointing out that this restriction posed a
barrier for his migration from git-new-workdir to "git checkout
--to"[1], and Duy adding --ignore-other-worktrees in response. Mark
presented a use-case here [2], but then the discussion petered out.

I likewise probably lack understanding of the finer points to make a
cogent argument for or against.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/260387/focus=260411
[2]: http://article.gmane.org/gmane.comp.version-control.git/260645
