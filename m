From: Antoine Pelisse <apelisse@gmail.com>
Subject: [RFD] Combine diff improvements
Date: Thu, 14 Mar 2013 23:32:35 +0100
Message-ID: <CALWbr2zY3uo==QTd69t1eXNS4-CX1w3T-AaMjOLVmxj-SMJyvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 14 23:33:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGGhq-0007NS-Is
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 23:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab3CNWcg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Mar 2013 18:32:36 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:63610 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab3CNWcg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Mar 2013 18:32:36 -0400
Received: by mail-qc0-f174.google.com with SMTP id z24so1287295qcq.33
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 15:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=C7N7EkYa8KmsKufud6hjhKABTQEsJOK1oDKWDeXB47Y=;
        b=Avg0nrzJgSgdECN492JgKHR3cguhaXWIkKGdk/dcX1JO6ySlzTp9Loj7dcehDSqo3S
         5bWECuLIDhwlQBAsLehOToz2NmjJVf6DSoNpw3dWOLi+TLkVnC4T5KVVjZfwlRqHMXJF
         b4Rai5AyFDO2rviw5M2SuVVme9mbzWDk7kIdh7bOPV94XpE21QbdgEMJs5TXJh6hFVNd
         M3GKaweEAO1faoWWwE2KdD3HoegsC7bfqw4+WGlXbSK8YBAETRTSGtJtZ9KhHYfMrDYP
         yvViPqkhcsk0F3qmr0QBvjXG+MU/WGQ2o4K/NSi/chCKjRRuKI5J8yrNmZdOYiFVWzVr
         Or2A==
X-Received: by 10.229.174.196 with SMTP id u4mr777366qcz.84.1363300355421;
 Thu, 14 Mar 2013 15:32:35 -0700 (PDT)
Received: by 10.49.70.163 with HTTP; Thu, 14 Mar 2013 15:32:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218177>

Hi,
I've been working on combine diff recently and have seen that the curre=
nt
implementation does not produce optimal results for coalescing lost lin=
es.

I would like to discuss some improvements.

I think we can define an optimal solution as the shortest diff
output. That is that we coalesced as much line as we could.
It means that if each parent has the same file removed, the output will
be n lines long (all lines coalesce to each others).

The current implementation doesn't look for optimal solution but for th=
e
easiest/greedy solution. It also stops matching with a parent if it
can't find a match. As an example, it means that losing [1, 2, 3, 4] fr=
om
parent A, and [3, 1, 2, 4] from parent B would give:
- 1
- 2
--3
- 4
 -1
 -2
 -4

While if we invert the two parents order we will have:
- 3
--1
--2
- 4
 -3
 -4

While clearly, in both cases, the optimal solution would be close to:
- 3
--1
--2
 -3
--4

Let's say we have only one empty file (deleted), with p parents. In eac=
h
parent, the file was n lines long, but the lines don't have to be the
same.

It clearly looks like an extension/variation of the Longest Common
Subsequence (LCS) problem, but with p sequences (and the common
subsequences doesn't have to be common to all sequences).

LCS dynamic programming is O(n=C2=B2) in time and space complexity for =
two
sequences.

We could extend it this way:
After processing two of the p parents, let's find LCS and build a new
optimal list of removals. Then find LCS again between this new list and
the third parent removals. And repeat until we made each parents.

Best-case analysis:
All p parents have the same n lines.
We will find LCS and provide a n lines (the same lines) new list in
O(n=C2=B2), and then run it again in O(n=C2=B2) with the next parent, e=
tc.
It will end-up being O(pn=C2=B2).

Worst-case analysis:
All p parents have no lines in common.
We will find LCS and provide a 2n new list in O(n=C2=B2).
Then we run it again in O(2n x n), and again O(3n x n), etc, until
O(pn x n).
When we sum these all, we end-up with O(p=C2=B2 x n=C2=B2)

Does it make any sense ? And is it worth implementing ?

Cheers,
Antoine
