From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Make 'git request-pull' more strict about matching
 local/remote branches
Date: Wed, 22 Jan 2014 14:03:47 -0800
Message-ID: <CA+55aFxSiKhM=4GtFaruWNZFNaUgCpVHsJOWJ9Qcd19nz6YYTw@mail.gmail.com>
References: <alpine.LFD.2.11.1401221243090.18459@i7.linux-foundation.org>
	<xmqq1tzzy9ip.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tejun Heo <tj@kernel.org>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 23:03:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W65tp-0005dP-Ck
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 23:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbaAVWDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 17:03:49 -0500
Received: from mail-vb0-f52.google.com ([209.85.212.52]:43323 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbaAVWDs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 17:03:48 -0500
Received: by mail-vb0-f52.google.com with SMTP id p14so578638vbm.25
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 14:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=R/ZTn8M0PUYM16fkrIMGmaIxtQvHzkGWdN7uG2yyIy4=;
        b=IibnCUEPJ3nhJjxo4ypww2WrgYNqMk97tBLuSupUoW7PSZwdW+YHKr2R7PlVtQ+dqa
         xhgr+5gxSuDMlebluibpO6vTAq8vb48Vf6D8ienQPQPCfznuJ226oAd9dQMPRlCOlKUF
         yn4HawTzYt6v2pGOnlwhJbgUAwUsPLJJonAnl6qc4ZuOeYWv4YekUUm8IyHBcH+LEZWM
         xIrvsSgBT2efAwPEHmz3zvxpyUwc99vUV8+AguWZN8h9nesZEF7X+4voYm0f3nxuYJxL
         E2yQAd6IhHeeeRdPSsYcbZu1eJvBKxbu0WtWoaUw3vo39q8exwR9efExn2hf/RoILNlF
         zkZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=R/ZTn8M0PUYM16fkrIMGmaIxtQvHzkGWdN7uG2yyIy4=;
        b=M3PftUT+BYQuUb1rcf9c19G8NmfaDpU53R60frfXDYMfxLNveIl7nuGDxjBAsvMOpR
         yoMz+OWqRHla06d3LipICvS0+WK3LtGBdrMPA03z6AnGqr8JyGE55dpwt7ib7C2V8Fn4
         InzzjG1G17f0QwwxwkfYiLGit6/61s+a+jwPM=
X-Received: by 10.58.37.67 with SMTP id w3mr2597550vej.22.1390428227345; Wed,
 22 Jan 2014 14:03:47 -0800 (PST)
Received: by 10.221.8.73 with HTTP; Wed, 22 Jan 2014 14:03:47 -0800 (PST)
In-Reply-To: <xmqq1tzzy9ip.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: P2keRhI0IL3R08yvxkqi6o4QuXM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240865>

On Wed, Jan 22, 2014 at 1:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> The new "find local ref" code will also complain loudly if you give an
>> ambiguous refname (eg you have both a tag and a branch with that same
>> name, and you don't specify "heads/name" or "tags/name").
>
> But this part might be a bit problematic.  $3=master will almost
> always have refs/heads/master and refs/remotes/origin/master listed
> because the call to "show-ref" comes before "rev-parse --verify",
> no?

Hmm. Yes.

It's done that way very much on purpose, to avoid the branch/tag
ambiguity (which we have had problems with), but you're right, it also
ends up being ambiguous wrt remote branches, which wasn't the
intention, and you're right, that is not acceptable.

Damn. I very much want to get the full ref-name (ie "master" should
become "refs/heads/master"), and I do want to avoid the branch/tag
ambiguity, but you're right, "show-ref" plus the subsequent "rev-parse
--verify" comes close but not quite close enough.

Any ideas? The hacky way is to do "| head -1" to take the first
show-ref output, and then check if you get a different result if you
re-do it using "show-ref --tags". But that sounds really excessively
hacky. Is there a good way to do it?

                 Linus
