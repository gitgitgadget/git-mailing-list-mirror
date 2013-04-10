From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 6/7] completion: get rid of __gitcomp_1
Date: Wed, 10 Apr 2013 01:57:56 -0500
Message-ID: <1365577077-12648-7-git-send-email-felipe.contreras@gmail.com>
References: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 08:59:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPp0B-0007kM-Gi
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 08:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847Ab3DJG7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 02:59:23 -0400
Received: from mail-qe0-f42.google.com ([209.85.128.42]:59902 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab3DJG7V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 02:59:21 -0400
Received: by mail-qe0-f42.google.com with SMTP id cz11so71538qeb.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 23:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=82QCgZWsdvZAyvPrwIH10kUahWil1oyFkGfNpzu8QAA=;
        b=VgNpHjAPYffwkMvJbcdSV5E7PU/JDKQ/wCeZXDDdQPCcy6Trm8d5j5VZ2j2aHw7A6o
         sgyBvGnWr9lm1+qj1je6qKePW83WP7nGCwCwtFOq938F+KZylSW54gG4YvW1QnUTDMnT
         r50QEmWYrEyyNHglufNgIRFZuV1Y5W7ydbrbG7kJspovIPqH1B+3dbcacPs7890JqmKx
         01UY0+Wz8YnKKG2dT4KuJdIg+x73/JnxX+gv4uQqaTcx57r7YgrarYUTMJVAhfqVLDh9
         kq9TOx7n2aYIx4ogXXmW5TFJQ46bknKqph3fcjyI/HpgyCiN0zTf3eE+WOeh4f0Nll9y
         iU7g==
X-Received: by 10.229.56.195 with SMTP id z3mr317169qcg.40.1365577160051;
        Tue, 09 Apr 2013 23:59:20 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id 10sm29107060qax.13.2013.04.09.23.59.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 23:59:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220669>

There's no point in calling a separate function that is only used in one
place. Specially considering that there's no need to call compgen, and
we traverse the words ourselves both in __gitcompadd, and __gitcomp_1.

So lets squash the functions together, and traverse only once.

This improves performance. For N number of words:

  == 1 ==
  original: 0.002s
  new: 0.000s
  == 10 ==
  original: 0.005s
  new: 0.001s
  == 100 ==
  original: 0.009s
  new: 0.006s
  == 1000 ==
  original: 0.027s
  new: 0.019s
  == 10000 ==
  original: 0.163s
  new: 0.151s
  == 100000 ==
  original: 1.555s
  new: 1.497s

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d8009f5..301de15 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -53,19 +53,6 @@ __gitdir ()
 	fi
 }
 
-__gitcomp_1 ()
-{
-	local c IFS=$' \t\n'
-	for c in $1; do
-		c="$c$2"
-		case $c in
-		--*=*|*.) ;;
-		*) c="$c " ;;
-		esac
-		printf '%s\n' "$c"
-	done
-}
-
 # The following function is based on code from:
 #
 #   bash_completion - programmable completion functions for bash 3.2+
@@ -220,8 +207,17 @@ __gitcomp ()
 	--*=)
 		;;
 	*)
-		local IFS=$'\n'
-		__gitcompadd "$(__gitcomp_1 "${1-}" "${4-}")" "${2-}" "$cur_" ""
+		local c i=0 IFS=$' \t\n'
+		for c in $1; do
+			c="$c${4-}"
+			case $c in
+			--*=*|*.) ;;
+			*) c="$c " ;;
+			esac
+			if [[ $c == "$cur_"* ]]; then
+				COMPREPLY[i++]="${2-}$c"
+			fi
+		done
 		;;
 	esac
 }
-- 
1.8.2.1
