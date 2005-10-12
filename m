From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-fetch --tags: deal with tags with spaces in them.
Date: Wed, 12 Oct 2005 11:57:33 -0700
Message-ID: <7vslv6ef6q.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90510062014l7f5740e0l77fc53b50f822e8f@mail.gmail.com>
	<46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com>
	<4349ED5D.6020703@catalyst.net.nz>
	<7v4q7p927d.fsf@assigned-by-dhcp.cox.net>
	<7vzmpgznfj.fsf_-_@assigned-by-dhcp.cox.net>
	<7virw4zlod.fsf_-_@assigned-by-dhcp.cox.net>
	<7vzmpgy4g4.fsf@assigned-by-dhcp.cox.net>
	<7vk6gjl2uu.fsf@assigned-by-dhcp.cox.net> <434D2D8F.2020407@zytor.com>
	<434D3000.5020601@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Oct 12 20:58:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPlnH-0000am-Ss
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 20:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbVJLS5g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 14:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbVJLS5g
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 14:57:36 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:32661 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751504AbVJLS5f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 14:57:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051012185727.YIEQ19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Oct 2005 14:57:27 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <434D3000.5020601@zytor.com> (H. Peter Anvin's message of "Wed,
	12 Oct 2005 08:47:12 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10043>

"H. Peter Anvin" <hpa@zytor.com> writes:

> H. Peter Anvin wrote:
>> We can disallow whitespace, and we *have* to disallow at least
>> newline due to the file format; I believe we should disallow all
>> control characters (0-31, 127-159.)
>
> Actually, disallowing anything 128 and above means knowing the encoding 
> system.  If we enforce UTF-8, we should presumably disallow at the very 
> least U+FFFE and U+FFFF too.

Hmph.  I think enforcing (or rather supporting preferentially)
UTF-8 in log messages was alright, but enforcing UTF-8 tagnames
imply UTF-8 host pathnames because we do not currently convert
when we fetch refs from remote and store locally.

 * git-clone-pack, git-fetch-pack and git-peek-remote run
   git-upload-pack on the other end.  Currently upload-pack
   sends a list of refs read from the remote filesystem without
   conversion, and:

   (1) clone-pack uses the names without conversion to replicate
       refs on the local filesystem.

   (2) fetch-pack sends the names given on the command line,
       and/or read from the local filesystem, to upload-pack
       without conversion.

   (3) fetch-pack and peek-remote outputs the names obtained
       from the remote without conversion to stdout.

 * over http, the encoding of the refnames client sees is what
   is stored in project.git/info/refs on the remote.  Currently,
   update-server-info reads from the filesystem and writes this
   file out without conversion.  While walking the commits,
   names are not used, so there is no refname encoding issues.

What we should do at this point is to declare that exchanging
refnames between systems is to happen after converting them to
UTF-8.  And version 1.0 just assumes pathnames are UTF-8.

If people on systems with non UTF-8 pathnames cared enough, the
tools can be made aware of local pathname encodings, and taught
how to convert what for_each_ref() read from the filesystem, the
refspecs given from the command line, etc. to UTF-8.  But that
can come later.
