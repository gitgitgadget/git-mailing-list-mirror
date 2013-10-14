From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 2/2] version-gen: fix versions
Date: Sun, 13 Oct 2013 22:01:04 -0700
Message-ID: <20131014050104.GA25344@google.com>
References: <1381561628-20665-1-git-send-email-felipe.contreras@gmail.com>
 <1381561628-20665-3-git-send-email-felipe.contreras@gmail.com>
 <CAJDDKr5K0UjcbhUpAjHjGcEk6=E2+cAVC8-RpxY+C1atSVj-Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 07:01:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVaHv-0004N8-3Y
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 07:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067Ab3JNFBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 01:01:40 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:32913 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab3JNFBL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 01:01:11 -0400
Received: by mail-pa0-f48.google.com with SMTP id bj1so7019306pad.21
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 22:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dssaJuvC/BL4t8MAeQEkRD9nnEiVQoD9KLfErczaNhc=;
        b=yymwhGPFRwn0Oo2PPlsgbYmYRlyZlc6Sk4QbwUwOw5L/eijnphAi5g6zCltvKuC9X9
         MixR/nnRFJqVQ8/Qiw6xYNe7Vsewy4WkOqTnPiA08sx33UZwSY59dr9TszG4weMeRAAS
         mJHVUkcOmrh2K4tuHcC2DegO6GYyFiKrbLR+0EQgqq+YllNbwplqCBuuUoMz3pB+xxVA
         fytgCoQ8IK8Yau1gelMpLEjWBwwhz3LICfRZFsDnv2kemSlatqFJ/o3chalajHO1GehO
         VQAEu9p79C8DiI2XAeI/EbLVGlGHAus98nJ55L4RYmTaPnU9RoxXwrxnAJoSYkVxd/us
         H2pg==
X-Received: by 10.66.158.196 with SMTP id ww4mr35990346pab.57.1381726871259;
        Sun, 13 Oct 2013 22:01:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id kd1sm88398002pab.20.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 13 Oct 2013 22:01:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJDDKr5K0UjcbhUpAjHjGcEk6=E2+cAVC8-RpxY+C1atSVj-Tg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236091>

Hi,

David Aguilar wrote:
> Felipe Contreras <felipe.contreras@gmail.com> wrote:

>> Virtually all packaging guidelines would prefer 1.8.4~rc1, over
>> 1.8.4.rc1 or 1.8.4-rc1, so it makes sense to use that instead.
>>
>> In particular, the only packaging we provide, git.spec, generates a
>> wrong version, because git-1.8.4 < git-1.8.4.rc1, changing to ~rc1 fixes
>> the problem as it's considered newer.

A more conservative fix would be to tweak the .spec generation in the
Makefile to follow whatever the appropriate Red Hat convention is.
For example, something like this:

-- >8 --
diff --git i/Makefile w/Makefile
index 0f931a2..73bd89d 100644
--- i/Makefile
+++ w/Makefile
@@ -2385,8 +2385,9 @@ quick-install-html:
 
 ### Maintainer's dist rules
 
+GIT_VERSION_RPM = $(subst -rc,~rc,$(GIT_VERSION))
 git.spec: git.spec.in GIT-VERSION-FILE
-	sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@+
+	sed -e 's/@@VERSION@@/$(GIT_VERSION_RPM)/g' < $< > $@+
 	mv $@+ $@
 
 GIT_TARNAME = git-$(GIT_VERSION)
-- 8< --

That way, programs that parse the git version by splitting at '.'
(there are more than a few, unfortunately) would continue to work, but
the packaging system would get the benefit of the proposed versioning
style change.

>> The same happens in dpkg.

Have you tested this?  I thought the Debian packaging did not use the
GIT-VERSION-GEN generated version in this way.

[...]
> This seems related:
>
> http://lintian.debian.org/tags/rc-version-greater-than-expected-version.html

If I understand correctly, that page has an exhaustive list of affected
packages in the Debian archive and doesn't include git.

Thanks and hope that helps,
Jonathan
