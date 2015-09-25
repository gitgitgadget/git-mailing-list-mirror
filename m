From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 20/43] refs-be-files.c: add methods for the ref iterators
Date: Fri, 25 Sep 2015 13:54:59 -0700
Message-ID: <xmqqeghm2p98.fsf@gitster.mtv.corp.google.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
	<1441245313-11907-21-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 22:55:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zfa1N-0002ML-Mh
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 22:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756921AbbIYUzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 16:55:03 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33421 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbbIYUzC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 16:55:02 -0400
Received: by pacex6 with SMTP id ex6so115416735pac.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rw7LMiRYubyp9Ai2Gpz/MVswdpDz+BE6xCpjlTmEX94=;
        b=EUgcrLXGOJgnQtWFh8LYDsTTnUY+HZw0K3M6nbuvcCujufOv80JbnmappWcGtP3gFC
         sOSqIcvgA4w+Simksei/D8keZSgU73ZGoPm6fyFwyb0NRth2fur7tKZ7FimE/jjl+5Py
         fDXgKV+QRGVuDbMQDjzP+PG7hrUCW5+jVimHKQSt7TIdIRpADn9z33qK4aaAxN+qsyIB
         sXpMOkH6T+Bln70CYTI1VGvi6e7ClIjw+zujwT+1UyLldAT9GqYSfEuMNaOHaPS3MTTY
         OjnjsEOkamL3+V9iNKi/lR1p1UDcHovzUAKHmhF2ApUYMzYy4qGhX0M+AcSKOtjtAqiU
         TwAQ==
X-Received: by 10.68.205.231 with SMTP id lj7mr10039103pbc.36.1443214501278;
        Fri, 25 Sep 2015 13:55:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:913:2c8:148a:1d8e])
        by smtp.gmail.com with ESMTPSA id tz8sm5495453pab.34.2015.09.25.13.55.00
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 25 Sep 2015 13:55:00 -0700 (PDT)
In-Reply-To: <1441245313-11907-21-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 2 Sep 2015 21:54:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278680>

Up to high-teens in this 43 patch series, the changes all looked
"separate filesystem backend specific part from refs.c to
refs-be-files.c" without other questionable changes, but I have to
give up at this step for now, as conflicts between the patch and the
current codebase is getting a bit too much to manually adjust the
patch only to make sure there is no funnies other than a straight
rename of static functions going on.

We seem to have added a few more iterators in refs.c that would need
to be also wrapped as methods, so this step would need to be redone.

Regarding [03/43], it is a straight rename without any content
change, so you probably could have done "format-patch -M".  But that
original commit, if I am not mistaken, left an empty ref.c instead
of removing, which was somewhat funny (and Makefile still expects
refs.o can be produced from refs.c).

The other side of the same coin is that [04/43] expects an empty
refs.c to be in the original; it should be creating a new file
instead.

Just for future reference to others, what I did was:

 * looked at the gzipped patch and made sure the preimage of refs.c
   and the postimage of refs-be-files.c were identical.

 * started from the tip of current master, merged the topics
   mentioned in the message with the gzipped patch to it, and called
   the result $BASE0.

 * applied 01/43 and 02/43 on $BASE0.

 * then manually moved refs.c to refs-be-files.c and told git about
   them, and applied changes to Makefile in 03/43, and committed the
   result.

 * adjusted 04/43 to expect refs.c to be missing and applied it.

 * continued to apply from 05/43 thru until I get a conflict that
   I feel uncomfortable to adjust myself.

 * "git format-patch --stdout -M $BASE0.. >./+dt0".

 * Pick 'next', 'jch' and 'pu' as the starting point, attempted to
   run "git am ./+dt0" (with success).  At least, by adjusting for
   03/43 and 04/43 and recording 03/43 as a rename in "./+dt0", the
   early parts of these attempts were survivable ;-).  Then
   attempted to apply 20/43 on top of the result, all of which
   unfortunately left a conflict that I feel uncomfortable to adjust
   myself.

Thanks.
