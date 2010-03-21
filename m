From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] rev-list: fix --pretty=oneline with empty message
Date: Sat, 20 Mar 2010 19:54:38 -0700
Message-ID: <7vk4t64c5t.fsf@alter.siamese.dyndns.org>
References: <1269109201-5768-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 03:54:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtBJU-00017F-3Y
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 03:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab0CUCyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 22:54:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49842 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab0CUCyq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 22:54:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E86E0A3A4F;
	Sat, 20 Mar 2010 22:54:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zvGJHhsFyq3XO/jUwse5Vbvdyf0=; b=XQzLzm
	ZKIrbAe4PkfPQrXdKUOz/3PgXP8/GRNhxjo/Q2LOZU18QPsmXOOueGd+RScvgcU/
	Hw1YHJfTVyacaruLjWhlkXBufEqynBD57vSpr7jeEPgHgGq9bra1xVV7AFjhsMYw
	SWPnRTKWxz/63HrCn67yZ+Ggw76PgQrghyYDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CuDQwqaZh0lDM/AiiVGsKcjrdRp/Fogb
	2sK1rxX/els5XXURvqSC7HME3HBdwJ87c9MG2mUaZmnzQbLsBGuX0l1U/iaE8g4c
	5sP6yH70OyoCDviy2FXJ59eveZaK8lNUD9wmNrLg0KGz0dv/+WT7qc98VHjNi6nz
	e+r5SOYnzZo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C3EBDA3A4C;
	Sat, 20 Mar 2010 22:54:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 105A8A3A49; Sat, 20 Mar
 2010 22:54:39 -0400 (EDT)
In-Reply-To: <1269109201-5768-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Sat\, 20 Mar 2010 19\:20\:01 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 198AF99E-3495-11DF-8423-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142786>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

> This is a fix for the issue I posted about with rebase -i:
> http://permalink.gmane.org/gmane.comp.version-control.git/141782

Thanks.

> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 5679170..133056b 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -135,7 +135,8 @@ static void show_commit(struct commit *commit, void *data)
>  					putchar('\n');
>  			}
>  		} else {
> -			if (buf.len)
> +			if (revs->commit_format != CMIT_FMT_USERFORMAT ||
> +			    buf.len)
>  				printf("%s%c", buf.buf, info->hdr_termination);
>  		}

When the format is not user-specified one (e.g. "-v"), then a commit with
no message will only show the regular header, without any body.

I wonder if we need something similar in the "graph" case, most of which
is outside the context before this hunk.  With your patch, this still
seems to misbehave:

    $ git rev-list --graph --oneline --abbrev=4 HEAD
    * 8cb0 * efea 4th commit
    * 341e 3rd commit
    * 2321 2nd commit
    * 3814 1st commit

Although anything other than --oneline seems to do just fine.

Perhaps this one on top, with an appropriate test, and we can lose the RFC
from the title?

 builtin-rev-list.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 133056b..1db4b4c 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -133,6 +133,8 @@ static void show_commit(struct commit *commit, void *data)
 				 */
 				if (graph_show_remainder(revs->graph))
 					putchar('\n');
+				if (revs->commit_format == CMIT_FMT_ONELINE)
+					putchar('\n');
 			}
 		} else {
 			if (revs->commit_format != CMIT_FMT_USERFORMAT ||
