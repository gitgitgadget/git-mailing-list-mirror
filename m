From: Martin Mares <mj@ucw.cz>
Subject: git-cvs-import retries
Date: Fri, 17 Feb 2006 20:38:05 +0100
Message-ID: <mj+md-20060217.193146.10308.albireo@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Feb 17 20:38:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FABR3-0004V5-It
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 20:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWBQTiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 14:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWBQTiE
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 14:38:04 -0500
Received: from albireo.ucw.cz ([84.242.65.108]:17803 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1751409AbWBQTiD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2006 14:38:03 -0500
Received: by albireo.ucw.cz (Postfix, from userid 1000)
	id 4DA80110090; Fri, 17 Feb 2006 20:38:05 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16362>

Hello!

I am trying git-cvsimport on a rather huge repository and the CVS server
sometimes drops the connection and the whole importing aborts, although
it contains some retrying logic. I've noticed that in the connection closes
I experience, $res ends up being empty instead of undefined. This is tested
by the `server went again' check, but not by the retry check a couple of
lines before.

This patch extends the retry check and makes the symptoms go away.
However, take it with a grain of salt as I don't understand yet why the
connection is aborted.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A jury consists of 12 persons chosen to decide who has the better lawyer.


Signed-Off-By: Martin Mares <mj@ucw.cz>

--- old/git-cvsimport	2006-02-17 13:02:24.000000000 +0100
+++ new/git-cvsimport	2006-02-17 18:13:06.000000000 +0100
@@ -371,7 +371,7 @@
 
 	$self->_file($fn,$rev) and $res = $self->_line($fh);
 
-	if (!defined $res) {
+	if (!defined $res || $res eq '') {
 	    # retry
 	    $self->conn();
 	    $self->_file($fn,$rev)
