From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce the config variable pack.packSizeLimit
Date: Fri, 08 Feb 2008 21:57:27 -0800
Message-ID: <7vbq6qfz94.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0802051423530.8543@racer.site>
	<7vfxw2g0gb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torarvid@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 09 06:58:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNijH-0007l2-Va
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 06:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbYBIF5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 00:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbYBIF5v
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 00:57:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbYBIF5u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 00:57:50 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 22CE919F0;
	Sat,  9 Feb 2008 00:57:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A139119EF;
	Sat,  9 Feb 2008 00:57:42 -0500 (EST)
In-Reply-To: <7vfxw2g0gb.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 08 Feb 2008 21:31:32 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73197>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> +test_expect_success \
>> +    'honor pack.packSizeLimit' \
>> +    'git config pack.packSizeLimit 200 &&
>> +     packname_4=$(git pack-objects test-4 <obj-list) &&
>> +     test 3 = $(ls test-4-*.pack | wc -l)'
>> +
>
> Where does "3" come from, and what could break it?

How about doing it like this, instead?

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 4f350dd..3eea478 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -268,4 +268,12 @@ test_expect_success \
     'make sure index-pack detects the SHA1 collision' \
     '! git-index-pack -o bad.idx test-3.pack'
 
+test_expect_success 'honor pack.packSizeLimit' '
+     limit=200 &&
+     git config pack.packSizeLimit $limit &&
+     packname_4=$(git pack-objects test-4 <obj-list) &&
+     bigger=$(find test-4-*.pack -size +${limit}c) &&
+     test -z "$bigger"
+'
+
 test_done
