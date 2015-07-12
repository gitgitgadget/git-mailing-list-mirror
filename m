From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 10/16] worktree: make branch creation distinct from
 worktree population
Date: Sat, 11 Jul 2015 22:36:49 -0400
Message-ID: <CAPig+cSiPeJskyanLAv71LuFoqPirUJ2FL0B0BsoT8BEVrE3LA@mail.gmail.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
	<1436573146-3893-11-git-send-email-sunshine@sunshineco.com>
	<CACsJy8A8QkeFa3FyCkv8dp-J52NGGaN-AV3oG7W8tNtYqDO-cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 04:47:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZE7IP-0002aP-2T
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 04:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbbGLCgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 22:36:51 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35505 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbbGLCgu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 22:36:50 -0400
Received: by ykee186 with SMTP id e186so91105108yke.2
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 19:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=sjikLxVntf1QadSg4rniFNbweSv89HyG60uEiGAD9zI=;
        b=0H1YlTDod8Hy0Z7QFUIffwsiM92rDP8/3QOzo+oyW0aWxmxwb1LJDGQRw71Fb34nnW
         LAbBbLEWnmySL+aC7pkBbMzHAKpAYpHYDWrn/FBNYiMXr+6wdTh/4P2PlfW8R0CFFJRd
         NSPXAkUsfcV6WcTDOTk9cdeuc1vpqTDfAGmA/i/nXiQTkNzDbn2NxVb5Rk189ZwLcp7v
         r9+UVNDvKKGt2Z6Pcx0r2vdmfRJgRwlj7cfAIb3Z3QWru0215UMDy3gKEwEO6C6PP8m4
         pfrkGxnaESwdqQx9ad9/Pv0j0LGj0fRAyvCAFijnes/8GosOZXo2AAehDkCTzVd8+TLM
         5Dmw==
X-Received: by 10.170.138.134 with SMTP id f128mr31649628ykc.90.1436668609493;
 Sat, 11 Jul 2015 19:36:49 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 11 Jul 2015 19:36:49 -0700 (PDT)
In-Reply-To: <CACsJy8A8QkeFa3FyCkv8dp-J52NGGaN-AV3oG7W8tNtYqDO-cw@mail.gmail.com>
X-Google-Sender-Auth: f1wqs6jN6-o9vF4Bf4nzWfScgn8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273881>

On Sat, Jul 11, 2015 at 9:20 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jul 11, 2015 at 7:05 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> The plan is eventually to populate the new worktree via "git reset
>> --hard" rather than "git checkout". Thus, rather than piggybacking on
>> git-checkout's -b/-B ability to create a new branch at checkout time,
>> git-worktree will need to do so itself.
>>
>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>> ---
>>
>> I considered calling branch-related API, such as create_branch(),
>> directly, however, git-branch provides extra value which may be useful
>> in the future (such as when --track and --orphan get added to
>> git-worktree), so it seemed wise to re-use git-branch's implementation
>> rather than duplicating the functionality. If this proves the wrong
>> choice, then the series can either be re-rolled or follow-on patches can
>> address the issue.
>
> I don't know much about ref handling code (especially after the big
> transaction update), so i may be wrong, but do we need to invalidate
> some caches in refs.c after this? The same for update-ref in the other
> patch. We may need to re-read the index after 'reset --hard' too if we
> ever need to do touch the index after that (unlikely though in the
> case of 'worktree add')

I'm not sure I understand. Are you talking about this patch's
implementation or a possible future change which uses the C API rather
than git-branch?

If you're talking about this patch, then I don't think we need to do
anything more, as the "git branch" and "git reset --hard" invocations
are separate process invocations which shouldn't affect the current
worktree or the current "git worktree add" process.

If you're talking about a future patch switching over to the C API,
and avoiding run_command(), then perhaps (but I haven't investigated
that avenue thoroughly enough to answer).

Or, am I totally misunderstanding you?
