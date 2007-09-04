From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Calculating tree nodes
Date: Tue, 04 Sep 2007 10:39:28 -0700
Message-ID: <7vbqcinxdb.fsf@gitster.siamese.dyndns.org>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>
	<20070904025153.GS18160@spearce.org>
	<9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
	<20070904062629.GZ18160@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 19:39:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IScNJ-0003G0-Lc
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 19:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbXIDRjh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 13:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752624AbXIDRjh
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 13:39:37 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbXIDRjg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 13:39:36 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 89DAB12CA04;
	Tue,  4 Sep 2007 13:39:52 -0400 (EDT)
In-Reply-To: <20070904062629.GZ18160@spearce.org> (Shawn O. Pearce's message
	of "Tue, 4 Sep 2007 02:26:29 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57625>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> There's nothing stopping us from creating additional indexes.
> ...
> But we can also store the notes alongside the commits in the
> packfile, so that if the data for the commit has been paged in
> by the kernel then the note data is also most likely in memory,
> and if not, is in the read-ahead queue.  Clustering the notes
> alongside the commits makes access to them even faster, as we
> don't need to consult an external hash to locate the position.

I would agree with your main thrust "nobody prevents you from
building additional index", but on a tangent, I am skeptical
about adding too much to pack v4.  Especially "clustering the
notes" part.

Many operations (like "git log" that is not path limited) do not
even need trees.  The current packfile format has commits at the
beginning without any associated trees, and they are stored in
traversal order (modulo delta-base requirements can move base
object earlier), which is geared toward optimizing such a common
case.

Now, hopefully many operations do not need notes either,
although notes themselves can store _anything_ so each of them
could be large and/or each commit could have large number of
them.  I suspect clustering notes along with the commit they
annotate would break the locality of access for common case.
