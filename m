From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [RFH] NetBSD 6?
Date: Thu, 03 Jan 2013 20:28:43 +0100
Message-ID: <50E5DBEB.9080009@gmail.com>
References: <7vd2xn18p5.fsf@alter.siamese.dyndns.org> <rmipq1numzj.fsf@fnord.ir.bbn.com> <7vd2xnypt6.fsf@alter.siamese.dyndns.org> <rmi8v8av05d.fsf@fnord.ir.bbn.com> <7vvcbew895.fsf@alter.siamese.dyndns.org> <rmiobh6rujt.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 20:29:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqqTX-0006Kl-JH
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 20:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843Ab3ACT2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 14:28:52 -0500
Received: from mail-bk0-f41.google.com ([209.85.214.41]:34373 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708Ab3ACT2u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 14:28:50 -0500
Received: by mail-bk0-f41.google.com with SMTP id jg9so6820478bkc.14
        for <git@vger.kernel.org>; Thu, 03 Jan 2013 11:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=d6DutT91mH7XZoaZYfecBZwbEF9bH9Bivucf6eL3+Is=;
        b=blWxaeVE4AAeeQ11smKlB8s24NR3CxZ7xNai6xi5lIRyi3b5WUD6hGuLyCnC3lMy1o
         N7wRZrqNmksjWzfWfFOd88hnxaJr5nExp+DeuMvgYPoG7yP/eZ2nHXBKmCyk9jTpe4xv
         koBI9wCaypOIwBKLdReZQp3KvAE07sZTRA1+YZXPY6haWvPRptFmgmfY9CSSxScLO6oX
         0TDmmlokWpN9n9FJQRobOt4TsK002alhfKEnZmQ6TaxRIlqNtw2rWULLY7xDngRwcCsv
         ey4y/kJJuTGrq75Ln/+PtJcq0OuModoG9FvDNP9/jZiuWBWG50zt4BZ3qqClJa2anlNU
         ZBdA==
X-Received: by 10.204.148.195 with SMTP id q3mr24050672bkv.122.1357241329007;
        Thu, 03 Jan 2013 11:28:49 -0800 (PST)
Received: from [192.168.178.21] (host137-94-dynamic.4-87-r.retail.telecomitalia.it. [87.4.94.137])
        by mx.google.com with ESMTPS id i20sm35000267bkw.5.2013.01.03.11.28.45
        (version=SSLv3 cipher=OTHER);
        Thu, 03 Jan 2013 11:28:48 -0800 (PST)
In-Reply-To: <rmiobh6rujt.fsf@fnord.ir.bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212604>

On 01/03/2013 07:27 PM, Greg Troxel wrote:
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> I forgot to mention that we also ship configure (and keep track of
>> configure.ac) so that optionally people can let autoconf machinery
>> to create config.mak.autogen to be included at the same place as
>> handcrafted config.mak in their build process.  I do not offhand
>> know if we do "for p in python python2.6 python2.7; do ..." kind of
>> thing, though.
> 
> pkgsrc uses the configure method, but it seems not to output a
> PYTHON_PATH.  It looks like automake's python.m4 is not used by git's
> configure.ac.
>
That is not surprising, since Git build system doesn't use Automake :-)

In addition, it's worth nothing that Automake's python support (both
in its m4 and make components) is intended as an help to install python
*modules* from Autotools-based packages; using it for mere stand-alone
scripts would be overkill.

In the case of Git, an adapted version of something like this might
be enough:

  AC_CHECK_PROGS([PYTHON], [python python2.7 python2.6 python2.5])
  if test -z "$PYTHON"; then
    AC_MSG_WARNING([python not found])
  fi

  $PYTHON -c 'check-not-py3k' || AC_MSG_WARNING([Python 3 is not supported])
  $PYTHON -c 'check-its-version' || AC_MSG_WARNING([python is too old])

(Automake itself uses, in its own build system, a similar idiom to
look for a Perl interpreter at configure runtime).

Not my itch so far, but I will happily review a patch if anyone is
willing to write it.

> But pkgsrc passes PYTHON_PATH in the environment to make,
> so it works out currently.
> 
>> It refers to the type of the second parameter to iconv(); OLD_ICONV
>> makes it take "const char *", as opposed to "char *", the latter of
>> which matches
>>
>>   http://pubs.opengroup.org/onlinepubs/9699919799/functions/iconv.html
> 
> Thanks - I now see our extra const and am looking into it.

Regards,
  Stefano
