From: Alain Kalker <a.c.kalker@gmail.com>
Subject: Re: [BUG] Git clone of a bundle fails, but works (somewhat) when
 run with strace
Date: Sat, 16 Feb 2013 00:03:58 +0000 (UTC)
Message-ID: <kfmide$4ro$3@ger.gmane.org>
References: <511E8D84.6060601@gmail.com> <kfmclb$4ro$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 01:04:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6VGe-0006Cj-Pm
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 01:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100Ab3BPAEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 19:04:13 -0500
Received: from plane.gmane.org ([80.91.229.3]:45108 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab3BPAEM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 19:04:12 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1U6VGZ-0006B6-03
	for git@vger.kernel.org; Sat, 16 Feb 2013 01:04:31 +0100
Received: from 524a7994.cm-4-3b.dynamic.ziggo.nl ([82.74.121.148])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Feb 2013 01:04:30 +0100
Received: from a.c.kalker by 524a7994.cm-4-3b.dynamic.ziggo.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Feb 2013 01:04:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 524a7994.cm-4-3b.dynamic.ziggo.nl
User-Agent: Pan/0.139 (Sexual Chocolate; GIT bf56508
	git://git.gnome.org/pan2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216368>

On Fri, 15 Feb 2013 22:25:47 +0000, Alain Kalker wrote:

> On Fri, 15 Feb 2013 20:33:24 +0100, Alain Kalker wrote:
> 
>> tl;dr:
>> 
>> - `git bundle create` without <git-rev-list-args> gives git rev-list
>> help, then dies.
>>    Should point out missing <git-rev-list-args> instead.
>> - `git clone <bundle> <dir> gives "ERROR: Repository not found."
>> - `strace ... git clone <bundle> <dir>` (magically) appears to work but
>>    cannot checkout files b/c of nonexistent ref.
>> - Heisenbug? Race condition?
>> - Zaphod Beeblebrox has left the building, sulking.
>> 
>> Full description:
>> 
>> When I try to clone from a bundle created from a local repository, `git
>> clone <bundle> <dir>` fails with: "ERROR: Repository not found. fatal:
>> Could not read from remote repository." unless I run it with strace.

After trying to bisect this using `bisect start; bisect good v1.5.1; git 
bisect bad HEAD; git bisect run ..test.sh`:

---test.sh---
#!/bin/sh

make clean
make || return 125
GIT=$(pwd)/git

cd /tmp
rm -rf testrepo
mkdir testrepo
cd testrepo
$GIT init
echo test > test.txt
$GIT add test.txt
$GIT commit -m "Add test.txt"
$GIT bundle create ../testrepo.bundle master || return 125
cd ..

rm -rf testrepofrombundle
$GIT clone testrepo.bundle testrepofrombundle || return 1
---
I was unable to find a bad revision.
After a lot more searching I found that I had `git` aliased to `hub`, a 
tool used to make Github actions easier.
Eliminating `hub` from the equation resolved most problems.
The only ones remaining are the confusing error message from `git bundle 
create` and the "missing HEAD" (you can interpret that in different 
ways) ;-)

P.S. I hereby promise to _never_ _ever_ alias `git` to something else and 
then post a Git bug about that "something else" on this ML.

Sorry to have wasted your time,

Alain
