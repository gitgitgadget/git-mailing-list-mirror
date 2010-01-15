From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 13/14] daemon: use select() instead of poll()
Date: Fri, 15 Jan 2010 23:49:06 +0100
Message-ID: <201001152349.06418.j6t@kdbg.org>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com> <1263591033-4992-14-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	"Erik Faye-Lund" <kusmabite@gmail.com>
To: "Erik Faye-Lund" <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 23:50:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVuza-00047R-Dd
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 23:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758548Ab0AOWuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 17:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758533Ab0AOWuE
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 17:50:04 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:53969 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758513Ab0AOWuE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 17:50:04 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3E1D61000B;
	Fri, 15 Jan 2010 23:50:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 82A2319F5A6;
	Fri, 15 Jan 2010 23:49:06 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1263591033-4992-14-git-send-email-kusmabite@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137150>

On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
> +#undef FD_SET
> +#define FD_SET(fd, set) do { \
> +	((fd_set*)(set))->fd_array[((fd_set *)(set))->fd_count++] =
> _get_osfhandle(fd); \ +	} while(0)
> +#undef FD_ISSET
> +#define FD_ISSET(fd, set) __WSAFDIsSet(_get_osfhandle(fd), (fd_set
> *)(set)) +

I'm worried about the internals that you have to use here. Isn't it possible 
save the original macro text and use it in the new definition, like (this is 
for exposition only):

#define ORIG_FD_SET(fd, set) FD_SET(fd, set)
#undef FD_SET
#define FD_SET(fd, set) ORIG_FD_SET(_get_osfhandle(fd), set)

Another approach would be to extend the poll emulation such that it uses 
select if all FDs to wait for are sockets, and I think this would be the case 
in this application.

-- Hannes
