From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [Updated PATCH 2/2] Improve transport helper exec failure
 reporting
Date: Thu, 31 Dec 2009 20:24:36 +0200
Message-ID: <20091231182436.GA1326@Knoppix>
References: <1262170338-11574-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1262170338-11574-3-git-send-email-ilari.liusvaara@elisanet.fi>
 <4B3CC6E5.7090404@kdbg.org>
 <20091231165904.GA24243@Knoppix>
 <4B3CE3D2.5010502@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Dec 31 19:24:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQPhU-0005WE-Pa
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 19:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbZLaSYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 13:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbZLaSYl
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 13:24:41 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:36012 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbZLaSYk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 13:24:40 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 0D0268C044;
	Thu, 31 Dec 2009 20:24:39 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A07AFEB5453; Thu, 31 Dec 2009 20:24:38 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id D0BD6158A64;
	Thu, 31 Dec 2009 20:24:36 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <4B3CE3D2.5010502@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135960>

On Thu, Dec 31, 2009 at 06:48:02PM +0100, Johannes Sixt wrote:
> Ilari Liusvaara schrieb:
> >On Thu, Dec 31, 2009 at 04:44:37PM +0100, Johannes Sixt wrote:
> >>Ilari Liusvaara schrieb:
 
> And you change this by treating the helper command not as a git
> command, but as a normal command that happens to start with 'git-'.
> Whether this interpretation is suitable for the transport layer, I
> do not want to decide and I will certainly not object. :-)

The transport helpers are special: they shouldn't be built-in.

> An alternative solution would be to forward the silent_exec_failure
> flag to exec_git_cmd() to unify the treatment of the error condition
> with the non-git-command error path.

Won't work. The error in git command case would be noted in another memory
image. And passing that back would be nasty to say the least.
 
> In case 3, it is expected that the child process prints a suitable
> error message. Therefore, you should start with merely replacing the
> unconditional
> 
> 	exit(127);
> by
> 	if (errno == ENOENT)
> 		exit(127);
> 	else
> 		die_errno("Cannot exec %s", cmd->argv[0]);
> 
> And then you can think about how you support the ENOENT case better.
> My proposal for this was to do the PATH lookup manually before the
> fork(), and then the above conditional would melt down to simply:
> 
> 	die_errno("Cannot exec %s", cmd->argv[0]);
> 

The child process can't sanely print anything. Stderr would go to
who knows where. Parent process should have much better idea what to
do with errors.


-Ilari
