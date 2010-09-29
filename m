From: Magnus Hagander <magnus@hagander.net>
Subject: Re: [PATCH] Allow gitweb tab width to be set per project.
Date: Wed, 29 Sep 2010 10:39:27 +0200
Message-ID: <AANLkTikMjVQgEzLQ5Z95cmb5fkQ5iSzqfA4T=D1zzy=j@mail.gmail.com>
References: <1285673709-24924-1-git-send-email-magnus@hagander.net>
	<m34odagioh.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 10:39:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0sCX-0007h9-5n
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 10:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755029Ab0I2Ijj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 04:39:39 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49478 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970Ab0I2Iji convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 04:39:38 -0400
Received: by qyk36 with SMTP id 36so700124qyk.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 01:39:33 -0700 (PDT)
Received: by 10.224.87.1 with SMTP id u1mr876805qal.292.1285749567931; Wed, 29
 Sep 2010 01:39:27 -0700 (PDT)
Received: by 10.229.96.207 with HTTP; Wed, 29 Sep 2010 01:39:27 -0700 (PDT)
In-Reply-To: <m34odagioh.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157545>

On Tue, Sep 28, 2010 at 14:25, Jakub Narebski <jnareb@gmail.com> wrote:
> Magnus Hagander <magnus@hagander.net> writes:
>
>> Allow the gitweb.tabwidth option to control how many spaces a tab
>> gets expanded to.
>>
>> Signed-off-by: Magnus Hagander <magnus@hagander.net>
>
> This might be a good idea, but the solution looks like it includes
> some unnecessary performance hit (see coment below).
>
>> ---
>>
>> In the PostgreSQL project, we're using 4-space tabs, but we have oth=
er projects
>> as well on our gitweb server, so we need to be able to control this =
on a
>> per-project basis.
>
> Some of this comment should IMHO make it into commit message, e.g.

Check.

>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index a85e2f6..ef92a4f 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -1465,9 +1465,11 @@ sub unquote {
>> =A0# escape tabs (convert tabs to spaces)
>> =A0sub untabify {
>> =A0 =A0 =A0 my $line =3D shift;
>> + =A0 =A0 my $tabwidth =3D git_get_project_config('tabwidth', '--int=
');
>
> Note that untabify() is called once for each _line_ in a file or a
> diff...

Ha, that's what I get for thinking it was too easy. It actually was :-)


> This has acceptable performance only because gitweb config is cached
> in %config hash by git_get_project_config() subroutine.
>
>
> I'm not sure if it wouldn't be better to have $tabwidth be passed as
> an (optional) argument to untabify(), and calculated either in callin=
g
> sites for untabify(), or be calculated per-request and save in a
> global variable.

Given that it's cached, will it actually make a big difference?

In order to put it on all the callsites to untabify() it needs to for
example go as a parameter to format_diff_line to make any difference
(or it'd still be called once per line), so that would be quite a bit
of pollution I think.

Putting it as a global variable is certainly an option - but I didn't
find a pattern of something else to follow for that, so I figured it
was frowned upon?


> We might want to turn 'tabwidth' into a feature, though that is
> probably overengineering.

What advantage(s) would it give? (I admit I'm not particularly
familiar with the code - this was just the easiest way to get it done
quickly)


>> + =A0 =A0 $tabwidth =3D 8 if ($tabwidth <=3D 0);
>
> git_get_project_config('tabwidth', '--int') can return 'undef' if a
> configuration key does not exist, resulting in
>
> =A0Use of uninitialized value in numeric le (<=3D) at
>
> warning in web server logs.

Ah, I knew that would go somewhere. Interestingly enough, it doesn't
show up in the logs of the server I run it on now. But still should be
fixed.

--=20
=A0Magnus Hagander
=A0Me: http://www.hagander.net/
=A0Work: http://www.redpill-linpro.com/
