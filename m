From: Martin Mares <mj@ucw.cz>
Subject: [PATCH] Fix retries in git-cvsimport
Date: Sat, 18 Feb 2006 21:44:20 +0100
Message-ID: <mj+md-20060218.203658.16817.albireo@ucw.cz>
References: <mj+md-20060217.193146.10308.albireo@ucw.cz> <7v1wy1t9cb.fsf@assigned-by-dhcp.cox.net> <mj+md-20060218.130645.5680.albireo@ucw.cz> <7vvevco6e3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 21:44:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAYwi-0002sr-Us
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 21:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWBRUoU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 15:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWBRUoU
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 15:44:20 -0500
Received: from albireo.ucw.cz ([84.242.65.108]:8836 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S932146AbWBRUoT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Feb 2006 15:44:19 -0500
Received: by albireo.ucw.cz (Postfix, from userid 1000)
	id CD84F110090; Sat, 18 Feb 2006 21:44:20 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvevco6e3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16421>

Fixed a couple of bugs in recovering from broken connections:

The _line() method now returns undef correctly when the connection
is broken instead of falling off the function and returning garbage.

Retries are now reported to stderr and the eventual partially
downloaded file is discarded instead of being appended to.

The "Server gone away" test has been removed, because it was
reachable only if the garbage return bug bit.

Signed-Off-By: Martin Mares <mj@ucw.cz>

--- old/git-cvsimport	2006-02-17 13:02:24.000000000 +0100
+++ new/git-cvsimport	2006-02-18 14:16:33.000000000 +0100
@@ -361,6 +361,7 @@
 			}
 		}
 	}
+	return undef;
 }
 sub file {
 	my($self,$fn,$rev) = @_;
@@ -372,19 +373,15 @@
 	$self->_file($fn,$rev) and $res = $self->_line($fh);
 
 	if (!defined $res) {
-	    # retry
+	    print STDERR "Server has gone away while fetching $fn $rev, retrying...\n";
+	    truncate $fh, 0;
 	    $self->conn();
-	    $self->_file($fn,$rev)
-		    or die "No file command send\n";
+	    $self->_file($fn,$rev) or die "No file command send";
 	    $res = $self->_line($fh);
-	    die "No input: $fn $rev\n" unless defined $res;
+	    die "Retry failed" unless defined $res;
 	}
 	close ($fh);
 
-	if ($res eq '') {
-	    die "Looks like the server has gone away while fetching $fn $rev -- exiting!";
-	}
-
 	return ($name, $res);
 }
 
