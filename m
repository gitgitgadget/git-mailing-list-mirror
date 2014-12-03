From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/14] hold_lock_file_for_append: pass error message back
 through a strbuf
Date: Tue, 2 Dec 2014 23:04:11 -0800
Message-ID: <20141203070411.GA24344@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051459.GN6527@google.com>
 <547EA918.30003@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 03 08:04:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw3z5-0004in-IW
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 08:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbaLCHET convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Dec 2014 02:04:19 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:57204 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbaLCHES (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 02:04:18 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so12282964igb.5
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 23:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E7sa1mXKSEhCdiee+q1QEdD6beN10iwBPYekT7Nu09o=;
        b=iUQkrE/F/Vbfrq8AoFOeYTL8MqDXvnAjvx1h71Dg03C+GB+urMg8j3bFoj4dVBBRF+
         2bCGGJkhtBwGEh2JsJlGdnEnWnh1FyGopN+0SyMxUp6zUAv1clIbunK1cFVnmX7wxDr5
         5t2mtJ79wruSmeHRWDMP7N2gKyWdaHBEMvC80jkJ3liQEC8rIMdXXImxI0l4oWKkRjM0
         mU38RJEg5YruGkR3w/mn+R546/uKGxTyrLfYX6DsXH7knLuf7Vh9YtPsKKUUSSFcCZHD
         kqy8+Mmq22H+t2MoV9S0HKXj7cgDQpYNgq2pixXvLj7VOxamGcw7SQhahFzKBHnw58SF
         TVDg==
X-Received: by 10.107.41.148 with SMTP id p142mr3143256iop.64.1417590257834;
        Tue, 02 Dec 2014 23:04:17 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id lo1sm3546289igb.8.2014.12.02.23.04.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 23:04:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <547EA918.30003@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260640>

Torsten B=F6gershausen wrote:
> On 12/03/2014 06:14 AM, Jonathan Nieder wrote:

>> --- a/lockfile.c
>> +++ b/lockfile.c
>> @@ -179,45 +179,36 @@ int hold_lock_file_for_update(struct lock_file=
 *lk, const char *path, int flags)
>>   	return fd;
>>   }
>> -int hold_lock_file_for_append(struct lock_file *lk, const char *pat=
h, int flags)
>> +int hold_lock_file_for_append(struct lock_file *lk, const char *pat=
h,
>> +			      int flags, struct strbuf *err)
>>   {
>>   	int fd, orig_fd;
>> -	struct strbuf err =3D STRBUF_INIT;
>> +
>> +	assert(!(flags & LOCK_DIE_ON_ERROR));
>> +	assert(err && !err->len);
>
> What do I miss ?
> In the old code we die() printing the errno when LOCK_DIE_ON_ERRORis =
set.

The assertion documents an assumption that no caller will set the
LOCK_DIE_ON_ERROR flag bit.  A later patch in the series eliminates
that flag bit completely.

> Now we die() in an assert() or two ?

assert() is not safe to use for anything other than documenting
assumptions.  It can't be relied on to exit (let alone to exit with a
nice message like die()).  So the die() that was removed and assert()
that this patch adds have different purposes.

> And should'nt we assert in  strbuf_addf() instead ?

strbuf_addf can be used to append to a nonempty strbuf.

[...]
> (Unless it will be used in later commit, and the we could mention it =
here)

Good idea.  I'll add to the commit message if rerolling.

Thanks,
Jonathan
