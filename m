From: "Giovanni Funchal" <gafunchal@gmail.com>
Subject: Re: Patch for NO_R_TO_GCC_LINKER
Date: Wed, 13 Aug 2008 23:20:27 +0200
Message-ID: <c475e2e60808131420h5b7350abq188b3f8a53b51d98@mail.gmail.com>
References: <c475e2e60808130342r452fae1cm7d08d8d2206d0468@mail.gmail.com>
	 <7vy730n0ac.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 23:21:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTNmf-0002pX-0G
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 23:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbYHMVUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 17:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752202AbYHMVUa
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 17:20:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:10312 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbYHMVU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 17:20:29 -0400
Received: by nf-out-0910.google.com with SMTP id d3so93877nfc.21
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ahVrNk70EBLdDOQEQOksb7Z2UenYQ+9k5F6kR1bkcaU=;
        b=Xcu8RoA69kiqkN1E6Z5O5PUnuxeu2E5dv8VAWkkdqOyVb3trKtw2/kdQLqcNvAnwL8
         ojLgMCz8LoAdnZ6m3z8dy8+tjRrlpsC0SdtIzkT0oKG283Gcojg24m1jBKZGE7ZpJhUc
         UBSM1mdEh29vv66c5onvMEyFO4o9BL2RGYNk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=pqKxm1sOFu770AP4ljw9sZYlIiQidvAUaAzPanYHd7qjUH6oFlX7bM1m2luqlTV/rY
         dPJnaiJ5SqcnpfnodKBrvlhVmoQy2coYzk5oi9E6iKu22L8/z49SkradX24r0eogVA3i
         26cRA6KbXj4HbhuSochuNQuoLup8WV8o+VKG8=
Received: by 10.187.210.10 with SMTP id m10mr17721faq.19.1218662427780;
        Wed, 13 Aug 2008 14:20:27 -0700 (PDT)
Received: by 10.187.245.17 with HTTP; Wed, 13 Aug 2008 14:20:27 -0700 (PDT)
In-Reply-To: <7vy730n0ac.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92276>

> In this project, use of configure is strictly optional and Makefile is
> more canonical than autoconf generated configure.  Unless absolutely
> necessary, I'd prefer to have a solution that does _not_ change the set of
> make variables people need to override from the command line.

My changes should not break a lot of people's setups. Most people will
find the new default better because it works straight on
linux/windows. I have tested it on ubuntu gcc 4.2.3, fedora gcc 3.2.3
and sunos gcc 3.4.2 and only sunos require ./configure or command line
arg. In addition this should provide better support for people running
AIX, IRIX and HP-UX which, to my best knowledge, have a different way
around runtime paths. Although very improbable, the changes might
indeed break some setups, but keep reading...

> Changes to configure.ac so that generated script sets NO_R_TO_GCC_LINKER
> appropriately would fit the current model much better and would not break
> people's existing setups that do not use configure.

This is contradictory... how can changes ONLY to configure.ac make
rpath work for people NOT using configure?

Try to face it like this: current Makefile support for rpath is
broken. Defaults are bad and the NO_R_TO_GCC_LINKER is totally ugly
and do not cover the case when neither "-Wl,rpath," nor "-R" are the
right choice. In addition if you do not test for flags support
(running configure), you cannot have better warnings when things go
wrong.

Regards,
-- Giovanni

On Wed, Aug 13, 2008 at 10:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Giovanni Funchal" <gafunchal@gmail.com> writes:
>
>> diff --git a/Makefile b/Makefile
>> index 90c5a13..6e20b08 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -111,9 +111,8 @@ all::
>>  #
>>  # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
>>  #
>> -# Define NO_R_TO_GCC_LINKER if your gcc does not like "-R/path/lib"
>> -# that tells runtime paths to dynamic libraries;
>> -# "-Wl,-rpath=/path/lib" is used instead.
>> +# LD_RUNPATH_SWITCH specifies how to pass the runtime dynamic library paths
>> +# to the linker. The default is "-Wl,-rpath,".
>
> Can you make your change to configure.ac to minimize changes to the
> Makefile?
>
> In this project, use of configure is strictly optional and Makefile is
> more canonical than autoconf generated configure.  Unless absolutely
> necessary, I'd prefer to have a solution that does _not_ change the set of
> make variables people need to override from the command line.
>
> Changes to configure.ac so that generated script sets NO_R_TO_GCC_LINKER
> appropriately would fit the current model much better and would not break
> people's existing setups that do not use configure.
>
>
>
>
