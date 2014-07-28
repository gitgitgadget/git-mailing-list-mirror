From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/5] refs.c: allow passing raw git_committer_info as email
 to _update_reflog
Date: Mon, 28 Jul 2014 19:39:55 -0400
Message-ID: <CAPig+cRWanM7fUR-fJ7r-zTrTj5jbkKik0=12WOiNGrWwA-JNw@mail.gmail.com>
References: <1406307521-10339-1-git-send-email-sahlberg@google.com>
	<1406307521-10339-2-git-send-email-sahlberg@google.com>
	<20140725193728.GG12427@google.com>
	<CAL=YDWmSKBnjXiBUJjOb-+M7R8d==mMsN11DjDTDxU2+WAh+vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 01:40:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuWP-0004Uf-Ci
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbaG1Xj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:39:57 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:48500 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbaG1Xj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:39:56 -0400
Received: by mail-yh0-f43.google.com with SMTP id 29so5335046yhl.30
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FmDga6GpTY6P1urNbsm+rJd2y67P22+wAYS79QWylpU=;
        b=fTJeA7VjuJzcsoPlwO06kYdN8r5dDLMfC+NPSjwA221sFVkWoUml8zfmBCcHaoeqWP
         1V+kuTA7awFs1oNFNbu68cz7BD3Na7BKUhYIa5PmqrzTeO+h0zW5yatHOC1qBlCXDm3T
         y3nRTYg7JEG1IG/bpIaCpCM2TA+ytnedAdbVmOfzxskVQ1HP5snX6kj8p70OEHfhJ+qW
         Xa5iNBds7C57AqnmJkiD+gwaNgyTdEgoxJxx+4iXqipcTfxsYgbSsVVEO1GvZ2mrCf+K
         GYBxbZ/av6ySAVhOLvGoiMc7NXgItTE/PW3R61KkjmnxHyIsAPaxt/PNlHZfnBRFCzAF
         oVjQ==
X-Received: by 10.236.185.132 with SMTP id u4mr45453663yhm.95.1406590795901;
 Mon, 28 Jul 2014 16:39:55 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Mon, 28 Jul 2014 16:39:55 -0700 (PDT)
In-Reply-To: <CAL=YDWmSKBnjXiBUJjOb-+M7R8d==mMsN11DjDTDxU2+WAh+vQ@mail.gmail.com>
X-Google-Sender-Auth: BV8c5rsCQF6ZP_U_10-pLxhvE2o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254382>

On Mon, Jul 28, 2014 at 2:01 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> On Fri, Jul 25, 2014 at 12:37 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Ronnie Sahlberg wrote:
>>>  /*
>>>   * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
>>>   * this update will first truncate the reflog before writing the entry.
>>>   * If msg is NULL no update will be written to the log.
>>>   */
>>>  int transaction_update_reflog(struct ref_transaction *transaction,
>>>                                const char *refname,
>>>                                const unsigned char *new_sha1,
>>>                                const unsigned char *old_sha1,
>>>                                const char *email,
>>>                                unsigned long timestamp, int tz,
>>>                                const char *msg, int flags,
>>>                                struct strbuf *err);
>>
>> This is a lot of parameters, some optional, not all documented.  Would
>> it make sense to pack some into a struct?
>
> I changed email,timestamp,tz into a struct
> /*
>  * Committer data provided to reflog updates.
>  * If flags contain REFLOG_COMMITTER_DATA_IS_VALID then
>  * then the structure contains a prebaked committer string

s/then then/then/

>  * just like git_committer_info() would return.
>  *
>  * If flags does not contain REFLOG_COMMITTER_DATA_IS_VALID
>  * then the committer info string will be generated using the passed
>  * email, timestamp and tz fields.
>  * This is useful for example from reflog iterators where you are passed
>  * these fields individually and not as a prebaked git_committer_info()
>  * string.
>  */
> struct reflog_committer_info {
> const char *committer_info;
>
> const char *id;
> unsigned long timestamp;
> int tz;
> };
>
>>
>> Thanks and hope that helps,
>> Jonathan
