From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Consolidate escaping/validation of query string
Date: Sun, 24 Sep 2006 00:36:13 +0200
Organization: At home
Message-ID: <ef4csl$7vk$1@sea.gmane.org>
References: <20060923221841.18063.56589.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Sep 24 00:37:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRG7X-0002bf-Bv
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 00:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWIWWgm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Sep 2006 18:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWIWWgm
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 18:36:42 -0400
Received: from main.gmane.org ([80.91.229.2]:4764 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750819AbWIWWgl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 18:36:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GRG6i-0002S3-3R
	for git@vger.kernel.org; Sun, 24 Sep 2006 00:36:24 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 00:36:24 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 00:36:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27636>

Petr Baudis wrote:

> Consider:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0http://repo.or.cz/?p=3Dglibc-cvs.git;a=3Dtree=
;h=3D2609cb0411389325f4ee2854cc7159756eb0671e;hb=3D2609cb0411389325f4ee=
2854cc7159756eb0671e
>=20
> (click on the funny =3D__ify file)

Aaargh? Why this name?

> We ought to handle anything in filenames and I actually see no reason=
 why
> we don't, modulo very little missing escaping that this patch hopeful=
ly
> also fixes.
>=20
> I have also made esc_param() escape [?=3D&;]. Not escaping [&;] was d=
ownright
> buggy and [?=3D] just feels better escaped. ;-) YMMV.

=46irst of all, before introduction href() subroutine we escaped (using=
=20
esc_param) the _whole_ generated query string. Now we need to escape
only value part (as we can assume that parameter names are correct;
they are taken from limited pre-defined set).

I'd rather have new esc_param() or esc_param_value() quote like escape
subroutine from CGI::Util, with the esception of _not_ escaping '/'
(it makes funny bookmark, and lot less readable query string), and rena=
me
current esc_param() to esc_query_string() or esc_params().

Perhaps we should have also esc_arg() for things like title attribute
of <a> (link) element (or other element) and filename=3D"..." part of
Content-disposition: HTTP header.


By the way, the validate_input() should be split into separate subrouti=
nes:
validate_ref() for validating hash, hash_base, hash_parent, hash_parent=
_base,
and validate_path() for validating project, file_name and file_parent
parameters.

We should _never_ use esc_html except during the output, or just before=
 output.
It certainly shouldn't take place in parse_* subroutine (or in the fake=
 parse
like in git_blobdiff)!

P.S. gitweb was tested I think with filenames wirh spaces. Perhaps we s=
hould
add some other test file to gitweb/test, with '=3D', '@', '$', '?', '*'=
, ' ', '\n'
etc.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
