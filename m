From: Bernd Naumann <bernd@kr217.de>
Subject: Re: Need some help on patching buildin-files // was: Looking for
 feedback and help with a git-mirror for local usage
Date: Fri, 12 Jun 2015 12:52:44 +0200
Message-ID: <557AB9FC.30102@kr217.de>
References: <5579F318.7050503@kr217.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 12:52:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3MZx-0000ai-H3
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 12:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632AbbFLKws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 06:52:48 -0400
Received: from zero.kr217.de ([88.198.92.197]:42333 "EHLO zero.kr217.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753486AbbFLKwr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 06:52:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by zero.kr217.de (Postfix) with ESMTP id A5905294111
	for <git@vger.kernel.org>; Fri, 12 Jun 2015 12:52:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at zero.kr217.de
Received: from zero.kr217.de ([127.0.0.1])
	by localhost (zero.kr217.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B9yTuOrkXpeq for <git@vger.kernel.org>;
	Fri, 12 Jun 2015 12:52:45 +0200 (CEST)
Received: from [192.168.254.12] (x4d07fd76.dyn.telefonica.de [77.7.253.118])
	(Authenticated sender: bernd@kr217.de)
	by zero.kr217.de (Postfix) with ESMTPSA id CA4B429410A
	for <git@vger.kernel.org>; Fri, 12 Jun 2015 12:52:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <5579F318.7050503@kr217.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271479>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello again,

After digging the code I may have got a clue where to start but I
would  still appreciate some help from a developer, cause I have never
learned to write C. (Some basics at school which happened over a
decade ago.)

Currently I have questions on:

* How to patch clone: would cmd_clone() a good place? Or are there
other calls which might be better. I think about to insert the check
if a mirror will be setup or just updated, right after dest_exists.

* Is it correct that a new config key just get specified via a config
file or by cmd_init_db()? So later, a check on that value is enough?
Would be the section 'user' a good place for this key or is it
something that would get a own/new section?

* Have I missed a relevant file?

git/git.c
git/builtin/clone.c
git/builtin/fetch.c
git/builtin/push.c
git/buildin/remote.c
along with the translation and Documentation, of course.


If you have some comments on that, please share these with me, and if
you are interested in helping me to got this implemented, I would
appreciate that :)

Sincere regards,
Bernd


On 06/11/2015 10:44 PM, Bernd Naumann wrote:
> Hello,
> 
> I have came up with an idea # Yep I know, exactly that kind of 
> e-mail everyone wants to read ;) and I'm working currently on a 
> shell-prototype to face the following situation and problem and 
> need some feedback/advise:
> 
> 
> I often build in example 'openwrt' with various build-scripts which
> depends heavily on a fresh or clean environment and they omit many
> sources via `git clone`, which results sometimes in over 100 MB of
> traffic just for one build. /* Later needed .tar.gz source archives
> are stored in a symlinked download directory which is supported by
> 'openwrt/.config' since a few months... to reduce network traffic.
> */
> 
> My connection to the internet is not the fastest in world and 
> sometimes unstable, so I wanted to have some kind of local bare 
> repository mirror, which is possible with `git clone --mirror`.
> 
> From these repositories I can later clone from, by calling `git 
> clone --reference /path/to.git <url>`, but I do not wish to edit 
> all the build-scripts and Makefiles.
> 
> 
> So I wrote a git wrapper script (`$HOME/bin/git`), which checks if
>  `git` was called with 'clone', and if so, then it will first 
> clones the repository as a mirror and then clones from that local 
> mirror. If the mirror already exists, then it will only be updated 
> (`git remote update`). This works for now.
> 
> /* To be able to have multiple identical named repositories, the 
> script builds paths like:
> 
> ~/var/cache/gitmirror $ find . -name "*.git"
> 
> ./github.com/openwrt-management/packages.git 
> ./github.com/openwrt/packages.git 
> ./github.com/openwrt-routing/packages.git ./nbd.name/packages.git 
> ./git.openwrt.org/packages.git ./git.openwrt.org/openwrt.git
> 
> It strips the schema from the url and replaces ":" with "/" in
> case a port is specified or a svn link is provided. The remaining
> should be a valid linux file and directory structure, if I guess 
> correctly!? */
> 
> Ok, so far, so good, but the implementation of the current 
> shell-prototype looks way too hacky [0] and I have found some edge
>  cases on which my script will fail: The script depends on the
> fact that the last, or at least the second last argument is a
> valid git-url, but the following is a valid call, too :
> 
> `git --no-pager \ clone git@github.com:openwrt/packages.git 
> openwrt-packages --depth 1`
> 
> But this is not valid:
> 
> `git clone https://github.com/openwrt/packages.git --reference 
> packages.git packages-2` or `git clone --verbose 
> https://github.com/openwrt/packages.git packages-2 --reference 
> packages.git`
> 
> 
> I found out that git-clone actually also can only make a guess
> what is the url and what not.
> 
> 
> 
> However, now I'm looking for a way to write something like a 
> submodul for git which will check for a *new* git-config value like
> "user.mirror" (or something...) which points to a directory, and
> will be used to clone from, and in case of 'fetch', 'pull' or 
> 'remote update' update the mirror first, and then the update of
> the current working directory is gotten from that mirror. (And in
> case of 'push' the mirror would be updated from the working dir,
> of course.)
> 
> 
> I would like to hear some toughs on that, and how I could start to
>  build this submodul, or if someone more talented, then I am, is 
> willed to spent some time on that. If requested/wished I could
> send a link to the shell-prototype.
> 
> 
> [0] For a reason I have to do ugly things like `$( eval exec 
> /usr/bin/git clone --mirror $REPO_URL ) 2>&1 >/dev/null` cause 
> otherwise in case of just `eval exec` the script stops after 
> execution, and without `eval exec` arguments with spaces will 
> interpreted as seperated arguments, which is no good, because of 
> failing .
> 
> 
> Thanks for your time! Yours faithfully, Bernd -- To unsubscribe 
> from this list: send the line "unsubscribe git" in the body of a 
> message to majordomo@vger.kernel.org More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> 

- -- 
Bernd Naumann <bernd@kr217.de>

PGP:   0xA150A04F via pool.sks-keyservers.net
XMPP:  bn@weimarnetz.de

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJVern8AAoJEEYW3OihUKBPLPYP/2RYrqH7qtH9ZVCc+dN6kEMb
KzEFiSF7Vg7EIcSYIeyw7SS8M/3QyBHmdClq6Gcgby7yAYuSsXcY4V0xja12cI2g
glH+5kXfZg11shJdi530GGLNVyTaLhhNUxqmrB56FHP31nOeFGEYzLhDs16mh4z8
2YiN4wT62O8R/yjRReaeRBe2cTniga1ZeDVFgYGE2atWmGOb2DLEfDyxAWIUeu0r
RfLF7NPb5ZLAlSBfifmMeRJ7Fu8Ewf0m3ESZoBlD3+CW68k7vefTo+iVvmRJnkEl
0p89IJMCdPEwTsXwXUMnI0xcofM9tLthGQ+x482rQTxUYvkzQnjT2vBc/DTe08Ok
+xS4JaZl+22IlyRt8KFJOLHhZfuZgYOlGqoHqxbIPZyNvR+AtuGRSGdGEJoc2ACb
aij+smTlN3k8X3DZVGPNlsNaFCRVgGin2Yad4pOIk/mlkR6xx3LfFB6qv8mSoj0z
kmFDPAdYWlGps+hPeM76Ql9UN+wgcD+1y2TpMJGyUy4YoGmOQq4TWO1JMUVjWWie
ie5Yf/JD8fopmrV3BM2sT7gLmi75zpsc3Em/i6S5zUIhZ0v+UfNE5dSim0KcAgyS
I0apoXZZw3UjaTilmd3h/ecuTa1lBygNucnGnDfm3NAGYDWjy0LR8Mu7+2rBogvk
JCF1hf3qka80GEwsZqu+
=3nO1
-----END PGP SIGNATURE-----
