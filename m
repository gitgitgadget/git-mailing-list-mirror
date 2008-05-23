From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] gitk - restore operation of git-reset on Cygwin
Date: Fri, 23 May 2008 19:17:14 -0400
Message-ID: <20080523231714.GY29038@spearce.org>
References: <1211511636-3552-1-git-send-email-mlevedahl@gmail.com> <18486.15879.551874.408651@cargo.ozlabs.ibm.com> <483744AB.8070509@gmail.com> <48374F82.7050005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 24 01:18:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzgWX-0007h6-EL
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 01:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbYEWXRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 19:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbYEWXRS
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 19:17:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33043 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbYEWXRS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 19:17:18 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JzgVV-0003hQ-Ef; Fri, 23 May 2008 19:17:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 65C9620FBAE; Fri, 23 May 2008 19:17:14 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <48374F82.7050005@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82772>

Mark Levedahl <mlevedahl@gmail.com> wrote:
> >Paul Mackerras wrote:
> >>Are you using Tk 8.4 or 8.5?  The man pages for 8.5 imply that the
> >>2>@1 form should work for all platforms, but maybe that wasn't true in
> >>8.4.  If that's the case it's worth mentioning in the patch
> >>description.
> 
> I just tried installation of ActiveState Tcl 8.4.16, put that on the 
> Cygwin path, and gitk operates correctly without the patch. So, the 
> issue seems to be entirely one of Cygwin's particular Tcl/Tk build, 
> though whether that is due to the version or the odd attributes of its 
> compilation I cannot say.

git-gui ran into this problem and uses the following procedure
anytime it wants both stdout and stderr:

proc _open_stdout_stderr {cmd} {
    _trace_exec $cmd
    if {[catch {
            set fd [open [concat [list | ] $cmd] r]
        } err]} {
        if {   [lindex $cmd end] eq {2>@1}
            && $err eq {can not find channel named "1"}
            } {
            # Older versions of Tcl 8.4 don't have this 2>@1 IO
            # redirect operator.  Fallback to |& cat for those.
            # The command was not actually started, so its safe
            # to try to start it a second time.
            #
            set fd [open [concat \
                [list | ] \
                [lrange $cmd 0 end-1] \
                [list |& cat] \
                ] r]
        } else {
            error $err
        }
    }
    fconfigure $fd -eofchar {}
    return $fd
}

-- 
Shawn.
