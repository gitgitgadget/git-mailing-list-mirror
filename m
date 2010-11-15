From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/10] add: do not rely on dtype being NULL behavior
Date: Mon, 15 Nov 2010 06:14:15 -0600
Message-ID: <20101115121415.GB14729@burratino>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 13:14:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHxxY-0006UN-8P
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 13:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156Ab0KOMOv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 07:14:51 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57221 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab0KOMOu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 07:14:50 -0500
Received: by gxk23 with SMTP id 23so2864843gxk.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 04:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/IhKM9qtKgkEnNRCwu02EaBbrL2a/D1i/tBTuGQh3CA=;
        b=c66a7BooZLG0TRZKSgyEF7kxJM0himwPjl2QD67tffWcYEx9hA450rBkcqwyUKf5Yf
         lYqjEbnjesVQx144hRwxZS5uXSYvhvjK/DDe11YJj+vwlFAkqaLK75QGsOZnWLvhAaUC
         4+mb09s8sHqFt1EX26nn6AKIaZkcS0wfqxi2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=M/gm8HKjXVQ8tFknEazLG0B4vwouprx/uUw5fbCe3U0JdVCRV4M7sauMpQ5o68RRd/
         ri0dRvJG7bZHvbJQ5vqAY7/1NOTWVpo0WQxGIhXNurpuES/E/JL43MMhH525MI4Vcjz7
         hizo0Y1/htzaSwbqo8DAT1XB9gUb+ZUn3j/1g=
Received: by 10.100.247.17 with SMTP id u17mr2831364anh.197.1289823290041;
        Mon, 15 Nov 2010 04:14:50 -0800 (PST)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id d20sm3732775and.9.2010.11.15.04.14.47
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 04:14:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289817410-32470-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161488>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Commit c84de70 (excluded_1(): support exclude files in index -
> 2009-08-20) added support for excluded() where dtype can be NULL. It
> was designed specifically for index matching because there was no
> other way to extract dtype information from index. It did not support
> wildcard matching (for example, "a*/" pattern would fail to match).
>=20
> The code was probably misread when commit 108da0d (git add: Add the
> "--ignore-missing" option for the dry run - 2010-07-10) was made
> because DT_UNKNOWN happens to be zero (NULL) too.
>=20
> Do not pass DT_UNKNOWN/NULL to excluded(), instead pass a pointer to =
a
> variable that contains DT_UNKNOWN. The real dtype will be extracted
> from worktree by excluded(), as expected.

Could you rephrase this in a way that contrasts current and desired
behavior?  Is it like this?

	The "git add --ignore-missing --dry-run" codepath is
	interpreting .gitignore incorrectly, unlike "git add".  For
	example:

		$ test -e foo || echo missing
		missing
		$ echo foo/ >>.gitignore
		$ mkdir bar
		$ git add --ignore-missing --dry-run foo; echo $?
		The following paths are ignored by one of your .gitignore files:
		foo/
		Use -f if you really want to add them.
		fatal: no files added
		128
		$ git add --ignore-missing --dry-run bar/foo; echo $?
		0

	In the original use case (preparing to add a submodule) the
	behavior of the first command is correct, second incorrect.
	If the entry to be added was a regular file, it would be the
	other way around.

	The cause: the --ignore-missing code passes DT_UNKNOWN as the
	dtype_ptr argument to excluded() which happens to equal zero
	(NULL) and accidentally triggers the "match pathspecs in index
	only" codepath (see c84de70, excluded_1(): support exclude
	files in index, 2009-08-20) that is unfortunately a bit
	primitive.

	Surely what was really wanted is to check paths against the
	index and work tree, defaulting to "regular file".

Wait --- that's not true.  In the "git submodule add" case, we really
want to default to (or even better, force) "directory".
