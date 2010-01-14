From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Show submodules as modified when they contain a dirty
 work tree
Date: Thu, 14 Jan 2010 15:13:09 -0800
Message-ID: <7v3a288em2.fsf@alter.siamese.dyndns.org>
References: <4B4BA096.5000909@web.de>
 <7vtyusb6rv.fsf@alter.siamese.dyndns.org> <4B4CA13F.6020505@web.de>
 <7vbpgyqy4a.fsf@alter.siamese.dyndns.org> <4B4E1817.1070202@web.de>
 <7v6375lkpj.fsf@alter.siamese.dyndns.org> <4B4F8EF1.3080709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jan 15 00:13:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVYsp-0001TZ-Kg
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 00:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111Ab0ANXN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 18:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755926Ab0ANXN2
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 18:13:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56946 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755Ab0ANXN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 18:13:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44A5390BDC;
	Thu, 14 Jan 2010 18:13:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=cleEb+As2klGY6WP7wSYGzN4B/A=; b=GH4F9lkTC6douOALCCKrsXY
	ZFXp6srzeufxsNvV/i44A7YBfvlW8m5oEi0Ei4tYIFYAdrbYxBZE9dJXyjbZbIIq
	z7C0/iTW+3kbhtSJHFgPUxKvKy2992CTrSEoEMMyZ6/exPSln0Vuy5LpjnShBvNr
	63YOZWuoiLIxZcypJW+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ahfRbGDvas6rfF8WbSLi4n9N5cFlGH4ViiuPs6/zTHqDSg6Zz
	4ce6FOPih/oXYs8jpHmwBcmwiJ6XmMt+IbOZnY0ve9u5r9rc31JapWtcNfvCv92e
	yneNjD/lo/UhBZn9NJyMgwo6T5aQR80vomjb53X+7SUhbHHJLPAxrbGpdk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C02C090BD9;
	Thu, 14 Jan 2010 18:13:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BBEC90BD8; Thu, 14 Jan
 2010 18:13:11 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 66CC16AE-0162-11DF-B236-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137035>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Subject: Show a modified submodule directory as dirty even if the refs match
>
> When the submodules HEAD and the ref committed in the HEAD of the
> superproject were the same, "git diff[-index] HEAD" did not show the
> submodule as dirty when it should.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>  diff-lib.c                |    3 ++-
>  t/t4027-diff-submodule.sh |   35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+), 1 deletions(-)
>
> diff --git a/diff-lib.c b/diff-lib.c
> index 5ce226b..9cdf6da 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -233,7 +233,8 @@ static int get_stat_data(struct cache_entry *ce,
>  			return -1;
>  		}
>  		changed = ce_match_stat(ce, &st, 0);
> -		if (changed) {
> +		if (changed
> +		    || (S_ISGITLINK(ce->ce_mode) && is_submodule_modified(ce->name))) {

You had a check in your previous patch that decides to call or skip
diff_change() based on is_submodule_modified() for diff-files, but forgot
to have the same for diff-index, which this patch does.  Perhaps we want
to squash this into 4519d9c (Show submodules as modified when they contain
a dirty work tree, 2010-01-13).

The existing code is a bit unfortunate; by the time we come to the output
routine, the information we found from is_submodule_modified() is lost;
that is why my "would look like this" patch calls is_submodule_modified().

We may want to add one parameter to diff_change() and diff_addremove(), to
tell them if the work-tree side (if we are comparing something with the
work tree) is a modified submodule, and add one bit to the diff_filespec
structure to record that in diff_change() and diff_addremove() (obviously
only when adding).  That way, my "would looks like this" patch needs to
check the result of is_submodule_modified() the front-ends left in the
filespec, instead of running it again.
