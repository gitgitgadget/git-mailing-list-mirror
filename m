From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] i18n: add infrastructure for translating Git with gettext
Date: Fri, 18 Nov 2011 13:29:32 +0100
Message-ID: <CACBZZX4hE=tSYRW3GJndvi3pr0B=Qyk+XT4qvMzC=jtAGhgXZg@mail.gmail.com>
References: <1320970164-31694-1-git-send-email-avarab@gmail.com>
 <1320970164-31694-2-git-send-email-avarab@gmail.com> <7v39dmmj8k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 13:30:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRNaL-0000Jt-BM
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 13:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475Ab1KRM3z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Nov 2011 07:29:55 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51504 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab1KRM3y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2011 07:29:54 -0500
Received: by bke11 with SMTP id 11so3349947bke.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 04:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=W2x/Lad7IvAgHRxlt/W5uD+JPFNRcZu6JynV20V50UM=;
        b=OYMJCxrMtLSJrgK6lYcd+1ibHueM/ZH6fJ4PvJLBgFqVw9UUOE1SUPJACCneRpDuD4
         HTew04l2HQZoxWNy2a9TS5Ugzl+L4fehrOpbfW4gkW6NoNJu/eg7SLM3nWTskqN0cVKm
         CJBHMy7htlP30Qyu975HnN4jEt0Da3DcQXY9g=
Received: by 10.205.124.134 with SMTP id go6mr3065027bkc.129.1321619393193;
 Fri, 18 Nov 2011 04:29:53 -0800 (PST)
Received: by 10.204.69.71 with HTTP; Fri, 18 Nov 2011 04:29:32 -0800 (PST)
In-Reply-To: <7v39dmmj8k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185655>

On Fri, Nov 18, 2011 at 00:17, Junio C Hamano <gitster@pobox.com> wrote=
:
> Just an extremely minor issue, but a few things seem to seep through =
the
> "make V=3D''" build:
>
> =C2=A0 =C2=A0SUBDIR perl
> /usr/bin/perl -pe "s<\Q++LOCALEDIR++\E><.../share/locale>" <Git/I18N.=
pm >blib/lib/Git/I18N.pm
> /usr/bin/perl -pe "s<\Q++LOCALEDIR++\E><.../share/locale>" <Git.pm >b=
lib/lib/Git.pm
> Manifying blib/man3/Git::I18N.3pm
> Manifying blib/man3/Git.3pm
> =C2=A0 =C2=A0SUBDIR git_remote_helpers

That behavior hasn't changed with this patch, we just print out more
stuff now. Without the patch with V=3D'':

        SUBDIR perl
    cp Git.pm blib/lib/Git.pm
    Manifying blib/man3/Git.3pm

And with it:

        SUBDIR perl
    /usr/bin/perl -pe "s<\Q++LOCALEDIR++\E></home/avar/share/locale>"
<Git/I18N.pm >blib/lib/Git/I18N.pm
    /usr/bin/perl -pe "s<\Q++LOCALEDIR++\E></home/avar/share/locale>"
<Git.pm >blib/lib/Git.pm
    Manifying blib/man3/Git::I18N.3pm
    Manifying blib/man3/Git.3pm

So the change is:

 * We now have 2 files instead of 1
 * We have a filtering command instead of just a "cp".

The reason this happens is that we have this in the perl.mak:

    PM_FILTER =3D $(PERL) -pe "s<\Q++LOCALEDIR++\E></home/avar/share/lo=
cale>"

And we then later call:

    pm_to_blib : $(FIRST_MAKEFILE) $(TO_INST_PM)
        $(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e
'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', q[$(PM_FILTER)],
'\''$(PERM_DIR)'\'')' -- \
          Git/I18N.pm $(INST_LIBDIR)/Git/I18N.pm \
          Git.pm $(INST_LIBDIR)/Git.pm
        $(NOECHO) $(TOUCH) pm_to_blib

Which in ExtUtils::Install calls pm_to_blib, which is defined like this=
:

    sub pm_to_blib {
        my($fromto,$autodir,$pm_filter) =3D @_;

        _mkpath($autodir,0,0755);
        while(my($from, $to) =3D each %$fromto) {
            if( -f $to && -s $from =3D=3D -s $to && -M $to < -M $from )=
 {
                print "Skip $to (unchanged)\n";
                next;
            }

            # When a pm_filter is defined, we need to pre-process the
source first
            # to determine whether it has changed or not.  Therefore,
only perform
            # the comparison check when there's no filter to be ran.
            #    -- RAM, 03/01/2001

            my $need_filtering =3D defined $pm_filter && length $pm_fil=
ter &&
                                 $from =3D~ /\.pm$/;

            if (!$need_filtering && 0 =3D=3D compare($from,$to)) {
                print "Skip $to (unchanged)\n";
                next;
            }
            if (-f $to){
                # we wont try hard here. its too likely to mess things =
up.
                forceunlink($to);
            } else {
                _mkpath(dirname($to),0,0755);
            }
            if ($need_filtering) {
                run_filter($pm_filter, $from, $to);
                print "$pm_filter <$from >$to\n";
            } else {
                _copy( $from, $to );
                print "cp $from $to\n";
            }

I.e. there's no way to stop it from printing what it copies /
filters. We could quiet it with some Perl or Makefile hack, but let's
try to address that outside of this series.
