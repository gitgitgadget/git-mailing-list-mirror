From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-cvsserver strips exec bit
Date: Tue, 10 Sep 2013 10:02:26 -0700
Message-ID: <xmqqa9jkzk2l.fsf@gitster.dls.corp.google.com>
References: <522F397E.6080709@cchtml.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Cronenworth <mike@cchtml.com>
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:02:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJRKo-0001lA-D3
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653Ab3IJRCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 13:02:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901Ab3IJRCd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:02:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F9E5404B4;
	Tue, 10 Sep 2013 17:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6jny51SV21sPNluWpvE5jXHk6tM=; b=pd72Lj
	L89LQ32TUDrlvFNcFoNuwUPgj37PB1yppmBVfDyK++jwrP9q1B3VHEMIV2gHQiD7
	bEwhBDK36jTywxl1WHf5RM4l6UI5yI2Vu842muvVWj6Z6DEb3aMpO571zkAxLnNp
	j5p1DzYoLFru3n+S0jxXhd96p6uJsVA8NfgLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U4rZAjTmUUsQoY0Uam6RbH5i/OVmTf2E
	WlS5fskOqbzm19f8knMgeRLl5QEqKHSsb5cydPydCD4kvM/pnHDtsAV6YRTHB71y
	TWw/bihQNlAlx8bR/Ub33CqxAFAQF5exFFTkIoOH/ZQtYzKks9v3TDbPE2y1cXgp
	Egqzzyj0cOM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4853D404AD;
	Tue, 10 Sep 2013 17:02:30 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 967C84049F;
	Tue, 10 Sep 2013 17:02:28 +0000 (UTC)
In-Reply-To: <522F397E.6080709@cchtml.com> (Michael Cronenworth's message of
	"Tue, 10 Sep 2013 10:23:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C664DA48-1A3A-11E3-A434-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234445>

Michael Cronenworth <mike@cchtml.com> writes:

> On git 1.8.1.x (Fedora 18) I was able to use the git-cvsserver to checkout code
> to package into a tarball. Script files that were in git with 755 masks were
> checked-out with the same mask. After upgrading the git repository machine to
> Fedora 19 (1.8.3.1) the behaviour has changed. When I checkout the same script
> files their mask is now 644. The mask has not changed in git.

Matthew, I do not know if you are still using the git-cvsserver, but
it seems that the only substantial change to that subsystem between
the 1.8.1.x and 1.8.3.x is your update.

Especially 2c3af7e7 (cvsserver: factor out git-log parsing logic,
2012-10-13) looks interesting.  It has a hunk like this:

-                my $git_perms = "";
-                $git_perms .= "r" if ( $mode & 4 );
-                $git_perms .= "w" if ( $mode & 2 );
-                $git_perms .= "x" if ( $mode & 1 );
-                $git_perms = "rw" if ( $git_perms eq "" );
+                my $dbMode = convertToDbMode($mode);

with the definition of convertToDbMode being:

+sub convertToDbMode
+{
+    my $mode = shift;
+    ...
+    $mode=~/^\d\d(\d)\d{3}$/;
+    my $userBits=$1;
+
+    my $dbMode = "";
+    $dbMode .= "r" if ( $userBits & 4 );
+    $dbMode .= "w" if ( $userBits & 2 );
+    $dbMode .= "x" if ( $userBits & 1 );
+    $dbMode = "rw" if ( $dbMode eq "" );
+
+    return $dbMode;

The $mode in the caller comes from diff-tree output (the post-change
side of the mode string, like "100755").

Picking the third digit from the left (i.e. "10'0'755"), instead of
the tail digit (i.e. "10075'5'"), looks strange.

Side note: now I look at it, the original does not make much sense
for that matter.  "100755" & 4 is different from oct("100755") & 4.
