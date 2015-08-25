From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] submodule: helper to run foreach in parallel
Date: Tue, 25 Aug 2015 15:44:09 -0700
Message-ID: <xmqqtwrnvvie.fsf@gitster.dls.corp.google.com>
References: <1440523706-23041-1-git-send-email-sbeller@google.com>
	<1440523706-23041-4-git-send-email-sbeller@google.com>
	<xmqq7fojxeh3.fsf@gitster.dls.corp.google.com>
	<CAGZ79kb2N_5_tJv-GURL9_ESFs=pHp=L-Mujn3Df_+-T74_9Dg@mail.gmail.com>
	<xmqqy4gzvwh5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 00:44:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUMwy-0001Tj-Ms
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 00:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046AbbHYWoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 18:44:12 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33439 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbbHYWoL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 18:44:11 -0400
Received: by pacti10 with SMTP id ti10so64894822pac.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 15:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TxiU1IynQlU2Vw/kjlG7AxqLCMrai/4M6DXBeVL5cSo=;
        b=teZc7NYpOprgxH+nGv54gN8ixc5nYHlt6UbemPErnaY+9lUyh3QqNMMIlWp4MIM6qa
         kzt5Lez9NnYkxg84kmwCSRfkSwCAaeqx6tFjHvrWYIU8bPbnf9neqACxJb+0OuD2ulY9
         sFhBzFdF0I0KBp5/aFY7yB+fWNWz2e7QKyqlqrqErtsOGgyLnBZCZ0jnou/EgIprC9W5
         xvuoZE/KbqpJxDCdBWkfFvpxD5S0hgpwiDyLqzHEJQXyi71lySCRioiQaDGp1eUQbcX5
         Sv+fdalyAeUCrRLqNr/ifXxrKWaryaHghwzrH+L5FRVZWlk7YFZFhI47DcF5usSefhSE
         pA2A==
X-Received: by 10.66.145.74 with SMTP id ss10mr62417752pab.28.1440542650970;
        Tue, 25 Aug 2015 15:44:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id qp13sm22265190pbb.9.2015.08.25.15.44.10
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 15:44:10 -0700 (PDT)
In-Reply-To: <xmqqy4gzvwh5.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 25 Aug 2015 15:23:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276583>

Junio C Hamano <gitster@pobox.com> writes:

>> Why would we want to unplug the task queue from somewhere else?
>
> When you have a dispatcher more intelligent than a stupid FIFO, I
> would imagine that you would want to be able to do this pattern,
> especially when coming up with a task (not performing a task) takes
> non-trivial amount of work:
>
> 	prepare task queue and have N threads waiting on it;
>
> 	plug the queue, i.e. tell threads that do not start picking
> 	tasks out of it yet;

s/that do not/not to/; sorry for grammo resulting from a lot of
editing while doing other things X-<.

> ...
>       and finally, wait for everything to finish.
>
> Without "plug/unplug" interface, you _could_ do the above by doing
> something stupid like
> ...
>       and finally, wait for everything to finish.

... but having to use yet another queue outside only because the
task queue cannot be plugged feels stupid.

But because we do not yet have a way to plug custom dispatching
logic to the dispatcher, the above is in the "but that can wait
until the need arises." category, as I said.
