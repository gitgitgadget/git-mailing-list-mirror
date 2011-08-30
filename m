From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t6030: use $SHELL_PATH to invoke user's preferred shell
 instead of bare sh
Date: Tue, 30 Aug 2011 13:27:50 -0700
Message-ID: <7vaaaq1w6x.fsf@alter.siamese.dyndns.org>
References: <Sn_8tnPB8FBe4C5QxoGkIRcdzJ2sLq_-h0oZ37fkrq42HJgWSlGgty_hMznS2ckiKKOg66yY7R2mRQqhJAzedr762dMKb_s6ELjELyGXyU-tkJzir-FnxhCkAIb3q1028d5FrBBy6EW3SXEPBMTYTw@cipher.nrlssc.navy.mil> <7vfwki1wqo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>,
	Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 22:29:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyUwD-0004gF-UA
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 22:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346Ab1H3U1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 16:27:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62960 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754141Ab1H3U1x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 16:27:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C2734220;
	Tue, 30 Aug 2011 16:27:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=znwkNXyRf3micKy84Pdf4aS1HpU=; b=HDchwC
	jvNNu09w/lQnBUOS+lAK3pa3DfKSLeTZg/uasWZNQ+LZHGhb2Q80hMDU8RV/+lzh
	v2ArZEZKqfruHEtGu2O5QwE6wqQdZrF1SudbyJV6/2+VmU7hl/JEdQouuhQhdSMi
	HkCk/5EMzm46XS4rPVnuZkx4IdPzoIwdJpZA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o9/2uJ/aUOMLSLrnBl0tjePNlTDAbQJI
	xIekGEzLWPDZriwRMUqnxkgoihk8rLqlQ58zVPN4esoJYPdbY4SFaxU470QjTWLn
	zzSTRuZY94CwF1GqWB001Rt1jPA0PxfmOwjy6QqhOyX1cU2MVSFWcAsxlZABUXwl
	uTLOAwO7TcI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 941CB421F;
	Tue, 30 Aug 2011 16:27:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23EDB421E; Tue, 30 Aug 2011
 16:27:52 -0400 (EDT)
In-Reply-To: <7vfwki1wqo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 30 Aug 2011 13:15:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 890C5E7E-D346-11E0-902A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180441>

Junio C Hamano <gitster@pobox.com> writes:

>> +	git bisect run \"$SHELL_PATH\" -c '
>>  		GOOD=\$(git for-each-ref \"--format=%(objectname)\" refs/bisect/good-*) &&
>>  		git rev-list --objects BISECT_HEAD --not \$GOOD >tmp.\$\$ &&
>>  		git pack-objects --stdout >/dev/null < tmp.\$\$
>
> Hmm, shouldn't we also be quoting '$' in front of SHELL_PATH to make the
> test_expect_success interpolate the value of SHELL_PATH, instead of hoping
> that SHELL_PATH does not have double-quote in it when the shell that forms
> parameters given to test_expect_success interpolates it?

By doing this silly thing:

	$ mkdir '/var/tmp/a"b c/'
        $ ln -s /bin/sh '/var/tmp/a"b c/shell'

and then adding

	SHELL_PATH='/var/tmp/a"b c/shell'

after we source "test-lib.sh" in t6030, I see this breaks when the shell
parses to figure out what parameters to call test_expect_success with.

 t/t6030-bisect-porcelain.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 68c0e97..cd9de63 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -701,7 +701,7 @@ test_expect_success 'bisect: demonstrate identification of damage boundary' "
 	git bisect reset &&
 	git checkout broken &&
 	git bisect start broken master --no-checkout &&
-	git bisect run \"$SHELL_PATH\" -c '
+	git bisect run \"\$SHELL_PATH\" -c '
 		GOOD=\$(git for-each-ref \"--format=%(objectname)\" refs/bisect/good-*) &&
 		git rev-list --objects BISECT_HEAD --not \$GOOD >tmp.\$\$ &&
 		git pack-objects --stdout >/dev/null < tmp.\$\$
