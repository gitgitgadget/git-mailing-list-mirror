From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/14] tempfile: a new module for handling temporary files
Date: Wed, 10 Jun 2015 14:35:07 -0700
Message-ID: <xmqqfv5zi6wk.fsf@gitster.dls.corp.google.com>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
	<f7681cfc8ee4f1f5eba50f315f8e0ed0fed883a8.1433751986.git.mhagger@alum.mit.edu>
	<xmqqy4jrlb32.fsf@gitster.dls.corp.google.com>
	<5578A486.1070307@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 10 23:35:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2neW-0002fN-Vv
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 23:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbbFJVfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 17:35:10 -0400
Received: from mail-ie0-f193.google.com ([209.85.223.193]:34862 "EHLO
	mail-ie0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbbFJVfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 17:35:09 -0400
Received: by iery20 with SMTP id y20so1523251ier.2
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 14:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=speaCsIq7LBmX7AdM5jwwvh3SYqqgmcFnaJUHq+U1Xc=;
        b=HGyoDo/aZVsDa0IUbRTI5w1rKC2bubaFDs4OhMqvPK6m22tjdu3ZgPC/5vJdr1HW+/
         g5DvBNboM5GJETEP8DbD2Mt8KH08SRIXwnThwCxBlt8IQxA/XfcA4ZgghyC7Ggvf8mOe
         5j6DltlrEv6eQDt6+uBzVKPf+j9xayP3uV3djf2RIQYhbKVZQITBZWTUnLXDuNPsuWOe
         ARs+PZiokQ77aaNrgr2ClJXqr7auQCTpDkDutsQ8caPqsafDswZ5AHTVGji+hhFRT6qS
         WXzGeGXJ44F8WYi54PS3vMPe8Vy1c6+q1NvIfOuBOxC7x3x6w+taXqkhn+lfdWt0MyJv
         016A==
X-Received: by 10.107.12.27 with SMTP id w27mr7283440ioi.10.1433972108950;
        Wed, 10 Jun 2015 14:35:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id q78sm6809201ioe.9.2015.06.10.14.35.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 14:35:08 -0700 (PDT)
In-Reply-To: <5578A486.1070307@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 10 Jun 2015 22:56:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271358>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 06/10/2015 07:36 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>>> diff --git a/builtin/add.c b/builtin/add.c
>>> index df5135b..aaa9ce4 100644
>>> --- a/builtin/add.c
>>> +++ b/builtin/add.c
>>> @@ -5,6 +5,7 @@
>>>   */
>>>  #include "cache.h"
>>>  #include "builtin.h"
>>> +#include "tempfile.h"
>>>  #include "lockfile.h"
>>>  #include "dir.h"
>>>  #include "pathspec.h"
>> 
>> It is a bit sad that all users of lockfile.h has to include
>> tempfile.h; even when trying to find out something as basic as the
>> name of the file on which the lock is held, they need to look at
>> lk->tempfile.filename and that requires inclusion of tempfile.h
> ...
> Hmmm, currently lockfile.h doesn't include tempfile.h. But I think it is
> a good idea for it to do so. (I would have done it already but I thought
> it was against project policy.)

The project policy is "include what you use, do not rely on others
that happen include what you use" with a minor exception for the
"must be the first" headers git-compat-util.h (which cache.h and
friends include), I think.

If it does not include tempfile.h itself, lockfile.h would be at the
mercy of the *.c file that includes it to be able to see the struct
it uses; if *.c does not include tempfile.h before lockfile.h, it
would break.
