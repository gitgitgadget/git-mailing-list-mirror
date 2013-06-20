From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/5] t6006 (rev-list-format): don't hardcode SHA-1 in expected outputs
Date: Thu, 20 Jun 2013 13:38:09 -0700
Message-ID: <7v1u7wseku.fsf@alter.siamese.dyndns.org>
References: <cover.1371720245.git.Alex.Crezoff@gmail.com>
	<cover.1359018188.git.Alex.Crezoff@gmail.com>
	<cover.1371720245.git.Alex.Crezoff@gmail.com>
	<3aff7ccae2f7e8b1499b4e11a65c5815b06c1959.1371720245.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 22:38:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UplcW-0007OX-G1
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 22:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965709Ab3FTUiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 16:38:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55915 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422653Ab3FTUiL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 16:38:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 294132AD54;
	Thu, 20 Jun 2013 20:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=/lXqbgjfChS0gSxwGIBvd97v6uo=; b=aCgSsVgKJkrjOVnou7np
	D8BKXG0hXSjFdcl9YqihaG8l3ugcXqI2u2KWF3/vUZYNh1d4eYBAjeX1WgzMBy87
	YcO/3i5iQneeF9Ph/kHrXCXk59Js5ffmsxgtNJBiuUnYZlA4X1JvLlRG2pcfoFWb
	0z4WP4PMhwIxhxrzDyZwgrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=u+4IVxoahom3qlNaTogiPtqbguMwHUUR/xSUDjYbOx9A5+
	c7l7dicg4f4MAkJAz8WgvyutShMWMi2WS79YjoNxBqOe37DO7g2Lx0zH7nT43hO3
	ERSt8Tn8SGIJl2uXoPffurHVyH190EMU+O4AJHMxssrnBHEt86CAQrWEp4Z/M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EF7E2AD53;
	Thu, 20 Jun 2013 20:38:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 994E82AD52;
	Thu, 20 Jun 2013 20:38:10 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5253AC74-D9E9-11E2-A31B-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228534>

Alexey Shumkin <Alex.Crezoff@gmail.com> writes:

> The expected SHA-1 digests are always available in variables. Use
> them instead of hardcoding.
>
> Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> ---
>  t/t6006-rev-list-format.sh | 142 +++++++++++++++++++++++++--------------------
>  1 file changed, 79 insertions(+), 63 deletions(-)
>
> diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> index 0393c9f..d32e65e 100755
> --- a/t/t6006-rev-list-format.sh
> +++ b/t/t6006-rev-list-format.sh
> @@ -7,8 +7,21 @@ test_description='git rev-list --pretty=format test'
>  
>  test_tick
>  test_expect_success 'setup' '
> -touch foo && git add foo && git commit -m "added foo" &&
> -  echo changed >foo && git commit -a -m "changed foo"
> +	: >foo &&
> +	git add foo &&
> +	git commit -m "added foo" &&
> +	head1=$(git rev-parse --verify HEAD) &&
> +	head1_short=$(git rev-parse --short $head1) &&
> +	tree1=$(git cat-file commit HEAD | sed -n -e "s/^tree //p" -e "/^$/q") &&
> +	tree1_short=$(git rev-parse --short $tree1) &&
> +	echo changed >foo &&
> +	git commit -a -m "changed foo" &&
> +	head2=$(git rev-parse --verify HEAD) &&
> +	head2_short=$(git rev-parse --short $head2) &&
> +	head2_parent=$(git cat-file commit HEAD | sed -n -e "s/^parent //p" -e "/^$/q") &&
> +	head2_parent_short=$(git rev-parse --short $head2_parent) &&
> +	tree2=$(git cat-file commit HEAD | sed -n -e "s/^tree //p" -e "/^$/q") &&

With modern Git, you can (and would) write this as

	tree2=$(git rev-parse HEAD:)

(the same for tree1).  Other than that, looks sensible.

Will queue with a tweak.
