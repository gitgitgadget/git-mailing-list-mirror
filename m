From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] bundle: fix wrong check of read_header()'s return value & add tests
Date: Tue, 06 Mar 2007 22:06:24 -0800
Message-ID: <7vslchio4f.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0703062256200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0703070613530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 07 07:06:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOpIH-00039X-Kn
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 07:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbXCGGG0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 01:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbXCGGG0
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 01:06:26 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:53740 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932127AbXCGGGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 01:06:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070307060626.CTOZ2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Mar 2007 01:06:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Xi6Q1W00Y1kojtg0000000; Wed, 07 Mar 2007 01:06:25 -0500
In-Reply-To: <Pine.LNX.4.63.0703070613530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 7 Mar 2007 06:15:12 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41653>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I fear this would suffer the same fate as t8001, namely that some sed 
> would add a newline, which is plain wrong here. This is a workaround:
>
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index ce96b4b..f895072 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -110,7 +110,7 @@ test_expect_failure 'unbundle 1' '
>  
>  test_expect_success 'bundle 1 has only 3 files ' '
>  	cd "$D" &&
> -	sed "1,4d" < bundle1 > bundle.pack &&
> +	dd bs=136 skip=1 if=bundle1 of=bundle.pack &&

We might want to reword or enhance the headers later, and 136 is
a horrible workaround.

Would this work?

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ce96b4b..ad589dd 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -110,9 +110,16 @@ test_expect_failure 'unbundle 1' '
 
 test_expect_success 'bundle 1 has only 3 files ' '
 	cd "$D" &&
-	sed "1,4d" < bundle1 > bundle.pack &&
+	(
+		while read x && test -n "$x"
+		do
+			:;
+		done
+		cat
+	) <bundle1 >bundle.pack &&
 	git index-pack bundle.pack &&
-	test 4 = $(git verify-pack -v bundle.pack | wc -l)
+	verify=$(git verify-pack -v bundle.pack) &&
+	test 4 = $(echo "$verify" | wc -l)
 '
 
 test_expect_success 'unbundle 2' '
