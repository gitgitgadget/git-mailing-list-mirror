From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3.5 08/12] send-email: Move Subject sanitization from 
	--compose code to send_message
Date: Sat, 18 Apr 2009 21:37:57 -0500
Message-ID: <b4087cc50904181937q38ef45fm7409e020ecf40792@mail.gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-7-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-8-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-9-git-send-email-mfwitten@gmail.com>
	 <76718490904181854o380fe118y9f3a52c926bd1f6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 04:39:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvMwT-0002zL-Cp
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 04:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766AbZDSCiA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2009 22:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753146AbZDSCh7
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 22:37:59 -0400
Received: from mail-qy0-f126.google.com ([209.85.221.126]:46899 "EHLO
	mail-qy0-f126.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbZDSCh6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Apr 2009 22:37:58 -0400
Received: by qyk32 with SMTP id 32so820475qyk.33
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 19:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yNC5xGea3AjGqONtyZ/AdDekl9+WTYbT/4Ma8YYk8Gw=;
        b=wjKeu2D71m+CELhscXXc7TWxO1fr8uww3LFi9ChJmwhXNN97pKOMnCgcvAkA0HyIvW
         IvOz73qmcQs2ARrFJstkj8wHtSENWsZwuRLvOgHNhR8plB4+76dO7wGJKi0MCpro737e
         w3+TdD9pGflDb4QLzwpxTOzcOIxuiru4nzTww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZPV9rwARJBgsgCL/gPDmk9LUYy9xmzt1RGtZVN89HnSm3orAE58S0GlKW7RioHZIGt
         jgSt4ejn9Rr976ol6Qx5xuuHNJyRpac3b8nxt80YIErffWELKmfK4DtR+6XpkN+7qnQs
         j9tCXIBoLG2/smv11LuHVYJqMip4yNqX1d32A=
Received: by 10.224.37.147 with SMTP id x19mr5174649qad.386.1240108677670; 
	Sat, 18 Apr 2009 19:37:57 -0700 (PDT)
In-Reply-To: <76718490904181854o380fe118y9f3a52c926bd1f6d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116878>

On Sat, Apr 18, 2009 at 20:54, Jay Soffian <jaysoffian@gmail.com> wrote=
:
> On Sat, Apr 18, 2009 at 1:02 PM, Michael Witten <mfwitten@gmail.com> =
wrote:
>> + =A0 =A0 =A0 my $sanitized_subject =3D ($subject =3D~ /[^[:ascii:]]=
/) ? quote_rfc2047($subject) : $subject;
>
> I wonder if it would be clearer to always call quote_rfc2047, then
> have that function just return its input unaltered if quoting is not
> needed.

It actually ALWAYS changes the input. This code:

	sub quote_rfc2047 {
		local $_ =3D shift;
		my $encoding =3D shift || 'utf-8';
		s/([^-a-zA-Z0-9!*+\/])/sprintf("=3D%02X", ord($1))/eg;
		s/(.*)/=3D\?$encoding\?q\?$1\?=3D/;
		return $_;
	}

	print quote_rfc2047("Yiarg #&@$! This output is messy!") . "\n"

gives this output:

	=3D?utf-8?q?Yiarg=3D20=3D23=3D26!=3D20This=3D20output=3D20is=3D20messy=
!?=3D

Therfore the /[^[:ascii:]]/ check actually saves us from corrupting
already encoded subjects or from encoding ones that shouldn't be. In
fact, I'm not entirely sure the original code is correct to make that
check, because some of the characters that are replaced are ascii
characters. This is all rather strange.

Thanks! I should have tested it more; I'm constantly amazed by my
inability to see the problems I introduce ;-)
