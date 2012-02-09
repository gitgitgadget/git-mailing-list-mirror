From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge <tag>: Spawning an editor can't be disabled
Date: Thu, 09 Feb 2012 13:34:25 -0800
Message-ID: <7vliobvggu.fsf@alter.siamese.dyndns.org>
References: <20120209153431.GA24033@godiug.sigxcpu.org>
 <20120209160803.GA5742@burratino> <7vpqdnvh3b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 22:34:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvbdR-00030S-Ia
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 22:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758124Ab2BIVe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 16:34:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50366 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825Ab2BIVe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 16:34:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAF4462C4;
	Thu,  9 Feb 2012 16:34:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o8K2fX0ZWNK3XwWHtcvhEiHUQWM=; b=eFMOSa
	SFPqtQyO9MTCbvhTHn+UGsurL2j7PM5w6vXg8AD43arGRoJPgTfY4DMAPO5OMm0z
	j1gnToVQ+Yr5bXcvG6+YnpWY18Sti+Eeom7swhxXl18Jegx1gAmx0aNQbP1o3Etn
	DShHx+zNHsiFfrFs5CmTrZ6Q2S5jkzu0a07Yk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HeKX5A0gVTDTg0QYOz5+mi8FUR+mv9gD
	sK8y+K5o2VGCBw893Zycv8pHpk/PcTWMPiE3mV3uqsEcT7EnDtcmgRJCX4mBCHgB
	A5MtlK76/+iZ7U2IKBvNnm/6WDxmFIw3hR1ia6FyRrkxnhWTQZPoXbvH81xj97Z4
	IrYZ6V5zbp4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2B3662C3;
	Thu,  9 Feb 2012 16:34:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7644F62C1; Thu,  9 Feb 2012
 16:34:27 -0500 (EST)
In-Reply-To: <7vpqdnvh3b.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 09 Feb 2012 13:20:56 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7C9E438-5365-11E1-B2F3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190327>

Junio C Hamano <gitster@pobox.com> writes:

> Your approach is the right one, though.  A patch for 1.7.9.1, on top of
> b5c9f1c (merge: do not create a signed tag merge under --ff-only option,
> 2012-02-05), would look like this, I think.
> ...

I tweaked the message to credit your initial analysis and added the
following test (again on top of b5c9f1c).

Thanks.

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index a598dfa..9e27bbf 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -683,4 +683,16 @@ test_expect_success GPG 'merge --ff-only tag' '
 	test_cmp actual expect
 '
 
+test_expect_success GPG 'merge --no-edit tag should skip editor' '
+	git reset --hard c0 &&
+	git commit --allow-empty -m "A newer commit" &&
+	git tag -f -s -m "A newer commit" signed &&
+	git reset --hard c0 &&
+
+	EDITOR=false git merge --no-edit signed &&
+	git rev-parse signed^0 >expect &&
+	git rev-parse HEAD^2 >actual &&
+	test_cmp actual expect
+'
+
 test_done
