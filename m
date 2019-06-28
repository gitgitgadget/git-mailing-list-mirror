Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63BD41F461
	for <e@80x24.org>; Fri, 28 Jun 2019 00:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfF1Aso (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 20:48:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39292 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfF1Aso (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 20:48:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so7310540wma.4
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 17:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J09H6z8zCn9NUbu0wCzPKbGRgWtpWjfj6QWqf5ed8nc=;
        b=MC0LuSTohcExfBJlpfSuJk5ZyaJj9Z+OAuH8YG6oyGUhM2FFE2wd/PSlujiI2U5BTk
         hkga+sM+iTwj3pG3RnPQZ2CObL5dwzsDjjhKkn3Gh9srPNYyW2D4ho/JS4mZLbhoMUlo
         KwosYQvaMK35Kr9+/ehDHbLMn8j+Ji6OIuLespl0Cp5/EMH6c3M+DWjSlRUOUqmTS5SG
         zcjJkSQR05pdSs44tjcs9ClHrPy2inR6hzsPptbbcT6QsHyBQV5j6WhCEb889cNYqh9r
         g62YIbJxCHasAgk+Vpa1dzeaG3B94gVl/I5be5LwY0riIGEVl9Sm9RSFm1wZLyTua/EA
         l25w==
X-Gm-Message-State: APjAAAUs42/2lF7XrdilMbF7wpsz+jpBt/kj50PSB9qAsFAGFePkF+lH
        rL0rKP3UBoyXGM2q7rcjllXkvq2BIuPJ1MmvMnY=
X-Google-Smtp-Source: APXvYqxXgdojADw8T/0LEMCqKpMijFjPCk43hzn7c4fK8hYaHIaYorS/ysdGzJ+DAgQ/hr8vrfnSlNe/rlk0coaahJs=
X-Received: by 2002:a1c:9a03:: with SMTP id c3mr4972563wme.101.1561682922432;
 Thu, 27 Jun 2019 17:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com>
 <20190626235032.177551-11-emilyshaffer@google.com> <CAPig+cR7rHokaTtZcJJg8trJ14xO3hdeWHqLnB4aOnEUak051w@mail.gmail.com>
 <20190627223110.GH245941@google.com>
In-Reply-To: <20190627223110.GH245941@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Jun 2019 20:48:31 -0400
Message-ID: <CAPig+cRB2=3j6BfuU00YWj1iSMi0qxE+0P7LCXHMtYpWdgam-A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/13] walken: add unfiltered object walk from HEAD
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 6:31 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> On Thu, Jun 27, 2019 at 01:37:58AM -0400, Eric Sunshine wrote:
> > Don't localize the die() message via _() here or in the preceding
> > OBJ_COMMIT case.
>
> I'm a little surprised by that. Is it because die() is expected to only
> be seen by the developer?

Sorry, I was reading those as BUG(), not die(), and we don't localize
BUG() text. But, why aren't those BUG()? Can those cases arise in
practice? (Genuine question; I haven't familiarized myself with that
code yet.)

If they legitimately should be die(), then ignore my comment about not
localizing them.

> > The two die() messages are unnecessarily dissimilar. Try to unify them
> > so that they read in the same way.
>
> I'm a little surprised by this too; it seems to me the root cause of
> each would be different. In the former case, I'd guess that
> traverse_commit_list()'s behavior changed, and in the latter case I'd
> guess that a new object type was recently added to the model. Can you
> help me understand the motivation for making the messages similar?

Both causes you describe here sound like BUG() cases, not die(). If
I'm understanding correctly, they could only trigger if someone made
some breaking or behavior changing modifications within Git and failed
to update all the code in the project impacted by the change. In other
words, these can't be triggered by user input, hence they would be
BUG()s indicating that a Git developer needs to fix the code.

As for the messages themselves, I was referring to the grammatical
dissimilarity of "unexpectedly" and "unexpected", and I also don't
understand why one messages mentions walken_show_object() explicitly,
whereas the other does not.
