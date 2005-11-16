From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/3] C implementation of the 'git' program, take two.
Date: Wed, 16 Nov 2005 01:10:36 +0100
Message-ID: <437A78FC.10608@op5.se>
References: <20051115233125.3153B5BF76@nox.op5.se> <7vwtj9eaqm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 16 01:11:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcAsr-0007EK-Dr
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 01:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbVKPAKi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 19:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbVKPAKi
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 19:10:38 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:13751 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S965095AbVKPAKh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 19:10:37 -0500
Received: from vrrx50sn1.teliamobile.net (192.71.148.196) by pne-smtpout1-sn2.hy.skanova.net (7.2.060.1)
        id 4378E95300072376 for git@vger.kernel.org; Wed, 16 Nov 2005 01:10:36 +0100
Received: from [212.181.228.90] (host-n13-90.homerun.telia.com [212.181.228.90])
	by vrrx50sn1.teliamobile.net (8.11.6/8.11.6) with ESMTP id jAG0Aaf24504
	for <git@vger.kernel.org>; Wed, 16 Nov 2005 01:10:36 +0100
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vwtj9eaqm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11975>

Junio C Hamano wrote:
> exon@op5.se (Andreas Ericsson) writes:
> 
> 
>>This patch provides a C implementation of the 'git' program and
>>introduces support for putting the git-* commands in a directory
>>of their own.
> 
> 
> Very nice, thanks.  Two questions and a half.
> 
> 
>>+static void prepend_to_path(const char *dir, int len)
>>+{
>>+	char *path, *old_path = getenv("PATH");
>>+	int path_len = len;
>>+
>>+	if (!old_path)
>>+		old_path = "/bin:/usr/bin:.";
> 
> 
> This is to cover strange case and probably would not matter in
> practice, but perhaps without current directory?
> 

I have no preference really and since it already covers a strange case 
it probably shouldn't matter either way.

> 
>>+int main(int argc, char **argv, char **envp)
>>+{
>>+	char git_command[PATH_MAX + 1];
>>+	char wd[PATH_MAX + 1];
>>+	int i, len, show_help = 0;
>>+	char *exec_path = getenv("GIT_EXEC_PATH");
>>+
>>+	getcwd(wd, PATH_MAX);
>>+...
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
> Can we always come back from where we started?
> 

Not sure what you mean. Perhaps "Come back *to* where we started"?

If getcwd(wd, sizeof(wd)) fails then chdir(wd) will also fail (or do 
something strange, at least). wd is otherwise absolute.

> 
>>+
>>+	len = strlen(git_command);
>>+	prepend_to_path(git_command, len);
>>+
>>+	strncat(&git_command[len], "/git-", sizeof(git_command) - len);
>>+	len += 5;
>>+	strncat(&git_command[len], argv[i], sizeof(git_command) - len);
>>+
>>+	if (access(git_command, X_OK))
>>+		usage(exec_path, "'%s' is not a git-command", argv[i]);
>>+
>>+	/* execve() can only ever return if it fails */
>>+	execve(git_command, &argv[i], envp);
> 
> 
> Shell version for Cygwin seems to do ".exe" at the end --- does
> it matter?
> 

Dunno, really. I suppose it does as it bypasses the shell with the 
execve() call, unless windows or the cygwin stuff does some trickery to 
find an .exe regardless.

Is it ok if I send a separate patch for it, or would you rather have me 
redo this one?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
