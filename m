From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 19/24] merge script: handle -m --log correctly
Date: Tue, 17 Aug 2010 02:06:56 -0500
Message-ID: <20100817070656.GS22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 09:08:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGHn-0001gn-US
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756501Ab0HQHIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 03:08:35 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45359 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756327Ab0HQHIe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 03:08:34 -0400
Received: by gyg10 with SMTP id 10so2251679gyg.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uEgzxToQa7qR1l7ryQ9Eg/bEfYK+kKfLeG9CSawVNTA=;
        b=PIy5c6FzgOp2F3+dZ2sM5khsbnRDmOt4a5Yh8AahHJo7xv8EFxPW+btq76ppsd6RsY
         OMyeBrNPjpD+UaE2tEuVzPZCSwQvsKIunTEfaRJ82noeoIdAhc8/JII/CtEUl8QJw39n
         npihpv9jPAFNO89o5/5v8HaTmNH3Uh81okZlw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XzdBKI1BumEnsvwDxw6ShG0Gwj0CjUyKmVFqOyptdBkCksTNCpa8rpL+g9jz0ek96q
         AxWzg1NnZCYaZaFn3Sjq67bJvbmtt5qK6R5ySgzA80RkbDvEmFDetwCha2oecmyPfqJl
         2TkzKhkNzUeJyc3t5ARy9JljmUUI4btm4IcnE=
Received: by 10.101.204.37 with SMTP id g37mr7020097anq.253.1282028911452;
        Tue, 17 Aug 2010 00:08:31 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t24sm11762304ano.32.2010.08.17.00.08.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 00:08:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153722>

Based on v1.7.1.1~23^2 (merge: --log appends shortlog to message if
specified, 2010-05-11).  Without this change, the scripted
(non-builtin) merge does not pass t7604.

Cc: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/examples/git-merge.sh |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index bab3da9..91e33a3 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -294,12 +294,18 @@ else
 	# the given message.  If remote is invalid we will die
 	# later in the common codepath so we discard the error
 	# in this loop.
-	merge_name=$(for remote
+	merge_msg="$(
+		for remote
 		do
 			merge_name "$remote"
-		done | git fmt-merge-msg $log_arg
-	)
-	merge_msg="${merge_msg:+$merge_msg$LF$LF}$merge_name"
+		done |
+		if test "$have_message" = t
+		then
+			git fmt-merge-msg -m "$merge_msg" $log_arg
+		else
+			git fmt-merge-msg $log_arg
+		fi
+	)"
 fi
 head=$(git rev-parse --verify "$head_arg"^0) || usage
 
-- 
1.7.2.1.544.ga752d.dirty
