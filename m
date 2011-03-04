From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Fri, 04 Mar 2011 10:37:59 -0800
Message-ID: <7vei6m7muw.fsf@alter.siamese.dyndns.org>
References: <4D70EBC3.3010400@colin.guthr.ie>
 <7vr5am7p30.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Colin Guthrie <gmane@colin.guthr.ie>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 19:38:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvZtI-00073E-Sj
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 19:38:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760027Ab1CDSiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 13:38:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759425Ab1CDSiK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 13:38:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AE9DB4B80;
	Fri,  4 Mar 2011 13:39:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WrVgNoVCkzunR/Ox9Hwf1+lz7oI=; b=IUXfaQ
	JdZv02X0dJqPK84gfg1b8YNS/rggoclu9912IakO85BC+zSJT1FS1IeC/cTORoxw
	knlqYKHfcTq3zOQn15l8NhSmOOTSUirs9dlDvaIybId9+81L6+oxn4/qRkODgC3N
	dXmbVSiJvVJQLWNedBcbncw7cii/moCejOajA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p6GcShlZmdkhCJVeOXCNx9DdMtqArzq6
	xB+U3vlw33/n10143yerCwywcLSriJy3jFiXZ3qcuEP2WLMxs5mM5iB567lH+VV3
	DJR/EnasSNCIOVc2JOcKlBcRuJ3OolUsKVRAn+sWV9ZpdthXIqIYSZid8DrV8bR5
	0zb/1IPnx58=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8D25E4B7F;
	Fri,  4 Mar 2011 13:39:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 636E64B7A; Fri,  4 Mar 2011
 13:39:24 -0500 (EST)
In-Reply-To: <7vr5am7p30.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 04 Mar 2011 09\:49\:55 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BCA5AB7C-468E-11E0-9265-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168457>

Junio C Hamano <gitster@pobox.com> writes:

> @@ -1224,6 +1253,9 @@ static int element_probe(pa_alsa_element *e, snd_mixer_t *m) {
>          }
>      }
>  
> +    if (check_required(e, me) < 0)
> +        return -1;
> +
>      return 0;
>  }
>
> I haven't looked at the offset logic in git-apply for a long time since
> Linus wrote its original version (I don't think the logic has changed very
> much since then), but I thought we are taking accumulated offsets into
> account when we decide where the patch target should roughly correspond
> to.  When we attempt to apply the second hunk, we have already found that
> the line the patch says should be at l.1190 is actually at l.1296 (iow,
> there are about 100 lines of new material above that the patch didn't
> expect), so instead of trying to find the lines that matches the preimage
> of the second hunk at around l.1224, we _should_ be trying to find that at
> around l.1224+100---perhaps we are not doing that.

I don't necessarily think mucking with the first location we try to apply
using the offset we found by applying the previous hunk is actually a good
thing.  With so many offset lines and multiple places that a hunk can
apply to make the patch application unreliable, that change would be
robbing Peter to pay Paul.  Depending on the nature of the change between
the version the patch is based on and the version the patch is being
applied with offsets, such a heuristics will sometimes err on the wrong
side.

Looking at it closer, however, I noticed that the false hit (i.e. "two
blocks closed, a blank line, return 0 and the end of function") in this
particular case only appears because we applied the previous hunk.  In the
version of the file in 0ce3017b, there is only one such place and there
should be no ambiguity in the patch application.

The problem we are seeing is caused only because we look at the result of
application of the previous hunks in the patch and incrementally try to
apply the remaining hunks.  So clearly "git apply" can and should be fixed
for this case by teaching find_pos() not to report a match on a line that
was touched by application of the previous hunk.
