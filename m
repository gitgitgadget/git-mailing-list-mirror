From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 08/23] checkout: fix bug with --to and relative HEAD
Date: Sat, 4 Jul 2015 04:49:12 -0400
Message-ID: <CAPig+cSQ6K7noQiKJbwHpY4tO2hzQMH9q-0nqkWUX_ecJkCTEg@mail.gmail.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
	<1435969052-540-9-git-send-email-sunshine@sunshineco.com>
	<CACsJy8C=BZF57GqRxO6CfBAYOxywEd4zHay4cgSZMrKCv6u77w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 12:01:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBgk1-0006ks-Cb
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jul 2015 12:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755307AbbGEKBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 06:01:37 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:32862 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273AbbGEKBg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 06:01:36 -0400
Received: by ykeo3 with SMTP id o3so5671169yke.0
        for <git@vger.kernel.org>; Sun, 05 Jul 2015 03:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=PNoe0rzwarAuvFWWRnpHYSERqcGxG6/BrlCd7U08YJI=;
        b=BgtWcd2xRAvFo0STL5h75yAvEnC8rSUI/3cLjJswdRt3zsXl4ONn37ahqinHIJaFsR
         XFDJ2Ps2NsBzcAWNeD8zXeYvoOk2cY9fflKcY9CRPABHP93ctLPkZSiI8wMr3gBVPB0q
         i6LY1koc1GhEGJ7R+gz9/FBv8BhOvsOmeAvkh8SWaNyA37P8OQUvBA6ckvkp8RN5TEYE
         9za7QUPVQc86s14OyuH23yJSyynRSWcltkWJfjvzc0O7ToJsbMOKABDSVMuImgqrauI8
         6UhkYirihzS838jo1owwiHI7EnaPhZ0lBx1LAJrs17qGmizYuR1+nsQVp1lraQPoN/UW
         ynKQ==
X-Received: by 10.129.50.207 with SMTP id y198mr48359638ywy.39.1435999752200;
 Sat, 04 Jul 2015 01:49:12 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 4 Jul 2015 01:49:12 -0700 (PDT)
In-Reply-To: <CACsJy8C=BZF57GqRxO6CfBAYOxywEd4zHay4cgSZMrKCv6u77w@mail.gmail.com>
X-Google-Sender-Auth: FhFaZ9QUJl1qzA69Kim2u09Q5iQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273359>

On Fri, Jul 3, 2015 at 10:45 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jul 4, 2015 at 7:17 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Given "git checkout --to <path> HEAD~1", the new worktree's HEAD should
>> begin life at the current branch's HEAD~1, however, it actually ends up
>> at HEAD~2. The happens because:
>>
>>     1. git-checkout resolves HEAD~1
>>
>>     2. to satisfy is_git_directory, prepare_linked_worktree() creates a
>>        HEAD in the new worktree with the value of the resolved HEAD~1
>>
>>     3. git-checkout re-invokes itself with the same arguments within the
>>        new worktree to populate the worktree
>>
>>     4. the sub git-checkout resolves HEAD~1 relative to its own HEAD,
>>        which is the resolved HEAD~1 from the original invocation,
>>        resulting unexpectedly and incorrectly in HEAD~2 (relative to the
>>        original)
>>
>> Fix this by unconditionally assigning the current worktree's HEAD as the
>> value of the new worktree's HEAD.
>
> Good catch!
>
>> @@ -924,9 +925,11 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
>>          * value would do because this value will be ignored and
>>          * replaced at the next (real) checkout.
>>          */
>
> This comment "any valid value would do.. will be ignored" is proved incorrect.

Yup, and I meant to update the comment but promptly forgot about it.
Thanks for the reminder.
