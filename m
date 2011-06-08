From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git-mediawiki : Encoding problems in perl
Date: Wed, 08 Jun 2011 17:37:56 +0200
Message-ID: <vpqhb8049m3.fsf@bauges.imag.fr>
References: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
	<20110608150106.GB7805@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?J=E9r=E9mie?= NIKAES <jeremie.nikaes@gmail.com>,
	thomas@xteddy.org, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 17:38:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUKpg-0004xj-Ah
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 17:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953Ab1FHPiH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 11:38:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40175 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755890Ab1FHPiE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 11:38:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p58FbsVm020507
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 8 Jun 2011 17:37:54 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QUKpQ-0003Hr-JI; Wed, 08 Jun 2011 17:37:56 +0200
In-Reply-To: <20110608150106.GB7805@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 8 Jun 2011 11:01:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 08 Jun 2011 17:37:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p58FbsVm020507
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1308152276.68897@A+7nLcMwNl1bGCdDt+LndQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175386>

Jeff King <peff@peff.net> writes:

> On Wed, Jun 08, 2011 at 03:45:43PM +0200, J=E9r=E9mie NIKAES wrote:
>
>> my $mw =3D MediaWiki::API->new();
>> $mw->edit( {
>>         action =3D> 'edit',
>>         title =3D> 'Main_page',
>>         text =3D> '=E9t=E9',
>> } ) ;
>> [...]
[...]
>>From the "utf8" man page:
>
>   Do not use this pragma for anything else than telling Perl that you=
r
>   script is written in UTF-8.
>
> which is what you are doing here,

Actually, this is what the example does, but this is not where the
original problem comes from. The code of git-remote-mediawiki contains
only us-ascii characters.

The actual code is:

    my $file_content =3D `git cat-file -p $sha1`;
    chomp($file_content);
    // ...
    $mw->edit( {
    	action =3D> 'edit',
    	summary =3D> $_[1],
    	title =3D> $title,
    	text =3D> $file_content,
    });

If the file is UTF-8 encoded, the page sent to the wiki is
double-utf8-encoded.

> That being said, this is probably just a small test case, and you are
> more likely to be reading the data from a file.

Oops, read this too late ;-).

> For file contents, you can use:
>
>   binmode($handle, ":utf8");
>
> to read everything in as utf8.

That's not exactly it, since we read the output of "git cat-file", not
an actual file.

But something along the lines of:

open(my $git, "-|:encoding(UTF-8)", "git cat-file -p $sha1");
my $file_content =3D <$git>;
close($git);

may do it.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
