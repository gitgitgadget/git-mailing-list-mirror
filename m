From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH v2 23/23] rebase -i: enable options --signoff, --reset-author
 for pick, reword
Date: Sun, 21 Sep 2014 18:59:40 +0200
Message-ID: <541F03FC.8040506@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com> <ed19a079924e11edac0163837500c2e8caa2a555.1407368621.git.bafain@gmail.com> <53EB5E77.8010005@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 19:00:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVkUS-0006GB-6w
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 19:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbaIUQ7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2014 12:59:46 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:46024 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbaIUQ7p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2014 12:59:45 -0400
Received: by mail-la0-f44.google.com with SMTP id q1so5491871lam.17
        for <git@vger.kernel.org>; Sun, 21 Sep 2014 09:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6lWOpd8HvcDB1bwRvSdrgSfbL+ocSERm4/10CO/YobA=;
        b=Ats4W6rddDyJ5yL++d0Wb90q1qgdPAK53C+rkv4lVuebEj8wzbsIsj6qs3c2qe+DNG
         gPPMRctGSrl+pPv1AMGnr8U9kR/9aMrChYcL8tBNBPTDUHskuOT3jv9ElWw29wTancU1
         uAyyMbeIAWtb+9vBXSGpKj6zzpEt1Ljxu/ukintnrOBn4HqmVhj6ehcMmJF7l/W/GWFX
         z0q1f7vhJHkKTM6WZhIwEcQMRG6O7DTXkAiMlVxgwv8Hzjmz5Wj6Z/DI+hQdNXX2mYf9
         UgPeAGrjCdAchBjBiGuB9c/OZFJ14uKS+UV6rNZBaQ7bZSzL1DQ1DP9AIOmjbfe0zbAR
         CeNQ==
X-Received: by 10.152.9.200 with SMTP id c8mr20758804lab.76.1411318783745;
        Sun, 21 Sep 2014 09:59:43 -0700 (PDT)
Received: from client.googlemail.com (dhcp-183053.eduroam.chalmers.se. [129.16.183.53])
        by mx.google.com with ESMTPSA id yx5sm2854952lbb.35.2014.09.21.09.59.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Sep 2014 09:59:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <53EB5E77.8010005@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257353>

Hi Michael,

On 08/13/2014 02:47 PM, Michael Haggerty wrote:
> On 08/07/2014 01:59 AM, Fabian Ruch wrote:
>> pick and reword are atomic to-do list commands in the sense that they
>> open a new task which is closed after the respective command is
>> completed. squash and fixup are not atomic. They create a new task
>> which is not completed until the last squash or fixup is processed.
> 
> I don't understand the distinction that you are attempting to draw
> between "atomic" and "non-atomic" commands.  For example, in the
> following command list:
> 
>     pick 1111111
>     squash 2222222
>     fixup 3333333
> 
> the "pick" command doesn't seem very atomic, because the *end* result of
> the three commands is a single commit that is affected by all three
> commands.

Right, when I wrote the commit message I was thinking in abstract terms
so I implicitly thought of your example as a (single) squash/fixup
command. Now it has become obvious that I wasn't very thorough with the
implementation part. The git-rebase implementation is oblivious to the
context when it processes 'pick' lines and your example shows how 'pick'
lines can be part of squash/fixup command context. In conclusion, I
intended to keep options disabled for squash/fixup commands but failed
to do so because I neglected that a 'pick' line can initiate a
squash/fixup command.

> Furthermore, if we change the example to
> 
>     pick 1111111
>     squash --reset-author 2222222
>     fixup --signoff 3333333
> 
> then isn't it clear that the user's intention was to apply both options,
> "--reset-author" and "--signoff", to the resulting commit?

This seems to suggest an interpretation of todo lists similar to what I
was thinking of when writing the commit message, that is one in which
pick is not oblivious to the neighbouring commands. It might be a
problem that it forbids the (admittedly improbable) use case where
--reset-author is used to rewrite the authorship to something recent and
fixup to have an even more recent committership.

To reconcile this kind of vertical interpretation with the horizontal
specification of options one could introduce a todo list command taking
the list of commits to be squashed as an argument. However, that seems
to make it difficult to obtain the squash behaviour for some commits and
the fixup behaviour for others that are part of the same chain.

The alternative interpretation of todo lists as simplified batch scripts
for git commands would allow the intended behaviour (--reset-author and
--signoff applied to the resulting commit), not restrict the user
relatively to what she can already do on the command line and give
actually different meanings to the syntactically different todo lists

    pick 1111111
    squash --reset-author 2222222
    fixup --signoff 3333333

and

    pick 1111111
    squash --signoff 2222222
    fixup --reset-author 3333333

, which would be treated identically by an implementation that collects
the options. The current meaning of squash/fixup seems to be valid in
the batch interpretation.

> In other
> words, it seems to me that any options on such a chain of lines should
> be collected and applied to the final commit as a whole.

To summarise, I think line options might be confusing if we interpret

    pick 1111111
    squash --reset-author 2222222
    fixup --signoff 3333333

as

    combine the changes of 1111111, 2222222, 3333333
    concatenate the messages of 1111111 and 2222222
    edit the message
    reset the authorship to the committership
    add a Signed-off-by: line

and not as

    pick 1111111
    pick -n 2222222
    commit amend --reset-author -m $squash_msg
    pick -n 3333333
    commit amend --signoff --edit

.

Thanks for pointing me at these issues. "Atomic" and "non-atomic" are
really poorly-chosen terminology and the squash-initiating 'pick' might
not be implemented correctly.

   Fabian
