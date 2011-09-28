From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFCv3 2/2] receive-pack: don't pass non-existent refs to
 post-{receive,update} hooks in push deletions
Date: Wed, 28 Sep 2011 15:37:32 -0700
Message-ID: <7vsjngxphv.fsf@alter.siamese.dyndns.org>
References: <20110928153935.GA7800@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sitaram Chamarty <sitaramc@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pang Yan Han <pangyanhan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 01:34:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R93e1-00061s-8d
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 01:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263Ab1I1XeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 19:34:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50875 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755356Ab1I1Whf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 18:37:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7E27639E;
	Wed, 28 Sep 2011 18:37:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I/h8BSbyo1FSCq5lGzoiJWxUAtU=; b=s+ku0t
	ULpdSHXYudX1BUZXCwG6lmgFe6tSddrQQa1ps6lRy3xfKvxZ8RlIHU/lxwBnYZzA
	TcTqZ7kv5hvfEhid2dN4sEqq1oafmzv66/j3sF54xTLO+dFxatg13T/yZxKoJo5/
	WslVJlGnKCo2pbDYSlFHasywqjLpmoU5vNou4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xLEqrKaBySpG8WwlWOej3DfSP8nJCE0P
	/7PefGbTOYSZtOYz+8jn4L5ZgsBxu4DJZMW42eLV9RwE3S/3wJ5jS+Mc+a3DsUqw
	t8zvaEVywus+odODzaIrAAPBxhruJofYaPMbcCBqwjfPgvQkB/BAvtf1xSS0Ic/K
	JWIxKZmBI2c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD7B0639D;
	Wed, 28 Sep 2011 18:37:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AAEC639C; Wed, 28 Sep 2011
 18:37:34 -0400 (EDT)
In-Reply-To: <20110928153935.GA7800@myhost> (Pang Yan Han's message of "Wed,
 28 Sep 2011 23:39:35 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 759CC3C2-EA22-11E0-97DD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182374>

Pang Yan Han <pangyanhan@gmail.com> writes:

> +/* For invalid refs */
> +static struct command **invalid_delete;
> +static size_t invalid_delete_nr;
> +static size_t invalid_delete_alloc;

Do you have to have these separately only to keep track of the corner case
errors?  I would have expected that it would be more natural to mark them
by adding a single bitfield to "struct command".

> @@ -447,6 +467,8 @@ static const char *update(struct command *cmd)
>  		if (!parse_object(old_sha1)) {
>  			rp_warning("Allowing deletion of corrupt ref.");
>  			old_sha1 = NULL;
> +			if (!ref_exists((char *) name))
> +				invalid_delete_append(cmd);

This is not an "invalid" delete but deleting a non-existing ref.  Perhaps
you would want to move the warning and optionally reword it as well, e.g.

	if (!parse_object(old_sha1)) {
        	old_sha1 = NULL;
                if (ref_exists(name)) {
			rp_warning("Allowing deletion of corrupt ref.");
		} else {
			rp_warning("Deleting a ref that does not exist.");
			cmd->did_not_exist = 1;
		}
		...
