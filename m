From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/20] git-submodule.sh: avoid "test <cond> -a/-o <cond>"
Date: Mon, 09 Jun 2014 16:23:45 -0700
Message-ID: <xmqqoay1d5vi.fsf@gitster.dls.corp.google.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
	<1402066563-28519-11-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:23:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu8uy-0004f1-Uy
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 01:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934395AbaFIXXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 19:23:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61882 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932414AbaFIXXv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 19:23:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 95FFB1D42D;
	Mon,  9 Jun 2014 19:23:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=I4OlePuV8YmN0I0yKLDAPfdS17M=; b=ujAQ63gLl7v3rZUwdoaK
	AwSd0LGQBVy/LaHFJ8f1gDWJaqHgaOafQ85TfvvbjcabDC5YrYAHSy3WRqQFbKbt
	I7ov54R6HNVbwg0I4emCFHMFlrh/72GVcx0LxMgyyyY7QuOCFZLijkZ9gG+tQ4Ik
	JIAvlC9DC52ATrPvsOLBoZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=BuyVZO93V39p/fPlSn3uA+MpTLniJhnU4xO2AranrZg6kf
	6IvD96e9KrZPn0r0mVldZRbf1Js6xfxlayHXa1YEZd7f6IPoh/dr9ehXd9/lg6Hc
	5tuQWZW94v3QE+IpEocUDwcmmCjMeCoi10xKfJX4uYuG/vF7TntsFh96sTiVU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8D0F01D42C;
	Mon,  9 Jun 2014 19:23:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AB7B31D42B;
	Mon,  9 Jun 2014 19:23:46 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1AEC10CC-F02D-11E3-A6A7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251141>

Elia Pinto <gitter.spiros@gmail.com> writes:

> @@ -1059,13 +1059,17 @@ cmd_summary() {
>  		while read mod_src mod_dst sha1_src sha1_dst status sm_path
>  		do
>  			# Always show modules deleted or type-changed (blob<->module)
> -			test $status = D -o $status = T && echo "$sm_path" && continue
> +			case "$status" in
> +			[DT])
> +				printf '%s\n' "$sm_path" &&
> +				continue
> +			esac

I think this conversion is wrong and causes parse error.  The
surrounding code cannot be seen in the context of thsi patch, but
looks somewhat like this:

	modules=$( ....
                   case "$status" in
                   [DT])
                           ...
                   esac
                   .... )

Perhaps you would need to spell it with the extra opening
parenthesis, like so:

	case string in
        ([DT])
        	...
	esac

or something.
