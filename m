From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] gitweb: merge boolean feature subroutines
Date: Sat, 3 Jan 2009 17:51:50 +0100
Message-ID: <9b18b3110901030851t47c03d0ay75fc91b1ef2ed44b@mail.gmail.com>
References: <1230996692-7182-1-git-send-email-kraai@ftbfs.org>
	 <9b18b3110901030818i242d81ccl20ef3f264ec64cad@mail.gmail.com>
	 <20090103164024.GA4205@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Matt Kraai" <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Sat Jan 03 17:53:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJ9kT-00045K-Ru
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 17:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759118AbZACQvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 11:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758019AbZACQvx
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 11:51:53 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:38158 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbZACQvw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 11:51:52 -0500
Received: by qw-out-2122.google.com with SMTP id 3so5792354qwe.37
        for <git@vger.kernel.org>; Sat, 03 Jan 2009 08:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8pjRCIA+eEG01lDCnryr6MRWcTQBojV7WNrL/byld2Y=;
        b=KrfltKwPSe7MqgopqL9QahwoD1vmvcknnIHNINDNtLnAJYFQQHvFE0Beqx1x/TQ+gK
         WWkI/XF1shzKTdxgm478OizC0otj2+3ExMQ9fjYqC/q5PdPwgeYRJS6x5PkKXyrKObOy
         p2bOn4p9VVbC70RokfNVj8fMWXamaetqaVspE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=u/RHDEnmIVmt3AtKftJ9DNGxbDH0iL5MGfwfmdmtkX0Xd15oMBLvnUTMLerRwz36Ea
         WTS2s7PrXVKEpDypbzV9qSsyOxTrs7AkgnFFsBf2J2UNoob7iGiDq4rVvWnTFzCatbeo
         J1jLhvkJ4lYc7klG3kNhvgyJDC+U2bfIsL5xs=
Received: by 10.214.181.5 with SMTP id d5mr15613332qaf.368.1231001510408;
        Sat, 03 Jan 2009 08:51:50 -0800 (PST)
Received: by 10.214.241.2 with HTTP; Sat, 3 Jan 2009 08:51:50 -0800 (PST)
In-Reply-To: <20090103164024.GA4205@ftbfs.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104474>

2009/1/3 Matt Kraai <kraai@ftbfs.org>:
> On Sat, Jan 03, 2009 at 05:18:44PM +0100, demerphq wrote:
>> 2009/1/3 Matt Kraai <kraai@ftbfs.org>:
>> [...]
>> > -sub feature_blame {
>> > -       my ($val) = git_get_project_config('blame', '--bool');
>> > +sub feature_bool {
>> > +       my $key = shift;
>> > +       my ($val) = git_get_project_config($key, '--bool');
>> >
>> >        if ($val eq 'true') {
>> >                return 1;
>>
>> Maybe that should be:
>>
>>            return ($val eq 'true');
>>
>> as It is not a good idea to use 0 as a replacement for perls false, as
>> the two have different behaviour.
>>
>> $perl -wle'my $val=shift; my $x=$val eq "true"; print "<$_>" for $x, 0+$x' false
>> <>
>> <0>
>
> I don't think Perl has *a* false value, but rather has multiple values
> that are treated as false, such as undef, zero, and the empty string.
> Personally, I find 0 clearer than the empty string, but that's
> probably just my C bias sneaking in.

Yes it definitely does have a false value, PL_sv_no, and a true value,
PL_sv_yes (although it is much less important).  It is these values
which are copied to signify true and false in the cases where the
internals need to, such as for boolean operators that must return
false, and things like negation and (in)equality checks.

It is a so called "dual var" SvPVNV, with 0 in the NV (numeric) slot
and the empty string in the PV (string) slot.

You can see one example of its behaviour in my previous mail, and can
see it further here:

$ perl -MDevel::Peek -e'print Dump(shift @ARGV eq "true")'
SV = PVNV(0x952eb10) at 0x952b6f0
  REFCNT = 2147483647
  FLAGS = (IOK,NOK,POK,READONLY,pIOK,pNOK,pPOK)
  IV = 0
  NV = 0
  PV = 0x952eae8 ""\0
  CUR = 0
  LEN = 4

Compare that to:

perl -MDevel::Peek -e'print Dump(shift @ARGV eq "true" ? 1 : 0)'
SV = IV(0x94d8398) at 0x94bd678
  REFCNT = 1
  FLAGS = (PADBUSY,PADTMP,IOK,READONLY,pIOK)
  IV = 0

> All of the boolean feature values use 0 or 1, so if this should be
> changed, I think it should probably be done as a separate patch.

As you think is best. It is after all a nit, and probably one that is
harmless. But I've been bitten by people not using the languages
native booleans before, and well, once bitten twice shy.

cheers,
Yves
-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
