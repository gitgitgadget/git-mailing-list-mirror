From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] more meaningful error message in gitk when git binary is
 not available
Date: Mon, 01 Oct 2012 10:11:05 -0700
Message-ID: <7va9w6dsnq.fsf@alter.siamese.dyndns.org>
References: <50694380.4090108@josefassad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josef Assad <josef@josefassad.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 19:21:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIjYR-0007Ig-9w
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 19:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913Ab2JARLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 13:11:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33331 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856Ab2JARLI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 13:11:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F4AD8D44;
	Mon,  1 Oct 2012 13:11:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M1DO3jzSP3UBOcWxAoad3VbzsyE=; b=TtM7Pp
	OBoAofMTQgV+BVvXG1qfDyvmRJv8EP6AUv3aqQ/lP21jNtVNTTxWlBYisdcxdhuX
	xXkqRKKnRnwd80wweIsg9WajndiHeIgeNGDgtnB/W22/vSaUO9VmN81nVpD+GflU
	e9LvGobi/RrKa2H+FEKntmU4XTcixl8dOdQag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dk0OhMgeqL/xFIolYxPAX9IDWsy6ID/F
	3G0PiepzY9UmTf/qsx/x5bUtzPLCdJwXVnUNnC6rrcPdgAivtz8PTqsxZaZsEwtH
	nCFeUoOPKq9kvMqocmV/DAuonSQQB+uOf1A3II79F7TTGRiu3ur5Py7AmJd8smpU
	f7A8GpcIDaM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C66E8D43;
	Mon,  1 Oct 2012 13:11:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D42058D41; Mon,  1 Oct 2012
 13:11:06 -0400 (EDT)
In-Reply-To: <50694380.4090108@josefassad.com> (Josef Assad's message of
 "Mon, 01 Oct 2012 09:17:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FCF5FE48-0BEA-11E2-A972-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206741>

Josef Assad <josef@josefassad.com> writes:

> Signed-off-by: Josef Assad <josef@josefassad.com>
> ---
>  gitk-git/gitk |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)

Thanks.

> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index d93bd99..7e2e0a7 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -11680,6 +11680,12 @@ setui $uicolor
>
>  setoptions
>
> +# check that the git executables are available for use
> +if [catch {set gitexists [exec which git]}] {
> +    show_error {} . [mc "Cannot find a suitable git executable."]
> +    exit 1
> +}
> +
>  # check that we can find a .git directory somewhere...
>  if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
>      show_error {} . [mc "Cannot find a git repository here."]

It is somewhat a stupid solution to add an extra fork that will only
waste cycles in the normal non-error case, especially when we
already have an error codepath that acts on lack of the "git"
command anyway, isn't it?

The "rev-parse" you see in the post-context will fail when we are
not in a git repository, but it will also fail when we do not have
git.

You can add the new check to if {[catch {... git rev-parse }]} block;
before unconditionally saying "cannot find a git repo", you check if
"git" even exists, and give an appropriate error message.  That way,
you do not punish normal use case with an extra useless fork.

Something like this, I presume.


 gitk | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index d93bd99..60794a7 100755
--- a/gitk
+++ b/gitk
@@ -11682,7 +11682,12 @@ setoptions
 
 # check that we can find a .git directory somewhere...
 if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
-    show_error {} . [mc "Cannot find a git repository here."]
+    # we could have failed because there is no git to begin with
+    if {[catch {exec git version}]} {
+        show_error {} . [mc "You do not seem to have 'git' command."]
+    } else {
+        show_error {} . [mc "Cannot find a git repository here."]
+    }
     exit 1
 }
 
