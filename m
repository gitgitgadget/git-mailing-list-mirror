From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/3] C implementation of the 'git' program, take two.
Date: Wed, 16 Nov 2005 01:42:15 +0100
Message-ID: <437A8067.9050308@op5.se>
References: <20051115233125.3153B5BF76@nox.op5.se> <Pine.LNX.4.64.0511151603510.11232@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 16 01:43:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcBNv-0007cF-EH
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 01:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbVKPAmS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 19:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbVKPAmS
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 19:42:18 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:2178 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S965122AbVKPAmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 19:42:16 -0500
Received: from vrrx50sn1.teliamobile.net (192.71.148.196) by pne-smtpout2-sn1.fre.skanova.net (7.2.060.1)
        id 4378F3940006CC55 for git@vger.kernel.org; Wed, 16 Nov 2005 01:42:16 +0100
Received: from [212.181.228.90] (host-n13-90.homerun.telia.com [212.181.228.90])
	by vrrx50sn1.teliamobile.net (8.11.6/8.11.6) with ESMTP id jAG0gFf24596
	for <git@vger.kernel.org>; Wed, 16 Nov 2005 01:42:15 +0100
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0511151603510.11232@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11980>

Linus Torvalds wrote:
> 
> On Wed, 16 Nov 2005, Andreas Ericsson wrote:
> 
>>+
>>+	/* allow relative paths, but run with exact */
>>+	if (chdir(exec_path)) {
>>+		printf("git: '%s': %s\n", exec_path, strerror(errno));
>>+		exit (1);
>>+	}
>>+
>>+	getcwd(git_command, sizeof(git_command));
>>+	chdir(wd);
> 
> 
> Argh. This is pretty horrible way to turn a path into an absolute one. 


It was your idea to begin with, actually, in the thread on how to do 
proper path validation in the git-daemon. :)

> 
> Why don't you just do
> 
> 	if (exec_path[0] != '/') {
> 		.. prepend "cwd/" to exec_path ..
> 

You mean
	setenv("PATH", concat3(cwd, exec_path, old_path), 1);

?

Because that can fail too. Every solution is bad if you twist and turn 
it enough.

> 
> The reason to avoid "chdir(relative) + chdir(back)" is that it totally 
> unnecessarily breaks under some extreme cases. For example, if the 
> exec_path is already absolute, and we just happen to be in a really deep 
> subdirectory, then the getcwd() could have failed due to the PATH_MAX 
> limitations.
> 

True. So, would something like
char *try_goddamn_hard_to_get_working_dir(char *rel_path)
{
	size_t plen = PATH_MAX;
	char *p = malloc(PATH_MAX);
	while(p && plen < 1 << 20 && !(p = getcwd(p, plen))) {
		plen += PATH_MAX;
		p = realloc(p, plen);
	}

	return p;
}

be considered safe from this particular point of view?


> Also, depending on getcwd() will not work if any parent directory is 
> unreadable or non-executable (well, under Linux it will, as long as it's 
> executable, since getcwd() is actually a system call. Not in UNIX in 
> general, though). Again, that means that unless you _have_ to know what 
> the cwd is, you should try to avoid relying on it.
> 

True. I'll redo that part (tomorrow).

> 
> and the nicer thign to do is to just not try to be clever.
> 

I never try. It just comes to me naturally. ;)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
