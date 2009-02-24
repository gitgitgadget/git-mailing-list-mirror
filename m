From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --format that is a synonym to --pretty
Date: Mon, 23 Feb 2009 21:33:59 -0800
Message-ID: <7vprh8mm9k.fsf@gitster.siamese.dyndns.org>
References: <94a0d4530902220918oc6f8ab9vc1fd0b55cad014a2@mail.gmail.com>
 <7v63j2z7bh.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com>
 <7vbpsuxqpo.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902221055g4e815a78oc0aa094304588ab7@mail.gmail.com>
 <7vljrxveqa.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902231656l71ee0e45nbdd1c20035d3dd4@mail.gmail.com>
 <94a0d4530902231703n701a17dbkd20c0e14d759dddf@mail.gmail.com>
 <7v3ae4r53f.fsf@gitster.siamese.dyndns.org>
 <20090224130626.6117@nanako3.lavabit.com>
 <20090224045041.GA4615@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, felipe.contreras@gmail.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 24 06:35:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbpxF-0002CK-Dx
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 06:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbZBXFeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 00:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbZBXFeL
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 00:34:11 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbZBXFeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 00:34:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B3B189CFD7;
	Tue, 24 Feb 2009 00:34:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 075D29CFD4; Tue,
 24 Feb 2009 00:34:00 -0500 (EST)
In-Reply-To: <20090224045041.GA4615@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 23 Feb 2009 23:50:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C0FE07DC-0234-11DE-AC9F-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111211>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 24, 2009 at 01:06:26PM +0900, Nanako Shiraishi wrote:
>
>> Some people prefer to call the pretty-print styles "format", and get
>> annoyed to see "git log --format=short" fail.  Introduce it as a synonym
>> to --pretty so that both can be used interchangeably without breaking
>> examples in existing web pages or ppeople's expectations.
>
> Thinking about this in context of the proposal to support --oneline (et
> al), I think this part by itself gives confusing behavior. That is,
> --pretty=oneline can be shortened to --oneline, but --pretty=format:$x
> cannot be shortened to --format=$x.
>
> But that is modified by what happens next:
>
>> Having to say --format="format:%h %s" is redundant because none of the
>> predefined pretty-print styles have per-cent sign in it, so this patch
>> also makes it possible to say --pretty="%h %s" (and --format="%h %s").
>
> This implies that --format=$x is equivalent to --pretty=format:$x, but
> the patch actually implements the equivalent of --pretty=tformat:$x.
>
> So that raises two concerns:
>
>   1. We have to pick one as the "most common" for this shorthand; are we
>      sure tformat is it? (Personally, I think it is, but I think it is a
>      subtle point which we should be sure of).
>
>   2. This _almost_ fixes the point I raised above. That is, --format=$x
>      would match its longer --pretty=format:$x counterpart. Except that
>      --format does _tformat_, which I would have expected to get via
>      --tformat under such a proposal.

I think the patch suffers from the same problem Felipe's patch had, by
conflating two issues.  Because it had the ":some string with %" shorthand
support in addition to "--format is another way to spell --pretty", and it
did that only to "--format" side, I initially misunderstood Felipe's patch
as primarily addressing "Why do we have to say '--pretty=format:%h %s'
when it is obvious from the context that '%h %s' is a format".  It turns
out that he did not like "pretty" and wanted to be able to say "format"
even for the predefined pretty-print styles.

If we split this round into two patches, one that makes --format a synonym
to --pretty, and then another one that allows --{format,pretty}='%h %s',
and *stop there*, then we wouldn't have difficulties.

I do not think --oneline is a bad idea, but I do not think we should
explain it as "You can write anything that you can write after '--pretty='
without 'pretty=' and they mean the same thing".  That's where your
concern arises from.  You just say "'--pretty=oneline --abbrev-commit' is
so often used, so we have a shorthand for the whole thing: --oneline",
without implying anything about other things such as --short or --tformat.
