From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Sun, 7 Feb 2010 02:38:52 +0100
Message-ID: <201002070238.53527.jnareb@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> <cb7bb73a1002061458s5b2c1e7ere83111429473d11c@mail.gmail.com> <201002070220.36897.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 02:46:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdwEl-00010Z-2N
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 02:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755615Ab0BGBjB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 20:39:01 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:44355 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab0BGBjA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 20:39:00 -0500
Received: by fxm3 with SMTP id 3so5865510fxm.39
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 17:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=rTzKPqqop7sVH7i0f6rVZ5UHY4LG9TlZ7Wl0zZMgd40=;
        b=vUiUOqs6nq2CJTNkUNv5+ZA5Um/1LrkzgCzufbws6NombVkQ37tLJKOiqXkV4ne83h
         /g7ebxbvU/nXa/18DIsuTbymhnir/dqszP9bv9uTdRLVvUtWTIFed/8BBJk2qde1zqQj
         o0r2Yo4czy37/fnTpgpHsdR5BiKTm19wV7omw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=iCTmh5i39pRZAVBsS4PhJ4oMH9LyFFw+keZx+OqfKhmIPXvnRvuybaMya4ngf+9s7W
         XNZ2w9+epqIo6a7Ub5Lv9kySO+XPWRMisT8R/Fe/5FKFzaLevO2zqbopWVbz81c7jkMb
         r8AQ65kAo6Wn9+Z1sAhxYqNMQ08GbJ86DzHhg=
Received: by 10.102.236.3 with SMTP id j3mr3111991muh.93.1265506737784;
        Sat, 06 Feb 2010 17:38:57 -0800 (PST)
Received: from ?192.168.1.13? (abws80.neoplus.adsl.tpnet.pl [83.8.242.80])
        by mx.google.com with ESMTPS id i5sm14270236mue.42.2010.02.06.17.38.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 17:38:57 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201002070220.36897.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139208>

On Sun, 7 Feb 2010, Jakub Narebski wrote:

> Right. =A0This method would be contrary to the goals of fan-out schem=
es...
> well, we could use 'git ls-tree' without '-r' option, or simply=20
> 'git cat-file --batch' to read trees (note that we would get raw,=20
> unformatted tree, which is parseable with Perl, but it is not that ea=
sy),
> and go down level-by-level.

=46YI, here is how you can parse raw tree output from 'git cat-file --b=
atch',
assuming that you have plain-ASCII filenames ('use bytes;' would probab=
ly
be needed):

-- 8< --
sub decode_tree {
	my $contents =3D shift;

	# ...

	while (my @entry =3D decode_tree_entry($contents)) {

		# ...

		my $len =3D tree_entry_len(@entry);
		contents =3D substr($contents, $len);
		last unless $contents;
	}

	# ...
}

sub tree_entry_len {
	my ($mode_str, $filename) =3D @_;

	# length of mode string + separator + 20 bytes of SHA-1
	# + length of filename (in bytes) + terminating NUL ('\0')
	length($mode_str)+1 + length($filename)+1 + 20;
}

sub decode_tree_entry {
	my $buf =3D shift;

	$buf =3D~ s/^([0-7]+) //;
	my ($mode_str) =3D $1;
	my ($filename, $sha1_str) =3D unpack('Z*H[40]', $buf);

	return ($mode_str, $filename, $sha1_str);
}
-- >8 --

--=20
Jakub Narebski
Poland
