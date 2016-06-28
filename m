Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA0911FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 08:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbcF1Ium (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 04:50:42 -0400
Received: from mail11.rbs.com ([155.136.80.61]:43132 "EHLO
	remlvdmzma03.rbs.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751419AbcF1Iuj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 04:50:39 -0400
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple;
  d=rbs.com; i=@rbs.com; q=dns/txt; s=mail;
  t=1467103839; x=1498639839;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4qU2vm7Cs75f4N/n0+5rb/mXfMFzYh+NzO19GJbwuBM=;
  b=IiZAGqhjRB9DKIF4dz+4tFpZq7FskcNZ6iFxNaTn0eooNrQf7oj7738v
   6qg+JcXm7Q9WAuqYDgWXzXisU2SmskSPxkfTwn6fC9E7Rp0cNf+wpQjc7
   6ZbyUFKyuDqR9BKmE7Wp1bm3P87QjkECKaqyb4yDxIKbs/zMVgFvSv6YE
   Y=;
X-GBM:	True
X-IronPort-AV: E=Sophos;i="5.26,540,1459810800"; 
   d="scan'208";a="248002907"
Received: from unknown (HELO lonix03001.fm.rbsgrp.net) ([11.160.46.101])
  by remlvdmzma03.rbs.com with ESMTP; 28 Jun 2016 09:50:36 +0100
X-IronPort-AV: E=Sophos;i="5.26,540,1459810800"; 
   d="scan'208";a="1387838655"
X-RBS-Disclaimer: True
Received: from lonms12853.rbsres07.net ([11.161.40.240])
  by lonix03001.fm.rbsgrp.net with ESMTP; 28 Jun 2016 09:50:36 +0100
Received: from LONMS10812.rbsres07.net (11.161.33.187) by
 LONMS12853.rbsres07.net (11.161.40.240) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 28 Jun 2016 09:50:35 +0100
Received: from GBROMEUHUBD0107.rbsres07.net (11.191.100.73) by
 LONMS10812.rbsres07.net (11.161.33.187) with Microsoft SMTP Server (TLS) id
 8.3.444.0; Tue, 28 Jun 2016 09:50:35 +0100
Received: from GBWGCEUHUBD0101.rbsres07.net ([169.254.1.46]) by
 GBROMEUHUBD0107.rbsres07.net ([169.254.7.13]) with mapi id 14.03.0266.001;
 Tue, 28 Jun 2016 09:50:35 +0100
From:	<Ioannis.Kappas@rbs.com>
To:	<git@vger.kernel.org>
Subject: git svn clone segmentation faul issue
Thread-Topic: git svn clone segmentation faul issue
Thread-Index: AdHRFizUNzqjuxhBT2iXB4SW7Alfsg==
Date:	Tue, 28 Jun 2016 08:50:34 +0000
Message-ID: <0BCA1E695085C645B9CD4A27DD59F6FA39AAD5CF@GBWGCEUHUBD0101.rbsres07.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [11.161.18.43]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-WiganSS: 01000000010017LONMS12853.rbsres07.net
	ID0047<0BCA1E695085C645B9CD4A27DD59F6FA39AAD5CF@GBWGCEUHUBD0101.rbsres07.net>
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello,

Git can fail with a "malformed index nnn" error or cause a segmentation fault when executing the "git svn clone" command. 

This is because the git-svn perl script calling into the external subversion library during fetch, wherein a bug exists that can corrupt the Perl Interpreter's stack maintained on the heap. The bug is in a custom swig typemap around the "result_digest" argument which is not handled in a safe manner: An absolute address on the perl stack is calculated beforehand to store the result of svn_swig_pl_from_md5(), but the function can trigger the stack to be reallocated elsewhere in memory (i.e. when trying to grow it but there is not enough space left) thus invaliding the address calculated earlier, causing memory corruption or segmentation fault.

This call is made once for each file retrieved from subversion. The fault is caused when the free available perl stack size is very small at the call, triggering a realloc() moving it elsewhere in memory. In my test environment --MSYS2 on windows 7--, this was caused when the available stack size left was 24 SV* slots. This means that a subversion repository with many file entries has a higher probability to fail while cloning than one with only a few file entries big.

Perl stack trace to the entry point of the offending code is:


        SVN::TxDelta::apply(GLOB(0x60107ece8), GLOB(0x6011ee3a0), undef, SVN::Pool=REF(0x6011ee268)) called at /usr/share/perl5/site_perl/Git/SVN/Fetcher.pm line 368
        Git::SVN::Fetcher::apply_textdelta(Git::SVN::Fetcher=HASH(0x6010236a0), HASH(0x6011ee2e0), undef, _p_apr_pool_t=SCALAR(0x60113e510)) called at /usr/lib/perl5/vendor_perl/SVN/Ra.pm line 623
        SVN::Ra::Reporter::AUTOLOAD(SVN::Ra::Reporter=ARRAY(0x6010e9ee0), SVN::Pool=REF(0x6010ea228)) called at /usr/share/perl5/site_perl/Git/SVN/Ra.pm line 312
        Git::SVN::Ra::gs_do_update(Git::SVN::Ra=HASH(0x60101f4f0), 384103, 384103, Git::SVN=HASH(0x60101fc58), Git::SVN::Fetcher=HASH(0x6010236a0)) called at /usr/share/perl5/site_perl/Git/SVN.pm line 1205
        Git::SVN::do_fetch(Git::SVN=HASH(0x60101fc58), HASH(0x6010e9b20), 384103) called at /usr/share/perl5/site_perl/Git/SVN/Ra.pm line 475
        Git::SVN::Ra::gs_fetch_loop_common(Git::SVN::Ra=HASH(0x60101f4f0), 384103, 384103, ARRAY(0x600788cc8), ARRAY(0x600788ce0)) called at /usr/share/perl5/site_perl/Git/SVN.pm line 179
        Git::SVN::fetch_all("svn") called at /usr/lib/git-core/git-svn line 522
        main::cmd_clone("http://...", "debug") called at /usr/lib/git-core/git-svn line 386
        eval {...} called at /usr/lib/git-core/git-svn line 384

The solution is to change the swig typemap in subversion to delay calculating the stack address where the result is stored after the call to the md5 function:

In subversion's subversion/subversion/bindings/swig/include/svn_types.swg, one can change

From 

%typemap(argout) unsigned char *result_digest {
    %append_output($1);
}

To

%typemap(argout) unsigned char *result_digest {
    SV* ucrdTemp = svn_swig_pl_from_md5($1);             
    %append_output(ucrdTemp);
}


Swig will translate the above typemap in subversion/subversion/bindings/swig/perl/native/svn_delta.c

From

      if (argvi >= items) EXTEND(sp,1);  ST(argvi) = svn_swig_pl_from_md5(arg3); argvi++  ;


to

      SV* ucrdTemp = svn_swig_pl_from_md5(arg3);             
      if (argvi >= items) EXTEND(sp,1);  ST(argvi) = ucrdTemp; argvi++  ;

(The stack address calculation is the results of calling the macro ST(argvi) ).

I am not a Perl expert, but ST(n) = any_function() seems to be a dangerous idiom because of the potential of any_function() to cause a Perl stack reallocation invaliding the address calculated beforehand by ST(n).


The above patch has been tested to work in my codebase both on windows 7 (with MSYS2) and on Arch Linux, where it would have caused a segmentation fault otherwise.


Fortunately, a patch has already been submitted to subversion with (github) revision a074af86c8764404b28ce99d0bedcb668a321408 (at https://github.com/apache/subversion/commit/a074af86c8764404b28ce99d0bedcb668a321408 ) on the trunk to handle this and a couple of other similar cases. But by the looks of it has not been picked up yet in the latest subversion 1.9.4 release or the 1.9.x branch, perhaps because this patch was identified in sanity checks rather than coming out from a perceivable production issue?

Although this issue is not in the Git source code, I thought reporting this error here first since it is Git that stresses the subversion perl bindings in such a level to cause the failure. Perhaps the patch can be applied first in those git binary releases that include subversion (I believe Git for windows is such a case) while in the mean time I submit this case for consideration in the subversion bug tracking system.

Yannis

*********************************************************************************** 
The Royal Bank of Scotland plc. Registered in Scotland No 90312. 
Registered Office: 36 St Andrew Square, Edinburgh EH2 2YB. 
Authorised by the Prudential Regulation Authority and regulated 
by the Financial Conduct Authority and Prudential Regulation Authority. 
The Royal Bank of Scotland N.V. is authorised and regulated by the 
De Nederlandsche Bank and has its seat at Amsterdam, the 
Netherlands, and is registered in the Commercial Register under 
number 33002587. Registered Office: Gustav Mahlerlaan 350, 
Amsterdam, The Netherlands. The Royal Bank of Scotland N.V. and 
The Royal Bank of Scotland plc are authorised to act as agent for each 
other in certain jurisdictions. 
  
This e-mail message is confidential and for use by the addressee only. 
If the message is received by anyone other than the addressee, please 
return the message to the sender by replying to it and then delete the 
message from your computer. Internet e-mails are not necessarily 
secure. The Royal Bank of Scotland plc and The Royal Bank of Scotland 
N.V. including its affiliates ("RBS group") does not accept responsibility 
for changes made to this message after it was sent. For the protection
of RBS group and its clients and customers, and in compliance with
regulatory requirements, the contents of both incoming and outgoing
e-mail communications, which could include proprietary information and
Non-Public Personal Information, may be read by authorised persons
within RBS group other than the intended recipient(s). 

Whilst all reasonable care has been taken to avoid the transmission of 
viruses, it is the responsibility of the recipient to ensure that the onward 
transmission, opening or use of this message and any attachments will 
not adversely affect its systems or data. No responsibility is accepted 
by the RBS group in this regard and the recipient should carry out such 
virus and other checks as it considers appropriate. 

Visit our website at www.rbs.com 
***********************************************************************************  

