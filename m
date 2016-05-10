From: Armin Kunaschik <megabreit@googlemail.com>
Subject: syntax error in git-rebase while running t34* tests
Date: Tue, 10 May 2016 19:29:51 +0200
Message-ID: <CALR6jEiF9Ooi1f0O3KG0wYmN0KRWBQTNarXx79-wBD2E-8q2jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 10 19:29:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0BTp-0001sM-Iu
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 19:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbcEJR3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 13:29:53 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36509 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbcEJR3x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 13:29:53 -0400
Received: by mail-yw0-f195.google.com with SMTP id u62so1624129ywe.3
        for <git@vger.kernel.org>; Tue, 10 May 2016 10:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=FqdZXlPfxCINFAl3A6aUNzbKVJKjAzE2yPPpGMbXjgA=;
        b=CJ0f6KdyoX+wTsh9uXfWD/QF7yo0G9xYAJAuWu8UyAMYP9M3zANvbyLWSoKlCf0e2Y
         Dq5YbJxAX5mD48bENxHCkpXqEaZTniOrykW5mI/fq2j8+wkl2x64WderXcZFozbritMn
         qxg4Z0KEZK9oX6/5Vg2E+3yJroYgwr/caIB+zQVj9sr4qc3kwxRZ2nf9Z+kjQ0ex12dx
         HJr0YomV14fa6f7L+1zP1UyEValYmhGqkaYiCLk7p5bi0UWuzCO4AiWNH4sg7fxOGvRz
         xU7qKiFc1QOTef908yI8IkqzElxdclo77C3IYqNl1rBOmhTkArqcE8UGY8NHRTbyBuKh
         8Dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FqdZXlPfxCINFAl3A6aUNzbKVJKjAzE2yPPpGMbXjgA=;
        b=ZeM0sbU5dSj3K7nINn3shpkbYnQNgabykr43Ko6hiplA+Xg15DSt5fZIMwo4WHN14L
         cDfYSxPXsTKwlKCZLZl0DM4XQDEZoO5daYgQYLlWqPVqg3u+U6cBCYtlbF0VCYQZsoNT
         Aa88ZKj2tDQaOfE9at9ANIHQ8jl9zjMBGSJr6ECFHRX+MWF8F4PBMgkDKuAXnVBypxx9
         dfO3qiPYij+TB4OnlJ75gXIccVKd7TufQvf5XhSFcltr01nfm8joPs0d4PstjQuxPZIq
         liIsNe5NEnCRBOI570SWstOSPTSbue6VxTYbqN6i+JUgNzt/jU4NVKNzfL/ZmP9xIH5Q
         ZN+g==
X-Gm-Message-State: AOPr4FXYNnTKRE13739KYoXYEptGaYhGq7RJvfF4dfl+94OjKExY94/XiC5dxQttDitlVvaRZJIO5GmB6h/PRQ==
X-Received: by 10.129.124.8 with SMTP id x8mr22661313ywc.200.1462901391996;
 Tue, 10 May 2016 10:29:51 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Tue, 10 May 2016 10:29:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294160>

Hello,

I noticed in my environment (AIX, ksh) that all rebase tests don't work.
git-rebase terminates with
git-rebase[6]: Syntax error at line 3 : `newline or ;' is not expected.
Digging deeper I found the problem in git-rebase--interactive line 85

<snip>
strategy_args=${strategy:+--strategy=$strategy}
eval '
        for strategy_opt in '"$strategy_opts"'
        do
                strategy_args="$strategy_args -X$(git rev-parse
--sq-quote "${strategy_opt#--}")"
        done
'
<snip>

This snippet fails when $strategy_opts is empty or undefined... and my
eval seems not to like this.
The for loop runs fine, even with empty strategy_opts, but not inside eval.
I fail to see why eval is really necessary here. Things can probably
be done without eval, but I
don't feel to see the big picture around this code.

My quick and dirty hotfix is to place a
test -n "$strategy_opts" &&
in front of the eval.
The tests run fine after this change.

What do you think?

Armin
