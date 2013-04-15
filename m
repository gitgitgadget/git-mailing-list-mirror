From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH v3] cherry-pick: make sure all input objects are commits
Date: Mon, 15 Apr 2013 11:29:34 -0700
Message-ID: <7vehebsl4h.fsf@alter.siamese.dyndns.org>
References: <20130403092704.GC21520@suse.cz>
 <7v38v1yn8o.fsf@alter.siamese.dyndns.org> <20130411092638.GA12770@suse.cz>
 <CALkWK0n6FjGbXTqiOT_O6NbB5h0DLaNWKCCTQAFSO_BL-pPdBA@mail.gmail.com>
 <20130411110324.GD12770@suse.cz>
 <CALkWK0kb+2KZLvRJDJb_VrNNs1k4grsfyFv0HfYv0Kr9v4sChQ@mail.gmail.com>
 <20130411130652.GG12770@suse.cz> <87vc7odvzi.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@suse.cz>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 15 20:29:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URo9t-0007gK-Mu
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 20:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931Ab3DOS3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 14:29:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60514 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755092Ab3DOS3g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 14:29:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29AC716646;
	Mon, 15 Apr 2013 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TrCogYSnsNXf/6pi68SEClJS1tA=; b=OHRZHZ
	7hQcDZ5TjRB5oUeke8+63ncbDRjw6F4xqqh0+yqwgI8p8ju1vNMaAaQ02zzx3gvK
	as/XkKC+5MJvO/aMSMRfTedASiF0OYiO0kmUGNt5fhU2C5FnSlMSYV0bJ3T5q4dW
	Av1wQ83ZwTCRgCzg3grIxA11RkgIusd5mEIAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NFBlW+wYfpAhVykRTeQG1YQBYEsSGfVD
	wCGj05KP3dv3sK6+86SjSYjHyEwyyGjDowMzx5fo4ewUixBEip38VgzBAOcEHdm9
	IAnVZ20l46IVaWtFTeOoNuTB6gfhgi8H+Q0aqtRdPgqwWN4RxArtQhCJSOkBfQV2
	pzKkVh/5Iu4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2174116645;
	Mon, 15 Apr 2013 18:29:36 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7FF1716643; Mon, 15 Apr
 2013 18:29:35 +0000 (UTC)
In-Reply-To: <87vc7odvzi.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's
 message of "Mon, 15 Apr 2013 10:44:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C80FA8E-A5FA-11E2-98EC-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221283>

Thomas Rast <trast@inf.ethz.ch> writes:

> From a cursory glance it looks like it's actually an existing bug in
> read_revisions_from_stdin or handle_revision_arg, depending on which way
> you look at it.  read_revisions_from_stdin passes its temporary buffer
> down to handle_revision_arg:
>
>         struct strbuf sb;
>         [...]
>         strbuf_init(&sb, 1000);
>         while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
>                 [...]
>                 if (handle_revision_arg(sb.buf, revs, 0, REVARG_CANNOT_BE_FILENAME))
>                         die("bad revision '%s'", sb.buf);
>         }
>
> But handle_revision_arg ends up just stuffing that parameter into the
> revision-walker options via some helpers:
>
> 	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
> 	add_pending_object_with_mode(revs, object, arg, oc.mode);
>
> This seems to have been lurking since 281eee4 (revision: keep track of
> the end-user input from the command line, 2011-08-25).
>
> Junio, at which level should we fix it?  We could of course have
> read_revisions_from_stdin make a copy of the buffers it passes
> down, but perhaps it would be less surprising to instead have
> handle_revision_arg make sure it makes a copy of everything it
> "keeps"?

That sounds like the right way to go to me.

> The easy fix of course is just this:
>
> diff --git i/revision.c w/revision.c
> index 3a20c96..181a8db 100644
> --- i/revision.c
> +++ w/revision.c
> @@ -1277,7 +1277,8 @@ static void read_revisions_from_stdin(struct rev_info *revs,
>  			}
>  			die("options not supported in --stdin mode");
>  		}
> -		if (handle_revision_arg(sb.buf, revs, 0, REVARG_CANNOT_BE_FILENAME))
> +		if (handle_revision_arg(xstrdup(sb.buf), revs, 0,
> +					REVARG_CANNOT_BE_FILENAME))
>  			die("bad revision '%s'", sb.buf);
>  	}
>  	if (seen_dashdash)
