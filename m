From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] clone: local URLs are not for ssh
Date: Sat, 05 Oct 2013 21:48:37 +0200
Message-ID: <52506D15.9040206@web.de>
References: <201309282137.21802.tboegi@web.de> <CACsJy8B-wA=bX6+E6O6UvX2vEtOwnR1PCMZNoi-q0x_jacB89Q@mail.gmail.com> <524C6885.8020602@web.de> <CACsJy8DjPiwpMvLe2p+dGBdpU6iTg2my7tddBsQwLnHiHdG8wQ@mail.gmail.com> <20131003013127.GA7917@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 05 21:48:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSXqS-0005ZS-Dc
	for gcvg-git-2@plane.gmane.org; Sat, 05 Oct 2013 21:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378Ab3JETsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Oct 2013 15:48:41 -0400
Received: from mout-xforward.web.de ([82.165.159.35]:61657 "EHLO
	mout-xforward.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab3JETsl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Oct 2013 15:48:41 -0400
X-Greylist: delayed 47929 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Oct 2013 15:48:40 EDT
Received: from [192.168.209.26] ([217.208.218.204]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MgO8g-1V88u03I8s-00Nm2Z for <git@vger.kernel.org>;
 Sat, 05 Oct 2013 21:48:39 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <20131003013127.GA7917@sigill.intra.peff.net>
X-Provags-ID: V03:K0:3ohxzwvdprhAYlq8AAdDZBPiTyti3gX4vTBsNewer6/Y1xadOWS
 Ipc/una1ehvIaJtyUoM2bAymlqJoHfaY8+U0IRE6B9HD4iWU+y7fbJKtW2BCSMBnN2/9VWP
 U4Wjivk0/3M01N92VmUh+vt1tEC0CccUE+PL75NAe+e0KuzcCvJcG9WthX6VqFqztHf4ynE
 bK0iyup6clsDUZX7fMbqA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235728>

On 2013-10-03 03.31, Jeff King wrote:
> On Thu, Oct 03, 2013 at 08:01:23AM +0700, Nguyen Thai Ngoc Duy wrote:
> 
>>> Sorry for the noise, I noticed it when I was trying to construct test cases.
>>>
>>> What do we think about adding this at the end of t5505:
>>
>> As usual more tests are usually better. But is t5505-remote.sh the
>> best place? That file seems about "git remote"..
> 
> Yeah, agreed. How about at the end of t5601, after the ssh wrapper I set
> up here:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/235473

Thanks for the review & pointer.
To get it working, a little tweak was needed here, please see below.

diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exec.sh
index d232e94..37464aa 100755
--- a/t/t5602-clone-remote-exec.sh
+++ b/t/t5602-clone-remote-exec.sh
@@ -62,21 +62,20 @@ expect_ssh () {
 
 test_expect_success 'cloning myhost:src uses ssh' '
        clear_ssh &&
-       git clone myhost:src ssh-clone &&
+       ! git clone myhost:src ssh-clone &&
        expect_ssh myhost src
 '
 
-test_expect_success NOT_MINGW,NOT_CYGWIN 'clone local path foo:bar' '
+test_expect_success SYMLINKS,NOT_MINGW,NOT_CYGWIN 'clone local path foo:bar' '
        clear_ssh &&
-       cp -R src "foo:bar" &&
-       git clone "./foo:bar" foobar
-       git clone "./foo:bar" foobar &&
+       ln -s src "foo:bar" &&
+       ! git clone "./foo:bar" foobar &&
        expect_ssh none
 '
 
 test_expect_success 'bracketed hostnames are still ssh' '
        clear_ssh &&
-       git clone "[myhost:123]:src" ssh-bracket-clone &&
+       ! git clone "[myhost:123]:src" ssh-bracket-clone &&
        expect_ssh myhost:123 src
 '
