From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: "fatal: index-pack failed" on git-clone
Date: Wed, 8 Jul 2009 22:42:51 +0200
Message-ID: <200907082242.51495.j6t@kdbg.org>
References: <C92DE6F3-4F35-469F-AC28-4DDD1D8105C2@uchicago.edu> <4103BA41-39E4-496F-A76F-17D84F30EA21@uchicago.edu> <7vd48b6md8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Fritz Anderson <fritza@uchicago.edu>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 22:43:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOdz4-0006La-7g
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 22:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662AbZGHUm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 16:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753482AbZGHUm4
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 16:42:56 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:30641 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007AbZGHUmz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 16:42:55 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9425AA7EBB;
	Wed,  8 Jul 2009 22:42:52 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 05CAD3FFD4;
	Wed,  8 Jul 2009 22:42:51 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vd48b6md8.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122918>

On Mittwoch, 8. Juli 2009, Junio C Hamano wrote:
> The PATH exported when this execvp() runs should have been adjusted to
> have the exec-path at the beginning by calling setup_path() and this is
> done way before cmd_clone() was called by git.c::main() function.
>
> What am I not seeing?  There should be something obvious that I am
> missing.  I do not see how your original command can fail with "exec
> failed: No such file or directory".

It failed because /usr/local/bin is not in the PATH when git is run with sudo. 
Look at the original trace output:

> $ sudo GIT_TRACE=1 git clone ...

At this point PATH is "/bin:/usr/bin" and the invoked git 
is /usr/local/bin/git (appearently!).

> trace: built-in: git 'clone' ...
> Initialized empty Git repository in /srv/scientia/.git/
> trace: run_command: 'ssh' ... 'git-upload-pack ...
> Password:

At this point PATH is "/usr/local/libexec/git-core:/bin:/usr/bin". There is 
no /usr/local/bin.

> trace: run_command: 'index-pack' '--stdin' '-v' '--fix-thin' ...
> trace: exec: 'git' 'index-pack' '--stdin' '-v' '--fix-thin' ...

The PATH doesn't have 'git'; this must fail.

> trace: exec failed: No such file or directory
> trace: exec 'index-pack' failed: No such file or directory
> fatal: index-pack failed

However, if Fritz runs 'sudo /usr/local/bin/git clone ...', then the interim 
PATH is "/usr/local/bin:/usr/local/libexec/git-core:/bin:/usr/bin" because 
this time setup_path() finds a non-empty argv0_path, and the command works.

-- Hannes
