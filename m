From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 07/23] expire_reflog(): use a lock_file for rewriting
 the reflog file
Date: Mon, 08 Dec 2014 15:05:45 +0100
Message-ID: <5485B039.1070200@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu> <1417734515-11812-8-git-send-email-mhagger@alum.mit.edu> <20141205002331.GJ16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 15:06:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxyx0-0002iW-50
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 15:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755715AbaLHOGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 09:06:03 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63091 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755708AbaLHOGA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 09:06:00 -0500
X-AuditID: 1207440d-f79976d000005643-f0-5485b03bb5d5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 15.75.22083.B30B5845; Mon,  8 Dec 2014 09:05:47 -0500 (EST)
Received: from [192.168.69.130] (p5DDB0B15.dip0.t-ipconnect.de [93.219.11.21])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB8E5jWe009876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 8 Dec 2014 09:05:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <20141205002331.GJ16345@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqGu9oTXEYMYydYuuK91MFg29V5gt
	3t5cwmjR2/eJ1WLz5nYWB1aPnbPusnss2FTqcfGSssfnTXIBLFHcNkmJJWXBmel5+nYJ3Bld
	7ZOZCpr0K2bffs/cwDhTtYuRk0NCwERi4rorjBC2mMSFe+vZuhi5OIQELjNK7Og9CuWcZZJY
	snImM0gVr4C2xOP/W8FsFgFViSVN21hAbDYBXYlFPc1MILaoQJDEyT3X2SHqBSVOznwCViMi
	oCHx/NM3sKHMAlMYJQ5++8cGkhAWiJa486OZFWLbQkaJA8vfsoIkOAUMJFYtWAk2iVlAT2LH
	9V+sELa8RPPW2cwTGAVmIVkyC0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGunl
	ZpbopaaUbmKEBDfvDsb/62QOMQpwMCrx8C540BIixJpYVlyZe4hRkoNJSZT34OLWECG+pPyU
	yozE4oz4otKc1OJDjBIczEoivIlxQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILU
	IpisDAeHkgTv33VAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgeI0vBkYsSIoH
	aC/zepC9xQWJuUBRiNZTjIpS4rwtIHMFQBIZpXlwY2Ep6xWjONCXwrzhIO08wHQH1/0KaDAT
	0OAXiWCDSxIRUlINjNOitzV9uBn/8SH73f+rVi5i3Xwus6oyr1fvom7aEoH6XRpu3m+Snk7e
	XNHjLb6sVmH/XYudbJvvXchinLbEecNh1hz7yXvWzVPPOvf6wYHF9xh4WM8x3i+o 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261043>

On 12/05/2014 01:23 AM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> We don't actually need the locking functionality, because we already
>> hold the lock on the reference itself, which is how the reflog file is
>> locked. But the lock_file code still does some of the bookkeeping for
>> us and is more careful than the old code here was.
> 
> As you say, the ref lock takes care of mutual exclusion, so we do not
> have to be too careful about compatibility with other tools that might
> not know to lock the reflog.  And this is not tying our hands for a
> future when I might want to lock logs/refs/heads/topic/1 while
> logs/refs/heads/topic still exists as part of the implementation of
> "git mv topic/1 topic".
> 
> Stefan and I had forgotten about that guarantee when looking at that
> kind of operation --- thanks for the reminder.

This reminder is important (and forgettable) enough that I will add a
comment within the function explaining it.

> Should updates to the HEAD reflog acquire HEAD.lock?  (They don't
> currently.)

Yes, they should; good catch. I assume that you are referring to the
code at the bottom of write_ref_sha1()? Or did you find a problem in
this patch series?

If the former, then I propose that we address this bug in a separate
patch series.

> [...]
>> --- a/builtin/reflog.c
>> +++ b/builtin/reflog.c
>> @@ -349,12 +349,14 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1, int
>>  	return 0;
>>  }
>>  
>> +static struct lock_file reflog_lock;
> 
> If this lockfile is only used in that one function, it can be declared
> inside the function.
> 
> If it is meant to be used throughout the 'git reflog' command, then it
> can go near the top of the file.

For now it is only used within this function, so I will move it into the
function as you suggest. (As you know, it does need to remain static,
because of the way the lock_file module takes over ownership of these
objects.)

>> +
>>  static int expire_reflog(const char *refname, const unsigned char *sha1, void *cb_data)
>>  {
>>  	struct cmd_reflog_expire_cb *cmd = cb_data;
>>  	struct expire_reflog_cb cb;
>>  	struct ref_lock *lock;
>> -	char *log_file, *newlog_path = NULL;
>> +	char *log_file;
>>  	struct commit *tip_commit;
>>  	struct commit_list *tips;
>>  	int status = 0;
>> @@ -372,10 +374,14 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
>>  		unlock_ref(lock);
>>  		return 0;
>>  	}
>> +
>>  	log_file = git_pathdup("logs/%s", refname);
>>  	if (!cmd->dry_run) {
>> -		newlog_path = git_pathdup("logs/%s.lock", refname);
>> -		cb.newlog = fopen(newlog_path, "w");
>> +		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0)
>> +			goto failure;
> 
> hold_lock_file_for_update doesn't print a message.  Code to print one
> looks like
> 
> 	if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0) {
> 		unable_to_lock_message(log_file, errno, &err);
> 		error("%s", err.buf);
> 		goto failure;
> 	}

Thanks; will add.

> (A patch in flight changes that to
> 
> 	if (hold_lock_file_for_update(&reflog_lock, log_file, 0, &err) < 0) {
> 		error("%s", err.buf);
> 		goto failure;
> 	}
> 
> )

Thanks for the heads-up. The compiler will complain when the branches
are merged, and hopefully the fix will be obvious.

>> +		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
>> +		if (!cb.newlog)
>> +			goto failure;
> 
> Hm.  lockfile.c::fdopen_lock_file ought to use xfdopen to make this
> case impossible.  And xfdopen should use try_to_free_routine() and
> try again on failure.

That sounds reasonable, but it is not manifestly obvious given that at
least one caller of fdopen_lock_file() (in fast-import.c) tries to
recover if fdopen_lock_file() fails. Let's address this in a separate
patch series if that is OK with you. For now I will add explicit
error-reporting code here before "goto failure".

> [...]
>> @@ -423,10 +429,9 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
>>  	}
>>  
>>  	if (cb.newlog) {
>> -		if (fclose(cb.newlog)) {
>> -			status |= error("%s: %s", strerror(errno),
>> -					newlog_path);
>> -			unlink(newlog_path);
>> +		if (close_lock_file(&reflog_lock)) {
>> +			status |= error("Couldn't write %s: %s", log_file,
>> +					strerror(errno));
> 
> Style nit: error messages usually start with a lowercase letter
> (though I realize nearby examples are already inconsistent).

Thanks; will fix.

> commit_lock_file() can take care of the close_lock_file automatically.

The existing code is a tiny bit safer: first make sure both files can be
written, *then* rename each of them into place. If either write fails,
then both files will get rolled back. But if we switch to using
commit_lock_file(), then a failure when writing the reference would
leave the reflog updated but the reference rolled back.

> [...]
>> @@ -434,21 +439,23 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
>>  			 close_ref(lock) < 0)) {
>>  			status |= error("Couldn't write %s",
>>  					lock->lk->filename.buf);
>> -			unlink(newlog_path);
>> -		} else if (rename(newlog_path, log_file)) {
>> -			status |= error("cannot rename %s to %s",
>> -					newlog_path, log_file);
>> -			unlink(newlog_path);
>> +			rollback_lock_file(&reflog_lock);
>> +		} else if (commit_lock_file(&reflog_lock)) {
>> +			status |= error("cannot rename %s.lock to %s",
>> +					log_file, log_file);
> 
> Most callers say "unable to commit reflog '%s'", log_file to hedge their
> bets in case the close failed (which may be what you were avoiding
> above.
> 
> errno is meaningful when commit_lock_file fails, making a more
> detailed diagnosis from strerror(errno) possible.

I will improve the error message.

Thanks for your detailed review!
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
