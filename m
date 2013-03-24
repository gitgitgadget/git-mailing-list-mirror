From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 2/3] t7800: fix tests when difftool uses --no-symlinks
Date: Sun, 24 Mar 2013 12:36:20 +0000
Message-ID: <20130324123620.GA2286@serenity.lan>
References: <cover.1363980749.git.john@keeping.me.uk>
 <cover.1364045138.git.john@keeping.me.uk>
 <cover.1364045138.git.john@keeping.me.uk>
 <e44349728c07d8ae22d4b73527b1d124b49cc4a9.1364045138.git.john@keeping.me.uk>
 <7vd2up4bo7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 13:37:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJkAh-0006dQ-1u
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 13:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560Ab3CXMgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 08:36:39 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:36196 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503Ab3CXMgi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 08:36:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 98091CDA5BF;
	Sun, 24 Mar 2013 12:36:37 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MED6Cf4saiQf; Sun, 24 Mar 2013 12:36:35 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 60CE1CDA569;
	Sun, 24 Mar 2013 12:36:25 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vd2up4bo7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218953>

On Sat, Mar 23, 2013 at 10:19:36PM -0700, Junio C Hamano wrote:
> > In the longer term, difftool probably needs to learn to warn the user
> > instead of overwrite any changes that have been made to the working tree
> > file.
> 
> Questionable.
> 
> Admittedly I do not use difftool myself, and I have long assumed
> that difftool users are using the tools to _view_ the changes, but
> apparently some of the tools let the user muck with what is shown,
> and also apparently people seem to like the fact that they can make
> changes.  So I've led to believe the "update in difftool, take the
> change back to working tree, either by making symbolic links or
> copying them back" behaviour was a _feature_.

Yes it is.  I think my explanation wasn't clear enough here.

What currently happens is that after the user's tool has finished
running the working tree file and temporary file are compared and if
they are different then the temporary file is copied over the working
tree file.

This is good if the user has edited the temporary file, but what if they
edit they working tree file while using the tool to examine the
differences?  I think we need to at the very least look at the mtime of
the files and refuse to copy over the temporary file if that of the
working tree file is newer.

Obviously none of this matters if we can use symlinks, but in the
non-symlink case I think a user might find it surprising if the
(unmodified) file used by their diff tool were suddenly copied over the
working tree wiping out the changes they have just made.

> It is possible that this is not universally considerd as a feature,
> but if that is the case, I think the right way to do this is to tell
> the tools _not_ to let the user to modify contents they show in the
> first place, not letting the user modify and then warning after the
> fact.
