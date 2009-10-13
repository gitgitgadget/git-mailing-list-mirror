From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] gitk: Prevent garbage text at the end of the tag description
Date: Tue, 13 Oct 2009 09:34:28 +0200
Message-ID: <4AD42D84.2030406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 09:38:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxbwA-00016f-8b
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 09:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757990AbZJMHfK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Oct 2009 03:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756675AbZJMHfK
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 03:35:10 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:47891 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756573AbZJMHfI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 03:35:08 -0400
Received: by ewy4 with SMTP id 4so3109516ewy.37
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 00:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=xAOi45pPKn8+8YDQn0axm4k9w/w6POUbe7Tm/k1y5pw=;
        b=IH/2/suM9gG/fy08Mw0fqHt1Vz9sYKqpVAd/sf5SQ+0nxxizbIfJDc2FkRIwqXbVVY
         CMzsxtvpN6o0t7fF/mxe3T1xvDv932Vsjo8AF1cavUiibSkXVUPR2tuBI6yfu817FoLD
         VQgoOIimvZHzYMRauB5WNjpXyZYhnrmhgb5Tg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=JQU91J7zApwhT3LDAB86B3evIw8aBFUg/U9BDDRMAW5QZw8GcrWaUWIAg3XzdL98Ap
         zaHyIhBcaySWSMlqAKEJdwvkENGGMIQz/ZQkOC2dnWyfzRkXMKkLlWpbUXeHOMyJYPQa
         fKivk4MjPAx5Repad1gBRJHPh6OLQ/Iw9hC7s=
Received: by 10.211.154.18 with SMTP id g18mr3235025ebo.70.1255419271150;
        Tue, 13 Oct 2009 00:34:31 -0700 (PDT)
Received: from bitis.local (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 10sm2409974eyz.12.2009.10.13.00.34.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Oct 2009 00:34:29 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130138>

When first clicking on a commit with a huge diff (in 1000 files
or more), and then clicking on a tag, garbage text could appear
after the tag description.

The problem is that commits are shown incrementally using a
run queue (implemented by the runq() and filerun() procedures).
When the user requests a tag to be shown, there may still be
jobs in the run queue updating the previous commit.

Solve this problem by implementing a new procedure
empty_run_queue() that will empty the run queue and cancel all
outstanding file events. Call it from showtag().

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---

This is more an annoyance than a real bug, but I was quite
surprised the first time I saw it happen and at first searched
for a bug in my own scripts that had created the tags.

This patch is a suggested correction.

Here is an example of a repository where the problem can be
reproduced quite easily:

git://github.com/mfoemmel/erlang-otp.git

 gitk-git/gitk |   34 ++++++++++++++++++++++++++++++++--
 1 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index a0214b7..ee0d0c3 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -34,12 +34,16 @@ proc run args {
 }
=20
 proc filerun {fd script} {
+    global pending_file_events
+
+    set pending_file_events($fd) $fd
     fileevent $fd readable [list filereadable $fd $script]
 }
=20
 proc filereadable {fd script} {
-    global runq currunq
+    global runq currunq pending_file_events
=20
+    unset pending_file_events($fd)
     fileevent $fd readable {}
     if {$runq eq {} && ![info exists currunq]} {
 	after idle dorunq
@@ -60,7 +64,7 @@ proc nukefile {fd} {
 }
=20
 proc dorunq {} {
-    global isonrunq runq currunq
+    global isonrunq runq currunq pending_file_events
=20
     set tstart [clock clicks -milliseconds]
     set t0 $tstart
@@ -79,6 +83,7 @@ proc dorunq {} {
 		# file readers return 2 if they could do more straight away
 		lappend runq [list $fd $script]
 	    } else {
+		set pending_file_events($fd) $fd
 		fileevent $fd readable [list filereadable $fd $script]
 	    }
 	} elseif {$fd eq {}} {
@@ -92,6 +97,29 @@ proc dorunq {} {
     }
 }
=20
+# Empty the run queue, cancel all outstanding file events,
+# and close all files associated with file events.
+proc empty_run_queue {} {
+    global isonrunq runq pending_file_events
+
+    foreach entry $runq {
+	set fd [lindex $entry 0]
+	set script [lindex $entry 1]
+	if {$fd eq {}} {
+	    unset isonrunq($script)
+	} else {
+	    catch {close $fd}
+	}
+    }
+    set runq {}
+
+    foreach fd [array names pending_file_events] {
+	fileevent $fd readable {}
+	unset pending_file_events($fd)
+	catch {close $fd}
+    }
+}
+
 proc reg_instance {fd} {
     global commfd leftover loginstance
=20
@@ -10261,6 +10289,8 @@ proc listrefs {id} {
 proc showtag {tag isnew} {
     global ctext tagcontents tagids linknum tagobjid
=20
+    empty_run_queue
+
     if {$isnew} {
 	addtohistory [list showtag $tag 0]
     }
--=20
1.6.5.2.gd6127
