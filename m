From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 17/19] fsck: Introduce `git fsck --quick`
Date: Sun, 21 Jun 2015 13:35:41 -0700
Message-ID: <xmqq1th4kdeq.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<5f1c4c16027b00ef80490d67bec5e948481153ec.1434720655.git.johannes.schindelin@gmx.de>
	<xmqq1th77829.fsf@gitster.dls.corp.google.com>
	<95e42f21de69ab5299c03ce6ad107037@www.dscho.org>
	<xmqqoakb5sk2.fsf@gitster.dls.corp.google.com>
	<558643CA.6000303@alum.mit.edu>
	<xmqqioahj849.fsf@gitster.dls.corp.google.com>
	<3faa92b10274ce8cfebe340761f73505@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 21 22:35:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6ly2-0006Vc-4M
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 22:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbbFUUfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 16:35:46 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35759 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369AbbFUUfo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 16:35:44 -0400
Received: by iefd2 with SMTP id d2so46950137ief.2
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 13:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xaqNmKjJ436LtLIXXxrmXwhb0nfCwHMUng8ZEYdNhAs=;
        b=HJj0VMmCKNNvnAQ0S2Ej+Mt3/etVSV63UzqDceSa2a5cuGGdgJJJfBOjx7aBt1Wy4j
         wlwg2Xuj9xmd0yogR4cZ0vhlyfxPekQwshAgZA+9lJcRB1tQdxIhVBIz3zdBE1wGobT/
         76SxGS+2Uo82DX6XXgYjsB4JA/Jf78qoN0QKVpRy9XTD7atqznb8bQ3rVbW4PfGqNvd+
         jAEhnUwW58lwV5uYh97SD/UqHKcNAIIpNcMGso6Tm6dPMSfb8G7HyCglhI+U31XMjO6/
         EpYV1Va0juq5TM4fw6OtwG5vSCxN5Ii+dKx1UzofxDUwhfyF9FJUICv7c6pEjEVHTqc4
         W/xg==
X-Received: by 10.50.78.199 with SMTP id d7mr17460630igx.18.1434918943778;
        Sun, 21 Jun 2015 13:35:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:990b:778:aa29:b388])
        by mx.google.com with ESMTPSA id s5sm6267571igh.6.2015.06.21.13.35.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 21 Jun 2015 13:35:42 -0700 (PDT)
In-Reply-To: <3faa92b10274ce8cfebe340761f73505@www.dscho.org> (Johannes
	Schindelin's message of "Sun, 21 Jun 2015 20:27:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272284>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> On 2015-06-21 19:15, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> That's brilliant.
>> 
>> Just to make sure I am reading you correctly, you mean the current
>> overall structure:
>> 
>> [...]
>
> The way I read Michael's mail, he actually meant something different:
> if all of the blob-related errors/warnings are switched to "ignore",
> simply skip unpacking the blobs.

That is how I read his mail, too.

But because IIRC we do not check anything special with blob other
than we can read it correctly, my description of "overall structure"
stayed at a very high conceptual level.  The unpacking may happen at
a much higher level in the code, i.e. it comes way before this part
of the logic flow:

        if ("is bad_blob ignored?")
		;
	else if (! "is the blob loadable and well-formed?") {

in which case "is bad blobs ignored?" check may have to happen
before we unpack the object.

And I do not suggest introducing yet another BAD_BLOB error class; I
would have guessed that you already have an error class for objects
that are not stored correctly (be it truncated loose object, checksum
mismatch in the packed base object, or corrupt delta in pack).

It so happens that blob is the only type of object that does not
have outgoing links that is needed for connectivity check, so even
if you allow to ignore "error class for objects that are not stored
correctly", you would still have to read trees, commits and tags;
it would be a natural consequence of ignoring that class of errors
that you would get a quick-and-dirty fsck by not unpacking blobs.

Of course, that assumes that you can tell an object is a blob
without unpacking.  If a tree entry mentions an object to be a blob
by having 100644 as its mode, unless you unpack the object pointed
at by that tree entry to make sure it is a blob, you wouldn't be
able to detect a case where a non-blob object is stored with 100644
mode, which would be an error in the containing tree object that we
may want to detect.  I am not sure if "skipping inflation of blobs,
but still ensure connectivity and tree integrity" is really a viable
mode of quick-and-dirty operation.  I would imagine you would need
to lose a bit more than "we don't bother reading blobs" (which is OK
by me, but I am just pointing out that (1) I do not mean to say we
should add BAD_BLOB as a new class, and (2) the automatic bypass
Michael's --quick skips may not be limited to suppressing "we cannot
read this blob object" class, but also need to suppress checks for
some form of tree integrity violation).

Thanks.
