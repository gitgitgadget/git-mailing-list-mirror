From: Pete Wyckoff <pw@padd.com>
Subject: Re: [RFC/PATCH 2/8 v3] git_remote_helpers: fix input when running
 under Python 3
Date: Tue, 15 Jan 2013 19:03:16 -0500
Message-ID: <20130116000316.GA26999@padd.com>
References: <a8c3aabfab64f49fa0cbb2d45bda79997a875ee8.1358018078.git.john@keeping.me.uk>
 <50F2296F.8030909@alum.mit.edu>
 <20130113161724.GK4574@serenity.lan>
 <50F38E12.6090207@alum.mit.edu>
 <20130114094721.GQ4574@serenity.lan>
 <20130115194809.GU4574@serenity.lan>
 <7vbocq2mri.fsf@alter.siamese.dyndns.org>
 <20130115215412.GX4574@serenity.lan>
 <7vy5fu14sy.fsf@alter.siamese.dyndns.org>
 <20130115224049.GZ4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 16 01:03:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvGU0-0002kn-D1
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 01:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574Ab3APADX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 19:03:23 -0500
Received: from honk.padd.com ([74.3.171.149]:41151 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932403Ab3APADU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 19:03:20 -0500
Received: from arf.padd.com (unknown [50.55.142.224])
	by honk.padd.com (Postfix) with ESMTPSA id 7623932C9;
	Tue, 15 Jan 2013 16:03:19 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id F0D7A249B4; Tue, 15 Jan 2013 19:03:16 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130115224049.GZ4574@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213694>

john@keeping.me.uk wrote on Tue, 15 Jan 2013 22:40 +0000:
> This is what keeping the refs as byte strings looks like.

As John knows, it is not possible to interpret text from a byte
string without talking about the character encoding.

Git is (largely) a C program and uses the character set defined
in the C standard, which is a subset of ASCII.  But git does
"math" on strings, like this snippet that takes something from
argv[] and prepends "refs/heads/":

    strcpy(refname, "refs/heads/");
    strcpy(refname + strlen("refs/heads/"), ret->name);

The result doesn't talk about what character set it is using,
but because it combines a prefix from ASCII with its input,
git makes the assumption that the input is ASCII-compatible.

If you feed a UTF-16 string in argv, e.g.

    $ echo master | iconv -f ascii -t utf16 | xargs git branch
    xargs: Warning: a NUL character occurred in the input.  It cannot be passed through in the argument list.  Did you mean to use the --null option?
    fatal: Not a valid object name: ''.

you get an error about NUL, and not the branch you hoped for.
Git assumes that the input character set contains roughly ASCII
in byte positions 0..127.

That's one small reason why the useful character encodings put
ASCII in the 0..127 range, including utf-8, big5 and shift-jis.
ASCII is indeed special due to its legacy, and both C and Python
recognize this.

> diff --git a/git_remote_helpers/git/importer.py b/git_remote_helpers/git/importer.py
> @@ -18,13 +18,16 @@ class GitImporter(object):
>  
>      def get_refs(self, gitdir):
>          """Returns a dictionary with refs.
> +
> +        Note that the keys in the returned dictionary are byte strings as
> +        read from git.
>          """
>          args = ["git", "--git-dir=" + gitdir, "for-each-ref", "refs/heads"]
> -        lines = check_output(args).strip().split('\n')
> +        lines = check_output(args).strip().split('\n'.encode('utf-8'))
>          refs = {}
>          for line in lines:
> -            value, name = line.split(' ')
> -            name = name.strip('commit\t')
> +            value, name = line.split(' '.encode('utf-8'))
> +            name = name.strip('commit\t'.encode('utf-8'))
>              refs[name] = value
>          return refs

I'd suggest for this Python conundrum using byte-string literals, e.g.:

        lines = check_output(args).strip().split(b'\n')
	value, name = line.split(b' ')
	name = name.strip(b'commit\t')

Essentially identical to what you have, but avoids naming "utf-8" as
the encoding.  It instead relies on Python's interpretation of
ASCII characters in string context, which is exactly what C does.

		-- Pete
