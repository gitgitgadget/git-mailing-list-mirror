From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-am: fix maildir support regression: accept email
 file as patch
Date: Wed, 15 Jul 2009 16:56:30 -0700
Message-ID: <7vfxcxcxg1.fsf@alter.siamese.dyndns.org>
References: <1654b578a7e045b564c46df4abb6e2196422c2b2.1247696294.git.nicolas.s.dev@gmx.fr> <7v1voheevy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Jul 16 01:56:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MREL6-0005xB-Rk
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 01:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756522AbZGOX4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 19:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756516AbZGOX4g
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 19:56:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756439AbZGOX4g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 19:56:36 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A5BFD49BE;
	Wed, 15 Jul 2009 19:56:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D43AE49BD; Wed,
 15 Jul 2009 19:56:31 -0400 (EDT)
In-Reply-To: <7v1voheevy.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 15 Jul 2009 15\:54\:25 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 211656EE-719B-11DE-8651-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123344>

Junio C Hamano <gitster@pobox.com> writes:

> Please describe what that new something is.
>...
> Running three independent printf piped to two processes in a loop is
> quite silly.
> ...

That is, something like this.

-- >8 --
Subject: mailinfo: allow individual e-mail files as input

We traditionally allowed a mbox file or a directory name of a maildir (but
never an individual file inside a maildir) to be given to "git am".  Even
though an individual file in a maildir (or more generally, a piece of
RFC2822 e-mail) is not a mbox file, it contains enough information to
create a commit out of it, so there is no reason to reject one.  Running
mailsplit on such a file feels stupid, but it does not hurt.

This builds on top of a5a6755 (git-am foreign patch support: introduce
patch_format, 2009-05-27) that introduced mailbox format detection.  The
codepath to deal with a mbox requires it to begin with "From " line and
also allows it to begin with "From: ", but a random piece of e-mail can
and often do begin with any valid RFC2822 header lines.

Instead of checking the first line, we extract all the lines up to the
first empty line, and make sure they look like e-mail headers.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index d64d997..617ca2f 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -191,6 +191,20 @@ check_patch_format () {
 			esac
 			;;
 		esac
+		if test -z "$patch_format" &&
+			test -n "$l1" &&
+			test -n "$l2" &&
+			test -n "$l3"
+		then
+			# This begins with three non-empty lines.  Is this a
+			# piece of e-mail a-la RFC2822?  Grab all the headers,
+			# discarding the indented remainder of folded lines,
+			# and see if it looks like that they all begin with the
+			# header field names...
+			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p "$1" |
+			grep -v -E -e '^[A-Za-z]+(-[A-Za-z]+)*:' >/dev/null ||
+			patch_format=mbox
+		fi
 	} < "$1" || clean_abort
 }
 
