From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH v3] diff-no-index: exit(1) if 'diff --quiet <repo file>
 <external file>' finds changes
Date: Tue, 19 Jun 2012 12:47:08 -0400
Message-ID: <CAFouetgRq1qkqJmThJJeu=Mdx9jS0c9dw7NPSwuJUOSpskCY2A@mail.gmail.com>
References: <1340047704-8752-1-git-send-email-tim.henigan@gmail.com>
	<7vr4tc2xhy.fsf@alter.siamese.dyndns.org>
	<CAFouethcrw3vOF7SPwHxjH4ABmF8U1df0MfyzcUGq2yTYxs4ow@mail.gmail.com>
	<20120619135814.GA3210@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 19 18:47:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh1aE-0005ia-U7
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 18:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280Ab2FSQrK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jun 2012 12:47:10 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35005 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139Ab2FSQrJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jun 2012 12:47:09 -0400
Received: by yenl2 with SMTP id l2so4391710yen.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ufOEhA5KszL2QcMHTJ8wMcEojAJVOrzbLe+Y45YyWc0=;
        b=E7x/1MaiWiuqNeLJW/S+wsW6h6j4PEIV1y+OBaCCwTz7xtCtCcNojz3FQkRQQzw/vK
         ITg/35Sf0N6EcXjrseILGRzVPBd4i/u8I3Q6ozoMRJnvZen3cT96S4F0VyJtLQICppUd
         plnt2Uzg461FpuK+f/fra/NEAlWEwFHvFjVmTXqQuxeiuIhIeV/ZZNXFxGt+7zXZKDUv
         PwIucavsgdVet2z7N+s0WjAKiuAB5UayVRb8ldUCtRk7f4+CXowoX4PlZn9F00Q3y8BB
         z95OHgP3/0pwz3YZPiCRLvAcCV4nPnW2Cmb7yLavBw6Jr1b++siS5fqfwDdswe4tdvMJ
         fAww==
Received: by 10.50.40.194 with SMTP id z2mr1902037igk.67.1340124428319; Tue,
 19 Jun 2012 09:47:08 -0700 (PDT)
Received: by 10.231.84.147 with HTTP; Tue, 19 Jun 2012 09:47:08 -0700 (PDT)
In-Reply-To: <20120619135814.GA3210@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200212>

On Tue, Jun 19, 2012 at 9:58 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 19, 2012 at 09:05:40AM -0400, Tim Henigan wrote:
>
>> As a side note, I found that these tests fail if a relative path is
>> used for the file in 'non/git'. =C2=A0In other words, this passes:
>>
>> =C2=A0 =C2=A0 test_expect_code 0 git diff --quiet a
>> "$TRASH_DIRECTORY/test-outside/non/git/matching-file"
>>
>> but this fails:
>>
>> =C2=A0 =C2=A0 test_expect_code 0 git diff --quiet a ../non/git/match=
ing-file
>>
>> This surprised me, but I have not investigated any further.
>
> The problem is that path_outside_repo in diff-no-index.c does not bot=
her
> handling relative paths at all, and just assumes they are inside the
> repository. This is obviously not true if the path starts with "..", =
in
> which case you would need to compare the number of ".." with the curr=
ent
> depth in the repository.
>
> prefix_path already does this (and is what generates the later
> "../non/git/matching-file is not in the repository" message). We coul=
d
> perhaps get rid of path_outside_repo and just re-use prefix_path's
> logic, something like (not tested):

With your patch applied, I was able to use relative paths in my tests.
 I also confirmed that all the t4*.sh tests pass.

=46or what its worth, your patch looks correct to me.  Existing
consumers of 'prefix_path' should get the same results as before and
the one added xmalloc is paired with a free.
