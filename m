From: Keith Derrick <keith.derrick@lge.com>
Subject: BUG or FEATURE? Use of '/' in branch names
Date: Fri, 2 May 2014 18:04:29 -0400
Message-ID: <AAC0CF0A2CCEC34CBE983015FD81C4F7392A504B61@AICEXMBXCL02.LGE.NET>
References: <5363D1B4.1000503@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "simon.busch@lge.com" <simon.busch@lge.com>
To: Keith Derrick <keith.derrick@lge.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 03 00:04:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgLZQ-0004gj-Qs
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 00:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbaEBWEh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2014 18:04:37 -0400
Received: from lgeamrelo01.lge.com ([156.147.1.125]:55164 "EHLO
	lgeamrelo01.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbaEBWEg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 18:04:36 -0400
Received: from unknown (HELO aicexhub01.lge.net) (204.79.148.70)
	by 156.147.1.125 with ESMTP; 3 May 2014 07:04:33 +0900
X-Original-SENDERIP: 204.79.148.70
X-Original-MAILFROM: keith.derrick@lge.com
Received: from AICEXMBXCL02.LGE.NET ([136.166.10.230]) by AICEXHUB02
 ([204.79.148.68]) with mapi; Fri, 2 May 2014 18:04:32 -0400
Thread-Topic: BUG or FEATURE? Use of '/' in branch names
Thread-Index: Ac9mKavAalHt+3FESZ6hu7NjEABBowAKHb+g
In-Reply-To: <5363D1B4.1000503@lge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-hashedpuzzle: Ad/J CERk CLjm C3ZC C8BE D4NW Ee/p Ftge F5a8 F7iV GWow
 GYas HXTl JN1B Jw7d
 KMpL;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{58395E1C-2E0B-4040-B156-0FDBCDF3ADD1};awBlAGkAdABoAC4AZABlAHIAcgBpAGMAawBAAGwAZwBlAC4AYwBvAG0A;Fri,
 02 May 2014 22:04:29
 GMT;QgBVAEcAIABvAHIAIABGAEUAQQBUAFUAUgBFAD8AIABVAHMAZQAgAG8AZgAgACcALwAnACAAaQBuACAAYgByAGEAbgBjAGgAIABuAGEAbQBlAHMA
x-cr-puzzleid: {58395E1C-2E0B-4040-B156-0FDBCDF3ADD1}
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247990>

According to https://www.kernel.org/pub/software/scm/git/docs/git-check=
-ref-format.html a '/' is character to use in a branch name.


git imposes the following rules on how references are named:
1. They can include slash=A0/=A0for hierarchical (directory) grouping, =
but no slash-separated component can begin with a dot=A0.=A0or end with=
 the sequence=A0.lock.


git-flow, for example,=A0 uses it extensively to prefix branches with '=
release/', 'bugfix/', 'hotfix/' etc.

However, I just ran into the following problem


    $git init
    Initialized empty Git repository in /home/keith/play/bug2/.git/
    $touch a
    $git add a
    $git commit -m "C1"
    [master (root-commit) d569d5b] C1
    =A01 file changed, 0 insertions(+), 0 deletions(-)
    =A0create mode 100644 a
    $git checkout -b hotfix
    Switched to a new branch 'hotfix'
    $git checkout -b hotfix/b2
    error: unable to resolve reference refs/heads/hotfix/b2: Not a dire=
ctory
    fatal: Failed to lock ref for update: Not a directory
    $

The problem arises when a branch already exists with a name matching th=
e stem of the new branch name.

As far as I can see, this comes from the use of the branch name to crea=
te a directory under .git/refs/heads with the name 'hotfix/b2' because =
=2Egit/refs/heads/hotfix already exists as a plain file.

Note, however that this works

    $git init
    Initialized empty Git repository in /home/keith/play/bug3/.git/
    $touch a
    $git add a && git commit -m 'C1'
    [master (root-commit) 304052c] C1
    =A01 file changed, 0 insertions(+), 0 deletions(-)
    =A0create mode 100644 a
    $git checkout -b hotfix/b1
    Switched to a new branch 'hotfix/b1'
    $git checkout -b hotfix/b2
    Switched to a new branch 'hotfix/b2'
    $ls .git/refs/heads/ -R
    .git/refs/heads/:
    hotfix=A0 master

    .git/refs/heads/hotfix:
    b1=A0 b2
    $

But, for the reverse reason, I can't now create the branch named 'hotfi=
x'

I can see the value in grouping branches in a directory tree under refs=
/heads, but wouldn't it make more sense to simply escape the '/' in the=
 branch name so that 'hotfix/b1' is stored on disk as 'hotfix\/b1'?

I found this when trying to document a branching workflow for support b=
ranches. The repositories already had branches such as 'release1', 'rel=
ease2' and I wanted to add branches such as 'release1/develop', 'releas=
e2/develop', 'release1/staging', 'release2/staging' etc.

Renaming the existing published branches is not an option for us, I'm a=
fraid.
