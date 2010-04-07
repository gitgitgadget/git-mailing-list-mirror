From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: git-svn clone fails
Date: Wed, 07 Apr 2010 11:31:31 +0200
Message-ID: <1270632691.5703.21.camel@localhost.localdomain>
References: <4BBAFEC5.6030103@tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heikki Orsila <heikki.orsila@tut.fi>,
	Santtu Pajukanta <santtu.pajukanta@tut.fi>
To: Janne Kulmala <janne.t.kulmala@tut.fi>
X-From: git-owner@vger.kernel.org Wed Apr 07 11:45:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzRpA-0006Lk-Mj
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 11:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806Ab0DGJpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 05:45:24 -0400
Received: from smtp-out1.tiscali.nl ([195.241.79.176]:48332 "EHLO
	smtp-out1.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362Ab0DGJpW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 05:45:22 -0400
X-Greylist: delayed 825 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Apr 2010 05:45:22 EDT
Received: from [212.123.169.34] (helo=[192.168.1.100])
	by smtp-out1.tiscali.nl with esmtp (Exim)
	(envelope-from <pebolle@tiscali.nl>)
	id 1NzRbk-0003Ua-Eq; Wed, 07 Apr 2010 11:31:36 +0200
In-Reply-To: <4BBAFEC5.6030103@tut.fi>
X-Mailer: Evolution 2.29.91 (2.29.91-1.fc13) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144210>

On Tue, 2010-04-06 at 12:28 +0300, Janne Kulmala wrote:
> I'm trying to clone OpenTTD subversion repository using git-svn from 
> Debian Lenny testing. Git version is 1.7.0. The clone operationg always 
> fails at the same revision with same error message.
> 
> I am using the following command:
> 
> 	git svn clone svn://svn.openttd.org/trunk openttd
> 
> Which gives this error message:
> 
> r1170 = 12fbf791d6e353346315756bf46cbbf75a325833 (refs/remotes/git-svn)
> Use of uninitialized value in concatenation (.) or string at 
> /usr/lib/perl5/SVN/Core.pm line 584.

I don't do perl but this looks like a bug in subversion's perl bindings.
This seems to fix it (where fix basically means something like "make
sure this warning/error isn't printed again):

--- /usr/lib/perl5/SVN/Core.pm.oud	2008-08-13 18:32:32.000000000 +0200
+++ /usr/lib/perl5/SVN/Core.pm	2010-04-07 10:30:19.000000000 +0200
@@ -581,7 +581,9 @@
 
 		my $error_message = $svn_error->strerror();
 		while ($svn_error) {
-		    $error_message .= ': ' . $svn_error->message();
+                    if ($svn_error->message()) {
+		        $error_message .= ': ' . $svn_error->message();
+                    }
 				$svn_error = $svn_error->child();
 		}
 		return $error_message;

> Network connection closed unexpectedly:  at /usr/lib/git-core/git-svn 
> line 5047
>
> Is this a Debian-specific problem, or a bug in git-svn?

No, the exact same problem can be triggered in fedora rawhide too (with
git-svn-1.7.0.1-1.fc14.noarch). It seems openttd's svn server terminates
the connection after fetching (roughly) 1000 commits. (I'm not sure what
happens. I don't know how to debug perl.)

A workaround might be to enter the openttd directory you just created
and do "git svn fetch" a number of times. (I stopped after it terminated
for the third time, around commit 2600. There are over 19.500 commits in
that trunk, so that might take a while. Whether you'll end up with a
working and correct clone I can't say.)

Could it be openttd's svn server doesn't really appreciate the way
git-svn uses it (a straightforward svn checkout finished much quicker
and in one session)?

Regards,


Paul Bolle
