From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodules: don't stumble over symbolic links when cloning
 recursively
Date: Wed, 11 Jul 2012 22:06:05 +0200
Message-ID: <4FFDDCAD.5080001@web.de>
References: <4FFDC1EE.8080106@web.de> <4FFDCFA4.9060602@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Bob Halley <halley@play-bow.org>,
	Phil Hord <phil.hord@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jul 11 22:06:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp3Au-0003FQ-1J
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 22:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933134Ab2GKUGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 16:06:10 -0400
Received: from mout.web.de ([212.227.15.3]:65396 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932436Ab2GKUGI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 16:06:08 -0400
Received: from [192.168.178.48] ([91.3.167.141]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0M25Bz-1Rw7Ik1Q5r-00tV0j; Wed, 11 Jul 2012 22:06:05
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <4FFDCFA4.9060602@kdbg.org>
X-Provags-ID: V02:K0:cDvlwFAA4OGv8OQeosAJjeyTIncQmhaN8WdgxAKius5
 KhVPggClOVJD61Naxfum5jaZJIQWGE/oDESB/fXct+UpAhUIyD
 hO3vQisqmUV/r5hDQxvQ31fvUKDtenyWeCxCzvkt4puH6QSEf0
 A3EQ1u/+bB/f0zfb1o/8bw2Aojvc3K0Aw4mBsb6WYDhC0KQT6r
 d/Vhw8Myj14jGb5R4jBXg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201325>

Am 11.07.2012 21:10, schrieb Johannes Sixt:
> Am 11.07.2012 20:11, schrieb Jens Lehmann:
>> Since 69c305178 (submodules: refactor computation of relative gitdir path)
>> cloning a submodule recursively fails for recursive submodules when a
>> symbolic link is part of the path to the work tree of the superproject.
>>
>> This happens when module_clone() tries to find the relative paths between
>> work tree and git dir. When a symbolic link in current $PWD points to a
>> directory in a different level determining the number of "../" needed to
>> traverse to the superprojects work tree leads to a wrong result.
>>
>> As there is no portable way to say "pwd -P" use cd_to_toplevel to remove
>> the link from the pwd, which fixes this problem.
> ...
>> -	a=$(cd "$gitdir" && pwd)/
>> -	b=$(cd "$sm_path" && pwd)/
>> +	a=$(cd_to_toplevel && cd "$gitdir" && pwd)/
>> +	b=$(cd_to_toplevel && cd "$sm_path" && pwd)/
> 
> But if you cd out, how can it be correct not to cd in again if $gitdir
> and/or $sm_path are relative?

I'm not sure what you mean by "cd out", but the two "cd_to_toplevel"
make sure that when $gitdir or $sm_path are relative the symbolic link
gets removed from the output of pwd. So it's rather "cd into the path
where the symlink is resolved".

> And if $gitdir and/or $sm_path are absolute, how can the earlier
> cd_to_toplevel make a difference?

Then it doesn't, but $sm_path is always relative while $gitdir is
sometimes (in the superproject it returns ".git"). Just drop either
of the "cd_to_toplevel" and run the test ;-)

But it looks like the commit message could use some tuning ...

>> +test_expect_success 'submodule update can handle symbolic links in pwd' '
> 
> Please add a SYMLINKS prerequisite.

Oops. Thanks, will add that.

Will wait some time for other comments before preparing v2.
