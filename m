From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: No fchmd. was: Re: [PATCH 00/14] Add submodule test harness
Date: Thu, 10 Jul 2014 08:22:31 +0200
Message-ID: <53BE3127.8020805@web.de>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>	<53B5C7AC.4040701@web.de>	<xmqqsimddrq3.fsf@gitster.dls.corp.google.com>	<53BAF7AF.4020901@web.de> <53BC47BD.1000705@web.de>	<53BD7A36.2030300@kdbg.org>	<xmqqr41u9w27.fsf@gitster.dls.corp.google.com>	<20140709195619.GA17454@dcvr.yhbt.net> <xmqqion69ovj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jul 10 08:23:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X57lW-0003yT-6X
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 08:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbaGJGXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 02:23:30 -0400
Received: from mout.web.de ([212.227.17.11]:62915 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbaGJGX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 02:23:29 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MGRVU-1WrsDr0nA0-00DKfM; Thu, 10 Jul 2014 08:23:23
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <xmqqion69ovj.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:gbdwpVlGJLyT+NcnsSTL2IInduaLazIBuWkNPwH5JMFRKQu5jvl
 6Xuzbbb3FMrlkAUCY1+IscLxdyyG0F1qsSBO2a71QKLlcHABk29n5mfIOje1cFXJ+kO7C39
 J10+OJXnPgxe2+4/KX+ta7S/Z92WcqTcjErh7Ng6nQNXAjRVDZFJnuEHnm/3PCJ80uLL6Bm
 sJSj2IDFYVt8fn8btUgNg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253176>

On 07/09/2014 11:57 PM, Junio C Hamano wrote:
> Eric Wong <normalperson@yhbt.net> writes:
>
>> Junio C Hamano <gitster@pobox.com> wrote:
>>> Johannes Sixt <j6t@kdbg.org> writes:
>>>> Am 08.07.2014 21:34, schrieb Jens Lehmann:
>>>>>> And Msysgit complains
>>>>>> error: fchmod on c:/xxxt/trash directory.t7613-merge-submodule/submodule_update_repo/.git/modules/sub1/config.lock failed: Function not implemented
>>>>> I'm not sure what this is about, seems to happen during the "cp -R" of
>>>>> the repo under .git/modules into the submodule.
>>>> No. It happens because fchmod() is not implemented in our Windows port.
>>>>
>>>> Please see my band-aid patch at
>>>> http://thread.gmane.org/gmane.comp.version-control.git/248154/focus=20266
>>>> The sub-thread ended inconclusive.
>>> We need to start somewhere, and a no-op fchmod() in your patch may
>>> be as a good place to start as anything.  At least we would then
>>> keep the old behaviour without introducing any new failure.
>> Right, this likely makes the most sense for single-user systems or
>> systesm without a *nix-like permission system.
>>
>>> An alternative might be to use chmod() after we are done writing to
>>> the config.lock in order to avoid the use of fchmod() altogether,
>>> which I think can replace the existing two callsites of fchmod().
>>> That approach might be a more expedient, but may turn out to be
>>> undesirable in the longer term.
>> In that case, we would need to open with mode=0600 to avoid a window
>> where the file may be world-readable with any data in it.
> Yes, of course.
>
> To elaborate what I was alluding to at the end of the message you
> are responding to a bit more, if we were to move this "grab perms
> from existing file (if there is any) and propagate to the new one"
> into the lockfile API,
>
>   - in hold_lock_file_for_update(), we would record the permission of
>     the original file, if any, to a new field in "struct lock_file";
>   - open with 0600 or tighter in lock_file(), and
>
>   - either before closing the file use fchmod() or after closing and
>     moving the file use chmod() to propagate the permission.
>
> If the original did not exist, we would pass 0666 to open as before
> in lock_file() and do not bother chmod/fchmod at the end.
>
> Or something like that, perhaps.

Isn't the whole problem starting here:
in config.c:

     fd = hold_lock_file_for_update(lock, config_filename, 0);
In lockfile.c:
   /* This should return a meaningful errno on failure */
   int hold_lock_file_for_update(struct lock_file *lk, const char *path, 
int flags)
   {
       int fd = lock_file(lk, path, flags);
which leads to
   static int lock_file(struct lock_file *lk, const char *path, int flags)
     []
     lk->fd = open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);

There is no way to tell which permissions the new lockfile should have.
That is somewhat unlucky.

On the other hand, shouldn't we call
adjust_shared_perm(const char *path) from path.c on the config file?

And to all files which are fiddled through the lock_file API?
In other words, the lockfile could be created with the restrictive 
permissions
600, and once the lockfile had been closed and renamed into the final name
we apply adjust_shared_perm() on it ?

Or probably directly after close() ?

I think there are 2 different things missing here:

- Be able to specify permissions to hold_lock_file_for_update(),
    especially restrictive ones, like 600 and not 666.

- Adjust the permissions for "shared files" in a shared repo.
   This is probably needed for a shared repo, when the user itself
    has a umask which is too restrictive and adjust_shared_perm()
    must be run to widen the permissions.

Do I miss something ?
