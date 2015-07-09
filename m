From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/44] Make git-am a builtin
Date: Wed, 08 Jul 2015 23:00:52 -0700
Message-ID: <xmqqio9tx42z.fsf@gitster.dls.corp.google.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
	<xmqqmvz7yuk4.fsf@gitster.dls.corp.google.com>
	<xmqqa8v7yts9.fsf@gitster.dls.corp.google.com>
	<20150708081902.GA8606@yoshi.chippynet.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 08:01:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZD4tI-0000fx-Qh
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 08:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbbGIGA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 02:00:57 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:36652 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbbGIGAz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 02:00:55 -0400
Received: by iecvh10 with SMTP id vh10so170417907iec.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 23:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OVCH+syvOT6wBaJ7SvWLVtr7oI1LdfeOJIlxMDWyVXY=;
        b=hl2bWsy7Ma1zz3QKIv2WpXPDOXA4VYQFxIxDnlEmZEg5w+7buaGb6bNnFiXJdCQb/y
         JdgcE/fauP6O/I7/AhkKacov3rqIxccBS2A9eC0P3OwSlz2snE11I3ZvvU3u9nErCtIu
         Tcv9prMsgTaOt2wZyaZTJR1FR+nwAbVMD+0YtxDZ+WMEGyweaVbqcoCTeqjlaIaq2U4C
         7UEq2d4bapB7KpL4pjE8Qh4YhZLSsUyjjT00ivrI8bhiLAF7JDjEMk2xWbD3WIN9jhR6
         2yirOIw/XxDzp4+J3ZKwE+y/3u+RZnewC/wPgWpG1mYcZsLZNqk+soPwGi+y5qr9DR09
         VgAw==
X-Received: by 10.50.49.46 with SMTP id r14mr73080733ign.45.1436421655082;
        Wed, 08 Jul 2015 23:00:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6567:f006:f2bd:2568])
        by smtp.gmail.com with ESMTPSA id m92sm3542933ioi.41.2015.07.08.23.00.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jul 2015 23:00:54 -0700 (PDT)
In-Reply-To: <20150708081902.GA8606@yoshi.chippynet.com> (Paul Tan's message
	of "Wed, 8 Jul 2015 16:19:02 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273726>

Paul Tan <pyokagan@gmail.com> writes:

> So the fix would be to remove the assert()s, as follows:

What I pushed out tonight should have SQUASH??? (or fixup!) that
splits this into appropriate steps in your series.  Please check.

Note that you do not have to say "if the variable has something,
then free it".  free(NULL) is perfectly fine and we can read

	free(var);
        var = compute_new_value();

just fine.

However, I am reluctant to blindly replace assert(!state->field)
with free(state->field).  Are there cases where we _must_ call a
function that sets these fields at most once?

On the other hand, assert() like this is more or less useless.

	assert(state->field);
        ...
        printf("%s", state->field); /* or other uses */

"The caller must have filled the field" can be seen by unconditional
use of "state->field" without such an assert().
