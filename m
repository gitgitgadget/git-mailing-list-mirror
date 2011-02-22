From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] revlist.c: introduce --left/right-only for
 unsymmetric picking
Date: Mon, 21 Feb 2011 17:17:33 -0800
Message-ID: <7vmxlog95e.fsf@alter.siamese.dyndns.org>
References: <4D625972.4090500@drmicha.warpmail.net>
 <a3224c4269b26c366bb5b5df691f22f17b767f83.1298304396.git.git@drmicha.warpmail.net> <7vvd0cgahg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 02:17:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prgst-00078L-La
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 02:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381Ab1BVBRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 20:17:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab1BVBRm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 20:17:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B94C44A2A;
	Mon, 21 Feb 2011 20:18:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SvrZLQJkhA56wlLprdpOOMqYlTM=; b=wJii9f
	bFlJKGRXygphPhTqymWU5zhyN2sZW4K+xws5/44vzBGZYP/8WLSfTCNHvWaP/5Hc
	SBdTCli7rl4cy3MK+ZCepWaIg8USSpCHJLmld4OQ049kPCUpW2MMa5o3SoOW338Z
	rDfCUsoqMaGpJOf2vsxZ5IXgKd1u4iFDhjcf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UTX2jHxbu7elC/SY2zv89JGJFPsAk7FK
	BYl0CM751CB0kZZ1rwvZy8jjWbktWB1mt22VNJ+GhBbv9h0+Kq3kZtX9Mhun1Ysg
	Z5MikmkZxqMoQ46g2vWwhx8GQtVkm3zVrnR/wH6dnQy3s0pR/rjc3X1O6JQ9qW3w
	SeXi9dju8fI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 978C64A29;
	Mon, 21 Feb 2011 20:18:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 734D44A28; Mon, 21 Feb 2011
 20:18:46 -0500 (EST)
In-Reply-To: <7vvd0cgahg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 21 Feb 2011 16\:48\:43 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B497863C-3E21-11E0-A411-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167521>

Junio C Hamano <gitster@pobox.com> writes:

> ...  We
> might want to make sure that l/r only are mutually exclusive at the
> command parser, though.

-- >8 --
Subject: [PATCH] rev-list: --left/right-only are mutually exclusive

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 0681c7c..1fcaeb7 100644
--- a/revision.c
+++ b/revision.c
@@ -1284,8 +1284,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--left-right")) {
 		revs->left_right = 1;
 	} else if (!strcmp(arg, "--left-only")) {
+		if (revs->right_only)
+			die("--left-only is incompatible with --right-only");
 		revs->left_only = 1;
 	} else if (!strcmp(arg, "--right-only")) {
+		if (revs->left_only)
+			die("--right-only is incompatible with --left-only");
 		revs->right_only = 1;
 	} else if (!strcmp(arg, "--count")) {
 		revs->count = 1;
-- 
1.7.4.1.107.ga7184
