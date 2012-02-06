From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Sun, 05 Feb 2012 18:08:54 -0800
Message-ID: <7vk440btmx.fsf@alter.siamese.dyndns.org>
References: <4F24E287.3040302@alum.mit.edu>
 <7vwr8bvvxj.fsf@alter.siamese.dyndns.org> <4F263AEE.4080409@alum.mit.edu>
 <7v39axc9gp.fsf@alter.siamese.dyndns.org>
 <7vaa55ar4v.fsf@alter.siamese.dyndns.org>
 <20120130215043.GB16149@sigill.intra.peff.net>
 <7vobtcbtqa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 03:09:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuE0q-0004Gt-Vi
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 03:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702Ab2BFCI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 21:08:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34148 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754534Ab2BFCI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 21:08:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 161FD622B;
	Sun,  5 Feb 2012 21:08:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NCOoKmjS4j2evDMNsa8TLV7uJYQ=; b=M155fK
	I2ea+GdVTUlO2pelJ6EDAgSzYsX6goWZVXAiSB6qFf5hdfM/yLSPGS7qcWDhUdcP
	GnBVbaaA5k82fUaHugdRAjx2LOJvdl2Jdx/1PZ69TTAbDB5zhzmQoaSpuZdmTfES
	gCkzJQNci2B+TGWuthZ0qBV3tf564xcX4Lb64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZDtbAZmEnBTWndN+prHsKbuf/ojeSt7a
	jSnSvbGW9MeY81iKwiAi/fTKYVy7XO+Ed9IZ6nizB8sevVJc5Xe2KTGdp9diuDaA
	CN2TrxRHy2tmFLs/5DVhmyngHP1N1rDDOKynUNRanfTmq+SoRMOM0o3/wvK/Mnnu
	jgCsJ/IIosE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CB9B622A;
	Sun,  5 Feb 2012 21:08:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93D1A6229; Sun,  5 Feb 2012
 21:08:55 -0500 (EST)
In-Reply-To: <7vobtcbtqa.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 05 Feb 2012 18:06:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85E6C22C-5067-11E1-ADB9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189999>

Junio C Hamano <gitster@pobox.com> writes:

> The patch is made on maint-1.7.6 track for no good reason, so it may have
> some merge conflicts around "resolve_ref()" vs "resolve_refdup()" if we
> were to apply it on a more modern codebase, but the resolution should be
> trivial.

The resolution should look like this, just in case.

diff --cc builtin/checkout.c
index 5bf96ba,5894f40..41b9b34
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@@ -1079,5 -1102,16 +1092,16 @@@ int cmd_checkout(int argc, const char *
  	if (opts.writeout_stage)
  		die(_("--ours/--theirs is incompatible with switching branches."));
  
+ 	if (!new.commit) {
+ 		unsigned char rev[20];
+ 		int flag, status;
 -		const char *old_ref = resolve_ref("HEAD", rev, 0, &flag);
++		char *old_ref = resolve_refdup("HEAD", rev, 0, &flag);
+ 
+ 		if ((flag & REF_ISSYMREF) && is_null_sha1(rev)) {
+ 			status = switch_unborn_to_new_branch(&opts, old_ref);
 -			free((char *)old_ref);
++			free(old_ref);
+ 			return status;
+ 		}
+ 	}
  	return switch_branches(&opts, &new);
  }
