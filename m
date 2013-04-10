From: Antoine Pelisse <apelisse@gmail.com>
Subject: Premerging topics (was: [RFD] annnotating a pair of commit objects?)
Date: Wed, 10 Apr 2013 22:35:20 +0200
Message-ID: <CALWbr2wocjqs1mpa+yuQ_Zw8m+SX24q6Pby3E3v3-jd-0w1pvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 22:35:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ1jq-0005FF-IB
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 22:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab3DJUfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 16:35:22 -0400
Received: from mail-qe0-f43.google.com ([209.85.128.43]:40499 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755531Ab3DJUfV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 16:35:21 -0400
Received: by mail-qe0-f43.google.com with SMTP id f6so518010qej.30
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 13:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type;
        bh=rxssL8sa7IYRJGmiusbmbuE3bzquu1iHnbb8kENNq4o=;
        b=haaFTvDTK/QGVQEIc9X7DdeFVEiLS6UHBEiJqgUFO8vlC/G8w6jMOCQ9A2FR3SU+i2
         PPLcZPUn/JYXFtqGG6XYqLFC87FYnPKoyIQBf2MJAtEeasb1AxS1fO3Jxk0zYJ2VbSQQ
         1zlPIK1PwIzegT9EEJpxxpNxkfmtbaZ4+TGypH4jVkwl0ZJsbcAfuirF7g6gYqNmUsgH
         gN3NqPQG4o64WTuRFA3+zBwG8mZXng3p2urVmc5NXcsNDpFGfMct7Kyiojn7lIOa4JWf
         C6uLC7LLQcvUTjfx+ZuTSCnkTMVSlB7AEtZWIRvz4kl62RHDZjTdYqrkqYhgvDKLHXM/
         xNPg==
X-Received: by 10.49.61.226 with SMTP id t2mr4641460qer.40.1365626120969; Wed,
 10 Apr 2013 13:35:20 -0700 (PDT)
Received: by 10.49.118.42 with HTTP; Wed, 10 Apr 2013 13:35:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220756>

The goal is to propose a structure for storing and pre-merging pairs of commits.

Data-structure
==============

We could use a note ref to store the pre-merge information. Each commit
would be annotated with a blob containing the list of pre-merges (one
sha1 per line with sha1 pointing to a merge commit). The commit on the
other side of a merge would also be annotated.

The choice of the refname could be done like we do with notes:
- Have a default value
- Have a default value configured in config
- Use a specific value when merging/creating the pre-merges

Here are my concerns:

Pros
----
1. Notes allow dynamic annotation a commit
2. If we manage to fix 4, we can easily download all pre-merges from a
remote host by fetching the ref (or clean by deleting the ref).
3. Conflicts on pre-merge notes could probably be resolved by concatenation.

Cons
----
4. Checking connectivity means opening the blob and parsing it
5. Regular notes and pre-merge notes have to be handled separately
because of 4.

I'm hoping we can keep the pros and avoid the cons, but I'm kind of
stuck here. Help would be really appreciated (or maybe this is a totally
wrong direction, and I would also like to know ;)

Merging (Using what we saved)
=============================
The goal is to merge branches J and B using existing pre-merges.

E0. Create an empty stack S
E1. Create set of commits 'J..B' and 'B..J' (that is probably already done)
E2. For each commit C in smallest(J..B, B..J), execute E3
E3. For each premerge P in notes-premerge(C), execute E4
E4. If one of both parents of P belongs to biggest(J..B, B..J), stack P in S
E5. Merge J and B using all pre-merges from S

Let's consider that |J..B| is smaller than |B..J|.
E0 is executed only once
E1 is O(|J..B| + |B..J|)
E2 is O(|J..B|)
E3 is O(|J..B| x the average number of pre-merge per commits P_avg)
E4 is executed for each parent (let's say it's two/constant, after all
the topic is "pair" of commits), so still O(|J..B| x P_avg)
E5 I don't know (how it can be done, and what would be the resulting
time complexity)

So the time cost for steps E0 to E4 is O(|J..B| + |B..J| x P_avg)

Tools (Save the pre-merges)
===========================

Of course we need several tools to maintain the list of premerges, and
to easily compute them. For example, it would be nice to be able to do
something like:

    $ git pre-merge topicA topicB topicC

to find, resolve and store all interactions between the topics. We could
then easily derive to something that would allow to pre-merge a new
topic with all topics already merged in master..pu (for example).

Anyway, this task is left for latter.
