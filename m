From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6 (v2)] revision caching documentation: man page and 
 technical discussion
Date: Sun, 09 Aug 2009 11:16:44 -0700
Message-ID: <7v63cw97jn.fsf@alter.siamese.dyndns.org>
References: <op.uyb1uuu4tdk399@sirnot.private>
 <7vbpmqi2d4.fsf@alter.siamese.dyndns.org>
 <c77435a80908090701x3aa2584fq353df1886ed1b02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 20:17:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaCxE-0008JZ-2i
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 20:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbZHISRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 14:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752550AbZHISQ7
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 14:16:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47198 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbZHISQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 14:16:59 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B2E340FA;
	Sun,  9 Aug 2009 14:16:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48DAC40F3; Sun,  9 Aug
 2009 14:16:46 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D3BF5F38-8510-11DE-A09C-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125359>

Nick Edelen <sirnot@gmail.com> writes:

> As you said, I'll answer most of your questions in the revised docs,
> but I have one question about the time field size.  git uses unsigned
> long internally for its commit date, so it'd be limited by the 32bits
> a long is on 32bit archs.  So, wouldn't the commit times effectively
> be a uin32_t?

The current implementations may be either 32 or 64 bit, but at the on-disk
permanent data structure level they are decimal integers of unlimited
size.  As the rev-cache, similarly to the index, is a local "cache" whose
nature is transient (iow we can afford to say "this new version of git
updates the file format for the rev-cache; your existing rev-cache will be
converted automatically"), its data representation can have limitation
tied to the implementation.  But the limitation should be documented.

As to defining the on-disk data format using C structure, I'd strongly
suggest looking at, learning from and mimicking how read-cache.c and
cache.h handles struct ondisk_cache_entry.  I find writing out a structure
with bitfields as-is, like your patch does, quite iffy.

> Other than that there shouldn't be an overflow problem, unless
> someone's merging over 63 branches in one go.

The current Porcelains may not allow it, but at the data structure level
commit can have arbitrary number of parents, so that assumption is already
broken at the design level.  You need an escape hatch there.

"Because such a merge is so rare, walking the rev-cache that contains such
a commit gives a wrong result without any diagnosis to the caller" is an
unacceptable escape hatch.  It is perfectly fine if the escape hatch is
"because it is so rare, rev-cache marks commits involved in such a path,
and walking the path falls back to actually reading the objects, without
any performance benefit from the cache".  It probably is also Ok if the
escape hatch is "because it is beyond the implementation limit, 'add'
command errors out and rev-cache won't kick in for such a history."
