From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes:
 line
Date: Mon, 28 Oct 2013 07:16:06 +0000
Message-ID: <20131028071606.GA16878@leaf>
References: <20131024122255.GI9378@mwanda>
 <20131024122512.GB9534@mwanda>
 <20131026181709.GB10488@kroah.com>
 <20131027013402.GA7146@leaf>
 <xmqqa9hui2lp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Oct 28 08:16:43 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Vah47-0004tQ-3V
	for glk-linux-kernel-3@plane.gmane.org; Mon, 28 Oct 2013 08:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648Ab3J1HQO (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 28 Oct 2013 03:16:14 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43764 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802Ab3J1HQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Oct 2013 03:16:13 -0400
Received: from mfilter2-d.gandi.net (mfilter2-d.gandi.net [217.70.178.140])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 95F82172091;
	Mon, 28 Oct 2013 08:16:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter2-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter2-d.gandi.net (mfilter2-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id LCpxF4CraIW6; Mon, 28 Oct 2013 08:16:08 +0100 (CET)
X-Originating-IP: 77.221.165.98
Received: from leaf (ip-77-221-165-98.dsl.twang.net [77.221.165.98])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 43E0E172080;
	Mon, 28 Oct 2013 08:16:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqa9hui2lp.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236819>

On Sun, Oct 27, 2013 at 06:52:18PM -0700, Junio C Hamano wrote:
> There are unbound number of kinds of trailers people would want to
> add, depending on their projects' needs.  We should not have to add
> a specific support for a tailer like this one, before thinking
> through to see if we can add generic support for adding arbitrary
> trailers to avoid code and interface bloat.
> 
> Think of the existing --signoff as a historical mistake.  Such a
> generic "adding arbitrary trailers" support, when done properly,
> should be able to express what "--signoff" does, and we should be
> able to redo "--signoff" as a special case of that generic "adding
> arbitrary trailers" support, and at that point, "Fixes:" trailer the
> kernel project wants to use should fall out as a natural consequence.

Well, the add_signoff_extra function I added makes it easy to add any
kind of trailing data you want to a commit; the question just becomes
what the UI looks like to drive that.

Would you be OK with a solution that pushes the specific supported
footer lines into git's configuration, and then supplies default
configuration for common cases such as Fixes?  The option could become
-f/--footer, and the configuration would specify how to parse various
arguments of -f and turn them into something.  For example:

[footer "Fixes"]
    abbrev = f
    arg = commit
    format = %h ('%s')

git commit -f Cc:stable@vger.kernel.org -f f:bad-commit ...

The Cc line there would go unparsed since there's no specific support
for it, while the 'f:bad-commit' would get expanded by the configuration
above to parse bad-commit as a committish and format it using the
specified pretty format.

Look reasonable?  I could start out by adding support for footer lines
that take commits as arguments and format them using arbitrary pretty
strings, and leave room for future expansion to support footers that
reference idents (given some way to expand idents from some shorter
form, otherwise there's no point).

- Josh Triplett
