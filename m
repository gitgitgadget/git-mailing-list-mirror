From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Sun, 10 Aug 2008 15:34:37 -0700
Message-ID: <7v7iao1oua.fsf@gitster.siamese.dyndns.org>
References: <20080809210733.GA6637@oh.minilop.net>
 <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com>
 <20080810035101.GA22664@spearce.org> <20080810112038.GB30892@cuci.nl>
 <alpine.DEB.1.10.0808100502530.32620@asgard.lang.hm>
 <20080810145019.GC3955@efreet.light.src> <20080810175735.GA14237@cuci.nl>
 <20080810181115.GA3906@efreet.light.src> <20080810201651.GB14237@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>, david@lang.hm,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Jamey Sharp <jamey@minilop.net>,
	Josh Triplett <josh@freedesktop.org>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Mon Aug 11 00:36:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSJW0-0002Oj-Ek
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 00:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbYHJWeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 18:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753535AbYHJWeu
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 18:34:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbYHJWet (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 18:34:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9D322506A6;
	Sun, 10 Aug 2008 18:34:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DB9C1506A0; Sun, 10 Aug 2008 18:34:39 -0400 (EDT)
In-Reply-To: <20080810201651.GB14237@cuci.nl> (Stephen R. van den Berg's
 message of "Sun, 10 Aug 2008 22:16:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8A3A68C4-672C-11DD-A328-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91894>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

> I agree that using a custom rare extension would allow for almost no
> change to git-core.

And at that point there is no "plumbing" side change necessary.  You just
have to teach your Porcelain to notice the associated "metainfo" files and
deal with them.

For merging such "metainfo", you would need to do your "flattish/unrich"
checkout anyway, so it might be that an easier approach for such a
Porcelain might be:

 * Define a specific leading path, say ".attrs" the hierarchy to store the
   attributes information.  Attributes to a file README and t/Makefile
   will be stored in .attrs/README and .attrs/t/Makefile.  They are
   probably just plain text file you can do your merges and parsing easily
   but with this counterproposal the only requirement is they are simple
   plain blobs.  The plumbing layer does not care what payload they carry.

 * When you want to "git setattr $path", the Porcelain mucks with
   ".attr/$path".  Probably checkout codepath would give you a hook that
   lets you reflect what ".attr/$path" records to "$path", and checkin
   (i.e. not commit but update-index) codepath would have another hook to
   let you grab attributes for "$path" and update ".attr/$path".

 * Merging and handling updates to ".attrs/" hierarchy are done the usual
   way we handle blobs.  Your Porcelain would then take the result and do
   whatever changes to ACL or xattrs to the corresponding path, perhaps
   from a hook after merge.

So it will most likely boild down to a "Porcelain only" convention that
different Porcelains would agree on.

My reaction for the initial proposal was very similar to the one given by
Shawn.  I do not see much point on having plumbing side support (yet).
