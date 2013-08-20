From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 10/24] make sure partially read index is not changed
Date: Tue, 20 Aug 2013 10:46:20 +0200
Message-ID: <87ioz0iwbn.fsf@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com> <1376854933-31241-11-git-send-email-t.gummerer@gmail.com> <CAPig+cTJQrVm+r77utWzduU3KqC5WPX_b4Vbvxyjezd0Wc4LZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 10:46:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBhaB-00083P-9a
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 10:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320Ab3HTIq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 04:46:26 -0400
Received: from mail-ea0-f169.google.com ([209.85.215.169]:53455 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab3HTIqY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 04:46:24 -0400
Received: by mail-ea0-f169.google.com with SMTP id k11so69907eaj.0
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 01:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=1b7GEyhAPcT4vlQ5IypgP4vCgu5bj42E/9ud1tl89rs=;
        b=R2NAd1ri62r3LI888R5grXEM0pvp01F/FSokAwNI7QxcGFHwK37iyCywirtmzbtVL7
         v2j+N++oXNHhZetinQSL0MfvsMyVu2fjJxNQ7eXT9FcC3/nzca5m9ReCoC366+X6Dnm4
         fXoeviafu4s78ad4CQKQ06UR/ahyCFdZ64QhzVBTGUb4rQDbPUU1Cxz4i9L2uoheyxrf
         TkcDCcnPEA3dwRfRMPS4/xw1HfZul7ezqe3p5ijbENh9w3V0JzS3Y/sdG0zhTxLJHJLs
         x7y98OT06qvZRFTYukAII1i3WAyBYwfffZUUoLC7Wl5lAg/LX0Uw44j9YvoxOob1rBex
         hkeQ==
X-Received: by 10.14.9.198 with SMTP id 46mr29913eet.82.1376988383630;
        Tue, 20 Aug 2013 01:46:23 -0700 (PDT)
Received: from localhost ([2a02:27e8:10:1047:0:dacb:1376:714a])
        by mx.google.com with ESMTPSA id d8sm755316eeh.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 01:46:22 -0700 (PDT)
In-Reply-To: <CAPig+cTJQrVm+r77utWzduU3KqC5WPX_b4Vbvxyjezd0Wc4LZw@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232590>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Aug 18, 2013 at 3:41 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> A partially read index file currently cannot be written to disk.  Make
>> sure that never happens, by erroring out when a caller tries to write a
>
> s/,//
>
>> partially read index.  Do the same when trying to re-read a partially
>> read index without having discarded it first to avoid loosing any
>
> s/loosing/losing/
>
>> information.
>>
>> Forcing the caller to load the right part of the index file instead of
>> re-reading it when changing it, gives a bit of a performance advantage,
>
> s/it,/it/  (or s/file instead/file, instead/)
> s/advantage,/advantage/
>
>> by avoiding to read parts of the index twice.
>
> /to read/reading/
>
> More below...
>
>>
>> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>> ---
>>  read-cache.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/read-cache.c b/read-cache.c
>> index 38b9a04..7a27f9b 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1332,6 +1332,8 @@ int read_index_filtered_from(struct index_state *istate, const char *path,
>>         void *mmap;
>>         size_t mmap_size;
>>
>> +       if (istate->filter_opts)
>> +               die("BUG: Can't re-read partially read index");
>>         errno = EBUSY;
>>         if (istate->initialized)
>>                 return istate->cache_nr;
>> @@ -1455,6 +1457,8 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
>>
>>  int write_index(struct index_state *istate, int newfd)
>>  {
>> +       if (istate->filter_opts)
>> +               die("BUG: index: cannot write a partially read index");
>
> Consistency nit:
>
> In the preceding hunk, the error message starts "BUG: Can't...", but
> in this hunk we have "BUG: index: cannot...".
>
> So, "BUG:" is the prefix of one, but "BUG: index:" is the prefix of the other.
>
> Spelling difference: "Can't" vs. "cannot".
>
> Capitalization difference: "Can't" vs. "cannot".

Thanks for catching this.  From quick grepping it seems the preferred
version seems to be the one with only "BUG:" as prefix and starting with
a lower case letter after this.  Both can't and cannot are used in the
codebase, but cannot seems to be used more often.  I'll use that.

Will fix this and the rest of the style/spelling/grammar fixes you
suggested.  Thanks.

>>         return istate->ops->write_index(istate, newfd);
>>  }
>>
>> --
>> 1.8.3.4.1231.g9fbf354.dirty
>>
