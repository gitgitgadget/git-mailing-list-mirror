From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v3] merge: fix cache_entry use-after-free
Date: Thu, 15 Oct 2015 22:38:43 +0200
Message-ID: <56200ED3.9000401@web.de>
References: <1444860424-8361-1-git-send-email-dturner@twopensource.com>
 <561F1EE5.5070300@web.de> <1444935764.20887.1.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Keith McGuigan <kmcguigan@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 22:39:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmpIg-0008PP-Hs
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 22:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbbJOUix convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Oct 2015 16:38:53 -0400
Received: from mout.web.de ([212.227.15.3]:62152 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244AbbJOUiw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 16:38:52 -0400
Received: from [192.168.178.36] ([79.253.191.204]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MEER6-1ZkfZa2Cs4-00FSaS; Thu, 15 Oct 2015 22:38:50
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1444935764.20887.1.camel@twopensource.com>
X-Provags-ID: V03:K0:XnIydvKNfvTKz+9VShJYTYWQoDyDaJalXxndgHoGvSW3BMjaPmi
 uIOt6CTdag+hutn5sd4qSlMh35XPyLuTcsIjSUEMmlnEmut9a52neCwJ65ptJO56oOlMjPB
 GB47YtOlJMrdwWqZBLzBRcpuflk5LYcgF2EW28qq/BvWMgOolVK1ZZbj4GO0VFhV78yf1PH
 h4tS+Bq9VFlEYFQe3QRWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tXhbE59Hx0Y=:6bSERRoTwxBYh9mCKrdcU+
 A9ETB1MhfeTqUQIyIweIUwBdcsCrmHSt3iaRJ3OvVic/O+v9Wjbl5XX0aa+zJ67iDKXoIcZix
 q4jZMVOId1PcEJdkUxtRsxwM2tlgGnisefe7IClHjn+vrsFQeDd/9bfYOw/CZAJtJOn5EcZz2
 g+Kd9SzO4jiqLutRQp40XomeRf0FXz0lBckIoDXoTzB71633yz7GsfDByA9FdErtAt/fZAcdt
 8DFAXMc79Z1yiMqbPztrM8xkl5ISWDoV7zutFb0y5a+OWpgp4ZWdnC5aRsW9XRODHUpY6XVsB
 W4lEyA7Sh0byXfM75Er8Zhz6tKLBXY+pFqATiEVYoC21Yk2A7wclMvjGz+mtviL1jwvOxYwjI
 tzdcabWSDaDlzgT9TEvd/Fy59iimN6v1pLraNPvPAAjh2Razev2Hue9CoXF51qyJ8yN14Mr4m
 q1cCmqsARjzdV5Kh/qujH+yHBB7HrFmUX/T07WWMU0q3Z/8W8wri4r2GD2c7/sEcL6HAiPhxH
 8kakhFHTT/7d96v4zE37TWqeAycZR6VZrs4+P3G9dsycXQ7hNZrfP3GO4CYWknLKoORAko/V5
 B8LHOuSuMhCIa6Ru0LcOobC8K8SoJ5AiiAyc3SromsoQqhOkZ8i0FVkpuNyz7gGqlhfCACo6A
 yaQzN3kHrHdOdn4aH+hyMHF03j4dvUaecSPqMJKyv7FeEf6JfAkGFXuJIYQELZsSfSF2kZmy/
 OgX/uus6eKEVLSQojWgs6XnZKWhHV9/Yhj9F02dmg1AVbkIM9+t+lyeXjInd19OysWKS0aGy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279708>

Am 15.10.2015 um 21:02 schrieb David Turner:
> On Thu, 2015-10-15 at 05:35 +0200, Ren=C3=A9 Scharfe wrote:
>> Am 15.10.2015 um 00:07 schrieb David Turner:
>>> From: Keith McGuigan <kmcguigan@twitter.com>
>>>
>>> During merges, we would previously free entries that we no longer n=
eed
>>> in the destination index.  But those entries might also be stored i=
n
>>> the dir_entry cache, and when a later call to add_to_index found th=
em,
>>> they would be used after being freed.
>>>
>>> To prevent this, add a ref count for struct cache_entry.  Whenever
>>> a cache entry is added to a data structure, the ref count is increm=
ented;
>>> when it is removed from the data structure, it is decremented.  Whe=
n
>>> it hits zero, the cache_entry is freed.
>>>
>>> Signed-off-by: Keith McGuigan <kmcguigan@twitter.com>
>>> Signed-off-by: David Turner <dturner@twopensource.com>
>>> ---
>>>
>>> Fix type of ref_count (from unsigned int to int).
>>>
>>>
>>>    cache.h        | 27 +++++++++++++++++++++++++++
>>>    name-hash.c    |  7 ++++++-
>>>    read-cache.c   |  6 +++++-
>>>    split-index.c  | 13 ++++++++-----
>>>    unpack-trees.c |  6 ++++--
>>>    5 files changed, 50 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/cache.h b/cache.h
>>> index 752031e..7906026 100644
>>> --- a/cache.h
>>> +++ b/cache.h
>>> @@ -149,6 +149,7 @@ struct stat_data {
>>>
>>>    struct cache_entry {
>>>    	struct hashmap_entry ent;
>>> +	int ref_count; /* count the number of refs to this in dir_hash */
>>>    	struct stat_data ce_stat_data;
>>>    	unsigned int ce_mode;
>>>    	unsigned int ce_flags;
>>> @@ -213,6 +214,32 @@ struct cache_entry {
>>>    struct pathspec;
>>>
>>>    /*
>>> + * Increment the cache_entry reference count.  Should be called
>>> + * whenever a pointer to a cache_entry is retained in a data struc=
ture,
>>> + * thus marking it as alive.
>>> + */
>>> +static inline void add_ce_ref(struct cache_entry *ce)
>>> +{
>>> +	assert(ce !=3D NULL && ce->ref_count >=3D 0);
>>> +	ce->ref_count++;
>>> +}
>>> +
>>> +/*
>>> + * Decrement the cache_entry reference count.  Should be called wh=
enever
>>> + * a pointer to a cache_entry is dropped.  Once the counter drops =
to 0
>>> + * the cache_entry memory will be safely freed.
>>> + */
>>> +static inline void drop_ce_ref(struct cache_entry *ce)
>>> +{
>>> +	if (ce !=3D NULL) {
>>> +		assert(ce->ref_count >=3D 0);
>>
>> Shouldn't this be "> 0" to prevent double frees?
>
> No.  If the ref_count is 1, then there is still some reference to the
> ce.  If it is 0, there is no reference to it, and the next check (< 1=
)
> will succeed and the ce will get freed.
>
>>> +		if (--ce->ref_count < 1) {
>>> +			free(ce);
>>> +		}
>>> +	}
>>> +}

OK, let me think out loud, step by step:

Given ref_count =3D=3D 1 then the assert passes, ref_count gets decreme=
nted=20
to 0, which is less than 1, so ce is freed.

Given ref_count =3D=3D 0 then the assert passes, refcount gets decremen=
ted=20
to -1, which is less than 1, so ce is freed again.

Where did I go wrong?

Ren=C3=A9
