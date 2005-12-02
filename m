From: Junio C Hamano <junkio@cox.net>
Subject: Re: resolve (merge) problems
Date: Thu, 01 Dec 2005 16:58:01 -0800
Message-ID: <7vhd9sb9ie.fsf@assigned-by-dhcp.cox.net>
References: <20051202000715.8100.qmail@web31810.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 02:00:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhzFl-0003yr-Vp
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 01:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbVLBA6F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 19:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbVLBA6F
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 19:58:05 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:52950 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932589AbVLBA6D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 19:58:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051202005639.LBSH17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Dec 2005 19:56:39 -0500
To: ltuikov@yahoo.com
In-Reply-To: <20051202000715.8100.qmail@web31810.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Thu, 1 Dec 2005 16:07:15 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13093>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- Junio C Hamano <junkio@cox.net> wrote:
>> Easier to read is:
>> 
>> 	$ git-diff-files --name-status
>
> Ok this is what it shows:
>
> $git-diff-files --name-status
> U       arch/arm/configs/poodle_defconfig
> D       arch/arm/configs/poodle_defconfig
> U       drivers/atm/atmdev_init.c
> D       drivers/atm/atmdev_init.c
>
> Unmerged and deleted?  Is this correct?

Yes, the first lets you notice it is unmerged, and the second
says the file does not remain in the working tree.

However, there is a bug recently introduced in the
merge-one-file script.  

Although the conflict resolution procedure I described applies
if you really had a real conflicting merge, I suspect your merge
should not have failed in the first place.

        case "${1:-.}${2:-.}${3:-.}" in
        #
        # Deleted in both or deleted in one and unchanged in the other
        #
        "$1.." | "$1.$1" | "$1$1.")
                if [ "$2" ]; then
                        echo "Removing $4"
                fi
                if test -f "$4"; then
                        rm -f -- "$4" &&
                        rmdir -p "$(expr "$4" : '\(.*\)/')" 2>/dev/null
                fi &&
                        exec git-update-index --remove -- "$4"
                ;;

The faliure code from "rmdir -p" leaks up and makes
git-update-index to be skipped.  Here is a fix.

-- >8 --
[PATCH] merge-one-file fix

9ae2172aed289f2706a0e88288909fa47eddd7e7 used "rmdir -p"
carelessly, causing the "git-update-index --remove" to be
skipped.

---
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 739a072..9a049f4 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -26,7 +26,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 	fi
 	if test -f "$4"; then
 		rm -f -- "$4" &&
-		rmdir -p "$(expr "$4" : '\(.*\)/')" 2>/dev/null
+		rmdir -p "$(expr "$4" : '\(.*\)/')" 2>/dev/null || :
 	fi &&
 		exec git-update-index --remove -- "$4"
 	;;
