From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] git-p4: Allow setting rename/copy detection
 threshold.
Date: Thu, 18 Aug 2011 16:04:20 -0700
Message-ID: <7vy5yq5nkb.fsf@alter.siamese.dyndns.org>
References: <1313706054-11740-1-git-send-email-vitor.hda@gmail.com>
 <1313706054-11740-2-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 01:04:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuBdU-0001Kl-9a
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 01:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab1HRXEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 19:04:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754091Ab1HRXEX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 19:04:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0D1F4A16;
	Thu, 18 Aug 2011 19:04:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fx3XV5fVUOHUDadveabK2/F/qX4=; b=hZNpKX
	Y+2F74uICu7jxlFGVKzJHJ2L9EKOokj/f4nUSmMydsGFewYxWOVrocXkpRZ9NcAv
	cJvi9wl2FtFecBFXDuTLmxUYTGUZrxC3whh+X28y5Y+IaxvmRkyi4NCQZL4OL1RZ
	IyS+ZjoHM6Jze3hsMQHSiNUIZIHZX22tgtXYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lT84dsuiNKNSYXEhNRCAq7MY0hZa11L+
	wnyoEd6PDOZGyrQ01jsfbeO45h0F+6y2OcYKkPqw2DofSdGe6W0cb5SbO/N5ysVF
	VJS9/QoIBR1aAiKXnISlTsFMXDKFuUVOWbQBkind78y1nRLOAOsvJgtRRgi2Xiwl
	YhoDJ7zc09U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8DAA4A15;
	Thu, 18 Aug 2011 19:04:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A01E4A14; Thu, 18 Aug 2011
 19:04:22 -0400 (EDT)
In-Reply-To: <1313706054-11740-2-git-send-email-vitor.hda@gmail.com> (Vitor
 Antunes's message of "Thu, 18 Aug 2011 23:20:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 690F876A-C9EE-11E0-B717-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179655>

Vitor Antunes <vitor.hda@gmail.com> writes:

> Copy and rename detection arguments (-C and -M) allow setting a threshold value
> for the similarity ratio. If the similarity is below this threshold the rename
> or copy is ignored and the file is added as new.
> This patch allows setting git-p4.detectRenames and git-p4.detectCopies options
> to an integer value to set the respective threshold.
>
> Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
> ---
>  contrib/fast-import/git-p4 |   18 +++++++++++++-----
>  1 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 6b9de9e..cf719be 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -774,15 +774,23 @@ class P4Submit(Command, P4UserMap):
>  
>          if not self.detectRenames:
>              # If not explicitly set check the config variable
> -            self.detectRenames = gitConfig("git-p4.detectRenames").lower() == "true"
> +            self.detectRenames = gitConfig("git-p4.detectRenames")
>  
> -        if self.detectRenames:
> +        diffOpts = ""
> +        if self.detectRenames.lower() == "true":

This is not a new problem you introduced with this patch, but unless you
are invoking "git config --bool" in your gitConfig() (I didn't bother to
check), you will misunderstand different ways to say "Yes", e.g.

	[git-p4]
                detectRenames
                detectRenames = on
                detectRenames = yes
                detectRenames = 1

If you use --bool, you can rely on the values being either true or false,
and do not have to do the .lower() thing.
