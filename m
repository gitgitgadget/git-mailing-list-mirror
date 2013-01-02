From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v2] build: do not automatically reconfigure unless configure.ac
 changed
Date: Wed, 02 Jan 2013 20:35:18 +0100
Message-ID: <50E48BF6.2020900@gmail.com>
References: <CANiSa6jt7_ixi7L6U9sfpV2mvT_7zgYV+m+sLiXjkDsFehAuwA@mail.gmail.com> <20130102072141.GB18974@elie.Belkin> <CANiSa6iMea95ELqS3-w01bL=LTgE9Cx6+8sXK=s-pPPFwjGCCA@mail.gmail.com> <20130102082544.GD18974@elie.Belkin> <20130102083837.GA9328@sigill.intra.peff.net> <20130102084807.GB22919@elie.Belkin> <50E4409B.4070203@gmail.com> <7va9sr4jgu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 20:35:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqU6I-0005GX-Li
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 20:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668Ab3ABTfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 14:35:24 -0500
Received: from mail-ee0-f44.google.com ([74.125.83.44]:42351 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab3ABTfW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 14:35:22 -0500
Received: by mail-ee0-f44.google.com with SMTP id b47so6991506eek.17
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 11:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5lTk5ObO6YFh8OxHrE8jQZKSOQF9oNW/hOe7jc8XbUw=;
        b=PAQc2dmutgyP5zI/v9AGEA02b/BfccgivQZgOgsk+oKrjQS6FxGGxnNTuKwN+ILwb6
         r/DZffvkNAX5PBD+iWO3OU4LO2qd7QiFUV77KkiIO9IBpMi6u+Tu07YmnWGaqttf0mKG
         n0uocj+xiTxVW5oi0hTj+X/8zaSWfzm67q8lTBbrFTr8omL0dgOj20ZLMFE3m7aLMCNU
         Y/spzqW2xGfT2wBRRxXFn5ykTTuVTrwLr7DEN91RVxOlllRl0EF8jTzrE6IPmYt0j2jZ
         37MVOwITL48bCpGt4hFVx04fU7OmMxwbuWFBNdliC6y4snBrMYn/PoG7+SiYQpk0DBt/
         MkZw==
X-Received: by 10.14.205.199 with SMTP id j47mr127308316eeo.26.1357155321735;
        Wed, 02 Jan 2013 11:35:21 -0800 (PST)
Received: from [192.168.178.21] (host137-94-dynamic.4-87-r.retail.telecomitalia.it. [87.4.94.137])
        by mx.google.com with ESMTPS id f49sm99404764eep.12.2013.01.02.11.35.19
        (version=SSLv3 cipher=OTHER);
        Wed, 02 Jan 2013 11:35:20 -0800 (PST)
In-Reply-To: <7va9sr4jgu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212535>

On 01/02/2013 05:50 PM, Junio C Hamano wrote:
> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
> 
>> On 01/02/2013 09:48 AM, Jonathan Nieder wrote:
>>> Jeff King wrote:
>>>
>>>> It seems I am late to the party. But FWIW, this looks the most sane to
>>>> me of the patches posted in this thread.
>>> ...
>> FYI, this seems a sane approach to me....
>> The only nit I have to offer is that I'd like to see more comments in
>> the git Makefile about why this "semi-hack" is needed.
> 
> Thanks, everybody.
> 
> Please eyeball the below for (hopefully) the last time, to be
> eventually merged to maint-1.7.12, maint-1.8.0 and maint (aka
> maint-1.8.1) branches.
> 
> -- >8 --
> From: Jonathan Nieder <jrnieder@gmail.com>
> Date: Wed, 2 Jan 2013 00:25:44 -0800
> Subject: [PATCH] build: do not automatically reconfigure unless configure.ac changed
> 
> Starting with v1.7.12-rc0~4^2 (build: reconfigure automatically if
> configure.ac changes, 2012-07-19), "config.status --recheck" is
> automatically run every time the "configure" script changes.  In
> particular, that means the configuration procedure repeats whenever
> the version number changes (since the configure script changes to
> support "./configure --version" and "./configure --help"), making
> bisecting painfully slow.
> 
> The intent was to make the reconfiguration process only trigger for
> changes to configure.ac's logic.  Tweak the Makefile rule to match
> that intent by depending on configure.ac instead of configure.
> 
> Reported-by: Martin von Zweigbergk <martinvonz@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Reviewed-by: Jeff King <peff@peff.net>
> Reviewed-by: Stefano Lattarini <stefano.lattarini@gmail.com>
> ---
>  Makefile | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 26b697d..2f5e2ab 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2167,8 +2167,14 @@ configure: configure.ac GIT-VERSION-FILE
>  	$(RM) $<+
>  
>  ifdef AUTOCONFIGURED
> -config.status: configure
> -	$(QUIET_GEN)if test -f config.status; then \
> +# We avoid depending on 'configure' here, because it gets rebuilt
> +# every time GIT-VERSION-FILE is modified, only to update the embedded
> +# version number string, which config.status does not care about.
>
Alas, config.status *do* care about it, in that the '@PACKAGE_VERSION@',
'@PACKAGE_STRING@' and '@DEFS@' substitutions are affected by what is
hard-coded in configure as the version number [1].  But if we do not
use those substitutions in any of our files (and I believe we don't),
then *we* can happily not care about the configure embedded version
number string, and thus avoid the extra configure runs.  Phew.

 [1] Yes, this is a mess.  We know.  Sorry!

> +# We
> +# do want to recheck when the platform/environment detection logic
> +# changes, hence this depends on configure.ac.
> +config.status: configure.ac
> +	$(QUIET_GEN)$(MAKE) configure && \
> +	if test -f config.status; then \
>  	  ./config.status --recheck; \
>  	else \
>  	  ./configure; \

HTH,
  Stefano
