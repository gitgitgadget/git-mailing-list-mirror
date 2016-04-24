From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] fast-import: implement unpack limit
Date: Sun, 24 Apr 2016 20:36:50 +0000
Message-ID: <20160424203650.GA32458@dcvr.yhbt.net>
References: <20160423024225.GA4293@dcvr.yhbt.net>
 <20160423031313.GA15043@sigill.intra.peff.net>
 <20160424043223.GA27609@dcvr.yhbt.net>
 <xmqqpoten7db.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 22:36:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auQlz-00064O-4b
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 22:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbcDXUgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 16:36:51 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52212 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226AbcDXUgv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 16:36:51 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CB9863381E;
	Sun, 24 Apr 2016 20:36:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqpoten7db.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292442>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> > +	argv_array_push(&unpack.args, "unpack-objects");
> > +	argv_array_push(&unpack.args, "-q");
> > +
> > +	return run_command(&unpack);
 
> Looks good.  I haven't thought if "-q" is appropriate or not though.

Oops, I think tying it to the existing --quiet option in PATCH v3
would be good.

> > @@ -972,6 +990,12 @@ static void end_packfile(void)
> >  		fixup_pack_header_footer(pack_data->pack_fd, pack_data->sha1,
> >  				    pack_data->pack_name, object_count,
> >  				    cur_pack_sha1, pack_size);
> > +
> > +		if (object_count <= unpack_limit) {
> > +			if (loosen_small_pack(pack_data) == 0)
> > +				goto discard_pack;
> > +		}
> 
> "if (!loosen_small_pack(pack_data))" would be more idiomatic, but
> the logic is very clear here.  We haven't created the idx, we skip
> the part that creates the idx and instead jump directly to the part
> that closes and unlinks it.

I was on the fence about "!" vs "== 0" vs something else, too;
and I get thrown off by things like "!strcmp" in C all the time.
I can change it to "if (!loosen_small_pack(pack_data))" in v3
(probably in a day or so in case there's further comments)
