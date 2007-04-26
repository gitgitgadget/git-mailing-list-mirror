From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Change git-rev-parse --show-cdup to output an absolute
 path
Date: Thu, 26 Apr 2007 02:00:25 -0700
Message-ID: <46306A29.4010608@midwinter.com>
References: <20070425232829.GA15930@midwinter.com> <81b0412b0704260120mda8a2abhe343f5c127945939@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 11:00:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgzqB-0005dn-ON
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 11:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773AbXDZJA2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 05:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754777AbXDZJA2
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 05:00:28 -0400
Received: from tater.midwinter.com ([216.32.86.90]:54298 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754773AbXDZJA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 05:00:26 -0400
Received: (qmail 22911 invoked from network); 26 Apr 2007 09:00:25 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=pdrdvP8yAJTnb73ID0Kt3wbMUxG6lRFPOAjVzUchDHi8TjdOah30zBSwy+bbo2Bd  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 26 Apr 2007 09:00:25 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <81b0412b0704260120mda8a2abhe343f5c127945939@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45623>

Alex Riesen wrote:
> Your implementation will fail if cwd is longer than PATH_MAX.
> Does not happen often, though.

That limitation is already littered through the code, e.g. in setup.c 
which would already be failing in the existing implementation. Actually 
setup.c goes one better: is_inside_git_dir() hardwires a 1024-character 
limit into the code rather than using PATH_MAX. I didn't think I was 
introducing a new limit here.

>> A typical failure case:
>>
>> $ git clone git://whatever.git foobar
>> $ ln -s foobar/src/tools/misc/myapp myapp
>> $ cd myapp
>
> Which is a strange thing to do. What is that for?
> myapp is kind of outside the git repo foobar.

For convenience, mostly; obviously that example was a bit contrived but 
I do have several symlinks to subdirectories of my repository and it's 
faster to type "cd ~/xyz" than "cd ~/repo/src/server/xyz" all the time. 
And as you say, you're only "kind of" outside the repo when going 
through the symlink; one could argue that cd-ing into a symlink should 
be the semantic equivalent of cd-ing into the thing the link points to, 
and that's certainly the way I use it.

But actually my big objection isn't that it fails, per se, but rather 
that it fails inconsistently. All the C commands work just fine since 
they do getcwd() which returns the real path. It's only the shell 
scripts that fail, e.g. git-pull. With the existing implementation I 
have to remember which commands are shell scripts and which are C 
programs, so I can do "cd `/bin/pwd`" to reset my $PWD before running 
any of the former.

That was actually my initial approach to fixing this -- I put "cd 
`/bin/pwd`" at the top of the "cd_to_toplevel" function in 
git-sh-setup.sh. But it felt cleaner to make git-rev-parse return the 
actual correct path so it'd work for shell scripts that didn't happen to 
use git-sh-setup.sh. I'm happy to go either way, or of course to keep 
this as a local modification if folks find it too distasteful to include 
in the official source.

-Steve
