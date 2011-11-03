From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: print progress
Date: Thu, 03 Nov 2011 12:43:59 -0700
Message-ID: <7vd3d9f0u8.fsf@alter.siamese.dyndns.org>
References: <20111103033325.GA10230@sigill.intra.peff.net>
 <1320310234-11243-1-git-send-email-pclouds@gmail.com>
 <20111103193826.GB19483@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 03 20:44:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM3Cs-0005Ez-VW
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 20:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222Ab1KCToE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 15:44:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43605 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864Ab1KCToD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 15:44:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C00606F13;
	Thu,  3 Nov 2011 15:44:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NvnyoKCAm6wj44+Ejk+qZobrX3o=; b=uz7iJV
	DXhlc+HVIgmxzkCT9EP4T7nKdlMl8eb8L8kiokkNnyKA5CsK4067cb6UV1VuaoCQ
	bp1VdDLMY5k8YbJnFG/jc5BTjWXDRe9z9XoiUL3YXzE9n0oT2P0ngR8hexVG7cvf
	Y5AiqLy0WY4a+vdQ/66QkXFg4Gd1n5/WpM44k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bz6RXErZQ34LnsrxWkQOnkXLPPFcxfoh
	og4A39tVPfhqAlm5hKFFhpEYTfyYM+B8wOUKXI5xiMU5I1wKDr0AYzcAEXgQAWpK
	XMic9pk6YM8hqiXJHoJNiHo0+0PgI8vxjbiJPAonnbK0d1sw1N+FK7KN6LH06VLm
	92m6D5Q0uzs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6CE76F12;
	Thu,  3 Nov 2011 15:44:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC72E6F10; Thu,  3 Nov 2011
 15:44:00 -0400 (EDT)
In-Reply-To: <20111103193826.GB19483@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 3 Nov 2011 15:38:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D7A36E4-0654-11E1-A959-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184743>

Jeff King <peff@peff.net> writes:

> a little more readable, or even:
>
>   stop_progress_msg(&progress, p->next ? NULL : "done\n");

Yeah, this one looks neat.

> But I almost wonder if it is worth factoring out the concept of a
> "progress group", where you would call it like:
>
>   progress = progress_group_start("Checking objects in pack", nr_packs);
>   for (p = packed_git; p; p = p->next) {
>           progress_group_next(progress, p->num_objects);
>           for (j = 0; j < num; j++) {
>                   fsck_sha1(p, j);
>                   display_progress(progress, j+1);
>           }
>   }
>   stop_progress(&progress);

Hmm, once you do this kind of thing I would expect two (or more) progress
bars to be shown, something like:

	$ git fsck --progress
	checking packs: 3 of 7 (42% done)
        checking objects in pack: 12405 of 332340 (4% done)
