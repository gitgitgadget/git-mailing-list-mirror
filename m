From: Junio C Hamano <junkio@cox.net>
Subject: Re: parsecvs tool now creates git repositories
Date: Mon, 03 Apr 2006 23:09:02 -0700
Message-ID: <7vodzhc1oh.fsf@assigned-by-dhcp.cox.net>
References: <1143956188.2303.39.camel@neko.keithp.com>
	<46a038f90604031538x3c94d86ap9f1400427513a3a7@mail.gmail.com>
	<1144116459.2303.129.camel@neko.keithp.com>
	<46a038f90604031916r4651b572lb9bae4c5a3d47bc9@mail.gmail.com>
	<1144117473.2303.132.camel@neko.keithp.com>
	<46a038f90604031942w779894b8p5ef221482a70a301@mail.gmail.com>
	<1144122709.2303.153.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 08:09:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQeiz-0005a8-SJ
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 08:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbWDDGJG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 02:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbWDDGJG
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 02:09:06 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:47763 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751813AbWDDGJF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Apr 2006 02:09:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060404060904.YMIT17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Apr 2006 02:09:04 -0400
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1144122709.2303.153.camel@neko.keithp.com> (Keith Packard's
	message of "Mon, 03 Apr 2006 20:51:49 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18375>

Keith Packard <keithp@keithp.com> writes:

> I've just changed parsecvs to generate blobs for every revision in
> each ,v file right after they're read in; putting the necessary code
> right into parsecvs should be reasonably straightforward; we don't need
> the multi-patch logic as we do want to compute each intermediate version
> of the file.

If you want to go really fast without extra fork, are writing it
in C, and have the data for blob in core, you could link with
libgit.a and call write_sha1_file() yourself:

	unsigned char sha1[20];
        void *buf;
        unsigned long len;

	write_sha1_file(buf, len, "blob", sha1);

instead of forking "hash-object -w".  You feed your blob data
in buf, with its length in len, and you will get the blob object
name back in sha1[].  buf is owned by you and after
write_sha1_file() returns it is safe for you to scribble over it
or free() it.  sha1[] stores binary object name (20 bytes, not
40-byte hexadecimal), and you can use the helper function
sha1_to_hex() if you need a hex representation:

	char *sha1_to_hex(sha1)

which returns a pointer to a static buffer that is valid until
next call to sha1_to_hex(), so you need to strdup it if you want
to retain it.
