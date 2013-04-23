From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [PATCH] gitk: workaround Tcl/Tk Cmd-TAB behavior on OSX
Date: Tue, 23 Apr 2013 15:26:55 +0200
Message-ID: <1l1scng.k9ly7ci7gjd2M%lists@haller-berlin.de>
References: <5165B758.4070308@bee.kz>
Cc: paulus@samba.org
To: tair.sabirgaliev@bee.kz (Tair Sabirgaliev), git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 15:37:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUdPG-000312-LA
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 15:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346Ab3DWNhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 09:37:07 -0400
Received: from server90.greatnet.de ([83.133.96.186]:40828 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756176Ab3DWNhG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 09:37:06 -0400
X-Greylist: delayed 611 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Apr 2013 09:37:06 EDT
Received: from [192.168.0.42] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id C00082C40B4;
	Tue, 23 Apr 2013 15:26:53 +0200 (CEST)
In-Reply-To: <5165B758.4070308@bee.kz>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.8.3 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222156>

Tair Sabirgaliev <tair.sabirgaliev@bee.kz> wrote:

> On OSX Tcl/Tk application windows are created behind all
> the applications down the stack of windows. This is very
> annoying, because once a gitk window appears, it's the
> downmost window and switching to it is pain.
> 
> The patch is trivial: if we are on OSX, emulate Cmd-Shift-TAB
> key event, so that the gitk application window is brought
> from bottom to top.
> 
> Signed-off-by: Tair Sabirgaliev <tair.sabirgaliev@gmail.com>
> ---
>
>   +# On OSX workaround the Tcl/Tk windows going down the stack of Cmd-TAB
> +if {[tk windowingsystem] eq "aqua"} {
> +    exec osascript -e {
> +        tell application "System Events"
> +            key down command
> +            key down shift
> +            keystroke tab
> +            key up shift
> +            key up command
> +        end tell    +    }
> +}
> +

First of all, I absolutely want this behaviour.  Bringing windows up in
the background is one of the biggest usability problems of git on Mac.

However, I don't think that synthesizing the keystrokes for
Command-Shift-Tab is a good solution. It would be better to explicitly
bring our process to the front.  One way to achieve this would be:

if {[tk windowingsystem] eq "aqua"} {
    exec osascript -e [format {
    tell application "System Events"
        set frontmost of processes whose unix id is %d to true
    end tell
    } [pid] ]
}

(Not sure about the formatting, I don't speak Tcl...)

Also, we need the same thing in git gui as well.

Best,
   Stefan


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
