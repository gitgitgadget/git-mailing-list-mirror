From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 41/68] init: use strbufs to store paths
Date: Wed, 30 Sep 2015 13:00:56 -0700
Message-ID: <xmqqh9mb7k3r.fsf@gitster.mtv.corp.google.com>
References: <20150924210225.GA23624@sigill.intra.peff.net>
	<20150924210736.GL30946@sigill.intra.peff.net>
	<CAO2U3QjunOPoAbGSRjAmCwfk-TnoMveXOJhpb351eh1a_3Xp3A@mail.gmail.com>
	<20150930002347.GA23406@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 30 22:01:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhNYm-00060d-Me
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 22:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbbI3UA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 16:00:59 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34165 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932442AbbI3UA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 16:00:58 -0400
Received: by padhy16 with SMTP id hy16so49820082pad.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 13:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TXbiuv1XaxXairEtd+0/+lO25NoEf+offaW5saFXnRM=;
        b=z3mSvZS0DgPqDOj9F9v72ivjVKuYf17P+XjT2SeWlg8JzLIOAw0/SvZDMnERDdTb5n
         PO8Ghf4eRafKECcwMs841FIJXpGA3WNtWY8dSsr5AMb9pj6dvSXhyb0s5e5mFZgUAZSJ
         nYXn3LTv8cUF6K+mTUAe86IteAjyEJCfdTdRPdtt15jrYYiULgPjxb3xmSbSY/tZYsd8
         wJtn0buPUXwgOElqkzW/1qJaIzNL/ykeWV+OjA9L+Yw0XWRkWj+5lsamnKcZfb+MMzYz
         3fDsWdoczKl5dSzes5EPSLT9S1WrcACxgT7BBmqMUyVGPDElyJNneW+UM9+xN/lYN9NG
         Fp3w==
X-Received: by 10.68.243.99 with SMTP id wx3mr6963799pbc.33.1443643257672;
        Wed, 30 Sep 2015 13:00:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2c4a:a656:af73:8140])
        by smtp.gmail.com with ESMTPSA id z13sm2245686pas.34.2015.09.30.13.00.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Sep 2015 13:00:56 -0700 (PDT)
In-Reply-To: <20150930002347.GA23406@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 29 Sep 2015 20:23:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278865>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 29, 2015 at 04:50:39PM -0700, Michael Blume wrote:
>
>> I see compile errors on my mac:
>> 
>> First a whole bunch of
>> 
>> ./compat/precompose_utf8.h:30:45: warning: declaration of 'struct
>> strbuf' will not be visible outside of this function [-Wvisibility]
>> void probe_utf8_pathname_composition(struct strbuf *path);
>
> Wow, my patch isn't even close to reasonable. I didn't realize because
> we do not compile this code at all for non-Mac platforms. Sorry.

Perhaps the way we completely stub out the platform specific helpers
contributes to this kind of gotchas?  I am wondering how much additional
safety we would gain if we start doing something like this.

Two things to note:

 * "struct strbuf" needs to be visible when the compiler sees this
   part, which is an indication of the same issue shown in the above
   error message, is not addressed.

 * precompose_str() does not seem to be defined or used, hence
   removed.

 git-compat-util.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 712de7f..6710ff7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -227,9 +227,11 @@ typedef unsigned long uintptr_t;
 #ifdef PRECOMPOSE_UNICODE
 #include "compat/precompose_utf8.h"
 #else
-#define precompose_str(in,i_nfd2nfc)
-#define precompose_argv(c,v)
-#define probe_utf8_pathname_composition(p)
+static inline void precompose_argv(int, const char **);
+static inline void probe_utf8_pathname_composition(struct strbuf *buf)
+{
+	; /* no-op */
+}
 #endif
 
 #ifdef MKDIR_WO_TRAILING_SLASH
