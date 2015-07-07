From: Edward Anderson <nilbus@nilbus.com>
Subject: No one understands diff3 "Temporary merge branch" conflict markers
Date: Tue, 7 Jul 2015 10:55:05 -0400
Message-ID: <CAOMsSXQVJsd0h1fnNMEJ5+cKpxbeF9mHraXva-wr6Y2zBCADbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:57:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCUJP-0000Og-At
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbbGGO50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:57:26 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:32861 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757586AbbGGOz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:55:26 -0400
Received: by qgef3 with SMTP id f3so35406172qge.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=uFL3MphHafG/SN0s3pdHZlFs0zGUB3QA9h8r5jYwMQI=;
        b=OxvNTRgBbA1ERXTPef/6TXbJsxP+D9Cn/1j1nDJmYLGtbZ2WXmFDJJQbgXgMu8Upzw
         4YaPoJiz84Y3ahejpWTJRL1Id7Ld69njj1AGo250ZN6KF8u13x+JP+/OiTaKvPVYN7NN
         NY9eyDPDU0S4Gdy6Wg1mMwA3iGQANASDwBlm3Pc23iMSDleLMuGfponJ9SXle4zpjCAc
         HpFKrYzyncmFTKIDwQoVqDiN30plH8c6OsaihrngmmPU1pOIt7DU0YSTaVZpJ+sH3uBa
         BrgaXUaeJdWCBLruX5EFPzlxyhwuTvcXSxpUrkoQP35Wxwv3sk7FSXj5I03XMhr3sQnX
         LVTQ==
X-Received: by 10.55.20.90 with SMTP id e87mr7329167qkh.68.1436280925153; Tue,
 07 Jul 2015 07:55:25 -0700 (PDT)
Received: by 10.140.104.44 with HTTP; Tue, 7 Jul 2015 07:55:05 -0700 (PDT)
X-Google-Sender-Auth: UwtHp8TtyRsocI06Wq4FebZ-P-o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273567>

I have the diff3 conflictstyle enabled and want to be able to
understand how to understand its output when there are criss-cross
merges requiring temporary merge branches.  Eg:

    <<<<<<< HEAD
      print(A);
    ||||||| merged common ancestors
    <<<<<<< Temporary merge branch 1
      print(B);
    =======
      print(C);
    >>>>>>> feature

I have combed Google but have been able to find no good explanation.
People are hitting these and asking for help, but the suggestions
are weak and fail to explain anything.


Background
----------

Our workflow often causes criss-cross merges. In this more extreme
(but real) case, I have 16 ambiguously "best" merge bases:

    $ git merge-base --all HEAD feature | wc -l
    16

The 'resolve' strategy isn't an option for this many merge-bases:

    $ git merge -s resolve feature
    fatal: I cannot read more than 8 trees
    Merge with strategy resolve failed.

That brings me back to the recursive strategy.

https://lwn.net/Articles/210045/ "Branching and merging with git"
describes what a criss-cross merge is and how the recursive strategy
deals with them by merging the multiple merge-bases to form a single
temporary merge base.

> The classic confusing case is called a "criss-cross merge", and
> looks like this:
>
>          o--b-o-o--B
>         /    \ /
>  o--o--o      X
>         \    / \
>          o--a-o-o--A
>
> There are two common ancestors of A and B, marked a and b in the
> graph above.  And they're not the same.  You could use either one
> and get reasonable results, but how to choose?
>
> The details are too advanced for this discussion, but the default
> "recursive" merge strategy that git uses solves the answer by
> merging a and b into a temporary commit and using *that* as the
> merge base.
>
> Of course, a and b could have the same problem, so merging them
> could require another merge of still-older commits.  This is why the
> algorithm is called "recursive."

With the diff3 conflictstyle showing the merged common ancestors and
the recursive merge strategy, the merged common ancestors may have a
conflict

Conflict #1
-----------

     1 <<<<<<< HEAD
     2     unless admin
     3       fail Unauthorized.new("Admin only")
     4     end
     5 ||||||| merged common ancestors
     6 <<<<<<< Temporary merge branch 1
     7     unless admin
     8       fail Unauthorized.new("Admin only")
     9     end
    10 ||||||| merged common ancestors
    11     unless admin
    12       fail Unauthorized.new
    13     end
    14 =======
    15     fail Unauthorized.new unless admin
    16 >>>>>>> Temporary merge branch 2
    17 =======
    18     unless admin
    19         fail Unauthorized.new("Admin only")
    20       fail Unauthorized.new
    21     end
    22 >>>>>>> feature

It seems lines 6-16 are a conflict that occurred when merging the
merge-bases.  That conflict could be resolved by merging the change in
Temporary merge branch 1 (add "Admin only") with Temporary merge
branch 2 (convert multi-line unless to single-line) as this:

           fail Unauthorized.new("Admin only") unless admin

Thus, you might thing that you could refactor the above conflict to be
this:

     1 <<<<<<< HEAD
     2     unless admin
     3       fail Unauthorized.new("Admin only")
     4     end
     5 ||||||| merged common ancestors
     6     fail Unauthorized.new("Admin only") unless admin
     7 =======
     8     unless admin
     9         fail Unauthorized.new("Admin only")
    10       fail Unauthorized.new
    11     end
    12 >>>>>>> feature

However this would be resolved by merging HEAD's apparent change
(break single-line unless onto multiple lines) and feature's change,
which appears to be a botched up conflict resolution.

Obviously I'm reading this wrong. What is the correct way?

Conflict #2
------------

     1 <<<<<<< HEAD
     2     unless feature.enabled_for_user?(UserIdLookup.new(params).user_id)
     3       fail Unauthorized.new("Requires setting #{label}.")
     4 ||||||| merged common ancestors
     5 <<<<<<< Temporary merge branch 1
     6     unless feature.enabled_for_user?(params[:user_id])
     7       fail Unauthorized.new("Requires setting #{label}.")
     8 =======
     9     unless feature.enabled_for_user?(params[:user_id])
    10       fail Unauthorized.new("Requires setting #{label}.")
    11 >>>>>>> feature

This is the full conflict, and it doesn't seem to balance. In this
case, there's only one Temporary merge branch. Can the line marker on
line 5 just be ignored?  If so, then this is easy to resolve, but I am
left puzzled as to why the sections in lines 6-7 and 9-10 are
identical.  Is the Temporary merge branch 1 marker here simply because
other conflicts had multiple Temporary merge branches that had to be
labeled?  Or is the 0 lines between lines 4 and 5 a significant
deletion?

---

The git community needs some light and understanding shed on this
topic, on how these conflicts are to be read and understood. I'm
looking for something that can be applied methodically. If better
understanding the recursive merge strategy is necessary, that is fine.
However suggestions like "just resolve it to how you think it should
be" or "talk to the authors" will not be appreciated, as they do not
lend understanding regarding these conflict markers nor where the code
they delineate comes from.

Does anyone out there understand this stuff?

Thanks,
Edward
