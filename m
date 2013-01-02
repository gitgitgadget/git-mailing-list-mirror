From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: Makefile dependency from 'configure' to 'GIT-VERSION-FILE'
Date: Tue, 1 Jan 2013 23:47:19 -0800
Message-ID: <CANiSa6iMea95ELqS3-w01bL=LTgE9Cx6+8sXK=s-pPPFwjGCCA@mail.gmail.com>
References: <CANiSa6jt7_ixi7L6U9sfpV2mvT_7zgYV+m+sLiXjkDsFehAuwA@mail.gmail.com>
	<20130102072141.GB18974@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 08:48:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqJ49-0000qY-UA
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 08:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061Ab3ABHrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 02:47:21 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:43681 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab3ABHrU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 02:47:20 -0500
Received: by mail-ie0-f178.google.com with SMTP id c12so16301726ieb.37
        for <git@vger.kernel.org>; Tue, 01 Jan 2013 23:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=52+9YNFTh8pf47dQqVuqkDNYhMemCDQN8H2OnZIToCc=;
        b=gwEmrjbPp8WRe+SA4sN1kzHnlrRgiwG6+8RKT01595iT2JnnwsECpCf+sb2BF1TaWY
         zNAwWCQQ420fyiEFEM4uW2fK+g2+xBsVLx1MdvQWXJ+Z6JHiYeDXYScAMh+Y0aw3NdDi
         NWU0+2V99ETBO3o3pkZS57xHM9rZhODbsBujNJutGI3KAZGcEplrDuyj+DXxPEY0Bbnw
         VBvhhb4ctZNRpBx+QJNORNZ8gcprdSVIQ1ujHTtt1O4750Y3QU5lendcY6dSWnKr7XlB
         laZnvoR7C3JZFNKiw8hyaLOBdsTMQBySJXkGqCIbnQORgeIFTfQgZAxcaAfOGSBNhmKh
         O9gQ==
Received: by 10.50.196.198 with SMTP id io6mr39559763igc.39.1357112839566;
 Tue, 01 Jan 2013 23:47:19 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Tue, 1 Jan 2013 23:47:19 -0800 (PST)
In-Reply-To: <20130102072141.GB18974@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212499>

On Tue, Jan 1, 2013 at 11:21 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> How about this patch (untested)?

Looks good. Thanks!

>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2267,12 +2267,9 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : unimplemented.sh
>>         mv $@+ $@
>>  endif # NO_PYTHON
>>
>> -configure: configure.ac GIT-VERSION-FILE
>> +configure: configure.ac
> [...]
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -142,7 +142,10 @@ fi
>>  ## Configure body starts here.
>>
>>  AC_PREREQ(2.59)
>> -AC_INIT([git], [@@GIT_VERSION@@], [git@vger.kernel.org])
>> +AC_INIT([git],
>> +       m4_esyscmd([ ./GIT-VERSION-GEN &&
>> +                    { sed -ne 's/GIT_VERSION = //p' GIT-VERSION-FILE | xargs echo -n; } ]),
>> +       [git@vger.kernel.org])
>
> I don't think that would warrant dropping the GIT-VERSION-FILE
> dependency, since the resulting configure script still hard-codes the
> version number.

Yeah, you're right. I was merely sweeping the dependency under the rug :-(

>
> diff --git a/Makefile b/Makefile
> index 736ecd45..2a22041f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2275,7 +2275,7 @@ configure: configure.ac GIT-VERSION-FILE
>         $(RM) $<+
>
>  ifdef AUTOCONFIGURED
> -config.status: configure
> +config.status: configure.ac
>         $(QUIET_GEN)if test -f config.status; then \
>           ./config.status --recheck; \
>         else \

The next line just outside the context here does depend on
'configure', which is why I thought this would not be right. But it
seems impossible to get away from that, and AUTOCONFIGURED should only
be set when ./configure has been run (IIUC), so it's not even
realistic to have "git reconfigure" fail to find "./configure". So,
again, looks good.
