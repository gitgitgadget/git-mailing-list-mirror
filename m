From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP v3 07/31] am: extract patch, message and authorship with git-mailinfo
Date: Fri, 19 Jun 2015 09:13:00 -0700
Message-ID: <xmqq1th7brsj.fsf@gitster.dls.corp.google.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-8-git-send-email-pyokagan@gmail.com>
	<xmqqtwu4d8pg.fsf@gitster.dls.corp.google.com>
	<CACRoPnS9eyBF5NEM7sKvep+A8aKUNLJDaV-1c_oWDBwMcv26Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 18:13:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5yuk-00013L-PJ
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 18:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754299AbbFSQNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 12:13:07 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34542 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbbFSQND (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 12:13:03 -0400
Received: by iebmu5 with SMTP id mu5so77869058ieb.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 09:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4/xAZAA1Pfek9OILGIjuQfp0iajPPr4Xl3uDUFDZwik=;
        b=st2NFSKnmMwhJksQxmhx3uXNYQjQDwBb4lIRtw4gQ5owOVUqy2yCuGMNQAdbsSovhP
         cblJZrQnSD2BJUhpcJgQwdInXfeLNYqv6azJZuV6AyqKFXYa57iivqTVPQtEcvWFipx4
         8AXPflp56ndYY0TJ3m8pEnWTQ8LiKeuMyKa9LiqS3IcX0VuLKvSwlgyiQ+FuulgOLl5Z
         dZDnYKRx00NtKP7BpzDdW581QxFSTqxSUbmtR4UF0FhFZ7lYuYuNa93lXz5uq5tKZRtQ
         9HIAagvl2QbCVHywoVC2gB0Ve2inV2yQRccSr0UuiOVdcQVqhe4LiJP9rkoI65BsJCUT
         /uOw==
X-Received: by 10.50.112.73 with SMTP id io9mr5678288igb.18.1434730382518;
        Fri, 19 Jun 2015 09:13:02 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id p39sm7288612ioi.5.2015.06.19.09.13.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 09:13:01 -0700 (PDT)
In-Reply-To: <CACRoPnS9eyBF5NEM7sKvep+A8aKUNLJDaV-1c_oWDBwMcv26Bg@mail.gmail.com>
	(Paul Tan's message of "Fri, 19 Jun 2015 17:22:11 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272164>

Paul Tan <pyokagan@gmail.com> writes:

> On Fri, Jun 19, 2015 at 5:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Paul Tan <pyokagan@gmail.com> writes:
>>
>>> +     /* commit message and metadata */
>>> +     struct strbuf author_name;
>>> +     struct strbuf author_email;
>>> +     struct strbuf author_date;
>>> +     struct strbuf msg;
>>
>> Same comment as "dir" in the earlier patch applies to these.  If the
>> fields are read or computed and then kept constant, use a temporary
>> variable that is a strbuf to read/compute the final value, and then
>> detach to a "const char *" field.  If they are constantly changing
>> and in-place updates are vital, then they can and should be strbufs,
>> but I do not think that is the case for these.
>
> I do think it is the case here. The commit message and metadata fields
> change for every patch we process, and we could be processing a large
> volume of patches, so we must be careful to not leak any memory.

With the above fields, it is clear that the above fields are
per-message thing.  So the loop to process multiple messages is
conceptually:


	set up the entire am_state (for things like cur=1, last=N)
        for each message {
		update per-message fields like cur, author, msg, etc.
		process the single message
                clean up per-message fileds like cur++, free(msg), etc.
	}
	tear down the entire am_state

Reusing the same strbuf and rely on them to clean up after
themselves is simply a bad taste.

More importantly, we'd want to make sure that people who will be
touching the "process the single message" part in the above loop to
think twice before mucking with read-only fields like author.

If they are "char *", they would need to allocate new storage
themselves, format a new value into there, free the original, and
replace the field with the new value.  It takes a conscious effort
and very much visible code and would be clear to reviewers what is
going on, and gives them a chance to question if it is a good idea
to update things in-place in the first place.

If you left it in strbuf, that invites "let's extend it temporarily
with strbuf_add() and then return to the original once I am done
with this single step", which is an entry to a slippery slope to
"let's extend it with strbuf_add() for my purpose, and I do not even
bother to clean up because I know I am the last person to touch
this".

So, no, please don't leave a field that won't change during the bulk
of the processing in strbuf, unless you have a compelling reason to
do so (and "compelling reasons" are pretty much limited to "after
all, that field we originally thought it won't change is something
we need to change very often").

Thanks.
