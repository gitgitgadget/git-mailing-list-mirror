From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] request-pull with diff body itself
Date: Mon, 27 Jul 2009 14:27:47 -0700
Message-ID: <7vtz0xerzg.fsf@alter.siamese.dyndns.org>
References: <20090727195357.GE17942@lenovo>
 <7vws5tg8fw.fsf@alter.siamese.dyndns.org>
 <aa79d98a0907271356l51111uac0884cf148f434f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Cyrill Gorcunov <gorcunov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 23:28:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVXjn-00017O-BI
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 23:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003AbZG0V1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 17:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754645AbZG0V1y
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 17:27:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42781 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979AbZG0V1x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 17:27:53 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8B67A134C2;
	Mon, 27 Jul 2009 17:27:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 572CB134BF; Mon, 27 Jul 2009
 17:27:48 -0400 (EDT)
In-Reply-To: <aa79d98a0907271356l51111uac0884cf148f434f@mail.gmail.com>
 (Cyrill Gorcunov's message of "Tue\, 28 Jul 2009 00\:56\:10 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5772046A-7AF4-11DE-9C31-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124198>

Cyrill Gorcunov <gorcunov@gmail.com> writes:

> Will post an updated patch in a day or so ( as only get back my laptop
> back). Or maybe someone could make it faster then me ;)

Like this, perhaps.

 git-request-pull.sh |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 5917773..5c1121c 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -8,13 +8,33 @@ USAGE='<start> <url> [<end>]'
 LONG_USAGE='Summarizes the changes between two commits to the standard output,
 and includes the given URL in the generated summary.'
 SUBDIRECTORY_OK='Yes'
-OPTIONS_SPEC=
+OPTIONS_SPEC='git request-pull [options] start url [end]
+--
+p    show patch text as well
+'
+
 . git-sh-setup
 . git-parse-remote
 
 GIT_PAGER=
 export GIT_PAGER
 
+patch=
+while	case "$#" in 0) break ;; esac
+do
+	case "$1" in
+	-p)
+		patch=-p ;;
+	--)
+		shift; break ;;
+	-*)
+		usage ;;
+	*)
+		break ;;
+	esac
+	shift
+done
+
 base=$1
 url=$2
 head=${3-HEAD}
@@ -54,5 +74,5 @@ echo "  $url $branch"
 echo
 
 git shortlog ^$baserev $headrev
-git diff -M --stat --summary $merge_base $headrev
+git diff -M --stat --summary $patch $merge_base..$headrev
 exit $status
