From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 05/13] ref-filter: implement an `align` atom
Date: Wed, 12 Aug 2015 10:13:13 -0700
Message-ID: <xmqqpp2sl9au.fsf@gitster.dls.corp.google.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
	<1439129506-9989-6-git-send-email-Karthik.188@gmail.com>
	<xmqqy4hhr72q.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZTnS0kL=CK8Lx-brO0tryB5YzOFUpapsM4LMW-m2Yf9pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 19:13:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPZac-0000lG-6p
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 19:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbbHLRNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 13:13:18 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35343 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932153AbbHLRNR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 13:13:17 -0400
Received: by pdrg1 with SMTP id g1so9348902pdr.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 10:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=S/hLSGLQgvDvTT6UYIu2heR0hrLXhv2vwo67qnxTVWI=;
        b=b0KGR2rECzk766Mhuxe+xra/o9qydSKJdq9W5KyyeIixyq7lwfhYHmbJF1pXM2IaKo
         cQ5Zu3JyAarghdeqx6VOEEDyZwvreTU+f8juxcqVT59tTCGDJgPi0U7l1NgDG3g0NMTo
         d7T4RSsSvlGRbFCFLWQi4nBOgfG5Ei4cDIzTftMbMTJlg4eKYhGIUnpjePXK9OuU0CUs
         sMysm94SA4Id/v22je/fxrwUgFdhpmb3VlUiufR61Pnh6of9M5jWALj4OhhjDMMa286w
         uwlHdWGe75KVgAyvEZJIXAujqsRRm4hCTzTjJoDa0dClHu0oXYIDcXyOXiUv0f5FwB/3
         6LlA==
X-Received: by 10.70.55.10 with SMTP id n10mr21944691pdp.47.1439399597054;
        Wed, 12 Aug 2015 10:13:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:755f:3d29:a826:eda6])
        by smtp.gmail.com with ESMTPSA id b11sm7079597pbu.80.2015.08.12.10.13.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 10:13:14 -0700 (PDT)
In-Reply-To: <CAOLa=ZTnS0kL=CK8Lx-brO0tryB5YzOFUpapsM4LMW-m2Yf9pw@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 12 Aug 2015 21:54:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275786>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Wed, Aug 12, 2015 at 12:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Minor nits on the design.  %(align:<width>[,<position>]) would let
>> us write %(align:16)...%(end) and use the "default position", which
>> may be beneficial if one kind of alignment is prevalent (I guess all
>> the internal users left-align?)  %(align:<position>,<width>) forces
>> users to spell both out all the time.
>>
>
> Isn't that better? I mean It sets a format which the others eventually
> can follow
> %(atom:suboption,value).
> For example: %(objectname:abbrev,size)

No, I do not think it is better.  First of all, the similarity you
are perceiving does not exist.  For 'objectname:abbrev', the 'size'
is a property of the 'abbrev'.  For 'align:left', the 'width' is not
a property of the position.  It is a property given to 'align'
(i.e. you have this many display columns to work with).

Also, if there are ways other than 'abbrev' that '8' could affect
the way how %(objectname) is modified, then it should be spelled as
%(objectname:abbrev=8).  To specify two modification magics, each of
which takes a number, the user would say e.g.

    %(objectname:abbrev=8,magic=4)

The syntax %(objectname:abbrev,size) would not allow you to extend
it nicely---you would end up with %(objectname:abbrev,8,magic,4) or
something silly like that.

Seeing your %(objectname:abbrev,size), I'd imagine that you are
assuming that you will never allow any magic other than 'abbrev'
that takes a number to %(objectname).  And under that assumption
%(objectname:8) would be a short-hand for %(objectname:8,abbrev).

And that would be following %(align:8).  Both 'left' (implied
default) and '8' are instructing 'align' what to do.
