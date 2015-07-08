From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 1/7] refs.c: add err arguments to reflog functions
Date: Wed, 08 Jul 2015 10:11:17 -0700
Message-ID: <xmqqr3oiy3pm.fsf@gitster.dls.corp.google.com>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
	<1435609076-8592-2-git-send-email-dturner@twopensource.com>
	<559AA490.3080605@alum.mit.edu>
	<1436308882.5521.15.camel@twopensource.com>
	<559D0281.6040908@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 08 19:42:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCssa-0007qz-8L
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 19:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965340AbbGHRLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 13:11:23 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37916 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965246AbbGHRLV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 13:11:21 -0400
Received: by igrv9 with SMTP id v9so172517135igr.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=PdWYZMNIPHbdxx4VVewLIwPj1jclfpCqJGvsVL25fdk=;
        b=dCqutS1VTmfTXRtBl6ytxuQ7poybY8OhlqzUa29yShtBg5Z3wLRsnfrU4uhymwg26I
         fNXWmrKH3et6ConGZ8h/yuL1FlOECS+kx2qkbZ+dZwe9momecAx412SbdVPeo8kFELQI
         xuGWBzYAx/8Ixn9g/IPxT6ntPFXxHTSE0UilVtWVfI6YUgFq7OnVeq31gqsrVQo1bXwE
         HuTxfAvfH9K5A6S+yjcn0aajzru35CPW5lFFudBfX/0ieE410UzbClRZ7XLeFCG2eGVm
         EnPyyJ1dQeagFEzzknZnDDsk+uWcVZU/lQx+Run3ag+FjbmmSNjcMLGsxmeRUjm2jvpO
         7bZA==
X-Received: by 10.107.3.104 with SMTP id 101mr8009846iod.48.1436375480266;
        Wed, 08 Jul 2015 10:11:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6567:f006:f2bd:2568])
        by smtp.gmail.com with ESMTPSA id d4sm2222594iod.17.2015.07.08.10.11.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jul 2015 10:11:18 -0700 (PDT)
In-Reply-To: <559D0281.6040908@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 08 Jul 2015 12:59:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273694>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I think your v7 of this patch goes too far, by turning a failure to
> write to the reflog into a failure of the whole transaction. The problem
> is that this failure comes too late, in the commit phase of the
> transaction. Aborting at this late stage can leave some references
> changed and others rolled back, violating the promise of atomicity.

Yeah, that sounds problematic.

> The old code reported a failure to write the reflog to stderr but didn't
> fail the transaction. I think that behavior is more appropriate. The
> reflog is of lower importance than the references themselves. Junio, do
> you agree?

That is actually a loaded question.

Do I agree that the current (i.e. before this change) behaviour is
more appropriate given the current choice of representation of refs
and reflogs on the filesystem, treating a failure to update reflog
as lower importance event and accept it as a limitation that it
cannot abort the whole transaction atomically?  Compared to leaving
the repository in a half-updated state where some refs and their
logs are updated already, other remaining proposed updates are
ignored, and the transaction claims to have failed even though some
things have already changed and we cannot rollback, I would say that
is a better compromise to treat reflog update as a lower importance.

Do I agree that reflog writing should stay to be best-effort in the
longer term?  Not really.  If we are moving the ref API in the
direction where we can plug a backend that is different from the
traditional filesystem based one for storing refs, I think the
backend should also be responsible for storing logs for the refs it
stores, and if the backend wants to promise atomicity, then we
should be able to fail the whole transaction when updates to refs
could proceed but updates to the log of one of these updated refs
cannot.  So I do not agree to cast in stone "the reflog is of lower
importance" as a general rule.
