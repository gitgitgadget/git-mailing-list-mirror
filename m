From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Libification project (SoC)
Date: Sun, 18 Mar 2007 01:23:32 -0400
Message-ID: <20070318052332.GC15885@spearce.org>
References: <20070316042406.7e750ed0@home.brethil> <20070316045928.GB31606@spearce.org> <7vejnpycu1.fsf@assigned-by-dhcp.cox.net> <20070316104715.483df0d5@localhost> <20070316140855.GE4489@pasky.or.cz> <20070316153822.5c842e69@localhost> <20070316231646.GB4508@spearce.org> <20070317195832.2af87c06@home.brethil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Sun Mar 18 06:23:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSnrr-0001KJ-Or
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 06:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbXCRFXm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 01:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbXCRFXm
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 01:23:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51377 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbXCRFXl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 01:23:41 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HSnri-00086A-3r; Sun, 18 Mar 2007 01:23:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7B2BB20FBAE; Sun, 18 Mar 2007 01:23:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070317195832.2af87c06@home.brethil>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42474>

"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:
> On Fri, 16 Mar 2007 19:16:46 -0400
> "Shawn O. Pearce" <spearce@spearce.org> wrote:
> | And then make their callers (if they are above the public API layer)
> | die instead.  In some cases this might imply an undesirable change
> | in the error message produced, as necessary details that are included
> | today would be unavailable in the caller.
> 
>  I've found a possible solution, though.
> 
>  Take a look at Rusty's solution for the same problem in
> module-init-tools:
> 
> """
> /* We use error numbers in a loose translation... */
> static const char *insert_moderror(int err)
> {
> 	switch (err) {
> 	case ENOEXEC:
> 		return "Invalid module format";
> 	case ENOENT:
> 		return "Unknown symbol in module, or unknown parameter (see dmesg)";
> 	case ENOSYS:
> 		return "Kernel does not have module support";
> 	default:
> 		return strerror(err);
> 	}
> }
> """

Take a look at sha1_file.c, open_packed_git_1:

...
    if (!pack_version_ok(hdr.hdr_version))
        return error("packfile %s is version %u and not supported"
            " (try upgrading GIT to a newer version)",
            p->pack_name, ntohl(hdr.hdr_version));
...

Here we are supplying a lot more than just a simple error code
that can be mapped to a static string.

Of course that code is currently feeding it to the error function,
which today calls the error_routine (see usage.c).  We could buffer
the strings sent to error()/warn() and let the caller obtain all
strings that occurred during the last API call.

-- 
Shawn.
