From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 2/8] t5520: test no merge candidates cases
Date: Mon, 18 May 2015 17:08:38 +0200
Organization: gmx
Message-ID: <e89b333476cbb1e546371a07b357cd42@www.dscho.org>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
 <1431955978-17890-3-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Jeff King <peff@peff.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 17:09:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMf6-00051Z-3o
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbbERPIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:08:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:54927 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290AbbERPIn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:08:43 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LqW8j-1ZParu21ZZ-00e2Br; Mon, 18 May 2015 17:08:39
 +0200
In-Reply-To: <1431955978-17890-3-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:WrxW3jiGMkE4NS7gRM3lCA92gJl7/BeG06kX38dH/c/igs36ENv
 eK9EAVgbn+dd0fX4zgHcMyvvxw6ZCO5kAc9z9WiWhgY1VQfAg+wuaVaq8bPxOFN7H/j2ci3
 PZAgLfVSqeUQA7W9JueLKWc6GPDXVto7RzeYA7s1P+KC3wtzTXJxoQUQXaARSHc7J9vHfNn
 aByX30g3Hyrz8rIvNvyNA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269274>

Hi Paul,

On 2015-05-18 15:32, Paul Tan wrote:

> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 5e4db67..4a2c0a1 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -109,6 +109,61 @@ test_expect_success 'the default remote . should
> not break explicit pull' '
>  	test "$(cat file)" = modified
>  '
>  
> +test_expect_success 'fail if wildcard spec does not match any refs' '
> +	git checkout -b test copy^ &&
> +	test_when_finished "git checkout -f copy && git branch -D test" &&

When I read this line, I immediately asked myself whether the branch would be deleted even if the test case failed. I then tested this theory by editing the first test case ("setup") like this:

-- snip --
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 227d293..3adc702 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -15,9 +15,12 @@ test_expect_success setup '
 
 	echo file >file &&
 	git add file &&
+test_when_finished "rm file" &&
+false &&
 	git commit -a -m original
 
 '
+exit 1
 
 test_expect_success 'pulling into void' '
 	mkdir cloned &&
-- snap --

and indeed, the file "file" was gone, even if the test case failed. I therefore believe that this "test_when_finished" cleanup might make debugging substantially harder. Maybe we can drop these lines from this patch?

Ciao,
Dscho
