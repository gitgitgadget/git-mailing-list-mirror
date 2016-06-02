From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t1308: do not get fooled by symbolic links to the source tree
Date: Thu, 02 Jun 2016 15:15:39 -0700
Message-ID: <xmqqeg8fs0dw.fsf_-_@gitster.mtv.corp.google.com>
References: <xmqqzir53mdc.fsf@gitster.mtv.corp.google.com>
	<712e0755-6008-21f5-0ee6-25ed9d97fd45@web.de>
	<xmqq1t4ftheu.fsf@gitster.mtv.corp.google.com>
	<xmqqwpm7s2ex.fsf@gitster.mtv.corp.google.com>
	<20160602213920.GA13356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 00:15:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8au3-0003wc-Lh
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 00:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161313AbcFBWPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 18:15:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161041AbcFBWPn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 18:15:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 66CFB21380;
	Thu,  2 Jun 2016 18:15:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8BAC5XEvkj6a4rcwMFJ4goSXblA=; b=kpjzJy
	LkO7s1CuI8y69EhgiEA/7pMMw/SpA18713RUUGkKUo5rwzZjw6wjx4u8IuoLW6y0
	4/UAm3ST/kJ6k/GbrA21+Oh06cdpU8YGrIBWoeYF9smRb5OlRxsu8KEPu7mid6AW
	9KfL/X6o/WiaF9en1H4T1iHyy+Qx/oDcGP+Ds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TxW9WMD8DfI+TeS1Gzes2UeAT5KD12qB
	73tVyIzUozIpWT7pLTeNgHMei+MjG6Q1SZoqNwxV5hDnCAIQaJvgNWH+paCABEby
	CCONtJ0ANHDInhakEpdrYbTVh2v08p28Jzq+tpi4qlaZZaP+8hS6Jj14ONgYffpn
	TwSxT22taYY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E3E72137F;
	Thu,  2 Jun 2016 18:15:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE5172137D;
	Thu,  2 Jun 2016 18:15:40 -0400 (EDT)
In-Reply-To: <20160602213920.GA13356@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 2 Jun 2016 17:39:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8AACC326-290F-11E6-B9A4-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296249>

When your $PWD does not match $(/bin/pwd), e.g. you have your copy
of the git source tree in one place, point it with a symbolic link,
and then "cd" to that symbolic link before running 'make test', one
of the tests in t1308 expects that the per-user configuration was
reported to have been read from the true path (i.e. relative to the
target of such a symbolic link), but the test-config program reports
a path relative to $PWD (i.e. the symbolic link).

Instead, expect a path relative to $HOME (aka $TRASH_DIRECTORY), as
per-user configuration is read from $HOME/.gitconfig and the test
framework sets these shell variables up in such a way to avoid this
problem.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

    > Yeah, I think it is the same issue. I think the most accurate value
    > there would probably be $HOME, though.

    Thanks.

 t/t1308-config-set.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 065d5eb..cf716b4 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -237,7 +237,7 @@ test_expect_success 'iteration shows correct origins' '
 	key=foo.bar
 	value=from-home
 	origin=file
-	name=$(pwd)/.gitconfig
+	name=$HOME/.gitconfig
 	scope=global
 
 	key=foo.bar
-- 
2.9.0-rc1-228-gd00d833
