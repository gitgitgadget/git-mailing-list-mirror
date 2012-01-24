From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/5] t0061: Add tests
Date: Tue, 24 Jan 2012 16:56:36 -0600
Message-ID: <20120124225636.GF8222@burratino>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
 <1327444346-6243-3-git-send-email-fransklaver@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 23:56:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RppIO-0000z9-5W
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 23:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420Ab2AXW4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 17:56:51 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57704 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab2AXW4u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 17:56:50 -0500
Received: by yhoo21 with SMTP id o21so2129437yho.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 14:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=prk/MAXseGTkKThfT0P74oXHTGxk8uEGQTSRbzJa9Sc=;
        b=mHSSJ5pAx0jyfOXqFi96hGfsYpd6+HozThy0s0NgleEPGPoZpdaXbWXs+y/TA0gzj0
         wwm3+DVNSiVBEyRXhvxJ7JZy6pOfCGZGOaYIJNLwn/elhUJ+MJsjK7jQ/NlEx0Tov6nl
         w1f6N2GGGwabZ8ybfO4X65Z4L7EcSeu5dhKg4=
Received: by 10.236.116.9 with SMTP id f9mr21662499yhh.0.1327445810009;
        Tue, 24 Jan 2012 14:56:50 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 17sm48774179ang.11.2012.01.24.14.56.48
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jan 2012 14:56:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1327444346-6243-3-git-send-email-fransklaver@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189084>

Hi,

Frans Klaver wrote:

> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -13,6 +13,24 @@ cat hello-script
>  EOF
>  >empty
>  
> +cat >someinterpreter <<-EOF
> +#!$SHELL_PATH
> +cat hello-script
> +EOF
> +>empty
> +
> +cat >incorrect-interpreter-script <<-EOF
> +#!someinterpreter
> +cat hello-script
> +EOF
> +>empty

Thanks for writing tests.  Some hints on mechanics below, and one on
strategy (see (*) below).

What is the point of repreatedly writing an empty file named "empty"?

I think this would be easier to read and maintain if scripts not
shared between multiple tests were written in the body of the relevant
tests.  For example, that way it is easier to remember to remove a
helper script if the relevant test assertion changes to no longer need
it.

[...]
> @@ -26,7 +44,7 @@ test_expect_success 'run_command can run a command' '
>  	test_cmp empty err
>  '
>  
>  test_expect_success POSIXPERM 'run_command reports EACCES' '
>  	cat hello-script >hello.sh &&
>  	chmod -x hello.sh &&
>  	test_must_fail test-run-command run-command ./hello.sh 2>err &&
[...]
> +test_expect_success POSIXPERM 'run_command reports EACCES, search path perms' '
> +	mkdir -p inaccessible &&
> +	PATH=$(pwd)/inaccessible:$PATH &&
> +	export PATH &&
> +
> +	cat hello-script >inaccessible/hello.sh &&
> +	chmod 400 inaccessible &&
> +	test_must_fail test-run-command run-command hello.sh 2>err &&
> +	chmod 755 inaccessible &&
> +
> +	grep "fatal: cannot exec.*hello.sh" err
> +'

(*) These tests would be easier to understand if squashed with the
relevant later patch in the series that changes the error message.

Maybe they could be less repetitive that way, too.

	test_expect_success POSIXPERM 'diagnose command in inaccessible part of $PATH' '
		mkdir -p subdir &&
		cat hello-script >subdir/hello.sh &&
		chmod +x subdir/hello.sh &&
		chmod -x subdir &&
		(
			PATH=$(pwd)/inaccessible:$PATH &&
			test_must_fail test-run-command run-command hello.sh 2>err
		) &&
		test_i18ngrep ...
	'

[...]
> +test_expect_success POSIXPERM 'run_command reports EACCES, interpreter fails' '
> +	cat incorrect-interpreter-script >hello.sh &&
> +	chmod +x hello.sh &&
> +	chmod -x someinterpreter &&
> +	test_must_fail test-run-command run-command ./hello.sh 2>err &&
> +
> +	grep "fatal: cannot exec.*hello.sh" err
> +'

Is this the common case?  Why would my interpreter be in the designated
spot but not marked executable?  Is there some other motivating
example?  (I'm genuinely curious; it's ok if the answer is "no".)

[...]
> +
> +test_expect_failure POSIXPERM 'run_command reports ENOENT, interpreter' '
> +	cat non-existing-interpreter >hello.sh &&
> +	chmod +x hello.sh &&
> +	test_must_fail test-run-command start-command-ENOENT ./hello.sh 2>err &&
> +
> +	grep "error: cannot exec.*hello.sh" err
> +'

Maybe:

	test_expect_success POSIXPERM 'diagnose missing interpreter' '
		echo "#!/nonexistent/interpreter" >hello.sh &&
		chmod +x hello.sh &&
		test_must_fail test-run-command run-command hello.sh 2>err &&
		test_i18ngrep ...
	'

Hope that helps,
Jonathan
