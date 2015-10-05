From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] Consolidate code to close a pack's file descriptor
Date: Mon, 05 Oct 2015 15:15:52 -0700
Message-ID: <xmqq1td9x8pz.fsf@gitster.mtv.corp.google.com>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
	<cover.1444076827.git.johannes.schindelin@gmx.de>
	<a1f0d9339a9de95ba3f5eaaaf2e1a712629ad5d4.1444076827.git.johannes.schindelin@gmx.de>
	<xmqqio6lxcci.fsf@gitster.mtv.corp.google.com>
	<b7d0f89bb94f88cb8d600a461dfe7ea1@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 06 00:16:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjE36-0003Ys-Hc
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 00:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbbJEWP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 18:15:56 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35729 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbbJEWPz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 18:15:55 -0400
Received: by pacfv12 with SMTP id fv12so192306594pac.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 15:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=omkEYybiP/NWKBp7HxeGupdBkTlC05f3ZEN+OP+G4MM=;
        b=e8uRio7LKhFCq8c3xXvsvFOGpIFeI4HoOYWvKb25zndxYLircncLAn2F3sPp3pOcct
         amI5sK8AD9qluYZJ43YUL1NZYgeXMt8b3fROfE+tfmifIujMppxVmAnWBu44EAr7pAjZ
         NuWP600EkuIkbhMXaxtwiURAQDdrjh5a1D65T9oDndL9IfDUpbo1KWyDPkwR0/RQgzdH
         02DVsCnzXp6LFz+o7naU/jLuvcihf7oYWJ/+J40FmOhi5MWO1bFX0OhxU97O9YiKYDuV
         k/DkEPP8X1pN3PYi1RUUc5tNQaikLbm25IjA5qliQ53AC7JBGeNv928dENUweJMFYQO6
         NmZw==
X-Received: by 10.66.219.8 with SMTP id pk8mr32901497pac.138.1444083355520;
        Mon, 05 Oct 2015 15:15:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:a14c:f96c:97d2:eee0])
        by smtp.gmail.com with ESMTPSA id fa14sm29666388pac.8.2015.10.05.15.15.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Oct 2015 15:15:53 -0700 (PDT)
In-Reply-To: <b7d0f89bb94f88cb8d600a461dfe7ea1@dscho.org> (Johannes
	Schindelin's message of "Mon, 05 Oct 2015 23:52:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279101>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>>> +				&& !p->do_not_close)
>>> +				close_pack_fd(p);
>> 
>> I wonder how this do_not_close bit should interact with "we are
>> shutting down (or we are spawning another to do the real work, while
>> we won't do anything useful anymore), so close everything down".
>
> The `close_all_packs()` function is meant for the use case where you
> really close all the packs, no question asked.
>
> I cannot think of a use case where it would make sense to try to be
> gentle, yet still ask for *all* of the packs to be closed. Maybe you
> can think of one to convince me that it might make sense to respect
> the `do_not_close` flag in such a function? Because so far, I am
> totally unconvinced.

Do not wait for being convinced forever, as I am not interested in
convincing you either way.  Decision by made-up examples or lack of
imagination is a waste of time ;-).

My earlier "I wonder" leads me to totally different conclusion,
which is "we declare that it is a bug for any caller to call
close-all-packs while marking any open pack with do_not_close bit".

Which merely means that while iterating over packs in the
"close-all" loop, we should throw a die("BUG") at the caller if that
bit is on.  That way, we won't have to rely on "we did not think of
a good use case so we unconditionally closed the packs without
telling the remainder of the system, hopefully we broke nothing."

Instead we'd make it absolutely clear what our assumption of this
change and the new helper function is, and a caller that may appear
in the future that wants to have do_not_close bit can complain.  At
that point, maybe we can decide to either loosen it if that caller
has a good reason, or tell the caller to drop do_not_close bit
before calling close-all.
