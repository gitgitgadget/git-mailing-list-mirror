From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commit f5bbc322 to git broke pre-commit hooks which read stdin
Date: Tue, 04 Mar 2008 04:17:30 -0800
Message-ID: <7vbq5u7kf9.fsf@gitster.siamese.dyndns.org>
References: <0tableanpe.wl%bremner@pivot.cs.unb.ca>
 <alpine.LSU.1.00.0803041044120.22527@racer.site>
 <7vk5ki91zj.fsf@gitster.siamese.dyndns.org> <47CD370A.3070404@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Bremner <bremner@unb.ca>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	Git Mailing List <git@vger.kernel.org>,
	469250@bugs.debian.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 04 13:18:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWW6G-00080e-QN
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 13:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123AbYCDMRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 07:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358AbYCDMRw
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 07:17:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942AbYCDMRv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 07:17:51 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4B4B02C45;
	Tue,  4 Mar 2008 07:17:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6439D2C44; Tue,  4 Mar 2008 07:17:40 -0500 (EST)
In-Reply-To: <47CD370A.3070404@viscovery.net> (Johannes Sixt's message of
 "Tue, 04 Mar 2008 12:48:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76079>

Johannes Sixt <j.sixt@viscovery.net> writes:

>> It is not metastore.  It is an interactive hook that reads from the user
>> who is sitting on the terminal and invoked the git-commit program.
>
> Are you saying stdin should not be directed to /dev/null, or that an
> interactive hook is required to do
>
>     exec < /dev/tty || { echo 2>&1 "not interactive"; exit 1; }
>
> before it reads from stdin?

I am saying that scripted version left the stdin as-is but somehow we
ended up spawning with .no_stdin = 1 in the C-rewrite, which is a change
in established behaviour.  It is often called a regression, unless the
change has a very good reason.  And I tend to think this particular one
falls into the former.

We should audit how the hooks are called from various commands
re-implemented, comparing the environment the scripted version used to
give them, which includes:

 - what directory the hook is run in;
 - what environment variables are exported to it;
 - what temporary files are visible to them for inspection;
 - in what order they are run;
 - which file descriptor is connected to what;

I think we already caught some of the environment and ordering issues in
commit and checkout, but I am far from confident to say that what we have
behave identically to the scripted version.
