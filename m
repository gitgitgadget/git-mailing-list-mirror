From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] gitk: Fix nextfile() and add prevfile()
Date: Wed, 27 Sep 2006 12:32:19 +0900
Message-ID: <87fyeernlo.fsf@duaron.myhome.or.jp>
References: <873bag12k3.fsf@duaron.myhome.or.jp>
	<7vpsdjryj2.fsf@assigned-by-dhcp.cox.net>
	<873bae3b5x.fsf_-_@duaron.myhome.or.jp>
	<17689.49841.913304.878599@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Sep 27 05:35:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSQCq-0006fM-FW
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 05:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWI0Dfa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 23:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWI0Dfa
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 23:35:30 -0400
Received: from mail.parknet.jp ([210.171.160.80]:15108 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932356AbWI0Df3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 23:35:29 -0400
X-AuthUser: hirofumi@parknet.jp
Received: from ibmpc.myhome.or.jp ([210.171.168.39]:1897)
	by parknet.jp with [XMail 1.21 ESMTP Server]
	id <SACE1> for <git@vger.kernel.org> from <hirofumi@mail.parknet.co.jp>;
	Wed, 27 Sep 2006 12:34:38 +0900
Received: from duaron.myhome.or.jp (duaron.myhome.or.jp [192.168.0.2])
	by ibmpc.myhome.or.jp (8.13.8/8.13.8/Debian-2) with ESMTP id k8R3XNR5023627
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 27 Sep 2006 12:33:25 +0900
Received: from duaron.myhome.or.jp (localhost [127.0.0.1])
	by duaron.myhome.or.jp (8.13.8/8.13.8/Debian-2) with ESMTP id k8R3XN43012798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 27 Sep 2006 12:33:23 +0900
Received: (from hirofumi@localhost)
	by duaron.myhome.or.jp (8.13.8/8.13.8/Submit) id k8R3WJGS012794;
	Wed, 27 Sep 2006 12:32:19 +0900
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17689.49841.913304.878599@cargo.ozlabs.ibm.com> (Paul Mackerras's message of "Wed\, 27 Sep 2006 10\:15\:45 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27866>

Paul Mackerras <paulus@samba.org> writes:

> OGAWA Hirofumi writes:
>
>> The current nextfile() jumps to last hunk, but I think this is not
>> intention, probably, it's forgetting to add "break;". And this
>> patch also adds prevfile(), it jumps to previous hunk.
>
> I think your prevfile isn't quite right - I don't think it will do the
> right thing if $loc is past the last entry in $difffilestart.  Don't
> you want the "$ctext yview $prev" after the loop?
>
> Paul.

Sure, it's obviously useful in the case of big hunk. Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


The current nextfile() jumps to last hunk, but I think this is not
intention, probably, it's forgetting to add "break;". And this
patch also adds prevfile(), it jumps to previous hunk.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 gitk |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff -puN gitk~gitk-nextfile-fix gitk
--- git/gitk~gitk-nextfile-fix	2006-09-27 12:14:07.000000000 +0900
+++ git-hirofumi/gitk	2006-09-27 12:16:23.000000000 +0900
@@ -4440,12 +4440,27 @@ proc getblobdiffline {bdf ids} {
     }
 }
 
+proc prevfile {} {
+    global difffilestart ctext
+    set prev [lindex $difffilestart 0]
+    set here [$ctext index @0,0]
+    foreach loc $difffilestart {
+	if {[$ctext compare $loc >= $here]} {
+	    $ctext yview $prev
+	    return
+	}
+	set prev $loc
+    }
+    $ctext yview $prev
+}
+
 proc nextfile {} {
     global difffilestart ctext
     set here [$ctext index @0,0]
     foreach loc $difffilestart {
 	if {[$ctext compare $loc > $here]} {
 	    $ctext yview $loc
+	    return
 	}
     }
 }
_
