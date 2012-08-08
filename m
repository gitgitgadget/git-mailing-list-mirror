From: Sascha Cunz <sascha-ml@babbelbox.org>
Subject: Re: Bringing a bit more sanity to $GIT_DIR/objects/info/alternates?
Date: Wed, 08 Aug 2012 03:42:11 +0200
Message-ID: <5037389.HDN2QUVQO5@mephista>
References: <7vmx2a3pif.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 03:46:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyvMM-0000EJ-Ja
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 03:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755121Ab2HHBqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 21:46:50 -0400
Received: from babbelbox.org ([83.133.105.186]:43094 "EHLO mail.babbelbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972Ab2HHBqt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 21:46:49 -0400
Received: (qmail 27303 invoked from network); 8 Aug 2012 01:47:04 -0000
Received: from unknown (HELO mephista.localnet) (Sascha@Babbelbox.org@89.204.130.18)
  by babbelbox.org with ESMTPA; 8 Aug 2012 01:47:04 -0000
User-Agent: KMail/4.9 (Linux/3.4.4-gentoo; KDE/4.9.0; x86_64; ; )
In-Reply-To: <7vmx2a3pif.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203061>

[..]
>  - By design, the borrowed object store MUST not ever lose any
>    object from it, as such an object loss can corrupt the borrowing
>    repositories.  In theory, it is OK for the object store whose
>    objects are borrowed by repositories to acquire new objects, but
>    losing existing objects is an absolute no-no.
[...]
>    In practice, this means that users who use "clone -s" to make a
>    new repository can *never* prune the original repository without
>    risking to corrupt its borrowing repository [*1*].
[...]

Given your example of /git/linux.git being a clone of Linus' repository, 
cloning a related repository using it as --reference:

     $ cd /git
     $ git clone --reference /git/linux.git git://k.org/linux-next.git mine

Wouldn't it be by far a less intrusive alternative to do the following (in the 
clone step above):

- create the file /git/linux.git/objects/borrowing/_git_mine (This is where we
  borrow FROM).
  This file would hold a packed-ref list of HEADs from the /git/mine clone of
  the repository.

  _git_mine here is slash-stripped version of the destination path. Maybe the
  packed-ref format could also be extended by a single line containing a full
  path to the foreign repository.

- On every update-ref to /git/mine, update the 'borrowing' refs in
  /git/linux.git

- On any maintenance on /git/linux.git (gc, prune, repack, etc.) consider refs
  in the packed-refs at objects/borrowing to be valid references.

  If packed-ref format was adopted like stated above, we could stat() here if
  this directory still exists and error out if it doesn't (In this case the
  user should tell us if she moved or removed the clone).

Any alternatives for looking up the packed-refs list for borrowing would also 
be doable; i.E. putting the list of valid borrowing-packed-refs-files into the 
config file (as opposed to lookup $GIT_DIR/objects/borrowing above).
Putting this list into the config file would eliminate need for the packed-ref 
format change and give the user the ability to maintain her clones with well-
known command 'git config'
