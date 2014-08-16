From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: Re: [PATCH] read-cache.c: Ensure unmerged entries are removed
Date: Sat, 16 Aug 2014 16:51:41 +0200
Message-ID: <CAPuZ2NEE0d_5Vj3MSGEJCtFBFOe75Rb+q9fk7q1YC-WcvAMb4A@mail.gmail.com>
References: <1407857491-16633-1-git-send-email-jsorianopastor@gmail.com>
	<1407857491-16633-2-git-send-email-jsorianopastor@gmail.com>
	<xmqq8umt5z8i.fsf@gitster.dls.corp.google.com>
	<CAPuZ2NFcJ5FFeJP=0-oG59fs=3ztenoPOGWOZKfZDdHpLGOYeA@mail.gmail.com>
	<xmqqiolw2dqc.fsf@gitster.dls.corp.google.com>
	<CAPuZ2NFJiUt1p_OfefswS8O8_BA6mQy=PStmYyNw=ABZCOQprQ@mail.gmail.com>
	<xmqqmwb5zatx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 16:52:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIfKr-0000ps-VA
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 16:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbaHPOvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2014 10:51:42 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33964 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbaHPOvl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 10:51:41 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so4900931pdj.16
        for <git@vger.kernel.org>; Sat, 16 Aug 2014 07:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7sVgZRaj4nRZG8dJKWkoY8BP0E22b4P7Zyw33Onj1SM=;
        b=KeL4kUi9ipPY4qhcgJQ3IveXEzQcopdC8ZmjWNIl9DUqEHvmUSqkMXV9u60ZB7YatE
         7AwRRznCcS8jbEbISgJ2+7ASDV1S9qkm0vtqiHVNPNutb8LhCSD7odWQruvKFRFP5o6R
         SDwyOX5nC3Gj3KW22hCcHS3KDw4rfUDAeoFvSznHn2eC73wT8T/5SD7/EVYnQF7rVmFJ
         n7sh6ckoH27dtGTTJq/w6ihE048HLf0Yjhc+XpqEa8KHmjBPK3MgarOAJizj8GyGhMYz
         Lrv9SvTx5I+LrSdJIXcTni6KaP9P5A4jiIcpXe1I83pE4yxpeedYHGxP/C5ERF15soAd
         BfIg==
X-Received: by 10.68.215.67 with SMTP id og3mr4143753pbc.30.1408200701217;
 Sat, 16 Aug 2014 07:51:41 -0700 (PDT)
Received: by 10.70.43.170 with HTTP; Sat, 16 Aug 2014 07:51:41 -0700 (PDT)
In-Reply-To: <xmqqmwb5zatx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255324>

I'd like to add some tests too for this, but I don't know how to
reproduce this state with git commands only, is there any way to add
entries to the index without checkings?
Or maybe it could be done by creating a "test-" command that adds the
entries to an index?

Thanks.

On Fri, Aug 15, 2014 at 11:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:
>
>> On Thu, Aug 14, 2014 at 1:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Being a conservative, I'd rather avoid doing any magic during
>>> read_cache() time. "ls-files -s" for example should show the four
>>> stages so that the "broken" state can be inspected.
>>>
>> Well, only read_cache_unmerged() is modified in the sent patch, so no
>> magic is done in read_cache(), I'd also avoid changes there.
>
> Ahh, I must have overlooked that; changes being only in _unmerged()
> variant makes me feel much better, and it probably would make much
> of ...
>
>>> Yes, it would be more work,...
>
> ... moot, hopefully ;-)
>
>> git reset will clean the index anyway if the loop finishes, would it
>> be ok?
>
> Surely.
>
>> git merge is also affected by the loop in read_cache_unmerged(), but
>> any of the solutions would be enough for it as only by finishing the
>> loop with unmerged entries it will die without commiting the cache to
>> the index file.
>
> Again, true.  The mergy operations want to start from a clean slate
> and they call _unmerged() variant primarily to learn that there were
> unmerged entries in the index, only to abort the operation in that
> case, so a change to _unmerged() variant should be safe for them.
>
> I'll take another look at your patch later, but not before the 2.1
> final, and by that time you may already have sent a reroll ;-)
>
> Thanks.



-- 
Jaime Soriano Pastor - Software Developer
