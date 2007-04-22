From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Today's 'master' leaves .idx/.pack in 0400
Date: Sun, 22 Apr 2007 11:54:41 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704221144250.9964@woody.linux-foundation.org>
References: <7vhcrml4wx.fsf@assigned-by-dhcp.cox.net> <7v1widrl0o.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704221019100.9964@woody.linux-foundation.org>
 <7vvefonvdz.fsf@assigned-by-dhcp.cox.net> <7vmz10nv1h.fsf_-_@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704221422250.28339@xanadu.home> <7vejmcnu28.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704221431430.28339@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Apr 22 20:55:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfhDM-0007ms-HT
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 20:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965650AbXDVSzI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 14:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbXDVSzH
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 14:55:07 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:46439 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965055AbXDVSzF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Apr 2007 14:55:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3MIsgKm024659
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Apr 2007 11:54:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3MIsfpm031918;
	Sun, 22 Apr 2007 11:54:41 -0700
In-Reply-To: <alpine.LFD.0.98.0704221431430.28339@xanadu.home>
X-Spam-Status: No, hits=-3.041 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45267>



On Sun, 22 Apr 2007, Nicolas Pitre wrote:
> 
> Well, actually there is no point making pack files writable.  If they're 
> modified, they get corrupted.
> 
> Here's the fix I wanted to propose:
> 
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index c72e07a..85c6e6e 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -1786,11 +1786,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  		if (rename(pack_tmp_name, tmpname))
>  			die("unable to rename temporary pack file: %s",
>  			    strerror(errno));
> +		chmod(tmpname, 0444);

I think this is wrong (as is Junio's). I think we should still honor the 
repository permission setting, and default to honoring umask.

So I think that if the user has a umask that says "nobody else can read", 
then we should *not* make it world readable (unless the 
"shared_repository" thing is set to override it, of course).

		Linus
