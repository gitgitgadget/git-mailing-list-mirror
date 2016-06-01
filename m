From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-submodule has bash-ism?
Date: Wed, 01 Jun 2016 09:19:06 -0700
Message-ID: <xmqqk2i8zxtx.fsf@gitster.mtv.corp.google.com>
References: <xmqq1t4h3jxo.fsf@gitster.mtv.corp.google.com>
	<xmqqoa7kzy3u.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 18:19:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b88rY-0004LC-4B
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbcFAQTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:19:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751808AbcFAQTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:19:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BD18218D6;
	Wed,  1 Jun 2016 12:19:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VYIxBvvgJ5cd7sD7+JDXIgeHq9Y=; b=LSQSPX
	1ynA5USm2EEGu92AVVC3s+L0pGY1JYLS7PywgiebfWKIpFuuTOPH6YmOc58JtmcF
	SdWmG99MsC32U0b/VORS9DfBicTj2gKkk/1l4E2W9Ew3Wkxyxc5T0A3NtRGFmwvU
	5DJPuvmNM/h30BNX+3VWupVtnlTvjWhQa3WvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tph0ErDVQj2L10xus6btwK4swR2j9zxv
	bI42/P97Pd3rlUdmeeHKIVCa0usbdpMOdclS7EiXNY4fPV1GwAnSe6cDL9Q5Y3aM
	XZV6NHkXqBfEUbkGX0ouGJtyn9QcgcaDl0/Uxe5wJy0zlQJuXb1Zt1py64xxDAEv
	xJDmoN3Nrvw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4403F218D5;
	Wed,  1 Jun 2016 12:19:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B2155218D4;
	Wed,  1 Jun 2016 12:19:07 -0400 (EDT)
In-Reply-To: <xmqqoa7kzy3u.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 01 Jun 2016 09:13:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 90EEEF08-2814-11E6-9F81-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296098>

Junio C Hamano <gitster@pobox.com> writes:

> These are two other offenders.
>
> $ git grep '^[	 ]local[ 	]' \*.sh
> t/t5500-fetch-pack.sh:	local diagport
> t/t7403-submodule-sync.sh:	local root
>
> The grep gives many other hits, but those in completion are OK; it
> is designed to be specific to bash, and whose tests in t9902 is in
> the same boat.  A few more near the end of t/test-lib-functions are
> only for mingw where bash is the only supported shell at least for
> running tests.

I think this should be sufficient (extra sets of eyeballs are
appreciated).  For 5500, diagport is not a variable used elsewhere
and can simply lose the "local".  7403 overrides the "root" variable
used in the test framework for no good reason (its use is not about
temporarily relocating where the test repositories are created), but
they can be made not to clobber the varible by moving them into the
subshells it already uses.

 t/t5500-fetch-pack.sh     | 1 -
 t/t7403-submodule-sync.sh | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 9b9bec4..dc305d6 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -556,7 +556,6 @@ check_prot_path () {
 }
 
 check_prot_host_port_path () {
-	local diagport
 	case "$2" in
 		*ssh*)
 		pp=ssh
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 79bc135..5503ec0 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -62,13 +62,13 @@ test_expect_success 'change submodule' '
 '
 
 reset_submodule_urls () {
-	local root
-	root=$(pwd) &&
 	(
+		root=$(pwd) &&
 		cd super-clone/submodule &&
 		git config remote.origin.url "$root/submodule"
 	) &&
 	(
+		root=$(pwd) &&
 		cd super-clone/submodule/sub-submodule &&
 		git config remote.origin.url "$root/submodule"
 	)
