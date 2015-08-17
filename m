From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] path: optimize common dir checking
Date: Mon, 17 Aug 2015 08:55:38 -0700
Message-ID: <xmqqegj1gb9h.fsf@gitster.dls.corp.google.com>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com>
	<1439416645-19173-2-git-send-email-dturner@twopensource.com>
	<55CC5DED.5050304@alum.mit.edu>
	<xmqqtws1iyxn.fsf@gitster.dls.corp.google.com>
	<55CF811A.8060106@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, pclouds@gmail.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Aug 17 17:55:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRMlI-0001Pk-0h
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 17:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866AbbHQPzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 11:55:43 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35796 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755497AbbHQPzk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 11:55:40 -0400
Received: by pacgr6 with SMTP id gr6so111192214pac.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 08:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rID35/VFQtbC5lut/NOQEaxXPcsWQl3eTgStfpvnvyY=;
        b=PQFbjhenWTZJO2lGmbvZTTyQDp9k78fGJ0G9udZIqepr0MXJebOMpypLccBuG/G5tm
         /stwEt9IjBJT3EJODE85o7xaPNYOT/QYIjTV1rBQYXsR0XJS3kzl54JCCL+DtyC2tg/r
         ZOUY9sfDgu2yOYYXxUfZviHlh0NpZPDubsiyUa9F4E7GMp291zIetc8utIIQrh/gI3MM
         uC/v9SJ6dgEGhsTbx+wB3j5SVDBcADGlk4j2UiyJOKEtGVKdOWsO+U7CRtMtv1hOzCL2
         fK8pOOv73V/WKlos3pxVJ5t3KKMlVgSrq3CqDHARg2XmmeB7uWwCUcKt34yeApkwNy/w
         NhCg==
X-Received: by 10.68.243.103 with SMTP id wx7mr3929418pbc.60.1439826939906;
        Mon, 17 Aug 2015 08:55:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id k5sm15140304pda.34.2015.08.17.08.55.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 08:55:38 -0700 (PDT)
In-Reply-To: <55CF811A.8060106@alum.mit.edu> (Michael Haggerty's message of
	"Sat, 15 Aug 2015 20:12:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276056>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> If I understand correctly, you consider the decision of where a
> particular reference should be stored to be a kind of "business logic"
> decision that should live outside of the refs module. I don't think it
> is so important whether this knowledge is inside or outside of the refs
> module (I can live with it either way).

I think I misspoke.  The decision to make a particular reference,
e.g. HEAD or 'master' branch, a per-workspace one or a repo-wide
one, should not be made by individual refs backend (i.e. lower-half
of the refs module).  It could still be the responsibility of the
upper-half of the refs module and that _feels_ more kosher.

But without actual implementation of the interface between upper-
and lower-half of the refs module yet (as we only have fs based
backend that is tightly integrated within the refs module and
nothing else right now), I do not yet see a clear implementation for
the "is this thing common?" table Duy did that decides where things
go for everything except "refs/" part while letting the upper-half
of the refs module to take responsiblity of that decision for refs.
For one thing, "the refs module decides what is in refs/, Duy's
table decides everything else " is not even the right partition, in
the presence of things like HEAD, logs/, etc.

So...
