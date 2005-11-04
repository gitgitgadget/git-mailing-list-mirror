From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: GIT networked storage
Date: Fri, 04 Nov 2005 01:21:13 -0800
Message-ID: <7vd5lg22gm.fsf@assigned-by-dhcp.cox.net>
References: <7vwtjp2h59.fsf@assigned-by-dhcp.cox.net>
	<436AE6A3.4040103@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 10:21:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXxlM-0005Kk-Jm
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 10:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVKDJVR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 04:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbVKDJVR
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 04:21:17 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:48065 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932152AbVKDJVR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 04:21:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051104092019.FKXL2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Nov 2005 04:20:19 -0500
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <436AE6A3.4040103@pobox.com> (Jeff Garzik's message of "Thu, 03
	Nov 2005 23:42:11 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11122>

Jeff Garzik <jgarzik@pobox.com> writes:

> How easy is it to add a new storage backend to git?

Almost everything is contained within sha1_file.c.

Object creation side is simple -- everybody who creates an
object (e.g update-index registering blobs, write-tree writing
the toplevel and intermediate level trees, commit-tree building
a commit object, unpack-objects exploding a pack) goes through
write_sha1_file(), which checks if the object is already
available using has_sha1_file() and creates a new object in the
local .git/objects/?? directory.  I am assuming that you are not
planning to create objects in a remote peer from within the git
code path, and instead to have background process that replicate
them over the network to peer repositories, so you probably do
not have to touch this side.

Extending inspection and reading from existing objects for your
networked storage may be somewhat messy, but starting points
are:

. has_sha1_file() takes the object name and returns true/false;
  if the object is available to us in any form (be it in one of
  the alternate object stores or the local repository, as
  individual object in an objects/??/ file or stored in a pack).
  Currently it looks at packs and then checks individual files
  for performance reasons (to minimize seeks and to prevent
  polluting dcache with many negative hits); you would be adding
  another data source. 

. read_sha1_file() takes the object name, and returns the
  uncompressed contents of the object in addition to the type
  and the size.

. sha1_object_info() takes the object name and returns the type
  of the object and optionally returns the size of it, without
  reading the contents.  Some programs call this before reading
  the data using read_sha1_file(), so you might want to use this
  as a cue to prefetch from a remote peer; also you _might_ want
  to keep type and size cached if you plan to implement
  forgetful storage that deliberately loses objects and expects
  to refetch it from its peers.  Good test program once you are
  done extending this part is git-cat-file with -t and -s flag.

The above three are the primary read interfaces, but there are
some places that cheat by assuming that packs and individual
objects are the only two kinds of sources for the object data,
so you need to be careful.  For example, write_sha1_to_fd(),
which is used only by ssh-upload, first tries to call
map_sha1_file_internal(), which is only valid for individual
objects, to grab the object data, and when it fails, calls
read_packed_sha1(), which is only valid for objects in packs,
without even checking if read_packed_sha1() succeeded.  This
doesn't crash only because the caller of write_sha1_to_fd()
checks if the object is available by calling has_sha1_file()
itself before calling this function, but you would need to
change it to fall back on your networked storage if you do not
want to crash when used by ssh-upload.

HTH, and have fun.
