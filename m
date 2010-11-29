From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCHv7.1 3/4] gitweb: File based caching layer (from git.kernel.org)
Date: Tue, 30 Nov 2010 00:07:39 +0100
Message-ID: <AANLkTinX9Phu+SuOyEWtAsMz182VkfVkJva1ep==V-zQ@mail.gmail.com>
References: <201010311021.55917.jnareb@gmail.com>
	<1288607092-31458-1-git-send-email-jnareb@gmail.com>
	<201011130035.50229.jnareb@gmail.com>
	<201011130056.24222.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 00:08:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNCpF-00056s-VY
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 00:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755551Ab0K2XHl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 18:07:41 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:34212 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755535Ab0K2XHk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Nov 2010 18:07:40 -0500
Received: by qyk11 with SMTP id 11so462277qyk.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 15:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=94114+V7fcvkj3aPO92si83ByrTjJIHc8ULOP1tUzzA=;
        b=WZOEvhEtgYt2XsTeFl+/ICGJptdMM7m0Eg2/l51oRXS63vZowG4I/XfFFL90aPri2D
         ywlrJ4lJi9iXSDJOeWZ/uJcWBN0ezbZpHOhTrX9SlGTaoeC8JamJmMX0dBtpzwZikLL7
         X4HdUfhc252z0x5xxI96tFb5eA5kfUyOBg2r0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=M7wqr7YPs5rCBxzXQhAgT8aNl76XsmDVSKuhAGAeVC4sBQekt84SRefqQ0G5Hv1E85
         s9PhMnOIMQwpj+rhBcByMrbOSUUiIsa0S7CCTbXq/uPew1al+N6j241isfM6xmPBbcVh
         G0544n+i0UWonqginOCMIEnwTvUUiQU4JHoq0=
Received: by 10.229.250.135 with SMTP id mo7mr5339444qcb.220.1291072059229;
 Mon, 29 Nov 2010 15:07:39 -0800 (PST)
Received: by 10.229.192.193 with HTTP; Mon, 29 Nov 2010 15:07:39 -0800 (PST)
In-Reply-To: <201011130056.24222.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162447>

2010/11/13 Jakub Narebski <jnareb@gmail.com>:
> - =A0 =A0 =A0 binmode STDOUT, ':raw';
> - =A0 =A0 =A0 print <$fd>;
> - =A0 =A0 =A0 binmode STDOUT, ':utf8'; # as set at the beginning of g=
itweb.cgi
> + =A0 =A0 =A0 if ($caching_enabled) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 open BINOUT, '>', $fullhashbinpath or d=
ie_error(500, "Could not open bin dump file");
> + =A0 =A0 =A0 }else{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 open BINOUT, '>', \$fullhashbinpath or =
die_error(500, "Could not open bin dump file");
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 binmode BINOUT, ':raw';
> + =A0 =A0 =A0 print BINOUT <$fd>;
> + =A0 =A0 =A0 binmode BINOUT, ':utf8'; # as set at the beginning of g=
itweb.cgi
> + =A0 =A0 =A0 close BINOUT;

Why do you use dynamically scoped file handles here as opposed to
lexically scoped ones?

And why do you change the output discipline on BINOUT immediately
before closing the file, and after you print data to it?

Doing so sortof makes sense when the filedhandle is STDOUT, but not
when it is BINOUT.

cheers,
Yves



--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
