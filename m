From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] add option to import series directly from a tar archive
Date: Mon, 8 Sep 2008 20:03:17 +0200
Message-ID: <20080908180317.GA6123@diana.vm.bytemark.co.uk>
References: <48C34EC7.9040102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 19:42:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kckkp-0002br-23
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 19:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbYIHRlQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Sep 2008 13:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172AbYIHRlP
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 13:41:15 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2881 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbYIHRlP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 13:41:15 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Kcl53-0001o6-00; Mon, 08 Sep 2008 19:03:17 +0100
Content-Disposition: inline
In-Reply-To: <48C34EC7.9040102@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95276>

On 2008-09-06 22:47:19 -0500, Clark Williams wrote:

> Attached is my first cut at adding the ability to import a patch
> series by specifying the tarball.

Thanks!

> No Karl, I haven't developed a test for it (yet). I wanted to see
> what you guys thought first :)

I don't see a problem with it, and if you took the time to code it
there is obviously at least one user (I have no idea how common patch
series tarballs are). I do have some comments below, but nothing that
would prevent you from writing a test or two right away. ;-)

> +           make_option('--tarfile',
> +                       help =3D 'import a series from a tar archive'=
,
> +                       action =3D "store_true"),

As I hint below, you might want to autodetect tarballs with --series
instead, since a tarball is just a tarred series directory.

> +        if n.startswith("../"):
> +            raise CmdException, "Relative path found in %s" % tar

I guess any occurrence of /../ in the middle of n should be caught as
well? Or can't that happen?

By the way, is the separator always '/' in tarfile? Or should you use
os.sep? (There is also os.pardir which you could use instead of '..',
but that might be overdoing it a little ...)

> +        raise CmdException, "no series file found in %s" % tar

Perhaps "no 'series' file ...", to make it clear what the name should
be?

> +    # unpack into a tmp dir
> +    tmpdir =3D tempfile.mkdtemp('.stg')
> +    t.extractall(tmpdir)
> +
> +    # apply the series
> +    __import_series(os.path.join(tmpdir, seriesfile), options)

Hmm. It seems like such a waste to go via the file system here, when
tarfile has such nice file extraction methods.

What you could do is something like this:

  1. Make two small classes with the same interface, one backed by a
     tarfile and one backed by a directory, that have two methods:
     get_series() and get_file(filename). Both methods return
     file-like objects (created by either open() or
     tarfile.extractfile()).

  2. Change __import_series() to use objects of this class rather than
     a directory directly -- starting with creating an instance of one
     or the other depending on tarfile.is_tarfile(). This will involve
     teaching __import_file to accept a file-like object instead of
     just a file name, but that's a one-liner.

  3. Drop the --tarfile flag, since you've just taught the --series
     flag to handle tarballs!

That said, if you don't feel like doing it the hard way, I won't
insist. The way you coded it is in no way bad (in particular, you
chose the right function to create a temp dir).

> +    # cleanup the tmpdir
> +    os.system('rm -rf %s' % tmpdir)

Aaah! My eyes! My _eyes_!!!!!

Seriously, though, you'd want to use something like shutil.rmtree
here.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
