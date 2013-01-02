From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v2] build: do not automatically reconfigure unless configure.ac
 changed
Date: Wed, 02 Jan 2013 21:53:40 +0100
Message-ID: <50E49E54.9050009@gmail.com>
References: <CANiSa6jt7_ixi7L6U9sfpV2mvT_7zgYV+m+sLiXjkDsFehAuwA@mail.gmail.com> <20130102072141.GB18974@elie.Belkin> <CANiSa6iMea95ELqS3-w01bL=LTgE9Cx6+8sXK=s-pPPFwjGCCA@mail.gmail.com> <20130102082544.GD18974@elie.Belkin> <20130102083837.GA9328@sigill.intra.peff.net> <20130102084807.GB22919@elie.Belkin> <50E4409B.4070203@gmail.com> <7va9sr4jgu.fsf@alter.siamese.dyndns.org> <50E48BF6.2020900@gmail.com> <7vbod72uze.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 21:54:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqVKC-0001D1-Pp
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 21:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735Ab3ABUxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 15:53:50 -0500
Received: from mail-ee0-f51.google.com ([74.125.83.51]:46179 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702Ab3ABUxt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 15:53:49 -0500
Received: by mail-ee0-f51.google.com with SMTP id d4so6979211eek.24
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 12:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vRH0ThNJ6tI5DV4L+1DgMQQMlix8tUCcNdA7CxdxtKw=;
        b=hyQ2lvGROXYVBmNrOSoIlpr8qDMOllx8HyfUBXy3hyY4TL5UVKxn54XutZX5c1LZ4w
         rzLn0dtzoCjJPNGp+sY5aQtbng/cotEAKmJC2cpxdjAwW2Htvhxv7xYkLosv2np9ju5o
         lvnM2XNeWnhNBxN2HQq806mkLAsP8V+n9diHnyBudTcERDvPDk3dQVBPRTLP38ux/eoJ
         GE1vpyfsB+hRXq5C1zF5nwOKLxpjsOi77nn0mPF9DDdeRdk2EIw/PLI1VVK3CW6l7zEO
         YXm0tFJdAzLR0kzRpqY0wGJ8Km5HJYvT4rFYbvAb8/VXoahRyp5jcXvztBSB3ySOE8nj
         4YbA==
X-Received: by 10.14.221.65 with SMTP id q41mr127797253eep.30.1357160028021;
        Wed, 02 Jan 2013 12:53:48 -0800 (PST)
Received: from [192.168.178.21] (host137-94-dynamic.4-87-r.retail.telecomitalia.it. [87.4.94.137])
        by mx.google.com with ESMTPS id v46sm99757574eep.1.2013.01.02.12.53.44
        (version=SSLv3 cipher=OTHER);
        Wed, 02 Jan 2013 12:53:47 -0800 (PST)
In-Reply-To: <7vbod72uze.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212539>

On 01/02/2013 09:25 PM, Junio C Hamano wrote:
> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
> 
>>>  ifdef AUTOCONFIGURED
>>> -config.status: configure
>>> -	$(QUIET_GEN)if test -f config.status; then \
>>> +# We avoid depending on 'configure' here, because it gets rebuilt
>>> +# every time GIT-VERSION-FILE is modified, only to update the embedded
>>> +# version number string, which config.status does not care about.
>>>
>> Alas, config.status *do* care about it, in that the '@PACKAGE_VERSION@',
>> '@PACKAGE_STRING@' and '@DEFS@' substitutions are affected by what is
>> hard-coded in configure as the version number [1].  But if we do not
>> use those substitutions in any of our files (and I believe we don't),
>> then *we* can happily not care about the configure embedded version
>> number string, and thus avoid the extra configure runs.  Phew.
>>
>>  [1] Yes, this is a mess.  We know.  Sorry!
> 
> Heh.  Should we warn against the use of these symbols somewhere in
> configure.ac, perhaps, then?
>
Actually, they should be checked against in files processed by
'config.status', i.e., files listed in AC_CONFIG_FILES calls in
'configure.ac'.  But I honestly believe that would be overkill;
I say we simply adjust your comment to read something like:

  # We avoid depending on 'configure' here, because it gets rebuilt
  # every time GIT-VERSION-FILE is modified, only to update the
  # embedded version number string, which we however do not
  # substitute in any file processed by config.status.

Thanks,
  Stefano
