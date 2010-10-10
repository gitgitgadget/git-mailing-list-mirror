From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-svn.perl: Fix glob matching on svn paths
Date: Sun, 10 Oct 2010 01:15:35 -0500
Message-ID: <20101010061534.GB23100@burratino>
References: <1286615236-29732-1-git-send-email-ebik@ucw.cz>
 <1286615236-29732-2-git-send-email-ebik@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: =?utf-8?B?VG9tw6HFoQ==?= Ebenlendr <ebik@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Oct 10 08:20:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4pGk-0004qR-9M
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 08:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298Ab0JJGSr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 02:18:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65099 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab0JJGSq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Oct 2010 02:18:46 -0400
Received: by iwn6 with SMTP id 6so2013487iwn.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 23:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=e8uCan1UssmOAPmqXEvK8Gbr7L9YjbhbhM7Xt5wwvh0=;
        b=IyjhJ7Ss0g8ZVISgrNfN/fG6VjR8QbYJlFgHsNSCzOIBOnuJ2SFD4lIX237lW9W4cz
         1fDgdo/AIJvCWjBQrLfEXYf1FwwZ8EUZgm0gFl4fRDKfdd6xMMmTtwSerpIGZiBjjbMc
         K35M+VCFvZ7oMZbeX6de0EXXAmLwQxV1/hmqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=oOAC7Kpret52w7Vax0h9GgaDdLxUwLv6sVN3oPbCqJVPehaVuWJ69zj0Ca9lGNyxDs
         HpQET2DN71dEnR/rXjEM2+qHlOw9LczhLqIdW/dy7WoeHQAeCzyjQFdai1YWSY844pnX
         Gw++mdSi4S6qKoVkYQjNhbpLy52zBkIf6H9rY=
Received: by 10.42.29.132 with SMTP id r4mr1070916icc.345.1286691526170;
        Sat, 09 Oct 2010 23:18:46 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id gy41sm5672023ibb.11.2010.10.09.23.18.45
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 23:18:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286615236-29732-2-git-send-email-ebik@ucw.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158646>

Hi Tom=C3=A1=C5=A1,

Tom=C3=A1=C5=A1 Ebenlendr wrote:

> I tried to convert our repositories to git. Our repositories have onl=
y
> branches (no tags, and no branch is so special to be called trunk).
> The directory of each individual branch live in the root of the
> repository (i.e., not in directory 'branches' as in standard layout).

Okay, so I am imagining:

	1.0.x/
	1.1.x/
	1.2.x/
	2.0.x/
	...

> I init the repository by: git svn init path_to_repo -b *
> This triggers first bogus match in match_globs(): the pattern matches=
 an
> empty string - the place before first slash in any path.

A branches refspec of

	*:refs/remotes/*

results in

	$self{left} =3D ''
	$self{glob} =3D '*'
	$self{left_regex} =3D qr'^/(/|$)'
	$self{regex} =3D qr'([^/]*)'.

Does get_dir_globbed cope correctly?  Will get_dir cope correctly with
the spurious / (from $left/$de) inserted at the beginning of paths?

The regex always matches, even for empty $p, but it is not immediately
obvious to me how that pans out.  Could you describe the symptoms?

> We have created some branch names just by adding some suffix to anoth=
er
> branch name. Imagine branch "devel" and "devel2". Then there is bogus
> match on path '/devel2' as it outputs 'devel'.

Is this problem reproducible without the other change?  If so, would
it makes sense to split off this fix as a separate patch?

Also, if Eric likes your patches, can he forge your sign-off?  See
Documentation/SubmittingPatches for what this means.

Thanks,
Jonathan
