Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3401920A40
	for <e@80x24.org>; Tue,  5 Dec 2017 20:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752312AbdLEUyO (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 15:54:14 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:60231 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752298AbdLEUyO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 15:54:14 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3yrv9w0Vp2z5tlD;
        Tue,  5 Dec 2017 21:54:12 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6D87D29D9;
        Tue,  5 Dec 2017 21:54:11 +0100 (CET)
Subject: Re: [PATCH v4 1/4] Makefile: generate Perl header from template file
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Dan Jacques <dnj@google.com>, git@vger.kernel.org,
        gitster@pobox.com, avarab@gmail.com
References: <20171129155637.89075-1-dnj@google.com>
 <20171129155637.89075-2-dnj@google.com>
 <3c897f4c-0cb5-ca44-f144-598a623c1dc3@kdbg.org>
 <alpine.DEB.2.21.1.1712011812250.98586@virtualbox>
 <97acc3d3-5c6a-2e65-a372-24def5b21d54@kdbg.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f0ad1ad4-67d8-21e2-fdd0-0a08328c1eaa@kdbg.org>
Date:   Tue, 5 Dec 2017 21:54:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <97acc3d3-5c6a-2e65-a372-24def5b21d54@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.12.2017 um 18:25 schrieb Johannes Sixt:
> Am 01.12.2017 um 18:13 schrieb Johannes Schindelin:
>> Hi Hannes,
>>
>> On Fri, 1 Dec 2017, Johannes Sixt wrote:
>>
>>> Am 29.11.2017 um 16:56 schrieb Dan Jacques:
>>>> @@ -1989,6 +1986,15 @@ GIT-PERL-DEFINES: FORCE
>>>>             echo "$$FLAGS" >$@; \
>>>>         fi
>>>>    +GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES 
>>>> perl/perl.mak
>>>> Makefile
>>>> +    $(QUIET_GEN)$(RM) $@ && \
>>>> +    INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory
>>>> instlibdir` && \
>>>> +    INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
>>>> +    
>>>> INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" &&
>>>> \
>>>> +    sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
>>>
>>> This doesn't work, unfortunately. When $(pathsep) is ';', we get an 
>>> incomplete
>>> sed expression because ';' is also a command separator in the sed 
>>> language.
>>
>> Funny, I tried this also with ';' as pathsep, and it worked in the Git 
>> for
>> Windows SDK...
> 
> My ancient sed vs. your modern sed, perhaps? I can check this on Monday.

I don't know what I tested last week; most likely not the version of the
patch I quoted above.

Today's version, with the tip at 5d7f59c391ce, is definitely bogus
with its quoting. It needs the patch below, otherwise an unquoted
semicolon may be expanded from $(pathsep). This would terminate the sed
command, of course.


diff --git a/Makefile b/Makefile
index 484dc44ade..a658c8169a 100644
--- a/Makefile
+++ b/Makefile
@@ -2071,10 +2071,10 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES perl/perl.mak
 	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
 	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
 	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
-	sed -e 's=@@PATHSEP@@='$(pathsep)'=g' \
-	    -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
-	    -e 's=@@GITEXECDIR@@='$(gitexecdir_relative_SQ)'=g' \
-	    -e 's=@@PERLLIBDIR@@='$(perllibdir_relative_SQ)'=g' \
+	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
+	    -e 's=@@INSTLIBDIR@@='"$$INSTLIBDIR"'=g' \
+	    -e 's=@@GITEXECDIR@@=$(gitexecdir_relative_SQ)=g' \
+	    -e 's=@@PERLLIBDIR@@=$(perllibdir_relative_SQ)=g' \
 	    $< >$@
 
 .PHONY: gitweb
-- 
2.14.2.808.g3bc32f2729
