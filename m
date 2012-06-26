From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/9] git p4 test: simplify quoting involving TRASH_DIRECTORY
Date: Tue, 26 Jun 2012 08:24:06 +0200
Message-ID: <4FE95586.8090803@viscovery.net>
References: <1340673505-10551-1-git-send-email-pw@padd.com> <1340673505-10551-4-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 08:24:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjPCB-0001D0-WE
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 08:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab2FZGYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 02:24:12 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:41706 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab2FZGYL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 02:24:11 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SjPDN-0004UA-Jl; Tue, 26 Jun 2012 08:25:29 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7BAD61660F;
	Tue, 26 Jun 2012 08:24:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <1340673505-10551-4-git-send-email-pw@padd.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200633>

Am 6/26/2012 3:18, schrieb Pete Wyckoff:
>  test_expect_success 'exit when p4 fails to produce marshaled output' '
> -	badp4dir="$TRASH_DIRECTORY/badp4dir" &&
> -	mkdir "$badp4dir" &&
> -	test_when_finished "rm \"$badp4dir/p4\" && rmdir \"$badp4dir\"" &&
> -	cat >"$badp4dir"/p4 <<-EOF &&
> +	mkdir badp4dir &&
> +	test_when_finished "rm badp4dir/p4 && rmdir badp4dir" &&
> +	cat >badp4dir/p4 <<-EOF &&
>  	#!$SHELL_PATH
>  	exit 1
>  	EOF
> -	chmod 755 "$badp4dir"/p4 &&
> -	PATH="$badp4dir:$PATH" git p4 clone --dest="$git" //depot >errs 2>&1 ; retval=$? &&
> +	chmod 755 badp4dir/p4 &&
> +	PATH="$TRASH_DIRECTORY/badp4dir:$PATH" git p4 clone --dest="$git" //depot >errs 2>&1 ; retval=$? &&
>  	test $retval -eq 1 &&

The long line here is severly broken, because the semicolon breaks the &&
chain; retval would be assigned to even if one of the earlier commands
fails, and that you don't want to treat as success. The least that is
needed is to put the line in braces. But I suggest to rewrite the two
lines above as

	(
		PATH="$TRASH_DIRECTORY/badp4dir:$PATH" &&
		export PATH &&
		test_expect_code 1 git p4 clone --dest="$git" //depot >errs 2>&1
	) &&

>  	test_must_fail grep -q Traceback errs

We don't expect that grep fails due to segfault or something. Write this
line as

	! grep Traceback errs

Also drop the -q; if the test detects a failure, you do want to see the
grep output in a verbose test run.

-- Hannes
