From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] t0005: skip signal death exit code test on Windows
Date: Fri, 07 Jun 2013 08:22:53 +0200
Message-ID: <51B17C3D.6000703@viscovery.net>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <51AEE1C3.9020507@viscovery.net> <20130605071206.GC14427@sigill.intra.peff.net> <51B02D81.3000700@viscovery.net> <20130606063754.GA20050@sigill.intra.peff.net> <CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com> <20130606064409.GA20334@sigill.intra.peff.net> <7vy5anyx1w.fsf@alter.siamese.dyndns.org> <20130606174032.GB32174@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 07 08:23:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukq4s-0003AO-IS
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 08:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810Ab3FGGXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 02:23:04 -0400
Received: from so.liwest.at ([212.33.55.13]:48631 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752312Ab3FGGXA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 02:23:00 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ukq4b-0001t0-SS; Fri, 07 Jun 2013 08:22:54 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 847EB1660F;
	Fri,  7 Jun 2013 08:22:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <20130606174032.GB32174@sigill.intra.peff.net>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226607>

Am 6/6/2013 19:40, schrieb Jeff King:
> On Thu, Jun 06, 2013 at 10:21:47AM -0700, Junio C Hamano wrote:
> 
>>> The particular deficiency is that when a signal is raise()d whose SIG_DFL
>>> action will cause process death (SIGTERM in this case), the
>>> implementation of raise() just calls exit(3).
>>
>> After a bit of web searching, it seems to me that this behaviour of
>> raise() is in msvcrt, and compat/mingw.c::mingw_raise() just calls
>> that.  In other words, "the implementation of raise()" is at an even
>> lower level than mingw/msys, and I would agree that it is a platform
>> issue.
> 
> Yeah, if it were mingw_raise responsible for this, I would suggest using
> the POSIX shell "128+sig" instead. We could potentially check for
> SIG_DFL[1] mingw_raise and intercept and exit there. I don't know if
> that would create headaches or confusion for other msys programs,
> though. I'd leave that up to the msysgit people to decide whether it is
> worth the trouble.

Even if we move the signal emulation closer to POSIX in the way that you
suggested (if that were possible, I haven't checked), the emulation is
still not complete, because we would have addressed only raise().
Therefore, personally I would like to delay the issue until there is a
user (script) that depends on POSIXly exit codes.

As far as t0005.2 is concerned, its the best to just concede that Windows
does not have POSIX-like behavior as far as signals are concerned, and
skip the test.

We could also sweep the issue under the rug with the patch below, which
works because SIGALRM does not exist in MSVCRT and is handled entirely by
compat/mingw.c. But it goes into the wrong direction, IMO.

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index ad9e604..68b6c3b 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -12,9 +12,8 @@ EOF
 test_expect_success 'sigchain works' '
 	test-sigchain >actual
 	case "$?" in
-	143) true ;; # POSIX w/ SIGTERM=15
-	271) true ;; # ksh w/ SIGTERM=15
-	  3) true ;; # Windows
+	142) true ;; # POSIX w/ SIGALRM=14
+	270) true ;; # ksh w/ SIGTERM=14
 	  *) false ;;
 	esac &&
 	test_cmp expect actual
@@ -23,8 +22,8 @@ test_expect_success 'sigchain works' '
 test_expect_success 'signals are propagated using shell convention' '
 	# we use exec here to avoid any sub-shell interpretation
 	# of the exit code
-	git config alias.sigterm "!exec test-sigchain" &&
-	test_expect_code 143 git sigterm
+	git config alias.sigalrm "!exec test-sigchain" &&
+	test_expect_code 142 git sigalrm
 '

 test_done
diff --git a/test-sigchain.c b/test-sigchain.c
index 42db234..0233a39 100644
--- a/test-sigchain.c
+++ b/test-sigchain.c
@@ -14,9 +14,9 @@ X(three)
 #undef X

 int main(int argc, char **argv) {
-	sigchain_push(SIGTERM, one);
-	sigchain_push(SIGTERM, two);
-	sigchain_push(SIGTERM, three);
-	raise(SIGTERM);
+	sigchain_push(SIGALRM, one);
+	sigchain_push(SIGALRM, two);
+	sigchain_push(SIGALRM, three);
+	raise(SIGALRM);
 	return 0;
 }
