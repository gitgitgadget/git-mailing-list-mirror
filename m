From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/4] t5509: add basic tests for hideRefs
Date: Mon, 2 Nov 2015 02:30:51 -0500
Message-ID: <CAPig+cSv1x50ZoXLRAW55v7H6K5828GhvkeptuHd-Jsr+u74qA@mail.gmail.com>
References: <1446406463-22527-1-git-send-email-lfleischer@lfos.de>
	<1446406463-22527-5-git-send-email-lfleischer@lfos.de>
	<CAPig+cR7sCqigz=--_d-bW0X=+vpbV-_N9hxriLH9fMjLJUfsA@mail.gmail.com>
	<20151102062449.24971.39537@typhoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Mon Nov 02 08:30:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zt9Zx-00075x-5D
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 08:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbbKBHaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 02:30:52 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35278 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbbKBHaw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 02:30:52 -0500
Received: by vkfw189 with SMTP id w189so80113281vkf.2
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 23:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TcgTJ0V43Gk5ebCKGi0j3JEXm6USveCdewzNpUKMtDU=;
        b=kCcrGB4p4h0mN5h98i7ETsWNrSKoWeJEgWXW+RDSZ2NQjdQW0DlM6m4r2LWDrP5MHy
         CGXMl54zJKqhZsdr5AXXhlecDMEZB52i+BHM+lJNJRwU9afumQ8r51JQn3SjTzfEoZvD
         zn9zHf1++Uihw+CMMgrlOnlFQvYfk/xXnvcbthUiM7krQnnf1Yb8F4DDhnMd9ZWM/fJn
         7nttuhf4Cw1ialDmp5Y8tfJsFFR2xSL+5R0DmLIcUyzu6fvmTsnfCIYUCrmmRyYr5umV
         R6OBIDX5qju8SFtxW83CN2qNc1Ru6nyKBh1BIHmyX1cjsPnHp63Mc/kCmiiXGJe6MopO
         KKgA==
X-Received: by 10.31.153.210 with SMTP id b201mr14017435vke.117.1446449451352;
 Sun, 01 Nov 2015 23:30:51 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Sun, 1 Nov 2015 23:30:51 -0800 (PST)
In-Reply-To: <20151102062449.24971.39537@typhoon>
X-Google-Sender-Auth: DlXy5g8QyXQLbiNsiIRtt5X1uBU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280685>

On Mon, Nov 2, 2015 at 1:25 AM, Lukas Fleischer <lfleischer@lfos.de> wrote:
> On Sun, 01 Nov 2015 at 22:13:51, Eric Sunshine wrote:
>> On Sun, Nov 1, 2015 at 2:34 PM, Lukas Fleischer <lfleischer@lfos.de> wrote:
>> > +       cd pushee &&
>> > +       test_config transfer.hideRefs refs/tags &&
>> > +       GIT_NAMESPACE=namespace git ls-remote "ext::git %s ." >actual &&
>> > +       printf "$commit1    refs/heads/master\n" >expected &&
>> > +       test_cmp expected actual &&
>> > +       cd ..
>>
>> If any of the commands above "cd .." fail, then "cd .." will never be
>> invoked, thus subsequent tests will fail since they won't be executed
>> in the expected directory. The typical way to handle this is to place
>> the "cd foo" and remaining test body in a subshell, and drop "cd .."
>> altogether. When the subshell exits (via success or failure), the
>> working directory will be restored automatically.
>>
>>     test_expect_success '...' '
>>         (
>>             cd pushee &&
>>             test_config ... &&
>>             ...
>>         )
>>     '
>> [...]
>
> I chose the `cd ..` approach because test_config does not work from a
> subshell. However, searching the Git log for "test_config", I found
> 1a9a23e (t7610: don't use test_config in a subshell, 2015-09-05) and
> da568b6 (t7800: don't use test_config in a subshell, 2015-09-05) which
> suggest to use the -C switch. The test cases now look like this:
>
>     test_expect_success '[...]' '
>         test_config -C pushee transfer.hideRefs [...] &&
>         (
>             cd pushee &&
>             [...]
>         )
>     '

Yes, that can work, although for these simple cases, it might be more
straightforward to use the git -c option to set the config variable
just for the duration of the one git command. For instance:

test_expect_success 'hide namespaced refs with transfer.hideRefs' '
    (
        cd pushee &&
        GIT_NAMESPACE=namespace \
            git -c transfer.hideRefs=refs/tags \
            ls-remote "ext::git %s ." >actual &&
        printf "$commit1\trefs/heads/master\n" >expected &&
        test_cmp expected actual &&
    )
'

In fact, these test are so simple, that you don't really need the 'cd'
at all. You could just use -C (along with -c):

test_expect_success 'hide namespaced refs with transfer.hideRefs' '
    GIT_NAMESPACE=namespace \
        git -C pushee -c transfer.hideRefs=refs/tags \
        ls-remote "ext::git %s ." >actual &&
    printf "$commit1\trefs/heads/master\n" >expected &&
    test_cmp expected actual &&
'
