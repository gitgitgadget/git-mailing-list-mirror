From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Crashes while trying to show tag objects with bad timestamps
Date: Fri, 22 Feb 2013 15:20:10 -0800
Message-ID: <7vppzsaqc5.fsf@alter.siamese.dyndns.org>
References: <kg8ri2$vjb$1@ger.gmane.org>
 <20130222224655.GB21579@sigill.intra.peff.net>
 <7vy5egark3.fsf@alter.siamese.dyndns.org>
 <20130222230418.GC21579@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 23 00:20:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U91ux-0003bY-KP
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 00:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758169Ab3BVXUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 18:20:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51967 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757857Ab3BVXUN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 18:20:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEA41B70D;
	Fri, 22 Feb 2013 18:20:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yFnkbYtSf7q4vDueo0MCEB8BK84=; b=gmta9H
	YfCMkWSRvXQ/zPB4EUQpNUsCXoQDSidk/gBfYGHojP61zpn4FYUd5vxbwz5G4RGC
	GjkWoEKSwixu7W5VeIixN5maxmUDF7lX8zf7HH4urciyH3oHjs5xfDEGw9lsVymo
	Flbb5fR0SEH2ibFatrBYQkgZMRUK5m4Xb0bak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cAFT8wgjtGG+1Z3VI73+0jxDqiYOgsam
	5vHgNTDFb9Z8a42f15JhG91bpAN0t7fBXQpnMrz8ddWCKuMWNPxjmInPiumLau+a
	G9pPNvzJceP3fQ0jb92ympWLjVfTLLZkFoDDt+824J32kYma8taNMqFKy+TFXRyF
	PIbSFuhYhdE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E406BB70C;
	Fri, 22 Feb 2013 18:20:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6257BB709; Fri, 22 Feb 2013
 18:20:12 -0500 (EST)
In-Reply-To: <20130222230418.GC21579@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 22 Feb 2013 18:04:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 683648B2-7D46-11E2-A37B-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216881>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 22, 2013 at 02:53:48PM -0800, Junio C Hamano wrote:
>
>> > I guess we should probably issue a warning, too. Also disappointingly,
>> > git-fsck does not seem to detect this breakage at all.
>> 
>> Yes for the warning, 
>
> Unfortunately, a good warning is harder than I had hoped. At the point
> where we notice the problem, pp_user_info, we have very little context.
> We can say only something like:
>
>   warning: malformed date in ident 'Jeff King <peff@peff.net> BOGUS'
>
> but we cannot say in which object, or even that it was a "tagger" line
> (and in some cases we do not even have an object, as in
> make_cover_letter).

As pp_user_info() is called from very few places, I do not think it
is unreasonable to add an output parameter (i.e. "unsigned *") to
let the caller know that we made a best guess given malformed input
and handle the error in the caller.  The make_cover_letter() caller
may look like:

	pp_user_info(&pp, NULL, &sb, committer, encoding, &errors);
        if (errors & PP_CORRUPT_DATE)
		warning("unparsable datestamp in '%s'", committer);

although it is unlikely to see this error in practice, given that
committer is coming from git_committer_info(0) and would have the
current timestamp.

> I also took a look at parsing routine of "cat-file -p". It's totally
> hand-rolled, separate from what "git show" does, and is not build on the
> pretty-print code at all. I wonder, though, if it actually makes sense
> to munge the date there. The commit-object pretty-printer for cat-file
> just shows the object intact. It seems weirdly inconsistent that we
> would munge tags just to rewrite the date. If you want a real
> pretty-printer, you should be using porcelain like "show".

The whole "cat-file -p" is a historical wart, aka poor-man's
"show".  I do not even consider it a part of the plumbing.  It is a
fair game for Porcelainisque improvement ;-)
