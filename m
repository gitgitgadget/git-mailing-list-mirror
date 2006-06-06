From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [RFC] revision limiter in git-rev-list
Date: Tue, 6 Jun 2006 10:36:31 +0200
Message-ID: <e5bfff550606060136l59143ef2mdb9dc68ab78e9ff1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jun 06 10:36:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnX3E-0007SA-Ie
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 10:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWFFIgd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 04:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWFFIgd
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 04:36:33 -0400
Received: from qb-out-0506.google.com ([72.14.204.231]:32933 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932122AbWFFIgd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 04:36:33 -0400
Received: by qb-out-0506.google.com with SMTP id e12so106956qba
        for <git@vger.kernel.org>; Tue, 06 Jun 2006 01:36:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TF88l9Y2TpYOILvk4qgBD5fxRjhE8vPXCgIDulyAL8ZUtbWGIKGKidgZh9R4QXQB7EkKubtd7M4i2zWOc6Ghkgu5VpvnXtTjoQG8aQVIGzIiVColtyT8xdfpDKgEoYm5wnz/R4IEFecIfdjZ20XdjNBgxAIohNZhhSQmTeeAa+M=
Received: by 10.64.195.9 with SMTP id s9mr4286707qbf;
        Tue, 06 Jun 2006 01:36:32 -0700 (PDT)
Received: by 10.65.210.20 with HTTP; Tue, 6 Jun 2006 01:36:31 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21370>

We currently can run something like

git-rev-list --topo-order --parents HEAD -- foo1.c  foo2.c foo3.c

And have in output a list of revisions that modify paths foo1.c,
foo2.c and foo.3

For each revision we have also the corresponding pseudo-parents,
i.e. the proper parents chosen among the revisions in output list.

The idea is to extend this behaviour to also commit objects sha.

As example, given the following revisions history:

a
b-
| c
| d
e
f

We could add a new option --filtered so that

git-rev-list --topo-order --filtered HEAD -- a d e

Gives the following

a
b-
| d
e

Note that the merge point b has been added implicitly as in path limiter case.


This is a powerful and quite general option that can be use for a large
and interesting number of cases.

1) Get the branch a given <sha> belongs

git-rev-list --topo-order --parents --filtered
    HEAD -- <sha> branchList[0] branchList[1]... branchList[k-1]


where branchList[] is the vector of branches of lenght k

Searched branch is the one where sha appears as one of his parents.



2) Get nearest previous tag of a given <sha>


git-rev-list --topo-order --parents -n1 --filtered
    <sha> -- <sha> tagList[0] tagList[1]... tagList[n-1]


where tagList[] is the vector of tags of lenght n

In output we have only one revision (see option -n1) that is <sha>,
his parent(s) are the nearest tag(s).


3) Get tag/branch history with a sensible graph (using a GUI frontend)

git-rev-list --topo-order --parents --filtered HEAD -- tagList[0] ...
branchList[n-1]

git-rev-list --topo-order --parents --filtered HEAD -- branchList[0]
... branchList[n-1]


4) Filter/find revisions according to a given search criteria (using a
GUI frontend)

git-rev-list --topo-order --parents --filtered HEAD -- matchList[0]
... matchList[n-1]

where matchList[] is the vector of sha's matching a filter criteria and could
be provided by a GUI frontend that already normally have filter capabilities.

The plus here is to let frontend to draw a sensible graph of the
resulting revisions.

Probably there are other uses of this option that is very powerful
because essentially
it adds topological information to a given set of revisions.

Of course I really ignore any implementation difficult/feasibility issues ;-)


Marco
