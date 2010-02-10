From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCHv2 04/10] gitweb: Use Cache::Cache compatibile (get, set) output caching
Date: Wed, 10 Feb 2010 21:32:54 +0100
Message-ID: <201002102132.56406.jnareb@gmail.com>
References: <1265711427-15193-1-git-send-email-jnareb@gmail.com> <20100210120257.GP4159@machine.or.cz> <201002101922.50010.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Feb 10 21:33:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfJFD-0001SZ-Rv
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 21:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144Ab0BJUdA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 15:33:00 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:62338 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756037Ab0BJUdA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 15:33:00 -0500
Received: by bwz19 with SMTP id 19so531956bwz.28
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 12:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vUd0OwFI3GzNbgCrhVQ6T5/cSo6RtdMN+dFUFq+jWSc=;
        b=QIs31ELcqvGFntYBg4zb65Rdy/TUCC6LsaTRFK/NIal+9NPkrlg3fHB0r7g1EEnaWm
         JIkB/DbB56cnCdrgidqpKup8O/zuGGRzH2RHjbkR0c057apTP0UO9zQqUP47bdHjkNvC
         ZatdRLlNhaJPRL4qvGqXSMEI0ipau42J2im+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ixAbmViu779YAuVfVRNtsTG/clbn+t+n6KcTayglFqFnJRiKXNHdaLedhWfpD20FRY
         ZHSlhjIiP6hoRj7+fOmX+SX7u+bgsC2jpFdhhRU7SVvFdODpmN35vIvfgV7KXrW4K1UO
         e3f9tTsbNcX6mjIUhzMzJ9J6g2KFjeJDguil4=
Received: by 10.204.132.7 with SMTP id z7mr502889bks.148.1265833978589;
        Wed, 10 Feb 2010 12:32:58 -0800 (PST)
Received: from ?192.168.1.13? (abvh24.neoplus.adsl.tpnet.pl [83.8.205.24])
        by mx.google.com with ESMTPS id 15sm740719bwz.0.2010.02.10.12.32.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Feb 2010 12:32:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201002101922.50010.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139546>

Dnia =B6roda 10. lutego 2010 19:22, Jakub Narebski napisa=B3:

> Well, the idea was to use PerlIO::Util if possible, checking it via
>=20
> =A0 out $use_perlio_layers =3D eval { require PerlIO::Util; 1 };
>=20
> and fallback to generic mechanism if it is not present. =A0Only the
> generic mechanism would have to be changed from manipulating *STDOUT
> (*STDOUT =3D $data_fh etc.) to tied filehandle.

Well, damn, this is not needed[1].  Instead of manipulating *STDOUT,
it is enough to use 'select FILEHANDLE'.  It means that the capture
would look like this:

  open my $data_fh, '>', \$data;
  my $oldfh =3D select($data_fh);

  # ... code that uses 'print <sth>'

  select($oldfh);
  close $data_fh;

One thing that needs to be done is changing 'binmode STDOUT ...' into
'binmode select() ...'

[1] Thanks to mst on #perl channel for pointing this to me.
--=20
Jakub Narebski
Poland
