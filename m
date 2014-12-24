From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: git update-ref --stdin : too many open files
Date: Tue, 23 Dec 2014 18:11:04 -0800
Message-ID: <549A20B8.3060805@gmail.com>
References: <54954E44.1080906@dachary.org> <xmqqoaqv8jmi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Loic Dachary <loic@dachary.org>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 24 03:11:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3bPu-0004mu-2g
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 03:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbaLXCLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 21:11:09 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:59094 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbaLXCLH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 21:11:07 -0500
Received: by mail-pa0-f47.google.com with SMTP id kq14so9081949pab.20
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 18:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=puqbFwYEWtQik0bU5VOmGl73m5MQgWxI1yG2K1dgegs=;
        b=Zi/Cs5Fc5EqIpcaglrIuD26+RmoPC5KdyBpICDI32W5aQDPykdwxzsmpRYAEsG99P1
         BYu0YWITaRyQM+26C21UUQ/8fnjMFmCMrA3Nd/SVRcz0PUuX0wCtXyE9igOpD1aqIoH1
         UEPHR4FZyekJwWSJ/ksvP7zhrSH9KO870gYjIkBee+eD+210mfars6wBgF6zPyyd+8Yc
         3LjTm5wRTIH9Ib3sErEw91/dRIzac+hwJ6ew84ABkHTl6Ib8N5bEWUzbMmuH/+6+6kK+
         fXJY7P3obaHVIdx/mFJ6fikJfTbxAJztMkZ2SVf8gRU3hDVUqOvjKB9406QGKZOyM2es
         gTGg==
X-Received: by 10.66.157.101 with SMTP id wl5mr48463016pab.37.1419387067127;
        Tue, 23 Dec 2014 18:11:07 -0800 (PST)
Received: from [192.168.2.3] (c-76-102-52-132.hsd1.ca.comcast.net. [76.102.52.132])
        by mx.google.com with ESMTPSA id kl7sm21243311pdb.10.2014.12.23.18.11.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Dec 2014 18:11:05 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqoaqv8jmi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261789>

On 22.12.2014 13:22, Junio C Hamano wrote:
> Loic Dachary <loic@dachary.org> writes:
> 
>> Hi,
>>
>> Steps to reproduce:
>>
>> $ git --version
>> git version 1.9.1
>> $ wc -l /tmp/1
>> 9090 /tmp/1
>> $ head /tmp/1
>> delete refs/pull/1/head
>> create refs/heads/pull/1 86b715f346e52920ca7c9dfe65424eb9946ebd61
>> delete refs/pull/1/merge
>> create refs/merges/1 c0633abdc5311354c9729374e0ba25c97a89f69e
>> ...
>> $ ulimit -n
>> 1024
>> $ git update-ref --stdin < /tmp/1
>> fatal: Unable to create
>> /home/gitmirror/repositories/Ceph/ceph/refs/heads/pull/1917.lock': Too
>> many open files
>> $ head -20 /tmp/1 | git update-ref --stdin
>> $ echo $?
>> 0
>>
>> The workaround is to increase ulimit -n
>>
>> git update-ref --stdin should probably close some files.
>>
>> Cheers
> 
> Sounds like the recent "ref update in a transaction" issue to me.
> 
> Stefan, want to take a look?  I think we do need to keep the .lock
> files without renaming while in transaction, but we do not have to
> keep them open, so I suspect that a fix may be to split the commit
> function into two (one to close but not rename, the other to
> finalize by renaming) or something.
> 
> Also the version of transaction series we have queued seem to lock
> these refs very late in the process, but as we discussed privately
> a few weeks ago, we would want to move the lock much earlier, when
> the first update is attempted.

So I decided the first thing to do was to put this case into the test
suite. so I typed in good faith:

test_expect_success 'but does it scale?' '
	for i in $(seq 1 1234567) ; do
		git branch branch_${i}
		echo "delete refs/heads/branch_${i}" >>large_input
	done
	git update-ref --stdin <large_input
'

And there I have problems with my hard disk having more than a million
files in one directory. So once I get rid of that I'll come up with a
better way to test and fix this problem.

Thanks,
Stefan
