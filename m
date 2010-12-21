From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] convert filter: supply path to external driver
Date: Tue, 21 Dec 2010 12:19:24 -0600
Message-ID: <20101221181924.GB25812@burratino>
References: <20101218223822.GA18902@arf.padd.com>
 <20101219212925.GA7393@arf.padd.com>
 <7vzks1e84p.fsf@alter.siamese.dyndns.org>
 <20101220160911.GA32136@honk.padd.com>
 <7v8vzkcol8.fsf@alter.siamese.dyndns.org>
 <20101221134403.GA10401@honk.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Dec 21 19:19:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV6oO-0000x6-GO
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 19:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463Ab0LUSTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 13:19:43 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:56141 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab0LUSTm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 13:19:42 -0500
Received: by fxm18 with SMTP id 18so4643843fxm.2
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 10:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=m2QDKNknA0RIkz+rhlzEA/uKRVe51Xn4C+NhckRG4cg=;
        b=Jx38JpGXOZbDa6tPKJK3GaMVIaCWdqBD2eQLIakhsoE1cnNcnde/gDbmGDW9j9rmL1
         hrsMsXV1XmPwYDRppgd1AYUWKyk0nRg2r8NZPg8aZFMB0le9g727NSVtCVatoUkZVvTE
         VnM9cYU6vNk4rM2Q3jwRHLzr9Zb3KxO/hK8xw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ln5EEi0MabBSpmiHxLqwP5n6IO7kLcLQEf3yHiGRbQWeNYuDLF+P2+8Zf4ziy8rsLM
         kLDbGovZ1c1ec/xzkKRh4MhxR84R1WuNerJLa0dLL0Du05ZH6KpjI0qQmxr6RJ1wO/NT
         2mm1G0zb8j1/IhsiFIN0NIjBdsY9yOaC+fEj8=
Received: by 10.223.95.199 with SMTP id e7mr2441528fan.39.1292955581218;
        Tue, 21 Dec 2010 10:19:41 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id n15sm1428795fam.12.2010.12.21.10.19.37
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 21 Dec 2010 10:19:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101221134403.GA10401@honk.padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164044>

Hi,

Pete Wyckoff wrote:

> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh

Nitpicks (some silly, some not):

> @@ -93,4 +93,51 @@ test_expect_success expanded_in_repo '
>  	cmp expanded-keywords expected-output
>  '
>  
> +cat <<EOF >argc.sh
> +#!$SHELL_PATH
> +echo argc: \$# "\$@"
> +echo argc running >&2
> +EOF
> +chmod +x argc.sh

You can embed this in a test_expect_success stanza (like the next
one or the earlier "setup") like so:

	cat <<-EOF >argc.sh &&
	#!$SHELL_PATH
	...
	EOF
	chmod +x argc.sh &&

This way if the "chmod" fails on some platform the test would
catch that.

> +
> +#
> +# The use of %f in a filter definition is expanded to the path to
> +# the filename being smudged or cleaned.  It must be shell escaped.
> +#

I'd even prefer to see this comment inside the test_expect_success
assertion so it can be printed when running the test with "-v".
But I suppose consistency with the other test in the script suggests
otherwise.

[...]
> +    echo some test text > test
> +    cat test > $norm &&
> +    cat test > "$spec" &&

Missing && after "> test".  Probably best to remove the space
after > (just for consistency[1]).  Also, please use tabs to indent.

[...]
> +    # make sure argc.sh counted the right number of args
> +    echo "argc: 1 $norm" > res &&
> +    cmp res $norm &&

test_cmp?  (for nicer output)  See t/README.

[...]
> +    # %f with other args
> +    git config filter.argc.smudge "./argc.sh %f --myword" &&
> +    rm $norm "$spec" &&
> +    git checkout -- $norm "$spec" &&
> +
> +    # make sure argc.sh counted the right number of args
> +    echo "argc: 2 $norm --myword" > res &&
> +    cmp res $norm &&
> +    echo "argc: 2 $spec --myword" > res &&
> +    cmp res "$spec" &&

Probably would be clearer if this were a separate test assertion.

> +    :
> +'
> +
>  test_done

Thanks for the tests.  I haven't looked at the substance, alas,
but hope that helps nonetheless.

Jonathan

[1] Trumped up justification for the "no space after >" style: if I
always include a space after, I would be tempted to use

	noisy_command > /dev/null 2> &1

But that does not work because >& is recognized as a single token.
