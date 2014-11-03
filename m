From: Tzvetan Mikov <tmikov@gmail.com>
Subject: Re: [PATCH] line-log: fix crash when --first-parent is used
Date: Mon, 3 Nov 2014 14:09:35 -0800
Message-ID: <CACt9tMj2GBWC6yRpfKXUk1hnh2ZyBqoV5HDmL0cjfxCiawHT=g@mail.gmail.com>
References: <1414784636-43155-1-git-send-email-tmikov@gmail.com> <xmqqoasoq9vh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Eric Vander Weele <ericvw@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 23:10:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlPpD-0003KW-8Z
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 23:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbaKCWKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 17:10:07 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:47381 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbaKCWKG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 17:10:06 -0500
Received: by mail-qg0-f49.google.com with SMTP id z60so6683772qgd.22
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 14:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UgFLqmilUdOM1+/JhmJMeHCwrama406HXFNIxqgAxuk=;
        b=xcqblmipCfW09EiVtv2cCvAL91DSrvXK0Tf83yMJZxB1g9fns57rLJBKcQWfKsE64w
         MPIkTauz29AFbFwMXTL0XDqvPNaYKbYW+aseMXL/2vE4Uht/7p0vdO5bVEwhRl0NJgX8
         HkA4Di8bwGj2CtU45tbYd1tMEJeqQ8zF3HNepPTCHnN9pyB+dUYzr0rTLkgD4l67XX1K
         +WtKa3o4rVjByaY9N/iiB18h0ESktsfKAc4hOL/zDfEmG7KuruATPraLwDmtAmHCDBbk
         h5bsNaQpvkrf/wCyZkKz6GJBBhaiQF5CDlg3fkfb5Trle4FdB++c8pgYKoo4tIT+S/zY
         WLmw==
X-Received: by 10.224.157.17 with SMTP id z17mr25598857qaw.97.1415052605661;
 Mon, 03 Nov 2014 14:10:05 -0800 (PST)
Received: by 10.140.16.45 with HTTP; Mon, 3 Nov 2014 14:09:35 -0800 (PST)
In-Reply-To: <xmqqoasoq9vh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 3, 2014 at 12:58 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> line-log tries to access all parents of a commit, but only the first
>> parent has been loaded if "--first-parent" is specified, resulting
>> in a crash.
>>
>> Limit the number of parents to one if "--first-parent" is specified.
>>

> [...]
> Tzvetan, can we have a test for this one?

Here is a sequence of commands to reproduce the crash:

git init
echo "1" > a.txt && git add a.txt && git commit -m "a"
git checkout -b branch
echo "2" > b.txt && git add b.txt && git commit -m "b"
git checkout master
git merge branch --no-ff -m "merge"
git log --first-parent -L 1,1:a.txt

I am not sure whether you have a requirement for a formal test
included with the patch, but if there is one, I am happy to
rework it.

This is a very simple fix for the crash, though possibly
a "real" comprehensive fix may be needed. I am not sure.
The real cause is that with "--first-parent" some commit
objects are never loaded from disk but may still be accessed.

(sorry about my formatting - have to use GMail)

regards,
Tzvetan
