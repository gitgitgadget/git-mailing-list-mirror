From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Refactor dirty submodule detection in diff-lib.c
Date: Thu, 11 Mar 2010 16:55:50 -0800
Message-ID: <7vfx46we7d.fsf@alter.siamese.dyndns.org>
References: <4B9965A1.60403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 12 01:56:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NptAq-0001RF-1J
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 01:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198Ab0CLA4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 19:56:01 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35131 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab0CLA4A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 19:56:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 024B89FFBC;
	Thu, 11 Mar 2010 19:55:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xqnt9YdgjYhT04CC8hWh8YaI5Wc=; b=DknfdI
	qJx0Md7gRvunk6g8GuswZWGeyzh81qxx/Zabw874h9cY9qwZoBG1AN/agMu9Mih6
	4otNPXBGxZqku5Aam1r23PGLIpGXAVKY8VdksDuknOR1k+sgMIVL0bCzxHNpQHjL
	PxBxenMQIMtAT3agQPLVcwMT16Kt/V2chKDn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wMOexOVAIbL7GjJR3ZVCEgGLdQMbLAkx
	4w0GTHlzli3tKefP6+ZqoY+QAmNHJen4wZhxVOaatcXDllHjzGyffqy3dob2J9KG
	jzxsfnv+cqH98zOew0cqnt5KS5duQXsDiooX93Ik61Z06+XP2ts2HA25Do+znN8I
	l9ThEQr0k0M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D28529FFBB;
	Thu, 11 Mar 2010 19:55:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 376099FFBA; Thu, 11 Mar
 2010 19:55:52 -0500 (EST)
In-Reply-To: <4B9965A1.60403@web.de> (Jens Lehmann's message of "Thu\, 11 Mar
 2010 22\:50\:25 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 033D8DE8-2D72-11DF-AF99-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142010>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Moving duplicated code into the new function match_stat_with_submodule().
> Replacing the implicit activation of detailed checks for the dirtiness of
> submodules when DIFF_FORMAT_PATCH was selected with explicitly setting
> the recently added DIFF_OPT_DIRTY_SUBMODULES option in diff_setup_done().
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>
> All tests run fine with this patch. All other callsites where the option
> DIFF_FORMAT_PATCH is set look like they don't deal with the work tree
> or they call diff_setup_done() shortly after.
> I am pretty sure about builtin/log.c, as this can't use the work tree
> but only already commited stuff, no?
> But then there is edit_patch() in buitin/add.c, I am not sure it makes
> sense to set DIRTY_SUBMODULES there too. Opinions?

I like this particular refactoring to remove duplicated obscure logic.

I am not sure if it is the right thing to do to return "changed" if the
change is only "submodule is dirty even though its HEAD is the same as
what is recorded in the index of the superproject", though.  See my
patches in response to your "[PATCH] git status: Fix false positive "new
commits" output for".  I think it would be conceptually the right thing to
do to feed the same object names in the sha1 field for both sides of the
filepair, with the working tree side marked with "dirty-submodule".  I
also suspect that you would not need to re-resolve the gitlinks in later
stages when you generate patches in textual form if you do it that way.
