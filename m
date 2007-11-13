From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/2] Fix parent rewriting in --early-output
Date: Tue, 13 Nov 2007 00:24:55 -0800
Message-ID: <7vabpiv9go.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
	<18221.14113.498416.396006@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711041004220.15101@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711041124050.15101@woody.linux-foundation.org>
	<alpine.LFD.0.9999.0711122046570.2786@woody.linux-foundation.org>
	<7v1wauzomr.fsf@gitster.siamese.dyndns.org>
	<20071113080125.GB14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 09:25:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irr5F-0005UW-CD
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 09:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbXKMIZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 03:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbXKMIZF
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 03:25:05 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50888 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbXKMIZD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 03:25:03 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2EB3A2F2;
	Tue, 13 Nov 2007 03:25:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8764C923EC;
	Tue, 13 Nov 2007 03:25:18 -0500 (EST)
In-Reply-To: <20071113080125.GB14735@spearce.org> (Shawn O. Pearce's message
	of "Tue, 13 Nov 2007 03:01:25 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64767>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> I have to wonder what would happen if a much higher level caller
>> caused the objects to get parsed before coming into the revision
>> walking machinery, e.g. after the command line processing for
>> A...B walked the ancestry chain until their common ancestors are
>> found.  So these commits between A and B are parsed, but the
>> revision limiting machinery hasn't done its operation to set
>> TREECHANGE and/or UNINTERESTING in add_parents_to_list() on
>> these commits yet.
>
> That's one of the problems with the way the revision walking
> machinery is built.  Its fast, but it can really only be used once.

Yes but not quite.  As long as you do not use overlapping set of
flag bits without cleaning, you are almost Ok.

The reason I say "almost" is that I think the true problem with
the first patch by Linus was to load "parsed" bit any semantics
other than "we have read and parsed the data so do not bother
rereading it".  If it used another mechanism (e.g. another flag
bit that means "we have done TREECHANGE and stuff"), returning
rewrite_one_ok to punt when seeing an unprocessed node would
have been safe, as it would not have munged the parent list.
The replacement "TREESAME" patch would work much better without
using such an extra bit, because it allows us to directly check
"if we already decided this does not change from the parent",
and the lack of the bit covers both "we haven't processed it"
and "we processed but we do not want to prune" cases, and not
pruning is safe and easily and correctly re-processible in the
post clean-up phase of the early_output series.

But in general, you're right.  An operation that changes the
ancestry shape is irreversible, and you would need to cause
reparsing of the commit objects after you are done with revision
traversal, and at that point, discarding and re-reading
everything from scratch, although is heavy-handed, is one
plausible approach to tackle the problem.
