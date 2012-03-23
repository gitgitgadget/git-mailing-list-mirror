From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH] difftool: print list of valid tools with '--tool-help'
Date: Fri, 23 Mar 2012 14:26:32 -0400
Message-ID: <CAFouethYEmY7g3Uw0HfFMOKFNcBv=TyAsSyEkBU-cQrhaf6v7g@mail.gmail.com>
References: <1331850311-4620-1-git-send-email-tim.henigan@gmail.com>
	<7v8vj1ihcn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 19:26:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB9CB-0002FU-IV
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 19:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759253Ab2CWS0e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Mar 2012 14:26:34 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58647 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028Ab2CWS0d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Mar 2012 14:26:33 -0400
Received: by iagz16 with SMTP id z16so4966111iag.19
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 11:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2+je12pVND5Goj0quS2aX+1D8hjfiulRowYHaw6uHEQ=;
        b=ggfVmGw23CkjAomYVUTzxsmp8j/25oazIPNy62onq7vSmzrs7bjK6OzmL4Z13s9TCK
         Gn1zS6/JdeBVlUuaa1CtvSTUEf9dG7aub4XJXdNVkgPl4Kmvq3KZcidYwH9HP9+hHUXv
         RpCsD0QZXyinV9Thh7eLpESmeqm1jKoF3Tg/8abQcRTjb3FCQq8SRyOaW844B03/xHf6
         piyWpih7g3lF+JkV9BFXz1mEoRF79cTOwse2vg5dq9Xt9dey/1RPBV9RxIDjR/MdW4/F
         kvpXj5U9NPeyLf1h6oSgrKutKH+eJ6SuXuMW7nEdSMkyFmcglxd1YkBQsce1PBVoJC/5
         r0nA==
Received: by 10.50.149.131 with SMTP id ua3mr2890919igb.41.1332527192462; Fri,
 23 Mar 2012 11:26:32 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Fri, 23 Mar 2012 11:26:32 -0700 (PDT)
In-Reply-To: <7v8vj1ihcn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193787>

On Thu, Mar 15, 2012 at 7:18 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
> As this topic to show list of tools dynamically has plenty of time to=
 be
> in the mainline (it will be post 1.7.10), I would suggest a follow-up
> series to this patch to do things like the following (just thinking
> aloud):
>
> =C2=A0- define a new entry point to these mergetools/ scriptlets, let=
's call
> =C2=A0 it "cando". =C2=A0An entry for mergetools/kompare might look l=
ike this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cando () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type kompare >=
/dev/null && test -n "$DISPLAY"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 that would yield true only when kompare is available and $DISP=
LAY is
> =C2=A0 set.
>
> =C2=A0- instead of dumping everything in $gitpath/mergetools/*, check=
 if each
> =C2=A0 tool says it can be used in the user's environment.

I experimented with this a bit and came up with the following idea
(not protected for GMail whitespace mangling):

# The following is to be added to 'git-difftool.perl'
sub print_tool_help
{
	my ($cmd, @found, @notfound);
	my $gitpath =3D Git::exec_path();

	for (glob "$gitpath/mergetools/*") {
		my $tool =3D basename($_);
		next if ($tool eq "defaults");

		$cmd  =3D '. "$(git --exec-path)/git-mergetool--lib"';
		$cmd .=3D " && get_merge_tool_path $tool >/dev/null 2>&1";
		if (system('sh', '-c', $cmd) =3D=3D 0) {
			push(@found, $tool);
		} else {
			push(@notfound, $tool);
		}
	}

	print "'git difftool --tool=3D<tool>' may be set to one of the followi=
ng:\n";
	print "\t$_\n" for (@found);

	print "\nThe following are valid tools, but not currently installed:\n=
";
	print "\t$_\n" for (@notfound);

	exit(0);
}

Rather than create a new entry point, I used the existing
'get_merge_tool_path' that resides in 'git-mergetool--lib' to
determine if a given tool is actually installed on the system.

The '$DISPLAY' variable is lost in this implementation, but honestly I
don't understand how it was intended to be used.

Does this look useful?
