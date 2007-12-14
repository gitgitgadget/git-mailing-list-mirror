From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Authentication support for pserver
Date: Thu, 13 Dec 2007 21:32:59 -0800
Message-ID: <7vd4t9x2lw.fsf@gitster.siamese.dyndns.org>
References: <87wsrhex4c.fsf@cpan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, martyn@catalyst.net.nz, martin@catalyst.net.nz
To: avar@cpan.org (=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason)
X-From: git-owner@vger.kernel.org Fri Dec 14 06:34:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J33BV-0008UR-TY
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 06:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbXLNFdP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 00:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752330AbXLNFdP
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 00:33:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbXLNFdO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 00:33:14 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4154B8ECB;
	Fri, 14 Dec 2007 00:33:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 76A9D8ECA;
	Fri, 14 Dec 2007 00:33:02 -0500 (EST)
In-Reply-To: <87wsrhex4c.fsf@cpan.org> (=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason's message of
	"Fri, 14 Dec 2007 04:08:51 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

avar@cpan.org (=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason) writes:

> +    unless ($user eq 'anonymous') {
> +        # Trying to authenticate a user
> +        if (not exists $cfg->{gitcvs}->{users}) {
> +            print "E the repo config file needs a [gitcvs.users] sec=
tion with user/password key-value pairs\n";
> +            print "I HATE YOU\n";
> +            exit 1;
> +        } elsif (exists $cfg->{gitcvs}->{users} and not exists $cfg-=
>{gitcvs}->{users}->{$user}) {
> +            print "E the repo config file has a [gitcvs.users] secti=
on but the user $user is not defined in it\n";
> +            print "I HATE YOU\n";
> +            exit 1;
> +        } else {
> +            my $descrambled_password =3D descramble($password);
> +            my $cleartext_password =3D $cfg->{gitcvs}->{users}->{$us=
er};
> +            if ($descrambled_password ne $cleartext_password) {
> +                print "E The password supplied for user $user was in=
correct\n";
> +                print "I HATE YOU\n";
> +                exit 1;
> +            }

I do not know what the real pserver does but by sending these E lines i=
n
the latter two different forms back to the client you are leaking
sensitive information, which is probably not what you want (the first
one is Ok, though.  It would help the server administrator to notice
misconfiguration, and until it is corrected nobody would be able to log
in anyway).

Admittedly, the pserver password scrambling is not a real security, but
if we were paranoid, we would probably be even adding random delay in
"no user found" case and "password does not match" case, so that the
client cannot even tell from the response latency if a username exists
at the server.

> @@ -1176,12 +1196,6 @@ sub req_ci
> =20
>      $log->info("req_ci : " . ( defined($data) ? $data : "[NULL]" ));
> =20
> -    if ( $state->{method} eq 'pserver')
> -    {
> -        print "error 1 pserver access cannot commit\n";
> -        exit;
> -    }
> -

Is this correct?  You are still allowing anonymous pserver access, so
shouldn't you check if this was an anonymous access or authenticated on=
e
and refuse access like before for anonymous people?

> +    my ($str) =3D @_;
> +
> +    # This should never happen, the same format has been used since
> +    # CVS was spawned
> +    $str =3D~ s/^(.)//;
> +    die "invalid password format $1" unless $1 eq 'A';

I do not quite understand what "spawn" means in this sentence.
