From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] daemon: send stderr of service programs to the syslog
Date: Mon, 15 Jun 2009 23:39:43 +0200
Message-ID: <200906152339.43607.j6t@kdbg.org>
References: <200906142238.51725.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 23:40:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGJuJ-00061B-26
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 23:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934315AbZFOVjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 17:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760355AbZFOVjs
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 17:39:48 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46217 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753744AbZFOVjs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 17:39:48 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id EBEB7A7EB3;
	Mon, 15 Jun 2009 23:39:48 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B00CE4275D;
	Mon, 15 Jun 2009 23:39:43 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <200906142238.51725.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121631>

On Sonntag, 14. Juni 2009, Johannes Sixt wrote:
>  I don't know whether service programs like upload-archive or upload-pack
>  write progress report to stderr or not, for example, if a client does not
>  support side-bands. In this case this patch is probably not enough since
>  this would fill the log with unneeded progress information. Any hints
>  are appreciated.

The progress indicator can be helped . But there is now another anoyance: If 
the client terminates the connection early, this is now logged as:

fatal: unable to run 'git-upload-pack'

The reason for this is that upload-pack is run as 'git upload-pack', which 
itself spawns the external 'git-upload-pack'. The latter dies from a SIGPIPE, 
and the former, in execv_dashed_external(), dutyfully writes this down.

The easiest solution is perhaps to make upload-pack a builtin.

BUT... The motivation, of which this patch is actually a fall-out, is to clean 
up the messy error behavor of the start,finish,run_command family. To take 
care of this error message is just one more (hopefully small) point on my 
agenda.

>  I intend to follow-up this patch with another one that integrates
>  run_service_command() in execute() in order to streamline how the
>  'incoming' fd is inherited to the service programs.

I'm not sure anymore whether the change I planned here is worth it. When I 
wrote this announcement, I had mis-remembered how daemon.c's handle() and 
execute() functions and --inetd mode interact.

-- Hannes
