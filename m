From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-mergetool: Make default smarter by considering user's desktop environment and editor
Date: Wed, 06 Jun 2007 01:08:03 -0700
Message-ID: <7vabvd7bfg.fsf@assigned-by-dhcp.cox.net>
References: <466637E2.5040303@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 10:08:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvqYv-0005u3-Jh
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 10:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbXFFIIH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 04:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752494AbXFFIIH
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 04:08:07 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:36492 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbXFFIIF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 04:08:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606080803.RPJV9600.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 04:08:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 88831X00K1kojtg0000000; Wed, 06 Jun 2007 04:08:04 -0400
In-Reply-To: <466637E2.5040303@freedesktop.org> (Josh Triplett's message of
	"Tue, 05 Jun 2007 21:28:18 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49260>

Josh Triplett <josh@freedesktop.org> writes:

> Make git-mergetool prefer meld under GNOME, and kdiff3 under KDE.  When
> considering emerge and vimdiff, check $VISUAL and $EDITOR to see which the
> user might prefer.
>
> Signed-off-by: Josh Triplett <josh@freedesktop.org>

The basic idea is sound.  However...

 (1) I wonder if we can get rid of the horribly long if .. elif
     chain by using shell function and then iterate a list of them;

 (2) echo "${VISUAL-$EDITOR}" | grep '^emacs'???

     Some people may have explicit path (/home/me/bin/emacs),
     and/or runs a variant of emacs called 'xemacs'.  Same for
     vim.

Something like...

        test_xstuff () {
                test -n "$DISPLAY" && type "$1" >/dev/null 2>&1
        test_kdiff3 () {
                test_xstuff kdiff3
        }
        test_tkdiff () {
                test_xstuff tkdiff
        }
        test_estuff() {
                type "$1" >/dev/null 2>&1 &&
                case "${VISUAL-$EDITOR}" in *"$1"*) : ;; *) false ;; esac
        }
        test_emerge () {
                test_estuff emacs
        }
        test_vimdiff () {
                test_estuff vim
        }

        choose_merge_tool () {
                for t in "$@"
                do
                        if test_$t
                        then
                                echo "$t"
                                break
                        fi
                done
        }

        if test -z "$merge_tool"
        then
                merge_tool_candidates='kdiff3 tkdiff xxdiff meld opendiff ...'
                if test -n "$GNOME_DESCTOP_SESSION_ID"
                then
                        merge_tool_candidates="meld $merge_tool_candidates"
                elif test -n "$KDE_FULL_SESSION"
                then
                        merge_tool_candidates="kdiff3 $merge_tool_candidates"
                elif
                        ...
                fi
                merge_tool=$(choose_merge_tool $merge_tool_candidates)
        fi
