From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Detect if kdiff3 supports '--' and do not supply it
 if not supported
Date: Thu, 12 Jun 2008 22:36:35 -0700
Message-ID: <7vlk19yjz0.fsf@gitster.siamese.dyndns.org>
References: <1213311817-4673-1-git-send-email-patrick.higgins@cexp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tytso@mit.edu
To: Patrick Higgins <patrick.higgins@cexp.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 07:37:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K71yl-0002bF-OH
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 07:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbYFMFgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 01:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbYFMFgp
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 01:36:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbYFMFgo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 01:36:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 73F8F24CA;
	Fri, 13 Jun 2008 01:36:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7A78724C9; Fri, 13 Jun 2008 01:36:37 -0400 (EDT)
In-Reply-To: <1213311817-4673-1-git-send-email-patrick.higgins@cexp.com>
 (Patrick Higgins's message of "Thu, 12 Jun 2008 17:03:37 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B41398C8-390A-11DD-942B-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84833>

Patrick Higgins <patrick.higgins@cexp.com> writes:

> kdiff3 can be compiled with Qt only or with KDE support. If compiled with
> Qt only, it does not support '--' and mergetool fails silently.
>
> Signed-off-by: Patrick Higgins <patrick.higgins@cexp.com>
> ---
>  git-mergetool.sh |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index fcdec4a..85ce004 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -181,12 +181,19 @@ merge_file () {
>  
>      case "$merge_tool" in
>  	kdiff3)
> +	    "$merge_tool_path" --auto -o /dev/null -- /dev/null /dev/null
> +	    if test $? -ne 0; then
> +		double_dash=""
> +	    else
> +		double_dash="--"
> +	    fi
> +
>  	    if base_present ; then
>  		("$merge_tool_path" --auto --L1 "$MERGED (Base)" --L2 "$MERGED (Local)" --L3 "$MERGED (Remote)" \
> -		    -o "$MERGED" -- "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
> +		    -o "$MERGED" $double_dash "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
>  	    else
>  		("$merge_tool_path" --auto --L1 "$MERGED (Local)" --L2 "$MERGED (Remote)" \
> -		    -o "$MERGED" -- "$LOCAL" "$REMOTE" > /dev/null 2>&1)
> +		    -o "$MERGED" $double_dash "$LOCAL" "$REMOTE" > /dev/null 2>&1)
>  	    fi
>  	    status=$?
>  	    ;;

Now, when the name of the merged file begins with a dash (or dash-dash),
what does kdiff3 without KDE do?

I am wondering if it would be simpler and more robust if we did something
like this, which would let us get rid of double-dash from many places...

 git-mergetool.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index fcdec4a..3d9833e 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -141,10 +141,10 @@ merge_file () {
     fi
 
     ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
-    BACKUP="$MERGED.BACKUP.$ext"
-    LOCAL="$MERGED.LOCAL.$ext"
-    REMOTE="$MERGED.REMOTE.$ext"
-    BASE="$MERGED.BASE.$ext"
+    BACKUP="./$MERGED.BACKUP.$ext"
+    LOCAL="./$MERGED.LOCAL.$ext"
+    REMOTE="./$MERGED.REMOTE.$ext"
+    BASE="./$MERGED.BASE.$ext"
 
     mv -- "$MERGED" "$BACKUP"
     cp -- "$BACKUP" "$MERGED"
