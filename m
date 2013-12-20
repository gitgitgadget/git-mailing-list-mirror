From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Bug when moving submodules (I think?)
Date: Fri, 20 Dec 2013 20:13:50 +0100
Message-ID: <52B496EE.70204@web.de>
References: <20131218233146.GR17291@wanderlust>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: fREW Schmidt <frioux@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 20 20:14:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vu5WL-0004V9-6I
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 20:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640Ab3LTTN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Dec 2013 14:13:57 -0500
Received: from mout.web.de ([212.227.15.4]:56707 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616Ab3LTTNz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Dec 2013 14:13:55 -0500
Received: from [192.168.178.41] ([84.132.145.171]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0Lzaxm-1VPmkK16rC-014hjM for <git@vger.kernel.org>;
 Fri, 20 Dec 2013 20:13:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20131218233146.GR17291@wanderlust>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:ESC1Pspjuvh0/X2HsjiaM7ANgfqDDlVK+Lddug4jBn9V6/gRjMU
 DWNDxg/Nonl0Pz51VV79Zu6qGj7QTmVgPN7XGXrHSmwqANiQT5RIkrfHiwsfY2DSC9FMAHj
 J9a4oPf2Ymz0I6mbL259kRwadXdbQ/izTHz35WgrDF9Vf5tIvYzYyGitVhmgGPGjG2tG3Ne
 S8C6EEKYbCQ7mS/9gjeUQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239578>

Am 19.12.2013 00:32, schrieb fREW Schmidt:
> I tried to make a script to repro this from scratch but ran into other
> issues, which may or may not be a bug.  I'll put that at the end.
> 
> To repro all you have to do is: 
> 
>  git checkout git://github.com/frioux/dotfiles
>  git reset --hard 92c85161ceec9e52b0b2d2de893ba11f49c80198
>  git mv zsh .zsh
> 
> (sha included so this email continues to be valid in the future)
> 
> You can now see that .git/index.lock has been left behind.

Thanks for the recipe, I can reproduce this crash and am working
on a fix (looks like mv chokes on an empty submodule). I'll look
into the problems you describe below too while doing that.

>  On a
> non-fresh checkout (I'm not sure why my old checkout is special) I get
> the following error:
> 
>  git: builtin/mv.c:248: cmd_mv: Assertion `pos >= 0' failed.
> 
> I assumed this was just related to moving submodules that are in
> subdirectories, but when I do that from a fresh repo I get a different
> error.
> 
>  mkdir -p test/a test/b
>  cd test/a
>  git init
>  touch a.txt
>  git add a.txt
>  git ci -m 'initial commit'
>  cd ../b
>  git init
>  mkdir c
>  touch c/c.txt
>  git submodule add ../a c/a
>  git ci -m 'initial commit'
>  git mv c d
>  git status
> 
> And the error:
> 
>  fatal: Could not chdir to '../../../../c/a': No such file or directory
>  fatal: 'git status --porcelain' failed in submodule d/a
