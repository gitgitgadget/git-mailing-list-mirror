From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 2/8] push: add push.default = mirror
Date: Mon, 20 Jul 2009 13:46:05 -0700
Message-ID: <7vocrfulpu.fsf@alter.siamese.dyndns.org>
References: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
 <1248112195-3761-3-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 22:46:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSzkc-0008La-2g
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 22:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbZGTUqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 16:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbZGTUqM
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 16:46:12 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbZGTUqL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 16:46:11 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A6040B60F;
	Mon, 20 Jul 2009 16:46:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B4D46B60E; Mon,
 20 Jul 2009 16:46:07 -0400 (EDT)
In-Reply-To: <1248112195-3761-3-git-send-email-bonzini@gnu.org> (Paolo
 Bonzini's message of "Mon\, 20 Jul 2009 19\:49\:49 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5B4AD7F0-756E-11DE-9D7E-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123632>

Paolo Bonzini <bonzini@gnu.org> writes:

> This patch adds a new value for push.default.  The aim of the series is
> to support all push.default values as arguments to `--push' in git-clone
> and git-remote, and if push.default=mirror works it is easy to make
> `--mirror' a synonym for `--push=mirror' in those comments.
>
> Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
> ---
>  Documentation/config.txt |    2 ++
>  builtin-push.c           |   12 ++++++++++--
>  cache.h                  |    1 +
>  config.c                 |    4 +++-
>  4 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 4c27e9d..fa5eb76 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1290,6 +1290,8 @@ push.default::
>  * `matching` push all matching branches.
>    All branches having the same name in both ends are considered to be
>    matching. This is the default.
> +* `mirror` pushes all branches forcing non fast-forward updates and
> +  deletes branches that do not exist anymore locally.
>  * `tracking` push the current branch to its upstream branch.
>  * `current` push the current branch to a branch of the same name.

I think this patch alone (regardless of the rest which I haven't read)
probably makes sense.

Except that I think the part below contradicts with the --mirror push
semantics (see remote.c::match_refs()).

> diff --git a/builtin-push.c b/builtin-push.c
> index e678a9d..8a312a3 100644
> --- a/builtin-push.c
> +++ b/builtin-push.c
> @@ -74,6 +73,10 @@ static void setup_default_push_refspecs(void)
>  		add_refspec(":");
>  		break;
>  
> +	case PUSH_DEFAULT_MIRROR:
> +		add_refspec("+refs/*:refs/*");
> +		break;
> +
