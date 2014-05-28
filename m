From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 06/41] refs.c: add an err argument to
 repack_without_refs
Date: Wed, 28 May 2014 11:30:32 -0700
Message-ID: <20140528183032.GR12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-7-git-send-email-sahlberg@google.com>
 <20140528001117.GH12314@google.com>
 <CAL=YDWnSL2vb2NcpPJnfMaR=p4iQhihyhiowwKXuuA-OiUpmfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 28 20:30:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpica-0000Wf-Cm
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 20:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbaE1Sag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 14:30:36 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:57392 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbaE1Saf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 14:30:35 -0400
Received: by mail-pa0-f41.google.com with SMTP id kx10so1611634pab.0
        for <git@vger.kernel.org>; Wed, 28 May 2014 11:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=g0D5Ezwj3DFTtFJ8jMzlhBOWyDthjPnoqiuBUcgljFY=;
        b=GwadIElQCsovko63VsZgcYHpLHeOjRM8o5kCGKz4m1peHy6bIayexxWO6wqGGK5Hp7
         Y+GFRwdmfC7+Nv/evg09ukgLGDi7N1AREu51SLw/Qr29e2Y4CqZWtTime1AHA51ns3fN
         1/aBC4mwRWXuMmwJGnfmKlbE7kZYdIZnnHbvnV2/TSYqaOL4+wRprfrKdwx/+CZ3qur6
         BsQcnmgbYVl7u/qgKZoMWVNzbt1JHHdOUwwyTG1kmeoqD40zyAc77mecGxREURXax/su
         7EJ47JflYf7fHJYgiPhqzwr7o0XWqOZfy6Jw4iS/M+V8rqXh2GGufDIuRytZz3jp2hmQ
         Hggg==
X-Received: by 10.66.162.137 with SMTP id ya9mr1748652pab.31.1401301835236;
        Wed, 28 May 2014 11:30:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id gr10sm29515572pbc.84.2014.05.28.11.30.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 11:30:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL=YDWnSL2vb2NcpPJnfMaR=p4iQhihyhiowwKXuuA-OiUpmfA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250309>

Hi,

Looking at 67b8fcee:

Ronnie Sahlberg wrote:
> On Tue, May 27, 2014 at 5:11 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Ronnie Sahlberg wrote:

>>> --- a/refs.c
>>> +++ b/refs.c
>>> @@ -2208,6 +2208,7 @@ int commit_packed_refs(void)
>>>       struct packed_ref_cache *packed_ref_cache =
>>>               get_packed_ref_cache(&ref_cache);
>>>       int error = 0;
>>> +     int save_errno = 0;
>>
>> This is about making errno meaningful when commit_packed_refs returns
>> an error.  Probably its API documentation should say so to make it
>> obvious when people modify it in the future that they should preserve
>> that property or audit callers.

67b8fcee doesn't address this.  While it's often even better to return
an error message or meaningful error number so the caller doesn't have
to worry about errno at all, I think being explicit in the comment
above a declaration about which functions leave behind a meaningful
errno can make error handling saner.

So I still think that the above would be a good idea.

[...]
>> [...]
>>> @@ -2444,6 +2448,11 @@ static int repack_without_refs(const char **refnames, int n)
>>>               return 0; /* no refname exists in packed refs */
>>>
>>>       if (lock_packed_refs(0)) {
>>> +             if (err) {
>>> +                     unable_to_lock_strbuf(git_path("packed-refs"), errno,
>>> +                                           err);
>>> +                     return -1;
>>> +             }
>>>               unable_to_lock_error(git_path("packed-refs"), errno);
>>
>> Via the new call to unable_to_lock_..., repack_without_refs cares
>> about errno after a failed call to lock_packed_refs.  lock_packed_refs
>> can only fail in hold_lock_file_for_update.  hold_lock_file_for_update
>> is a thin wrapper around lockfile.c::lock_file.  lock_file can error
>> out because
>>
>>         strlen(path) >= max_path_len
[...]
>>                                                            Could be a
>> separate, earlier patch (or a TODO comment in this patch to be
>> addressed with a later patch) since it's fixing an existing bug.
>
> I will add it to my todo list.

My worry with that is that it is too easy to forget that there is a
problem at all.  That's not *that* bad --- if no one remembers, how
serious of a problem was it, really?

Except that it makes reading code difficult.  It's easier to read
some code that prints strerror(errno) in a place that is known to
sometimes have errno==0 if there is a comment

	/*
	 * NEEDSWORK: Tweak lock_packed_refs to either reliably
	 * set errno to a sane value on error or to propagate
	 * back error information another way.
	 */
	perror(...);

Otherwise, the reader has to keep scratching their head, wondering
"how did this ever work?".

That's why I suggested adding a TODO comment.

> I think passing of errno around is too fragile and that we should
> avoid ad-hoc save_errno hacks and implement dedicated return codes to
> replace errno.
> We should only inspect errno immediately after a syscall has failed.

Sure, agreed in principle. ;-)

Thanks,
Jonathan
