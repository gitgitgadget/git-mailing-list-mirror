From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH v3] cherry-pick: make sure all input objects are commits
Date: Mon, 15 Apr 2013 12:12:54 -0700
Message-ID: <7v61znsj49.fsf@alter.siamese.dyndns.org>
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
	<git@vger.kernel.org>, Michael Haggerty <mhagger@alum.mit.edu>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 15 21:13:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URopr-0006r5-Kq
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 21:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934980Ab3DOTM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 15:12:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43378 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932892Ab3DOTM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 15:12:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3280916C02;
	Mon, 15 Apr 2013 19:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ujq74TrxWYEZSosfW7CfXd96RLE=; b=iRBgWD
	ZfIC90039jKPcKS1+SDh1KorXTwImxLPjkU2+ofHlN1s3w5nhPyxwWYKzMm3vw62
	9ntdzE7SuCFUkPfreK7HobSrWJk+RP9Hnu4FHbmJAStravkBK7GW1mt9EZ++gfQc
	N5jkWR5mm/1XmQQn+hUPqES53UbdEc38f3yyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RWgoPsA58ziZrxQ94CWRm8MvEw+e54Ul
	XxyMyN516SykzNA5Yaa8BDLCtdfSL5lZMQKAA/THks/eCxOF0nSM02yXQl3D+pHZ
	XtqkqmkfQodoRxRCOXZqDiNv0yWHYcwWcbwiHf3WWbeWzPkyuQOl5916RQc3obcs
	wospYX6VQy8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2969016C01;
	Mon, 15 Apr 2013 19:12:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80CA116BFA; Mon, 15 Apr
 2013 19:12:56 +0000 (UTC)
In-Reply-To: <87vc7odvzi.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's
 message of "Mon, 15 Apr 2013 10:44:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7AD26F86-A600-11E2-9000-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221301>

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
> read_revisions_from_stdin make a copy of the buffers it passes down, but
> perhaps it would be less surprising to instead have handle_revision_arg
> make sure it makes a copy of everything it "keeps"?

Looking at it again, it seems that the issue is much older than the
introduction of cmdline interface.

Everything we throw at add_pending_object() is assumed to be stable,
because historically they were argv[] strings, and --stdin is what
breaks that assumption.  Making copies unconditionally at the lower
layer only because some minority callers give it unstable strings
does not sound like a good trade-off.

So I changed my mind.  Your "easy fix" looks to me the right thing
to do.

The paths given to handle_refs() may also have to be copied before
saved, depending on how ref iteration is implemented, details of
which may change as Michael seems to be updating the area again.
I think we let the callback peek ref_entry->name[] which is stable,
so I suspect we are OK.

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
