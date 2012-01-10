From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [BUG] gitattribute macro expansion oddity
Date: Tue, 10 Jan 2012 10:01:34 +0100
Message-ID: <4F0BFE6E.6080904@alum.mit.edu>
References: <20120110070300.GA17086@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?SGVucmlrIEdydWJic3Ryw7Zt?= <grubba@grubba.org>,
	git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 10 10:02:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkXax-0002sW-K0
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 10:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463Ab2AJJCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 04:02:08 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:43280 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab2AJJCF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 04:02:05 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0A91YnJ026271
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 10 Jan 2012 10:01:34 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <20120110070300.GA17086@sigill.intra.peff.net>
X-Enigmail-Version: 1.1.2
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188229>

On 01/10/2012 08:03 AM, Jeff King wrote:
> I'm seeing some very odd behavior with git's attribute expansion for
> diffs. You can see it with this repository:
> 
>   git clone git://github.com/libgit2/libgit2sharp.git
> 
> Try a diff of a non-binary file: [...]

The problem has nothing with diffing; simply interrogating the attribute
values gives different results depending on the order of the files:

$ git check-attr --all Lib/NativeBinaries/x86/git2.dll
LibGit2Sharp/Configuration.cs
Lib/NativeBinaries/x86/git2.dll: binary: set
Lib/NativeBinaries/x86/git2.dll: diff: unset
Lib/NativeBinaries/x86/git2.dll: text: unset
LibGit2Sharp/Configuration.cs: binary: set
LibGit2Sharp/Configuration.cs: diff: unset
LibGit2Sharp/Configuration.cs: text: unset
LibGit2Sharp/Configuration.cs: crlf: set
$ git check-attr --all LibGit2Sharp/Configuration.cs
Lib/NativeBinaries/x86/git2.dll
LibGit2Sharp/Configuration.cs: diff: csharp
LibGit2Sharp/Configuration.cs: crlf: set
Lib/NativeBinaries/x86/git2.dll: binary: set
Lib/NativeBinaries/x86/git2.dll: diff: unset
Lib/NativeBinaries/x86/git2.dll: text: unset

It also doesn't depend on the fact that Lib/.gitattributes uses CRLF as
its EOL, nor does it depend on the use of the "binary" macro.  However,
it does depend on the fact that the directory name "Lib" matches the
first part of the directory name "LibGit2Sharp".  Here is a simplified
demonstration of the problem:

a=LibA/a.txt
b=Lib/b.bin
rm -rf foo
git init foo
cd foo
mkdir $(dirname $a) $(dirname $b)
touch $a $b
echo '*.txt foo' >.gitattributes
echo '* bar' >$(dirname $b)/.gitattributes
git add .
git commit -am 'Demonstrate problem'
echo '================================================='
git check-attr --all $b $a
echo '================================================='
git check-attr --all $a $b
echo '================================================='

The attributes of $a are different depending on what order $a and $b
appear in the "git check-attr" command line.

Changing the example to "a=foo/a.txt" makes the problem go away.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
