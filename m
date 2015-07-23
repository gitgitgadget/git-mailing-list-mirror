From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] diff-tree: do not show the sha1 of the given head with --quiet
Date: Thu, 23 Jul 2015 09:06:01 +0200
Message-ID: <CAHGBnuM5TG6m7Rwd-EZTUXnaDNYomidthmCamCevNECTQCTnmA@mail.gmail.com>
References: <0000014eb518dc87-a69705c4-31e7-4983-99a8-f780a743aeac-000000@eu-west-1.amazonses.com>
	<xmqqmvyoq6gh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 09:06:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIAa0-0006w6-Bw
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 09:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbbGWHGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 03:06:04 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38057 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbbGWHGC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 03:06:02 -0400
Received: by iggf3 with SMTP id f3so151793570igg.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 00:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hwC34Z7rGG4t1Zs2HO223WObYjK5sfbq6uGTX555IvE=;
        b=k3coALydVvke+yupf2dEG2kbBCkOp7oJl1cBsM+avMkAnN6ZsmznRKmIKm+ahL8cdF
         o98yYEjRe1IGtQf63pLw4HcpW973QEntoeugnSSuKsNWjyg43+eQDiChF0TJ+YKwH/4N
         MdY99D39oJSUWn7snIC/b8Hmn8DQLIocnYMKUdGN9ULfnxto5GGsv0o3lvt63FeO3nL0
         hClA8lnHEVQrLBwJvhIrdVK/n8KhICDrB33JVj9fWizTl6uwl8DZabgXBbHlxOf0bUmZ
         EivtK9rsGc/XN8EBiILKmCQpZKU9c+TEP8agD/mQMirElmHZQPgqYFNXHn916BPxQ4x7
         W8WQ==
X-Received: by 10.50.56.104 with SMTP id z8mr12780289igp.45.1437635162034;
 Thu, 23 Jul 2015 00:06:02 -0700 (PDT)
Received: by 10.107.29.149 with HTTP; Thu, 23 Jul 2015 00:06:01 -0700 (PDT)
In-Reply-To: <xmqqmvyoq6gh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274485>

On Wed, Jul 22, 2015 at 10:32 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> "--quite" is documented to "Disable all output of the program". Yet
>> calling diff-tree with a single commit like
>>
>> $ git diff-tree --quiet c925fe2
>>
>> was logging
>>
>> c925fe23684455735c3bb1903803643a24a58d8f
>
> At this point, unfortunately I think we need to call that a
> documentation bug.  The "output" it refers to is output from the
> "diff" portion, not the "poor-man's log" portion, of the program,
> where diff-tree was the workhorse behind scripted "git log" that
> gave the commit object name as the preamble for each commit it
> shows information about.

Well, from a user's perspective it does not matter which part of the
internal implementation of diff-tree is responsible for printing that
single line, a user would just expect "--quiet" to really mean
"quiet". As for almost any bug, we could turn it into a feature by
"fixing" the docs and claiming it's documented behavior. To me the
question simply is whether it makes sense for "--quiet" to not be
quiet, and I think it does not make sense. If you run diff-tree this
way there is no added value in the given output.

My use-case (also see [1]) is that I wanted to checked whether some
given commits change nothing but whitespace. So I did

if git diff-tree --quiet --ignore-space-change $commit; then
    echo "$commit only changes whitespace."
fi

just to see those SHA1s being printed to the console.

I probably could instead do

if git diff-tree --exit-code --ignore-space-change $commit > /dev/null
2>&1; then
    echo "$commit only changes whitespace."
fi

but that defeats the purpose of having "--quiet" in the first place.

[1] http://article.gmane.org/gmane.comp.version-control.git/273975

-- 
Sebastian Schuberth
