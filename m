From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 23/35] lockfile: avoid transitory invalid states
Date: Tue, 23 Sep 2014 15:40:33 +0200
Message-ID: <54217851.6020209@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu> <1410896036-12750-24-git-send-email-mhagger@alum.mit.edu> <20140916224523.GW29050@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 15:40:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWQKf-0008GK-M5
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 15:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755762AbaIWNkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 09:40:37 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:43790 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751688AbaIWNkh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Sep 2014 09:40:37 -0400
X-AuditID: 12074413-f79ed6d000002501-ab-54217854a072
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id A6.C7.09473.45871245; Tue, 23 Sep 2014 09:40:36 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1DCD.dip0.t-ipconnect.de [93.219.29.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8NDeXtF022125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 23 Sep 2014 09:40:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20140916224523.GW29050@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsUixO6iqBtSoRhicOO4kEXXlW4mi4beK8wW
	T+beZbZ4e3MJo8WPlh5mi38Taiw6O74yOrB77Jx1l91jwaZSj4evutg9nvXuYfS4eEnZ4/Mm
	OY/bz7axBLBHcdskJZaUBWem5+nbJXBn3H56mqXgjmTFqoP6DYyLRboYOTkkBEwkFjauZYWw
	xSQu3FvP1sXIxSEkcJlR4uXKa+wQznkmiZ4LV9lAqngFtCWezpnI0sXIwcEioCpxeLcJSJhN
	QFdiUU8zE4gtKhAg8aHzASNEuaDEyZlPWEBsEQENieefvoEtYBb4yCgx9/pJsM3CAu4Scxes
	YYRYtohRYva3nWDLOAUMJN6c3gs2lVlAT2LH9V+sELa8RPPW2cwTGAVmIVkyC0nZLCRlCxiZ
	VzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmuvlZpbopaaUbmKERILwDsZdJ+UOMQpwMCrx8Hqs
	UQgRYk0sK67MPcQoycGkJMqbX6oYIsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEVywDKMebklhZ
	lVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuD9XAbUKFiUmp5akZaZU4KQZuLg
	BBnOJSVSnJqXklqUWFqSEQ+K1fhiYLSCpHiA9j4EaectLkjMBYpCtJ5i1OVY1/mtn0mIJS8/
	L1VKnPc2SJEASFFGaR7cCljae8UoDvSxMK9JOVAVDzBlwk16BbSECWjJ/ePyIEtKEhFSUg2M
	YpUGwp5/Fnhynrz9u+2vzo0o3YnbjPqZ+o/7FTYqREe6J3pVdwUfO6q6vij3jMv9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257419>

On 09/17/2014 12:45 AM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> We could probably continue to use the filename field to encode the
>> state by being careful to write characters 1..N-1 of the filename
>> first, and then overwrite the NUL at filename[0] with the first
>> character of the filename, but that would be awkward and error-prone.
>>
>> So, instead of using the filename field to determine whether the
>> lock_file object is active, add a new field "lock_file::active" for
>> this purpose.
> 
> Nice.
> 
> [...]
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -576,6 +576,7 @@ extern int refresh_index(struct index_state *, unsigned int flags, const struct
>>  
>>  struct lock_file {
>>  	struct lock_file *next;
>> +	volatile sig_atomic_t active;
>>  	int fd;
>>  	pid_t owner;
>>  	char on_list;
> [...]
>> +++ b/lockfile.c
>> @@ -27,16 +27,19 @@
> [...]
>> @@ -189,9 +198,14 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>>  		atexit(remove_lock_file);
>>  	}
>>  
>> +	if (lk->active)
>> +		die("BUG: lock_file(\"%s\") called with an active lock_file object",
>> +		    path);
> 
> The error message doesn't make it entirely obvious to me what went
> wrong.
> 
> Maybe something like
> 
> 		die("BUG: cannot lock_file(\"%s\") on active struct lock_file",
> 		    path);

This is an internal sanity check that users should never see, and if
they do the first thing a developer will do is grep the source code for
the error message in the bug report and then he/she will see exactly
what went wrong. So I don't think it is very important that this error
message be super self-explanatory.

But it doesn't hurt, so I'll make the change you suggest.

> lock_file already assumed on_list was initialized to zero but it
> wasn't particularly obvious since everything else is blindly
> scribbled over.  Probably worth mentioning in the API docs that
> the lock_file should be zeroed before calling hold_lock_file_...

Good point. I will document this better.

> [...]
>> @@ -326,6 +341,7 @@ int commit_lock_file(struct lock_file *lk)
>>  	if (rename(lk->filename, result_file))
>>  		goto rollback;
>>  
>> +	lk->active = 0;
>>  	lk->filename[0] = 0;
> 
> Is it useful to set filename[0] any more?
> 
> It seems potentially fragile to set both, since new code can appear
> that only sets or checks one or the other.  Would it make sense to
> rename the filename field to make sure no new callers relying on the
> filename[0] convention sneak in (with the new convention being that
> the filename doesn't get cleared, to avoid problems)?

I admit that nobody should be relying on filename being cleared anymore.
And I can see your point that somebody might come to rely on this
implementation detail. But I don't like leaving valid filenames around
where a bug might cause them to be accessed accidentally. I would rather
set the filename to the empty string so that any attempt to use it
causes an immediate error message from the OS rather than accessing the
wrong file.

I will note in the lock_file docstring that client code should not rely
on the filename being empty when in the 'unlocked' state.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
