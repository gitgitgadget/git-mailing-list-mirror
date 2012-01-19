From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] am: learn passing -b to mailinfo
Date: Thu, 19 Jan 2012 13:26:48 -0800
Message-ID: <7vd3afidt3.fsf@alter.siamese.dyndns.org>
References: <8762ghxpxw.fsf@thomas.inf.ethz.ch>
 <a804650f805fd8c89a843302cb92bbbdf36b8c0b.1326710194.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 19 22:27:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnzVb-0006Lt-7G
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 22:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234Ab2ASV0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 16:26:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42885 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993Ab2ASV0u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 16:26:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35CCA5EE9;
	Thu, 19 Jan 2012 16:26:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=t8C2rObG0KcwxBm/gTZ5quqbbhg=; b=f80UuJlBIvzPnjC9RFE4
	yIZVmBtJfMTjuKZv8VbgVdRpaevG2oirnOYX09ynaz5kd7LNRxYFXtB5CYAFKAf6
	XsMjzI7H/1HnEosAcGlw2UxJi7XaEBps3byb/9X9ksDaGHqdWMMAHWCA2l4Iuuhe
	8CibfpUuu86Pr27hiZwRs9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=hXkObGt86FY+SOK8ItguP+E+VH0s0iWc0u5qwNFS1GsTu1
	Eqp5a/2sryoP0ibNRakQzZBouqGx+auZEN1DfT8sCFZKb5q8fWG5mbgXaTB9IwQe
	TOsvDpGVB9VxgaptbEXfMEVKAaj3Rv/KxzChH0alTMCjM+vdjJbrS+DpDQz6w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D64A5EE8;
	Thu, 19 Jan 2012 16:26:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 997D95EE7; Thu, 19 Jan 2012
 16:26:49 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4C35BE88-42E4-11E1-A8BC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188838>

Thomas Rast <trast@student.ethz.ch> writes:

> git-am could pass -k to mailinfo, but not -b.  Introduce an option
> that does so.  We change the meaning of the 'keep' state file, but are
> careful not to cause a problem unless you downgrade in the middle of
> an 'am' run.
>
> This uncovers a bug in mailinfo -b, hence the failing test.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> This fixes the broken 'if', and the use of 'echo' with an argument
> that starts with '-'.

After re-reading the code that parses the command line options given to
"am" and the previous invocation state we read from $dotest/*, however, I
think the way this change uses $keep makes things somewhat inconsistent
and harder to follow.

Currently the variables are given abstract meaning (e.g. "are we told to
record to utf8? yes or no") when we parse our command line options and
read from the previous invocation state, and then based on that abstract
meaning, a later code decides what exact option we throw at the git
commands we invoke (e.g. "utf8=t" -> "-u").

How about doing something like this instead at least for now?  It might be
better to decide when we parse our options and $dotest/* immediately what
options we give to the git commands we run (which your patch does but only
to $keep option), but that kind of change (1) belongs to a separate topic
and should be done consistently to all options, and (2) I am not convinced
if it is necessarily a good change.

Thanks.

diff --git a/git-am.sh b/git-am.sh
index 6cdd591..8b755d9 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -15,6 +15,7 @@ q,quiet         be quiet
 s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
+keep-non-patch  pass -b flag to git-mailinfo
 keep-cr         pass --keep-cr flag to git-mailsplit for mbox format
 no-keep-cr      do not pass --keep-cr flag to git-mailsplit independent of am.keepcr
 c,scissors      strip everything before a scissors line
@@ -345,6 +346,8 @@ do
 		utf8= ;;
 	-k|--keep)
 		keep=t ;;
+	--keep-non-patch)
+		keep=b ;;
 	-c|--scissors)
 		scissors=t ;;
 	--no-scissors)
@@ -522,16 +525,25 @@ case "$resolved" in
 	fi
 esac
 
+# Now, decide what command line options we will give to the git
+# commands we invoke, based on the result of parsing command line
+# options and previous invocation state stored in $dotest/ files.
+
 if test "$(cat "$dotest/utf8")" = t
 then
 	utf8=-u
 else
 	utf8=-n
 fi
-if test "$(cat "$dotest/keep")" = t
-then
-	keep=-k
-fi
+keep=$(cat "$dotest/keep")
+case "$keep" in
+t)
+	keep=-k ;;
+b)
+	keep=-b ;;
+*)
+	keep= ;;
+esac
 case "$(cat "$dotest/keepcr")" in
 t)
 	keepcr=--keep-cr ;;
