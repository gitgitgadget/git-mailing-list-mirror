From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] gitk: use mktemp -d to avoid predictable temporary
 directories
Date: Sun, 15 Jun 2014 14:49:29 -0700
Message-ID: <20140615214928.GA619@gmail.com>
References: <1402695828-91537-1-git-send-email-davvid@gmail.com>
 <87k38ir4p0.fsf@red.patthoyts.tk>
 <20140615163227.GE368384@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:49:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwIJ7-00040N-LJ
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 23:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbaFOVtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 17:49:41 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:60894 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbaFOVtl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 17:49:41 -0400
Received: by mail-pd0-f176.google.com with SMTP id ft15so166477pdb.7
        for <git@vger.kernel.org>; Sun, 15 Jun 2014 14:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0+twchGU1bLFhKFNZ6zIbj+JTCkJXmfHcb8SoAmp/pA=;
        b=YmXJMMAD469bNxoHNE95dkM+CgUTLdt9BDyG2hkYcfHEgMndeed7Lf5Xd/eQjOjUBw
         4267R1CxzndEGXcn1ySHinwya463E9Wd9xv9M2dNE+yvAqK525dRFJZ3NoINCHUw8coV
         KozMT5PP77+AISEzJ5ISexL2L7m8Vy9zvdzVWemW8HT+mgqSvPpwX+zkIhrOiOGwKI/I
         lAZ2Cu7qyVbcuBGAsYVHMUUhuuXsaXA32A6+XRwNfaN7lCL2f1+tpaWVivIUBtBpf0wp
         v6ZZwN4oM6B36WZKRP0hSbC3lTlBz9Ij+WDIMwioYdaAMB2aJZAIjH+0PV7u6gfkFG91
         lcsg==
X-Received: by 10.68.164.100 with SMTP id yp4mr19109183pbb.136.1402868980790;
        Sun, 15 Jun 2014 14:49:40 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id si8sm58147783pab.27.2014.06.15.14.49.39
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 15 Jun 2014 14:49:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140615163227.GE368384@vauxhall.crustytoothpaste.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251698>

On Sun, Jun 15, 2014 at 04:32:27PM +0000, brian m. carlson wrote:
> On Sun, Jun 15, 2014 at 08:51:23AM +0100, Pat Thoyts wrote:
> > David Aguilar <davvid@gmail.com> writes:
> > >--- a/gitk
> > >+++ b/gitk
> > >@@ -3502,7 +3502,8 @@ proc gitknewtmpdir {} {
> > > 	} else {
> > > 	    set tmpdir $gitdir
> > > 	}
> > >-	set gitktmpdir [file join $tmpdir [format ".gitk-tmp.%s" [pid]]]
> > >+	set gitktmpformat [file join $tmpdir ".gitk-tmp.XXXXXX"]
> > >+	set gitktmpdir [exec mktemp -d $gitktmpformat]
> > > 	if {[catch {file mkdir $gitktmpdir} err]} {
> > > 	    error_popup "[mc "Error creating temporary directory %s:" $gitktmpdir] $err"
> > > 	    unset gitktmpdir
> > 
> > This is a problem on Windows where we will not have mktemp. In Tcl 8.6
> > the file command acquired a "file tempfile" command to help with this
> > kind of issue (https://www.tcl.tk/man/tcl8.6/TclCmd/file.htm#M39) but
> > for older versions we should probably stick with the existing pattern at
> > least on Windows.
> 
> The existing pattern is a security bug on Unix systems. MITRE (CWE-377)
> tells me that it is a vulnerability on Windows as well, so you'd
> probably want to come up with a better solution than the existing
> pattern.
> 
> You also probably want to request a CVE for this, which the Red Hat and
> Debian security teams can do for you if you like.  Distributions will
> likely want to issue security advisories for this.

I don't think this requires a CVE since it's basically plugging a hole
that my previous patch introduced by making gitk honor the TMPDIR
variable; it hasn't strictly been in any release yet.

Does Git on Windows use a modern tcl?
I checked, and my (old) existing msysgit installation had tcl
8.5, so I unfortunately using "file tempname" won't help there.

Hmm.. I guess what I could do is keep the old behavior (having gitk ignore TMPDIR)
on Windows and only use the new code path on non-Windows.

That seems like it'd be the simplest implementation (no need to check versions)
and the least harmful to existing users (avoids a tcl upgrade or mkdtemp installation
for Windows users).
-- 
David
