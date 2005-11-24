From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb on kernel.org and UTF-8
Date: Wed, 23 Nov 2005 19:24:38 -0800
Message-ID: <7vfypm20eh.fsf@assigned-by-dhcp.cox.net>
References: <7vzmnw9qo0.fsf@assigned-by-dhcp.cox.net>
	<4383BEE4.1060800@zytor.com> <20051123033526.GA24098@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 04:25:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef7jE-0001FX-Oi
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 04:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbVKXDYl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 23 Nov 2005 22:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbVKXDYl
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 22:24:41 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:36499 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932622AbVKXDYk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2005 22:24:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051124032318.HPPP17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 23 Nov 2005 22:23:18 -0500
To: Kay Sievers <kay.sievers@vrfy.org>,
	Paul Mackerras <paulus@samba.org>
In-Reply-To: <20051123033526.GA24098@vrfy.org> (Kay Sievers's message of "Wed,
	23 Nov 2005 04:35:26 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12670>

Kay Sievers <kay.sievers@vrfy.org> writes:

> Should be fine now. The escapeHTML() garbled the utf8 "=F6", and the
> decode() failed that.

Looking better.  Thanks.

This begs for addressing another issue, although I am hesitant
to open this can of worms at this moment.

It might be a good idea to have configuration items gitk and
gitweb can use to get a hint to decide what the commit log
message and the blob data encodings might be.  gitweb already
adds its own information to the git repository format
(.git/description), so this _could_ be stored outside just like
that (e.g. .git/commit_log_encoding), but using .git/config is
probably better.

How about doing something like this?

	[i18n]
        	commitEncoding =3D utf8
		blobEncoding =3D utf8

to mean:

	If you _have_ to make an assumption on an encoding
	commit and blob objects are in, utf8 is your best bet
	(but mistakes can happen, and some blobs can be binary).

Then gitweb and gitk can look at commitEncoding and blobEncoding
as a hint to base its display defaults on.  Sending everything
out in utf8 would be sane and safe choice these days for gitweb,
so if commitEncoding is latin-1 it may need to iconv latin-1 to
utf8 while reading commits.  For blobs, it might be better off
asking file(1) or File::MMagic (since you are using Perl in
gitweb --- sorry I do not know tcl equivalent of that) what they
are; eventually you would want to be able to show repositories
full of jpeg pictures anyway ;-).

On the commit-producing side, I could have:

	[i18n]
        	editorEncoding =3D latin-1

and if editorEncoding is different from commitEncoding,
"git-commit -c $commit" would first iconv from utf8 to latin-1
before populating the user's editor, and iconv back from latin-1
to utf8 before feeding what the user edited to commit-tree.

Pathname encoding is the reason why I was hesitant about bring
this up.  Although it is too late for 1.0 now, we _could_ have
declared that the paths recorded in git tree objects and index
files are internally utf8, and working tree paths can be in
different encoding.  As a local repository configuration not
project wide configuration, we could have something like:

	[i18n]
        	pathnameEncoding =3D latin-1

to mean that the filesystem paths returned by readdir(3) and
accepted by open(2) and friends are in latin-1.  Comparison and
movement between working tree files, the index file, and tree
objects have to involve iconv and do the right thing.  So if you
fetch from such a repository into a filesystem that stores
pathnames in utf8, the right thing should happen.

I personally feel any sane project should restrict its pathname
to ASCII only, so this issue might be moot (or is the right word
"mute"?), but something like this _might_ be useful in later
versions of git.

But not in 1.0.
