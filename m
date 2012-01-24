From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 3/2] i18n: do not use gettext.sh by default when
 NO_GETTEXT is set
Date: Mon, 23 Jan 2012 18:31:09 -0600
Message-ID: <20120124003109.GB26980@burratino>
References: <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
 <CALxABCbaBmP6k5TYrYLCYm8oiv=9cF=N7_opSTKUnbkz5b-cwg@mail.gmail.com>
 <20120119195222.GA5011@blimp.dmz>
 <7v1uqq84es.fsf@alter.siamese.dyndns.org>
 <7vwr8i6prk.fsf_-_@alter.siamese.dyndns.org>
 <7vr4yq6poy.fsf_-_@alter.siamese.dyndns.org>
 <20120123221256.GG20833@burratino>
 <7vehuq6ote.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 01:31:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpUIL-0001uh-Ik
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 01:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203Ab2AXAbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 19:31:21 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36394 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198Ab2AXAbU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 19:31:20 -0500
Received: by ggnb1 with SMTP id b1so1706917ggn.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 16:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=14iMbSP5zUNtnaCduG0gq61j4fqCV7UcNWLMFqiSfL8=;
        b=kKEL7pzMdVFXhQxRrB/tCMqYL8KhAVVgtSUhHvkRYiqS35i8jCtZTclpbA++ai9g1Q
         G1LeGIDelF71ij/HzdKzTYlaojVZC5Rx1yWONVLDeH/CuZNcYjmgwtpdPRxYzxnYi8g2
         Iv+Uhl6M/h6iKHRb+emt0s2b6AcBVFFmPwzew=
Received: by 10.101.148.13 with SMTP id a13mr63401ano.31.1327365079315;
        Mon, 23 Jan 2012 16:31:19 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id o16sm39595073ank.14.2012.01.23.16.31.18
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Jan 2012 16:31:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vehuq6ote.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189026>

From: Junio C Hamano <gitster@pobox.com>

When NO_GETTEXT is set, even if a usable installed gettext.sh is
detected to be present, it can only help to use git's simple fallback
stub implementations of gettext and eval_gettext for shell scripts
instead.  That way:

 1) we avoid the complication of autodetection of gettext.sh support
    at runtime;

 2) in particular, if the operating system provides gettext.sh but
    it is unusable, we will not be tricked into trying to use it.

So this patch makes USE_GETTEXT_SCHEME default to fallthrough when
NO_GETTEXT is set.  This is only a default so the operator can set
USE_GETTEXT_SCHEME=gnu or ...=gettext_without_eval_gettext to try the
other schemes.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> Should be easy to do so, like this?

Probably too late to be useful, but here's a patch with commit message
implementing the same.

 Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index b2b738bb..e9b4a2f9 100644
--- a/Makefile
+++ b/Makefile
@@ -1524,6 +1524,9 @@ ifdef GETTEXT_POISON
 endif
 ifdef NO_GETTEXT
 	BASIC_CFLAGS += -DNO_GETTEXT
+	ifndef USE_GETTEXT_SCHEME
+		USE_GETTEXT_SCHEME = fallthrough
+	endif
 endif
 ifdef NO_STRCASESTR
 	COMPAT_CFLAGS += -DNO_STRCASESTR
-- 
1.7.9.rc2
