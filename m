From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] trailer: support multiline title
Date: Wed, 26 Aug 2015 09:05:39 -0700
Message-ID: <xmqqk2siujak.fsf@gitster.dls.corp.google.com>
References: <1440557461-1078-1-git-send-email-chriscool@tuxfamily.org>
	<1440557461-1078-2-git-send-email-chriscool@tuxfamily.org>
	<vpqa8tetwfi.fsf@anie.imag.fr>
	<CA+P7+xqaAKckB0P5oqFS64BWU2H1OsVX8Oq=CLLW8PMJ5fdenQ@mail.gmail.com>
	<CAP8UFD2x8i5wC9JP8d1zAH=d-2BMYWAvpaFmWnu09N5QSG==TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 18:05:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUdCv-0007aO-Es
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 18:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933491AbbHZQFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 12:05:44 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36037 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbbHZQFn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 12:05:43 -0400
Received: by pacgr6 with SMTP id gr6so13016738pac.3
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=c/sI+5i+3X9pRmF00gq2Mn6+42+fMO0+L6M0KFtnvxU=;
        b=F3eDMjtPtdGzxN4dMhnv//2MGeukQBRWNWcv6gx0SaEQC6vpoGWUjTVFfNLy5CMP/o
         t80lWEbqzM+UzoigKpNI4bxTYuBAzwygnj3KUIx9cp7AVqTJJzqBSVMznKZv7MnCtFv7
         WYriqM3QH0e9rYxLdTYLjR9l/WUojsGlOddWJ1eraV0lYEfiIE6cjPvZGXTF3VKz3Y0j
         +s4uC+vX5/V8AUe4fk+MJ2BOR16fq8zSCosR4WFPrpzHN1oDAwcrC8fd02clfGngnaMx
         xCbzAtyiI0gXHc9v0xb4p4m/WRQ3nKmlp5pS3wwXEa5Y9xsMGvhM+W94OZ5uSCyYdG/B
         5pgA==
X-Received: by 10.66.235.33 with SMTP id uj1mr5313209pac.10.1440605142556;
        Wed, 26 Aug 2015 09:05:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac9b:ef8c:b4db:d257])
        by smtp.gmail.com with ESMTPSA id ud2sm25323289pab.45.2015.08.26.09.05.40
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 26 Aug 2015 09:05:40 -0700 (PDT)
In-Reply-To: <CAP8UFD2x8i5wC9JP8d1zAH=d-2BMYWAvpaFmWnu09N5QSG==TA@mail.gmail.com>
	(Christian Couder's message of "Wed, 26 Aug 2015 16:53:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276613>

Christian Couder <christian.couder@gmail.com> writes:

> There is already code to detect a patch in interpret-trailers, but it
> relies on the patch starting with a line with only three dashes.

Hmm, then it can be taught to notice "everything below..." as
another marker, right?

> Maybe. I don't know if there is a reason why the commit-msg is called
> before removing the patch.

Is that "removing", or are you talking about changing the order from

 - prepare log template in-core
 - add comments and patch to that in-core copy
 - write in-core copy out
 - run hook
 - read the hook's result in-core
 - use the message

to

 - prepare log template in-core
 - write in-core copy out
 - run hook
 - read the hook's result in-core
 - add comments and patch to that in-core copy
 - use the message

While the reordering would certainly stop showing the comments and
patch, I am not sure if that is a move in the right direction.  It
will rob from the hooks information that they have traditionally
been given---it will break some hooks.

But if interpret-trailers is almost there to reliably know where the
log message ends, teaching it the one last step would be the right
thing to do anyway.  After all, interpret-trailers was invented
exactly because we did not want individual hooks to roll their own
ways to detect the end of the message proper, so the command should
know where the message ends.
