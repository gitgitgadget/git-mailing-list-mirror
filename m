From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/1] run-command.c: ignore bad permissions on dirs in
 PATH
Date: Tue, 25 May 2010 09:01:49 +0200
Message-ID: <4BFB75DD.7030201@viscovery.net>
References: <4BFB3C0A.2030505@gmail.com> <7vaarownmv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dale Rowley <ddrowley@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 25 09:02:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGo9e-0004bM-Fc
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 09:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab0EYHCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 03:02:17 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32089 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752487Ab0EYHCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 03:02:16 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OGo9T-0005rX-Au; Tue, 25 May 2010 09:02:11 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id DB3F31660F;
	Tue, 25 May 2010 09:02:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <7vaarownmv.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147672>

Am 5/25/2010 7:34, schrieb Junio C Hamano:
> Dale Rowley <ddrowley@gmail.com> writes:
> 
>> All of my git aliases stopped working one day. For example, when I ran 'git ci'
>> (where 'ci' is an alias for 'commit') it printed out this error:
>>
>> fatal: cannot exec 'git-ci': Permission denied
>>
>> This error was confusing (I didn't have a 'git-ci' executable anywhere, so why
>> was it complaining about permissions?) and it took me a while to figure out that
>> this was happening because I happened to have a random directory in my PATH that
>> had permissions set incorrectly. Git should probably ignore this, and here is
>> one way to fix it, although I'm not sure if it's the best way.
> 
> As long as the issue is "a directory P on PATH is unreadable, and we tried
> to see if P/git-ci is executable and reported failure by exiting", I think
> your patch is a reasonable solution.

But it is not only about an unreadable directory. EACCES is also returned
when a "git command" is found that does not have execute permission:

$ touch ~/bin/git-frob	# ~/bin is in $PATH
$ git frob		# original git
fatal: cannot exec 'git-frob': Permission denied
$ ./git frob		# patched git
WARNING: You called a Git command named 'frob', which does not exist.
Continuing under the assumption that you meant 'ambox'
in 11.0 seconds automatically...

That is, when you write a new git command and forget to set execute
permission, you lose the "Permission denied" error. (Ditto if you
accidentally remove execute permission from an existing external git command.)

The question is which corner case is more important to cater for.

I don't have an idea how to solve both issues short of doing the PATH
lookup manually.

-- Hannes
