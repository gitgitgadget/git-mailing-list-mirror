From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] run-command: write full error message in die_child
Date: Wed, 20 Apr 2011 09:42:30 +0200
Message-ID: <4DAE8E66.5060705@viscovery.net>
References: <7v8vv78eld.fsf@alter.siamese.dyndns.org> <7v4o5v8dlp.fsf@alter.siamese.dyndns.org> <20110419070510.GB28291@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 09:42:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCS3b-00084b-Hv
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 09:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910Ab1DTHme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 03:42:34 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19739 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753530Ab1DTHmd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 03:42:33 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QCS3S-0004CO-Hg; Wed, 20 Apr 2011 09:42:31 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4B02B1660F;
	Wed, 20 Apr 2011 09:42:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110419070510.GB28291@elie>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171851>

Am 4/19/2011 9:05, schrieb Jonathan Nieder:
> diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> index 10b26e4..be602fd 100755
> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -7,8 +7,32 @@ test_description='Test run command'
>  
>  . ./test-lib.sh
>  
> +cat >hello-script <<-EOF
> +	#!$SHELL_PATH
> +	echo hello
> +EOF
> +>empty
> +

Unfortunately, on Windows, the bash spawnd by git converts LF to CRLF...

>  test_expect_success 'start_command reports ENOENT' '
>  	test-run-command start-command-ENOENT ./does-not-exist
>  '
>  
> +test_expect_success 'run_command can run a command' '
> +	echo hello >expect &&
> +	cat hello-script >hello.sh &&
> +	chmod +x hello.sh &&
> +	test-run-command run-command ./hello.sh >actual 2>err &&
> +
> +	test_cmp expect actual &&

... therefore, we fail here. Can we have this squashed in, because 'cat'
leaves LFs alone?

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index be602fd..979b478 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -9,7 +9,7 @@ test_description='Test run command'
 
 cat >hello-script <<-EOF
 	#!$SHELL_PATH
-	echo hello
+	cat hello-script
 EOF
 >empty
 
@@ -18,12 +18,11 @@ test_expect_success 'start_command reports ENOENT' '
 '
 
 test_expect_success 'run_command can run a command' '
-	echo hello >expect &&
 	cat hello-script >hello.sh &&
 	chmod +x hello.sh &&
 	test-run-command run-command ./hello.sh >actual 2>err &&
 
-	test_cmp expect actual &&
+	test_cmp hello-script actual &&
 	test_cmp empty err
 '
 


> +test_expect_success POSIXPERM,SANITY 'run_command reports EACCES' '

Thanks for this detail (POSIXPERM). It's required. I did not check whether
SANITY is really needed; I trust you did.

-- Hannes
