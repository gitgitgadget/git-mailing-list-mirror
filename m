From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb.cgi: Use File::MMagic; "a=blob" action knows the blob/file type
Date: Fri, 07 Jul 2006 23:18:37 -0700
Message-ID: <7vzmfksjpe.fsf@assigned-by-dhcp.cox.net>
References: <20060708041021.24704.qmail@web31804.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 08:18:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fz69R-0007Ep-PZ
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 08:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWGHGSk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 02:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWGHGSk
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 02:18:40 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:36604 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751298AbWGHGSj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jul 2006 02:18:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060708061838.ZLED27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 8 Jul 2006 02:18:38 -0400
To: ltuikov@yahoo.com
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23478>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Use File::MMagic to determine the MIME type of a blob/file.
> The variable magic_mime_file holds the location of the
> "magic.mime" file, usually "/usr/share/file/magic.mime".
> If not defined, the magic numbers internally stored in the
> File::MMagic module are used.

I am sorry to ask you this, but would you mind redoing this
patch without File::MMagic bits?  I think giving "a=blob" an
ability to automatically switch to git_blob_plain is a good
addition (as is your earlier patch to give a direct link to
reach blob_plain from the list), so let's have that part in
first.  I haven't applied your earlier one but it will appear in
"next" shortly.

Existing filename based mimetypes_guess should be a lot cheaper
than exploding a blob and feeding it to File::MMagic.  I was
hoping File::MMagic to be used when we cannot guess the content
type that way (i.e. when mimetypes_guess returns undef or
application/octet-stream).

Since the repository owner can correct misidentification by the
standard /etc/mime.types by supplying a custom per-repository
$mimetypes_file (modulo that the current implementation of
mimetype_guess_file does not allow it if the file does not have
an extension that is specific enough), File::MMagic might be an
overkill, especially if used in the way this patch does.  To
allow finer grained differentiation that cannot be done with
file extensions alone (e.g. some files may have .dat extension
but one can be VCD mpeg wrapped in RIFF, and another can be a
Z-machine story file), it might be simpler to allow the
repository owner to specify full $file_name for such an ambiguous
file in their custom $mimetypes_file, and try to match it in
mimetype_guess_file sub.  That way we may not even need to use
File::MMagic.

Are there cases where only $hash is given without $file_name?
If so we may need to fall back on File::MMagic in such a case
after all, but get_blob_mimetype sub copies the whole blob to a
temporary file to work around a problem with version 1.27 you
state in the comment -- this is way too much (and nobody seems
to clean up the tempfile).  Looking at magic.mime, I suspect we
might be able to get away with the first 4k bytes or so at most
(the largest offset except iso9660 image is "Biff5" appearing at
2114 to signal an Excel spreadsheet).
