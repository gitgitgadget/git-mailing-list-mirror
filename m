From: J Chapman Flack <jflack@math.purdue.edu>
Subject: git's fascination with absolute paths
Date: Mon, 21 Dec 2009 13:42:02 -0500
Message-ID: <4B2FC17A.3010705@math.purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 20:06:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMnaP-0000ci-Tg
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 20:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757020AbZLUTGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 14:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756998AbZLUTGX
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 14:06:23 -0500
Received: from mailhub131.itcs.purdue.edu ([128.210.5.131]:54713 "EHLO
	mailhub131.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756177AbZLUTGW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Dec 2009 14:06:22 -0500
X-Greylist: delayed 1449 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Dec 2009 14:06:22 EST
Received: from math.purdue.edu (zorn.math.purdue.edu [128.210.3.177])
	by mailhub131.itcs.purdue.edu (8.14.2/8.14.2/smtp.purdue.edu) with ESMTP id nBLIg9eS021009
	for <git@vger.kernel.org>; Mon, 21 Dec 2009 13:42:09 -0500
Received: from mailrelay.math.purdue.edu (mailrelay.math.purdue.edu [128.210.3.183])
	by math.purdue.edu (8.13.8+Sun/8.13.6/RPM-20060601-1) with SMTP id nBLIg99m006289
	for <git@vger.kernel.org>; Mon, 21 Dec 2009 13:42:09 -0500 (EST)
Received: From mailrelay.math.purdue.edu ([128.210.3.183]) by mailrelay.math.purdue.edu (WebShield SMTP v4.5 MR3)
	id 1261420929270; Mon, 21 Dec 2009 13:42:09 -0500
Received: from hardy.math.purdue.edu [128.210.3.54]
	by mailrelay.math.purdue.edu (Alligate(TM) SMTP Gateway v3.9.7.13)
	with ESMPT id <A534CA0617A454A9.98F6E8DC8DC26213@mailrelay.math.purdue.edu>
	for <git@vger.kernel.org>; Mon, 21 Dec 2009 13:42:03 -0500
User-Agent: Thunderbird 2.0.0.22 (X11/20090609)
X-Alligate-SMTP: Whitelisted
X-Alligate-ReceivingIP: [128.210.3.183]
X-Originating-IP: 128.210.3.54
X-Destination-IP: 
X-Alligate-ID: 372752
X-Alligate-Out: IGNORED - WhiteListed From: (@*purdue.edu)
X-PMX-Version: 5.5.7.378829
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135563>


Hi list,

I have a requirement involving the reasonably common Unix-y design
pattern where a directory owned by a particular user lives in a
directory that user can't access, with a setuid gate that chdirs to
the right place and then drops to the real user's id to do certain
allowed things.

I wanted to use git for some of those allowed things and I can't,
because the code seems to call make_absolute_path on approximately
everything, and this is one of the situations that illustrates why it
isn't safe to assume you can get an absolute path that's even
usable (let alone race-free) corresponding to a relative path
in general.

git init tries to do this on the db path (even if
it's specified explicitly in GIT_DIR), and even if I do the git init
as root in advance, all the other git subcommands I've tried also
try to do it and fail when they chdir up out of the
working directory and try to chdir (not fchdir) back in.

In general it seems best for a program to stay free of assumptions
about absolute paths except when there is a specific functional
requirement that needs them.  I assume there is something git does
that requires it to have this limitation, but it's not intuitive
to me if I just think about what I expect an scm system to do.
I've searched on 'absolute' in the list archive to see if there
was a past discussion like "we've decided we need absolute paths
everywhere because X" but I didn't find any.  Can someone
describe what the reasoning was?  A security concern perhaps?
(And one more serious than the race condition built into
make_absolute_path?)

Or, perhaps I should be asking, what is there in git that will
break if I recompile it with make_absolute_path(p){return p;}?
Does it store absolute paths in the db?  Would a recompiled
version produce a db other gits couldn't read?

(Or less drastic perhaps, what if there were a version of m_a_p
that still returned an absolute path when possible and safe, and
just returned p otherwise so the program could still be usable?)

Thanks,
Chapman Flack
mathematics, purdue university
