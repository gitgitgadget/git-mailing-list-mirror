From: Marco Costalba <mcostalba@gmail.com>
Subject: [Fwd: Re: qgit reports errors in the git repository]
Date: Thu, 15 Dec 2005 20:16:11 +0100
Message-ID: <43A1C0FB.9070709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 15 20:17:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmyaX-0005os-W9
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 20:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbVLOTQX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 14:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVLOTQX
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 14:16:23 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:31894 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751027AbVLOTQW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Dec 2005 14:16:22 -0500
Received: by zproxy.gmail.com with SMTP id 34so440813nzf
        for <git@vger.kernel.org>; Thu, 15 Dec 2005 11:16:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=iBPiK+/9IWG7YPh4+duAKG8oLI68XQlZOXODhsEZyzh5LNrKXSaGVeG2N8gwNRRW/ZQ6YqPZQCfl/IUDcPm75lfYB67M0qh7Xse3fP2tHeZEcJzfL5JBHwJtnR9lngUXmqMg7TNiKaRi6OaFp7HcLdgTD7BXi3sPAoZsXXC8tTk=
Received: by 10.64.49.5 with SMTP id w5mr16342qbw;
        Thu, 15 Dec 2005 11:16:21 -0800 (PST)
Received: from ?10.0.0.13? ( [151.56.82.23])
        by mx.gmail.com with ESMTP id e10sm45090qbe.2005.12.15.11.16.19;
        Thu, 15 Dec 2005 11:16:21 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0.6-7.2.20060mdk (X11/20050322)
X-Accept-Language: it, it-it, en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13707>

On 12/15/05, Pavel Roskin <proski@gnu.org> wrote:
>
> Hello, Marco.



> qgit doesn't print its command line at all when running commands
> synchronously.


Hi Pavel,

  Yes! this is a bug.
Thanks  for the patch, applied.

Unfortunatly, regarding the main question on git-cat-file I cannot reproduce
the bug.
The problem is that on my box the object
23ea3e201cea0deea909569e08e950a9ec2345f7 is
_never_ fed to git-cat-file because is filtered out ending with "^{}"

git-ls-remote ./.git |grep 23ea3e201cea0deea909569e08e950a9ec2345f7
23ea3e201cea0deea909569e08e950a9ec2345f7        refs/tags/v0.99.9g^{}

The corresponding tag feeded to git-cat-file is
bd67d7d845eb5ae929306dadd3dff41cf04ce004

I have just made a
git pull
git fetch --tags

from git repository.

So, please, test with this:

--- a/src/git_startup.cpp
+++ b/src/git_startup.cpp
@@ -111,6 +111,7 @@ bool Git::getRefs() {

          if (itNext != rLst.constEnd() && (*itNext).right(3) == "^{}") {
              signedTag = true;
+            dbg(refSha);
              if (run("git-cat-file tag " + refSha, &runOutput)) {
                  QString msg(runOutput.section("\n\n", 1));
                  if (!msg.isEmpty())

and send me the output. Mine is

refSha is <a0e7d36193b96f552073558acf5fcc1f10528917>
refSha is <24d9d195a206825bc1f03e7e7110fe05a827d1e3>
refSha is <d6602ec5194c87b0fc87103ca4d67251c76f233a>
refSha is <f25a265a342aed6041ab0cc484224d9ca54b6f41>
refSha is <c5db5456ae3b0873fc659c19fafdde22313cc441>
refSha is <7ceca275d047c90c0c7d5afb13ab97efdf51bd6e>
refSha is <b3e9704ecdf48869f635f0aa99ddfb513f885aff>
refSha is <07e38db6a5a03690034d27104401f6c8ea40f1fc>
refSha is <f12e22d4c12c3d0263fa681f25c06569f643da0f>
refSha is <f8696fcd2abc446a5ccda3e414b731eff2a7e981>
refSha is <1094cf40f7029f803421c1dcc971238507c830c5>
refSha is <da30c6c39cd3b048952a15929c5440acfd71b912>
refSha is <9165ec17fde255a1770886189359897dbb541012>
refSha is <02b2acff8bafb6d73c6513469cdda0c6c18c4138>
refSha is <b041895af323bdef10cc9a718bda468ba3622bc0>
refSha is <cfc2ea6116410a545573d5fa5311d3c3b2df69d1>
refSha is <0b122201af0afb6a6a8059ff446a1e26b1d0c823>
refSha is <d186f3d21148f373a5ea5e43804f5f6707670a87>
refSha is <48055bb38d650ab39957ed07d640469176c12419>
refSha is <b79a5a49c9e412e27a336e705fb7b462367f4c16>
refSha is <ebd5d002da3f6cfbd0aa3ff5b5c4a9d9eeee630d>
refSha is <08f9f32076455ff75b59b41d7003927869082a3f>
refSha is <67b4b78858d9d9dd044f758a90a4270e48543cf1>
refSha is <c512b0344196931ad3a9a049eb3f5d3f05b09328>
refSha is <3d65a838c77f816527acf84c899419eb6825dcee>
refSha is <3521017556c5de4159da4615a39fa4d5d2c279b5>
refSha is <107e3d2b4d5b9ecd9a15a23ad1c64652b8b67ba9>
refSha is <10e5ae69eb6cdcdd149bb23e1e73131adf4ab3b7>
refSha is <b685b14cd9385e8b0f5742ebcd35ef8c8c12ec4d>
refSha is <bd67d7d845eb5ae929306dadd3dff41cf04ce004>
refSha is <5c857638d55bdd575d3f38bf3b99f1a2f99d3e46>
refSha is <4a6a394c62f33a3bf94badd6b14bc1f48647905f>
refSha is <c0f7d44ecba75d54a73ba542adde0ff80d2da03a>
refSha is <0c675e9d0b5f5d1fbb7b0169d71769993b225701>
refSha is <ca6cec9c5843d85d23b1184d584a11699d92e927>
refSha is <93ea4a9599564101be20507a3a756d38427a70ac>
refSha is <71c1a700da60da8cf99d586cc618c46fef201ed1>
refSha is <5f4cd4ca015dc795b9f7f4fed11b3f80a60ac175>
refSha is <112c4fd6b3fe400a075d575c0fe1a583aafe8f2c>
refSha is <dcd118f6b933d7a81739c3c4269e2bf4654e4a99>
refSha is <055e4ae3ae6eb344cbabf2a5256a49ea66040131>
refSha is <2d2846cd06fce719c35b58a8b81f7ae42f1986ca>
refSha is <781aab17fe544cbfcaba0f0ea5cacf7672717236>

and the offending object is not displayed.

Thanks
Marco
