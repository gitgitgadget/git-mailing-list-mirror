From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: The different EOL behavior between libgit2-based software and
 official Git
Date: Thu, 19 Jun 2014 08:39:29 +0200
Message-ID: <53A285A1.3090804@web.de>
References: <1403146778624-7613670.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Yue Lin Ho <yuelinho777@gmail.com>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 19 08:39:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxW0n-0005qt-Bb
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 08:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756683AbaFSGjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 02:39:48 -0400
Received: from mout.web.de ([212.227.17.12]:49959 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754283AbaFSGjs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 02:39:48 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LnjBT-1WVcuT0eKd-00hyFx; Thu, 19 Jun 2014 08:39:46
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403146778624-7613670.post@n2.nabble.com>
X-Provags-ID: V03:K0:3lR8aywcydazmkKDaJoyYh5stbuwcnvprUYmTKU7Nx+t/7nWi4f
 EfSv3A55SkExQeOay5xXhNQuauWf8gtnz/1ZTzxUu6QRZYplfxxD5pLh4Jm9tIFQiTpnVBu
 H88QcoXAR/j/Un/xPFz1XpXvSTawynM9Hysi0txRR8QDOJZLlA1+8VZ7G5zX+n5kh5tMLwh
 BdstDR5gts3ZmzF4zIpkw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252097>

On 06/19/2014 04:59 AM, Yue Lin Ho wrote:
> Hi:
>
> ^_^
>
> I did some test on the EOL behavior between official git and libgit2-based
> software(TortoiseGit).
> Then, I got that they have different EOL behavior.
>
> The blob stored in repository is a text file with mixed EOLs.
> Even set core.autocrlf = true, official git checkout the file as it is(means
> still *mixed EOLs* there).
> But, libgit2 checkout it with *All CRLF EOLs*.
>
>   * The steps:
>     * set core.autocrlf = false
>     * add file with mixed EOLs
>     * set core.autocrlf = true
>     * delete that file in the working tree
>     * checkout that file
>     * examine the EOL
>
> If you are interested in this, you might take a look at my testing
> repository on GitHub.
> (https://github.com/YueLinHo/TestAutoCrlf)
>
> Thank you.
>
> Yue Lin Ho

(I send a similar mail to msysgit, I'm not sure if this came trough)

Sorry being late, I don't think there is something wrong with Git.
The core.autocrlf is the "old" crlf handling, which has been in Git for 
a long time.

If you exactly know what you are doing, know exactly
which tools are doing what, convince everybody who pulls or pushes to 
that repo to use
the same local config then it may be useful.

In short: I would strongly recommend to use gitattributes, please see 
below.


tb@msygit ~/temp
$ git clone https://github.com/YueLinHo/TestAutoCrlf.git
Cloning into 'TestAutoCrlf'...
[snip]
$ cd TestAutoCrlf/

tb@msygit ~/temp/TestAutoCrlf (master)
$ ls
CRLF.txt  LF.txt  MIX-more_CRLF.txt  MIX-more_LF.txt  Readme.md
###### Check how the file looks like:
$ od -c MIX-more_LF.txt
0000000   L   i   n   e       1  \n   l   i   n   e       (   2   ) \r
0000020  \n   l   i   n   e       3   .  \n   t   h   i   s i   s
0000040       l   i   n   e       4  \n   l       i       n       e
0000060   N   o   .       5  \n   L   i   n   e       N   u   m b e
0000100   r       6  \n
0000104
####### The file has one CRLF, the rest is LF, exactly how it had been
####### commited. So this is what we expect. Or do I miss something ?



####### Tell Git that MIX-more_LF.txt is a text file:
$ echo MIX-more_LF.txt text >.gitattributes

####### Verify that MIX-more_LF.txt is text, all other files
####### are "binary" (or "-text" in Git language)
$ git check-attr text *
CRLF.txt: text: unspecified
LF.txt: text: unspecified
MIX-more_CRLF.txt: text: unspecified
MIX-more_LF.txt: text: set
Readme.md: text: unspecified

####### Now ask Git to normalize the line endings in the working tree
$ rm  MIX-more_LF.txt

tb@msygit ~/temp/TestAutoCrlf (master)
$ git checkout   MIX-more_LF.txt

########## Check what we got:
tb@msygit ~/temp/TestAutoCrlf (master)
$ od -c MIX-more_LF.txt
0000000   L   i   n   e       1  \r  \n   l   i   n   e       ( 2 )
0000020  \r  \n   l   i   n   e       3   .  \r  \n   t   h   i   s
0000040   i   s       l   i   n   e       4  \r  \n   l i       n
0000060       e       N   o   .       5  \r  \n   L   i   n e N
0000100   u   m   b   e   r       6  \r  \n
0000111
######### (This is under Windows, under Linux I would expect only LF)
######### See core.eol for for information

##########
########## Now we need to normalize the file in the repo,
########## All line endings should be LF, otherwise Git
########## things the file is modified:
$ git status
On branch master
Your branch is up-to-date with 'origin/master'.

Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working 
directory)

         modified:   MIX-more_LF.txt

Untracked files:
   (use "git add <file>..." to include in what will be committed)

         .gitattributes

no changes added to commit (use "git add" and/or "git commit -a")


###############
############### Do the normalization:
tb@msygit ~/temp/TestAutoCrlf (master)
$ git add MIX-more_LF.txt .gitattributes

tb@msygit ~/temp/TestAutoCrlf (master)
$ git commit -m  "MIX-more_LF.txt is text"
[master 200d874] MIX-more_LF.txt is text
  Committer: unknown <tb@msysgit>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly:

     git config --global user.name "Your Name"
     git config --global user.email you@example.com

After doing this, you may fix the identity used for this commit with:

     git commit --amend --reset-author

  2 files changed, 2 insertions(+), 1 deletion(-)
  create mode 100644 .gitattributes

tb@msygit ~/temp/TestAutoCrlf (master)
$

######## From now on, MIX-more_LF.txt is treated as text by Git,
######## and get CRLF under Windows.
######## I think there is nothing wrong with Git here.
######## If libgit2 does something different, we need to ask
######## the libgit2 project, which is independent from Git
