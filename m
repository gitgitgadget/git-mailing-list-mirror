From: Indigo Frankencastle <swediomurital@gmail.com>
Subject: Minor gitk bug - update on empty project : can't read
 "viewmainheadid_orig(1)": no such variable
Date: Wed, 23 Jan 2013 15:00:02 +0100
Message-ID: <CAHioFH-Nf=J0pkyx+684o3bv-DKOitb_-co9zG+A_WYh8mT9LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 15:00:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty0sS-0004bS-0S
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 15:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408Ab3AWOAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 09:00:06 -0500
Received: from mail-oa0-f53.google.com ([209.85.219.53]:49836 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755122Ab3AWOAF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 09:00:05 -0500
Received: by mail-oa0-f53.google.com with SMTP id l20so559842oag.40
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 06:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=TmVbUIyzNoXY+VnflocADdFwQGM1YzUTdCdVcNfnoQ4=;
        b=VeAdITrBcQ1T2NyGDKgeyVv0v/nUbwOut7IPMStIICq9I+4tT0t04iV2tCZsSpNiOm
         RYeftexZezzZeJL6nOBfEqJtT61WBXhW/qBwIqk6vZURde3JFjzFOWO/8MwMvmc+8CNj
         zNd0omPHCoaCEVrQPEmbxd1zyeSCcKW5RAv57ygj0KZWwbe/s+MeEmmdPmrAtqiLOKMz
         3zWc0lKnf72fsJzqu0QyKQsXrsTJWVqRz4bCgIP2xRVuc+xxVNPOHp3ETZF9cGPlpA++
         OZuLXoVEigS7zFIQRgqH7Xxpei8llTASr8uSYLGco16IefheNQ0HuiL3czysvAYDkWUe
         W/Tg==
X-Received: by 10.182.92.70 with SMTP id ck6mr1045523obb.46.1358949602474;
 Wed, 23 Jan 2013 06:00:02 -0800 (PST)
Received: by 10.76.112.173 with HTTP; Wed, 23 Jan 2013 06:00:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214320>

One of these "weird usage causes weird bugs".

One way to reproduce:

mkdir foo
cd foo
git init
git commit -am "Initial"
gitk &
# or
gitk --all &
<F5>

Resulting in (gitk-git/gitk line 503 - 512):

can't read "viewmainheadid_orig(1)": no such variable
can't read "viewmainheadid_orig(1)": no such variable
    while executing
"if {$mainheadid ne $viewmainheadid_orig($view)} {
	if {$showlocalchanges} {
	    dohidelocalchanges
	}
	set viewmainheadid($view) $mainheadid
	set vie..."
    (procedure "updatecommits" line 13)
    invoked from within
"updatecommits"
    (command bound to event)

As "$mainheadid" is not set, should there be something in the
direction of this perhaps?

    ...
Subject: [PATCH] gitk catch missing head id on update

---
 gitk-git/gitk |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index d93bd99..fa869d7 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -499,6 +499,11 @@ proc updatecommits {} {

     set hasworktree [hasworktree]
     rereadrefs
+    if {$mainheadid eq ""} {
+	# error_popup "[mc "Error updating commits:"] No main HEAD id"
+	show_status [mc "No main HEAD id"]
+	return {}
+    }
     set view $curview
     if {$mainheadid ne $viewmainheadid_orig($view)} {
 	if {$showlocalchanges} {
-- 
1.7.10.4

    ...
Or perhaps some logic in:
proc rereadrefs {}

----
Best regards,
IF
