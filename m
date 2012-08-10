From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2] macos: lazily initialize iconv
Date: Fri, 10 Aug 2012 23:11:34 +0200
Message-ID: <50257906.1010606@web.de>
References: <7vk3xjked0.fsf@alter.siamese.dyndns.org> <7v1ujrkc9p.fsf@alter.siamese.dyndns.org> <50253A1E.20706@web.de> <7vsjbuk3v3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 23:11:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzwUj-0000wR-Co
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 23:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757608Ab2HJVLk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Aug 2012 17:11:40 -0400
Received: from mout.web.de ([212.227.15.3]:58194 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754834Ab2HJVLj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 17:11:39 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0M7bVP-1TuN6G233X-00wjGd; Fri, 10 Aug 2012 23:11:36 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vsjbuk3v3.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:+s5V6guRaPSc9kK8mL9HfHU8G31a4M6M4VOdtmVhpms
 AwLolSgEvcvv4SxYyDgAMJ44IMh3Ez6AiPyw5KtEyauJtuJz4l
 SIgR8N8M/yknVaclV7kQy/pGX64W1fVpbEZFUYV2k5wJ+KzHuY
 s8Ah7+7GOTRuA9+H3dfL6YovhJt4l1YlLJjQHC1ZbYvdA3nUp/
 6d2luAyYNXFwE5dYmLisg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203261>

On 10.08.12 20:18, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> On 31.07.12 20:37, Junio C Hamano wrote:
>>> In practice, the majority of paths do not have utf8 that needs
>>> the canonicalization. Lazily call iconv_open()/iconv_close() to
>>> avoid unnecessary overhead.
>>>
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>> Helped-by: Ralf Thielow <ralf.thielow@gmail.com>
>>> Helped-by: Linus Torvalds <torvalds@linux-foundation.org>
>>> ---
>>>
>>>  * This is not even compile tested, so it needs testing and
>>>    benchmarking, as I do not even know how costly the calls to
>>>    open/close are when we do not have to call iconv() itself.
>>> ...
>> Hi Junio,
>>
>> thanks for the optimization.
>> Tested-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> Well, I didn't mean the correctness testing without numbers.  The
> correctness of the patch after a couple of people eyeballed it was
> no longer a question.
>
> If the patch does not give any measuable performance difference to
> people who exercise this codepath, it is not worth merging.  And
> that is not something I can't do myself without a Mac (nor I wish to
> have one to be able to do so myself).
>
> Thanks.
Really sorry for the confusion with the percentage, I should have writt=
en:
The patch is tested OK, and we can even remove 2 lines of code,
where we save and restore errno.
They are no longer needed.

Here some benchmarks on my system
(Intel Core 2 Duo @   3,06 GHz, L2-Cache:    3 MB,  Memory:    4 GB)
running git status on the linux source tree.

After cloning, I set "git config core.precomposeunicode true".

git is v1.7.12.rc2,
git_git/git is with your patch.

git v1.7.12.rc2:
tb@birne:~/projects/git/linux-2.6> for f in 1 2 3 4 5; do time git stat=
us  ; done 2>&1 | egrep "^user|^real|^sys"
real    0m0.469s
user    0m0.283s
sys     0m0.175s

real    0m0.461s
user    0m0.283s
sys     0m0.170s

real    0m0.460s
user    0m0.283s
sys     0m0.170s

real    0m0.461s
user    0m0.283s
sys     0m0.177s

real    0m0.460s
user    0m0.283s
sys     0m0.176s

With lazy init of iconv:
tb@birne:~/projects/git/linux-2.6> for f in 1 2 3 4 5; do time ~/projec=
ts/git/git_git/git status  ; done 2>&1 | egrep "^user|^real|^sys"
real    0m0.463s
user    0m0.282s
sys     0m0.173s

real    0m0.460s
user    0m0.281s
sys     0m0.172s

real    0m0.460s
user    0m0.281s
sys     0m0.172s

real    0m0.463s
user    0m0.281s
sys     0m0.175s

real    0m0.462s
user    0m0.281s
sys     0m0.177s
