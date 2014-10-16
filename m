From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: git describe oddity with GIT_DIR
Date: Thu, 16 Oct 2014 21:27:45 +0200
Message-ID: <54401C31.5090209@virtuell-zuhause.de>
References: <543FC965.7040600@virtuell-zuhause.de> <xmqq1tq8uf4f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 21:27:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeqiH-00007O-MT
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 21:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbaJPT1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 15:27:50 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:56387 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751874AbaJPT1t (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Oct 2014 15:27:49 -0400
Received: from p5ddc190d.dip0.t-ipconnect.de ([93.220.25.13] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1XeqiA-0003up-8d; Thu, 16 Oct 2014 21:27:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqq1tq8uf4f.fsf@gitster.dls.corp.google.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1413487669;ef9dd61c;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.10.2014 um 18:57 schrieb Junio C Hamano:
> Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:
> 
>> I've encountered an oddity with git describe.
>> Consider the following snippet:
>> -----
>> mkdir test
>> cd test
>> git init
>> echo 1 > file
>> git add file
>> git commit -m "changes"
>> $ git describe --always --dirty
>> 8ad486e
>> $ cd ..
>> $ git --git-dir=test/.git describe --always --dirty
>> 8ad486e-dirty
>> $ GIT_DIR=test/.git git describe --always --dirty
>> 8ad486e-dirty
>> -----
>>
>> The "-dirty" suffix appears if invoking git not from the worktree
>> itself, but should actually never appear.
> 
> This is not oddity with describe.  You are using --git-dir incorrectly.
> 
> When you tell Git where its repository resides with the $GIT_DIR
> environment variable or the --git-dir command-line option, unless
> you tell it where the top-level of your working tree is, you are
> telling that your current working directory is the top-level of your
> working tree.
> 
> You are asking "git describe" to describe the state of the HEAD
> including the dirtyness of the working tree in various ways.  With
> the first invocation, you do not tell Git where things are and let
> it correctly figure it out, i.e. you are in 'test' directory and
> relative to where you are, ".git" is the repository and "." is the
> top of the working tree.  The commit recorded in the ".git/HEAD",
> i.e. 8ad486e, is used, and its compared with the working tree to
> determine dirtiness.  Specifically, the blob object 8ad486e:file is
> the same as "./file" (that is "test/file" relative to where you
> started with "mkdir test" above).
> 
> With the latter two, you are asking the same question but you go one
> level up and then tell Git that the repository is "test/.git"
> (correct) and the top of the working tree is "." (a lie).  Again,
> "test/.git/HEAD" records the same commit, but when trying to compare
> the contents of its tree, e.g. "file" at the top-level in the
> commit, you do not have "file" in the working tree.  Git is led to
> believe that you removed "file", hence your working tree state is
> dirty.
> 
> Make it a habit to always specify GIT_WORK_TREE when you use
> GIT_DIR, unless you know you will always start from the top of the
> working tree.

Thanks a lot Junio for the in-depth explanation.
I'll promise to do more research next time :)
