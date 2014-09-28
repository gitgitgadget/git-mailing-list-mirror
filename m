From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] init - Honour the global core.filemode setting
Date: Sun, 28 Sep 2014 13:52:46 +0200
Message-ID: <5427F68E.5030003@web.de>
References: <CAE1pOi0zhnUNNdHsrq+4H_6LiFnr-qoY-owrcJquy6dyG+Mk4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 28 13:53:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYD2K-0003im-VT
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 13:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbaI1Lwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2014 07:52:55 -0400
Received: from mout.web.de ([212.227.17.12]:57998 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbaI1Lwy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2014 07:52:54 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0Ma2YF-1Xq1AS0Nf5-00LovH; Sun, 28 Sep 2014 13:52:51
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <CAE1pOi0zhnUNNdHsrq+4H_6LiFnr-qoY-owrcJquy6dyG+Mk4g@mail.gmail.com>
X-Provags-ID: V03:K0:JCvq6C7gE04jmPHbmGkrnFs8sv23dtLnc28ai1yocIJdMBWsoZG
 53LRGCpboSKIK+6BndAglGNolzSTt2uu5D1B3uiV0Iiy/lv/QpQICdvI77n6MPdkFPtqxhE
 YI835lH1ck+nQQps3Z2qflycnBVJ/9Yc34bzRG//ZxpGRZjd9J5fu2N/hlxx3TwiqcpPO8P
 CnIxdupqrfUSXFaA9/p4w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257596>

On 2014-09-28 02.37, Hilco Wijbenga wrote:
> If "~/.gitconfig" contains a "core.filemode" entry then "git init"
> should honour that setting.
> 
> Signed-off-by: Hilco Wijbenga <hilco.wijbenga@gmail.com>
> ---
> This bit me at work where I have to work with Windows. Git on Cygwin
> and the Eclipse Git plugin do not agree on file attributes so I had
> set "filemode = false" in ~/.gitconfig.
This feels strange.
Each and every repo has a core.filemode setting.
Or should have.

Did you manage to create a repo without core.filemode in repo/.git/config ?
And if yes, how?

> 
> A few weeks later, I did a "git init" and, some time later yet, I
> noticed the strange behaviour of Cygwin/Eclipse again.
I do not fully understand which "strange behaviour" you experied,
so I need to guess.

 This was very
> surprising because things had been working well until then. It took
> quite a bit of research before I realized that "git init" always sets
> "filemode". I think "filemode" should only be set if not set already
> in the global config (similar to log_all_ref_updates).

That is part of the whole story:
In general, "git init" probes the file system, if the executable bit
is working as expected.
So if you  create a Git repository under VFAT, the executable bit is not supported.

Git will notice that, and set core.filemode = false.

NTFS is a different story:
Cygwin has support for the executable bit under NTFS, but Msysit does not.
So if you "share" a Git repository between Msysgit and cygwin, it may be better
to set core.filemode to false.


There is however a problem with your patch, or 2:

When you set core.filemode = false in your ~/.gitconfig,
another developer may have core.filemode = true in his config.
If you manage to share the repo using a network, git will behave different
for the 2 users.
Solution:
Set core.filemode for this repo alwways in the repo. (as we do today in git.git)

When you run "git init" with ~/.gitconfig = true, you should
anyway probe the file system, as it may not support file mode, and core.filemode may be false.


So the solution that I can see is:
(Some pseudo-code:)

if (git config (global config ) == false) ||
   (git config (~/.config ) == false) then
  git_config_set("core.filemode", "false");
else
  probe the file system and set core.filemode as we do today
fi


> 
> The usual caveat applies: this is my first patch. Having said that,
> please feel free to be pedantic and strict. It's a small patch so I
> would imagine that fixing any problems should not take long (assuming
> it is acceptable at all, of course). I'd like to know I did it right.
> :-)
> 
> AFAICT, all tests passed. Should a separate test be added for this change?
I think yes.

Under which system did you test ?

Windows?
CYWGIN ?
MingWW/Msysgit ?
Linux ?


> - /* Check filemode trustability */
> - filemode = TEST_FILEMODE;
> - if (TEST_FILEMODE && !lstat(path, &st1)) {
> - struct stat st2;
> - filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
> - !lstat(path, &st2) &&
> - st1.st_mode != st2.st_mode);
> + /* Do not override the global filemode setting. */
> + if (trust_executable_bit == -1) {
> + /* Check filemode trustability */
> + filemode = TEST_FILEMODE;
> + if (TEST_FILEMODE && !lstat(path, &st1)) {
> + struct stat st2;
> + filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
> + !lstat(path, &st2) &&
> + st1.st_mode != st2.st_mode);
> + }
> + git_config_set("core.filemode", filemode ? "true" : "false");
The indentation seems to be broken ?
(We use one TAB, for better info please see Documentation/CodingGuidelines)
[snip]
