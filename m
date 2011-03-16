From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] diff-lib.c: Fix diff-files --diff-filter --quiet exit
 code
Date: Wed, 16 Mar 2011 15:21:40 -0700
Message-ID: <7vwrjy670r.fsf_-_@alter.siamese.dyndns.org>
References: <4D80EBC1.7010105@elegosoft.com>
 <7v62ri7oqm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de,
	johannes.schindelin@gmx.de
To: Jakob Pfender <jpfender@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 23:22:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzz6N-0006TP-S3
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 23:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154Ab1CPWVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 18:21:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61542 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab1CPWVy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 18:21:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A6723B18;
	Wed, 16 Mar 2011 18:23:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dBRbpBuytU3MdFC+8WdLoTQwncY=; b=JBkX/L
	zcWgOEFFKCWNbcWCPAvtztEAPHZrX8RqDUIMAovuoO/KNc8qG4luKMuPshozeOeI
	KCbbDTzOPDzyoBYqI1LfjeN3qZPa/2ZxZFe7ESOL8MNnAzE8FbkMOaKj5K3rQ5G/
	erfdO2DydctUE7mdKjSsu82GOf8WAX41HbUT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yDcsTJHs8TtZv96kYKsf2ZOozwUypdD2
	mlThgWYJGeg+3wbozPJ6jtYA18NRpqxcsA2AUkkFsAsD22u49TUX7uumw7sXTBuf
	bE7TU522jYOkO0ZstXPO0yWeosb7UbzjBspJ5+vqfnAwyccwX9wxRFiXgYM9jeI0
	SB3RCsHLMO8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 285C13B13;
	Wed, 16 Mar 2011 18:23:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CFB8B3B0F; Wed, 16 Mar 2011
 18:23:15 -0400 (EDT)
In-Reply-To: <7v62ri7oqm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 16 Mar 2011 14:13:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00078958-501C-11E0-AB98-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169202>

Junio C Hamano <gitster@pobox.com> writes:

> The code notices that the caller, by specifying --quiet, does not want any
> details of the changes and instead wants to know if there is a change or
> not.  And it breaks out of the loop because it already found what it
> wanted to know, namely, there is a change.
>
> When you have a post-process filter (like -w or -S), the path we found to
> be different here may be uninteresting and there may be no output (hence
> we should exit with status 0).  So it is true that the optimization you
> are removing needs to be disabled in _some_ situations, and the current
> code doesn't, and it needs fixing.

What I was hinting at was perhaps to do it something like the attached; it
is totally untested, and merely for illustration purposes.

I didn't even try to cover -w/-S which may or may not involve inspecting
DIFF_FROM_CONTENTS bit in the options.

 diff-lib.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 1e22992..2870de4 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -103,7 +103,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		unsigned dirty_submodule = 0;
 
 		if (DIFF_OPT_TST(&revs->diffopt, QUICK) &&
-			DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
+		    !revs->diffopt.filter &&
+		    DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
 			break;
 
 		if (!ce_path_match(ce, &revs->prune_data))
