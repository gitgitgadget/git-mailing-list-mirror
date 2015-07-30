From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] clone: fix hostname parsing when guessing dir
Date: Thu, 30 Jul 2015 09:53:07 -0700
Message-ID: <xmqqfv457fkc.fsf@gitster.dls.corp.google.com>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
	<1438185076-28870-1-git-send-email-ps@pks.im>
	<1438185076-28870-6-git-send-email-ps@pks.im>
	<xmqq7fpiamiq.fsf@gitster.dls.corp.google.com>
	<20150730121811.GA24635@pks-pc.localdomain>
	<xmqqk2th7gmq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Thu Jul 30 18:53:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKr51-0004e2-PD
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 18:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbbG3QxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 12:53:11 -0400
Received: from mail-pd0-f196.google.com ([209.85.192.196]:34118 "EHLO
	mail-pd0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbbG3QxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 12:53:09 -0400
Received: by pdav4 with SMTP id v4so2400599pda.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TsojRqD0vrm6FUCVc/GYGB8j8qSvKwtJ3KnEv/caLA8=;
        b=o7oP8Z12rcMIzZZXTSlQobRvGvsxBEvhoYT/AGgoNj0Z5QZEvaFzYyYqcIoEUcCg9b
         Fji+YKr6eajJhZg2Y9QBE8keZPxijzQm2GC40oFRxPEQXwZ28Idr/7SZzHXUkiGQOjfP
         VwL9SQgiQK5OYZN7jqEByQwnUArNg0sxthV1vjMie7hEoEjMuuQHyESjOZmw8udzryxJ
         3rPmqcNuB6wNW5frdu4iZaGL30eVesb61byvJfHtnZvH4e9L4QhWVrc+xvgNLIWh1Ei6
         H4rX8acV9HVa1weHEBYJZfN6n3voZ/umELW5Ufz5iD+9Ro2u/ydh/GBWi9oALU1l4w/P
         O0ag==
X-Received: by 10.70.54.196 with SMTP id l4mr79362287pdp.42.1438275189409;
        Thu, 30 Jul 2015 09:53:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:106d:d8d6:d21e:17fe])
        by smtp.gmail.com with ESMTPSA id u8sm3108698pdj.46.2015.07.30.09.53.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 Jul 2015 09:53:08 -0700 (PDT)
In-Reply-To: <xmqqk2th7gmq.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 30 Jul 2015 09:30:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275020>

Junio C Hamano <gitster@pobox.com> writes:

> Well, but there is the above "or we may not" ;-)
>
>> But actually you are right, currently I still have the old logic
>> in place that splits on colons in the path component. 
>
> Yes.  The reason why I suggested the simple route was exactly
> because I noticed that you didn't seem to care about the above
> "$site/foo:bar.git/" => "$site/foo:bar" => "bar" transform.
>
> And I think people might depend on that behaviour.  "Fixing" that
> may even be seen as a regression.
>
> When was the last time you created a foo@bar.git repository?

Actually, this was an unrelated question and a wrong one to ask at
that.

Even though I personally haven't created foo:bar.git repository,
because it is no longer 2005, it is highly likely that somewhere
there is such a person who depends on the current behaviour of
turning that to "bar" on the cloned side.  Similarly, even if we the
people who read the Git mailing list collectively do not know
anybody who has foo@bar.git repository, it is highly likely that
somewhere there is such a person who depends on the current
behaviour of turning that to "foo@bar" on the cloned side.

So the ideal would be to keep turning $site/foo:bar.git to bar,
$site/foo@bar.git to foo@bar, and $scheme//u@p:$host/ to $host.

And it would be ideal if we do so without much code churn.  "The
whole site is dedicated to host a single repository at the root" is
a highly unlikely set-up and it feels wasteful to spend too much
effort on.
