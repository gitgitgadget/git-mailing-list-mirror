From: Robert Irelan <rirelan@epic.com>
Subject: RE: "git commit" fails due to spurious file in index
Date: Tue, 5 Mar 2013 15:30:04 +0000
Message-ID: <2D9BD788B02ABA478C57929170AF952B7637B5@EXCH-MBX-3.epic.com>
References: <2D9BD788B02ABA478C57929170AF952B7622B5@EXCH-MBX-3.epic.com>
 <87y5e2op9p.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 05 16:30:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCtpE-00079G-IK
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 16:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755764Ab3CEPaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 10:30:16 -0500
Received: from goon4.epic.com ([199.204.56.118]:49941 "EHLO goon4.epic.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755179Ab3CEPaP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Mar 2013 10:30:15 -0500
Received: from EXCH-HUB-1.epic.com (exch-hub-1.epic.com [10.8.7.181])
	by goon4.epic.com (8.13.8/8.13.8) with ESMTP id r25FU5Kg022671;
	Tue, 5 Mar 2013 09:30:10 -0600
Received: from EXCH-MBX-3.epic.com ([fe80::89d9:a0e3:3740:4f53]) by
 EXCH-HUB-1.epic.com ([fe80::90c1:a07:c011:1fde%10]) with mapi id
 14.02.0342.003; Tue, 5 Mar 2013 09:30:06 -0600
Thread-Topic: "git commit" fails due to spurious file in index
Thread-Index: Ac4Y/ss6LRrQulaXQ/6loYEIwo4NdwAHGHR+ACaEyCA=
In-Reply-To: <87y5e2op9p.fsf@pctrast.inf.ethz.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.191.131]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217451>

Yes, you're correct, it was a bug in my pre-commit hook. Thanks!

For posterity, the issue is that I had the following line:

    git diff -z --cached --name-only | egrep -z '\.(pl|pm|t)$' | \
            while read -d'' -r f; do ...

In Bash, when `read` is passed the `-d` option with a zero-length
string argument, read will split on null characters (`'\0'`). However,
I did not put a space between the `-d` option and the argument, so
it took the `-` in the next argument `-r` as the delimiter. My commit
includes Perl files with `-` characters in the name, which I had not
previously committed to this repo, which is why I only ran into the
problem now. I fixed it by changing the read command to
`read -r -d '' f`, which now has the crucial space between -d and
its argument, making the zero-length string a separate argument.

Robert Irelan | Server Systems | Epic | (608) 271-9000


-----Original Message-----
From: Thomas Rast [mailto:trast@student.ethz.ch] 
Sent: Monday, March 04, 2013 2:59 PM
To: Robert Irelan
Cc: git@vger.kernel.org
Subject: Re: "git commit" fails due to spurious file in index

Robert Irelan <rirelan@epic.com> writes:

> Now, when I run 'git add admin_script/setup' to add the new directory 
> to the repo and then try to commit, I receive the following message:
>
>     $ git commit
>     mv: cannot stat `admin_scripts/setup/2012/setup': No such file or 
> directory
>
> The error message is correct in that `admin_scripts/setup/2012/setup` 
> does not exist, either as a file or as a directory. However, I'm not 
> attempting to add this path at all. Using grep, I've confirmed that 
> the only place this path appears in any of my files is in `.git/index`.

To me that sounds like the message comes from a commit hook.  Can you check if you have anything in .git/hooks/, especially pre-commit?

There really isn't any other good reason why 'git commit' would call 'mv' (plain mv, not git!).

--
Thomas Rast
trast@{inf,student}.ethz.ch
