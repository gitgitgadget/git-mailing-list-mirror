From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commit templates are not readable after 'make install'
Date: Wed, 10 Sep 2008 00:23:33 -0700
Message-ID: <7vsks8xy4q.fsf@gitster.siamese.dyndns.org>
References: <3665a1a00809091202u295fedabl53b280aad7bedb62@mail.gmail.com>
 <7v8wu16sbc.fsf@gitster.siamese.dyndns.org>
 <7vprnd5b07.fsf@gitster.siamese.dyndns.org> <48C76A88.2050109@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Sep 10 09:24:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdK4J-00043D-LX
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 09:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbYIJHXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 03:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbYIJHXm
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 03:23:42 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51601 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbYIJHXm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 03:23:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8F22C7A6BD;
	Wed, 10 Sep 2008 03:23:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BFECD7A6BC; Wed, 10 Sep 2008 03:23:35 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6455DF54-7F09-11DD-95DF-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95492>

Johannes Sixt <j.sixt@viscovery.net> writes:

>> diff --git c/templates/Makefile w/templates/Makefile
>> index 0722a92..a12c6e2 100644
>> --- c/templates/Makefile
>> +++ w/templates/Makefile
>> @@ -31,9 +31,11 @@ boilerplates.made : $(bpsrc)
>>  		dir=`expr "$$dst" : '\(.*\)/'` && \
>>  		mkdir -p blt/$$dir && \
>>  		case "$$boilerplate" in \
>> -		*--) ;; \
>> -		*) cp -p $$boilerplate blt/$$dst ;; \
>> -		esac || exit; \
>> +		*--) continue;; \
>> +		esac && \
>> +		cp $$boilerplate blt/$$dst && \
>> +		if test -x "blt/$$dst"; then rx=rx; else rx=r; fi && \
>> +		chmod a+$$rx "blt/$$dst" || exit; \
>>  	done && \
>>  	date >$@
>
> Since only hooks need to be executable, how about this instead:

Hmm. I tried to avoid hardcoding "it so happens that currently the only
executables are hooks".

> diff --git a/templates/Makefile b/templates/Makefile
> index 0722a92..80cd000 100644
> --- a/templates/Makefile
> +++ b/templates/Makefile
> @@ -32,7 +32,12 @@ boilerplates.made : $(bpsrc)
>  		mkdir -p blt/$$dir && \
>  		case "$$boilerplate" in \
>  		*--) ;; \
> -		*) cp -p $$boilerplate blt/$$dst ;; \
> +		hooks--*) \
> +			cp -p "$$boilerplate" "blt/$$dst" && \
> +			chmod a+rx "blt/$$dst";; \
> +		*) \
> +			cp -p "$$boilerplate" "blt/$$dst" && \
> +			chmod a+r "blt/$$dst";; \
>  		esac || exit; \
>  	done && \
>  	date >$@
