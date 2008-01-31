From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitignore(5): Allow "foo/" in ignore list to match directory "foo"
Date: Thu, 31 Jan 2008 02:35:33 -0800
Message-ID: <7vfxwecmfe.fsf@gitster.siamese.dyndns.org>
References: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com>
	<6bc632150801230604p2589c893pa05bb6f27e482de8@mail.gmail.com>
	<alpine.LFD.1.00.0801231313590.2803@woody.linux-foundation.org>
	<47A06EF9.60704@users.sourceforge.net>
	<7vprvjgi9v.fsf@gitster.siamese.dyndns.org>
	<47A1733E.9040103@users.sourceforge.net>
	<7vhcgue5nr.fsf_-_@gitster.siamese.dyndns.org>
	<7v63xae4lf.fsf_-_@gitster.siamese.dyndns.org>
	<20080131094124.GA25546@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Piatyszek <ediap@users.sourceforge.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	pradeep singh rautela <rautelap@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 11:36:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKWmH-0005lk-C7
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 11:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765320AbYAaKfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 05:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765124AbYAaKfp
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 05:35:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765112AbYAaKfo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 05:35:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 318CE3B76;
	Thu, 31 Jan 2008 05:35:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 44DB33B74;
	Thu, 31 Jan 2008 05:35:36 -0500 (EST)
In-Reply-To: <20080131094124.GA25546@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 31 Jan 2008 04:41:25 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72121>

Jeff King <peff@peff.net> writes:

> You can at least lazily do the stat so that only users of foo/ need to
> pay the penalty. Something like this (completely untested):

Without "foo/", you do not have to pay the price, so I think
that is a sane optimization, but at the same time it would make
it worse if "foo/" is actually used.  excluded_1() is called for
the same pathname from a loop to check for a match and you would
end up running lstat(2) three times (once each for EXC_CMDL,
EXC_DIRS and EXC_FILE).

But maybe people who want "foo/" deserve it.  I dunno.

In any case, if you do this...

> @@ -581,7 +587,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
>  			if (simplify_away(fullname, baselen + len, simplify))
>  				continue;
>  
> -			dtype = get_dtype(de, fullname);
> +			dtype = get_dtype(de, fullname, 0);
>  			exclude = excluded(dir, fullname, dtype);
>  			if (exclude && dir->collect_ignored
>  			    && in_pathspec(fullname, baselen + len, simplify))

... I think you would need to get the real dtype again in later
part of this function after exclude() decides it should not
ignore it, before the "switch (dtype)" really uses it, on
systems with NO_D_TYPE_IN_DIRENT.
