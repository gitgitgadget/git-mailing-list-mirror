From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: Premerging topics (was: [RFD] annnotating a pair of commit objects?)
Date: Mon, 22 Apr 2013 11:23:37 +0200
Message-ID: <CALWbr2ys4G=Dz+gOqT7-qxjX6KL5FqgfEJqrfmqUmW9HzGLESg@mail.gmail.com>
References: <CALWbr2wocjqs1mpa+yuQ_Zw8m+SX24q6Pby3E3v3-jd-0w1pvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 22 11:23:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUCyQ-0002st-O8
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 11:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755437Ab3DVJXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 05:23:40 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:44775 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab3DVJXi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 05:23:38 -0400
Received: by mail-qc0-f169.google.com with SMTP id t2so2038646qcq.14
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 02:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=j9mNdwnWPM32QC5S2b5sExssffikCU54nF5Vnp2cFtI=;
        b=HXhMXxZ/Iikq1m/l9TZ6BxQ6ZchjqX0AlYHAcdciGb8NRyzagn9uYBp6IooVc6kREY
         PMh2RTDLF4otbaT6qIElqmuZ2NSn9ZCDcpyN5g+vQCugJyxSxsjgqycGxzQPIQD4g98B
         xYWgXzraggn8+i041Ps6S0/IpKW/HzTTsX+9PPUetH8AB16JzDODbSSrZm6eGDlkrO0a
         M/TueZ7nTDmp+Z6X73dtZvifJ58QKMEP5n6qz84UxlJME7sbD0BR+Yuiap+723e7w/9S
         TAm6aQcw4RWYVkMkIcZXPGdmJoue91y1CihFDLDp/vHlcKQ2BTXPZRHlBxddjsr63eVj
         WbdQ==
X-Received: by 10.49.62.3 with SMTP id u3mr17519787qer.25.1366622617675; Mon,
 22 Apr 2013 02:23:37 -0700 (PDT)
Received: by 10.49.118.42 with HTTP; Mon, 22 Apr 2013 02:23:37 -0700 (PDT)
In-Reply-To: <CALWbr2wocjqs1mpa+yuQ_Zw8m+SX24q6Pby3E3v3-jd-0w1pvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222000>

Any comment on that ? I think anyone using a "Topic Workflow" could
use that feature and that it would be a nice addition to the project.
Maybe I'm totally wrong in the proposal below (please tell me !), but
there are some unanswered question that prevents me from starting (and
I'd really like this to be discussed before actually starting).

On Wed, Apr 10, 2013 at 10:35 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
>
> The goal is to propose a structure for storing and pre-merging pairs of commits.
>
> Data-structure
> ==============
>
> We could use a note ref to store the pre-merge information. Each commit
> would be annotated with a blob containing the list of pre-merges (one
> sha1 per line with sha1 pointing to a merge commit). The commit on the
> other side of a merge would also be annotated.
>
> The choice of the refname could be done like we do with notes:
> - Have a default value
> - Have a default value configured in config
> - Use a specific value when merging/creating the pre-merges
>
> Here are my concerns:
>
> Pros
> ----
> 1. Notes allow dynamic annotation a commit
> 2. If we manage to fix 4, we can easily download all pre-merges from a
> remote host by fetching the ref (or clean by deleting the ref).
> 3. Conflicts on pre-merge notes could probably be resolved by concatenation.
>
> Cons
> ----
> 4. Checking connectivity means opening the blob and parsing it
> 5. Regular notes and pre-merge notes have to be handled separately
> because of 4.
>
> I'm hoping we can keep the pros and avoid the cons, but I'm kind of
> stuck here. Help would be really appreciated (or maybe this is a totally
> wrong direction, and I would also like to know ;)
>
> Merging (Using what we saved)
> =============================
> The goal is to merge branches J and B using existing pre-merges.
>
> E0. Create an empty stack S
> E1. Create set of commits 'J..B' and 'B..J' (that is probably already done)
> E2. For each commit C in smallest(J..B, B..J), execute E3
> E3. For each premerge P in notes-premerge(C), execute E4
> E4. If one of both parents of P belongs to biggest(J..B, B..J), stack P in S
> E5. Merge J and B using all pre-merges from S
>
> Let's consider that |J..B| is smaller than |B..J|.
> E0 is executed only once
> E1 is O(|J..B| + |B..J|)
> E2 is O(|J..B|)
> E3 is O(|J..B| x the average number of pre-merge per commits P_avg)
> E4 is executed for each parent (let's say it's two/constant, after all
> the topic is "pair" of commits), so still O(|J..B| x P_avg)
> E5 I don't know (how it can be done, and what would be the resulting
> time complexity)
>
> So the time cost for steps E0 to E4 is O(|J..B| + |B..J| x P_avg)
>
> Tools (Save the pre-merges)
> ===========================
>
> Of course we need several tools to maintain the list of premerges, and
> to easily compute them. For example, it would be nice to be able to do
> something like:
>
>     $ git pre-merge topicA topicB topicC
>
> to find, resolve and store all interactions between the topics. We could
> then easily derive to something that would allow to pre-merge a new
> topic with all topics already merged in master..pu (for example).
>
> Anyway, this task is left for latter.
