From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/WIP PATCH 11/11] Document protocol version 2
Date: Fri, 29 May 2015 14:52:14 -0700
Message-ID: <xmqqk2vraw6p.fsf@gitster.dls.corp.google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-12-git-send-email-sbeller@google.com>
	<xmqqsiafazr7.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbELvZ6otnNwGHsgiC9EjgS2vrDGU2KCgF2c_Azm=-rWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 29 23:52:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YySCU-000522-GG
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 23:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757297AbbE2VwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 17:52:18 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38157 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757028AbbE2VwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 17:52:16 -0400
Received: by igbjd9 with SMTP id jd9so24750813igb.1
        for <git@vger.kernel.org>; Fri, 29 May 2015 14:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=sXaMD0dd79KIBbqFJOoQRjOcAVftn4K2W9Lx5FongQs=;
        b=bgYKEdqFMvUiNYibSSTY9+npq28AEkcRntzAMRR1Co9ad4RSKp2HNRdimZEgqgZv1W
         /UUfRoQh8cFy5pyz4bTCtai3d1pk/dQzWN4gVgvT6ChNkVi3uTCaFx+vwNmCTdVlsAH9
         Gv9uRVxF4bM8U/DEAcdgpP9y74Z0xZNXaJKy8i3eW2ooX7UZGvaGVS/GT2MSyWqdL53M
         bAKOTFLmsQej8bsNAoZZDAEz58aOTu/ytBXKUHq2zTQvSiUptp3cjD9IDoyRLk3V6OU3
         /qeIKNxKly48lcJnPY3B+IRuZV93OsuG2vlBrJrc7E1GA+yh0khdXLUsAJMkPgsQkSR6
         9gow==
X-Received: by 10.107.3.210 with SMTP id e79mr12981247ioi.50.1432936336281;
        Fri, 29 May 2015 14:52:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d9c8:419b:acd5:cf1d])
        by mx.google.com with ESMTPSA id w4sm2410088igl.22.2015.05.29.14.52.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 14:52:15 -0700 (PDT)
In-Reply-To: <CAGZ79kbELvZ6otnNwGHsgiC9EjgS2vrDGU2KCgF2c_Azm=-rWg@mail.gmail.com>
	(Stefan Beller's message of "Fri, 29 May 2015 14:36:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270274>

Stefan Beller <sbeller@google.com> writes:

>>> +Capability discovery (v2)
>>> +-------------------------
>>> ...
>>> +  capability-list  =  *(capability) [agent LF] flush-pkt
>>> +  capability       =  PKT-LINE("capability:" keyvaluepair LF)
>>> +  agent            =  keyvaluepair LF
>>> +  keyvaluepair     =  1*(LC_ALPHA / DIGIT / "-" / "_" / "=")
>>
>> What is the "=" doing there?  If you meant to cover things like
>> "lang=en" with this, I do not think it is a good idea.  Rather, it
>> should be more like this:
>>
>>         capability = 1*(LC_ALPHA / DIGIT / "-" / "_") [ "=" value ]
>>         value = 0*( any octet other than LF, NUL )
>>
>> in order to leave us wiggle room to have more than very limited
>> subset of US-ASCII in 'value'.  I suspect that we may want to allow
>> anything other than LF (unlike v1 that allowed anything other than
>> SP and LF).
>
> Currently we can do a = as part of the line after the first ref, such as
>
>     symref=HEAD:refs/heads/master agent=git/2:2.4.0
>
> so I thought we want to keep this.

I do not understand that statement.

Capability exchange in v2 is one packet per cap, so the above
example would be expressed as:

	symref=HEAD:refs/heads/master
        agent=git/2:2.4.0

right?  Your "keyvaluepair" is limited to [a-z0-9-_=]*, and neither
of the above two can be expressed with that, which was why I said
you need two different set of characters before and after "=".  Left
hand side of "=" is tightly limited and that is OK.  Right hand side
may contain characters like ':', '.' and '/', so your alphabet need
to be more lenient, even in v1 (which I would imagine would be "any
octet other than SP, LF and NUL").
