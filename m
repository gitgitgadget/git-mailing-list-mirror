From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 3/3] git rebase -i: add static check for commands and SHA-1
Date: Tue, 23 Jun 2015 12:42:24 -0700
Message-ID: <xmqqpp4mciu7.fsf@gitster.dls.corp.google.com>
References: <1435009369-11496-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1435009369-11496-3-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Galan =?utf-8?Q?R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 23 21:42:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7U5a-0006FA-NW
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 21:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932994AbbFWTma convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2015 15:42:30 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35607 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133AbbFWTm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 15:42:28 -0400
Received: by igblr2 with SMTP id lr2so61123673igb.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 12:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=HG+q722Cu+UvqZvMGiS6uMagx54rG9RTrE2sxvS6aQk=;
        b=KjksS/9Qnu49cK/J1Uc6maIrrRKxnP5yjMIxk8cuCmjuNhcphDz/PcpYMmprFCMMWN
         CvxkUO4+8DeByPREYFyZcwT/9GlVwX7Mi+e7Hwsjj60jlZRC2XokmdsLuLDrABPVr9Bx
         Sf/RTVn2bBv6DU/vLzK+Dsweh0B+XUMUXc3naxMdyx28O4pQgVo1xvtSv3PiiNKtkbEC
         UzmynuKw7emmWk+hFIQtTZLFupFA8FzXw+3AzBBu4RcSyk7P8deeJrozj4WP3+38IgKD
         VJ0YZJakMBVP/skDllzaz/T6DIRQM9m6CVNGJvcciagV0z55CxyJI1AWkA4f1Dpk5F3D
         sEQg==
X-Received: by 10.107.130.101 with SMTP id e98mr47041889iod.38.1435088547779;
        Tue, 23 Jun 2015 12:42:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3c90:65f7:f86b:dfda])
        by mx.google.com with ESMTPSA id p193sm15726876ioe.34.2015.06.23.12.42.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jun 2015 12:42:26 -0700 (PDT)
In-Reply-To: <1435009369-11496-3-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	("Galan =?utf-8?Q?R=C3=A9mi=22's?= message of "Mon, 22 Jun 2015 23:42:49
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272488>

Galan R=C3=A9mi  <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:

>  I used:
>    read -r command sha1 rest <<EOF
>    $line
>    EOF
>  because
>    printf '%s' "$line" | read -r command sha1 rest
>  doesn't work (the 3 variables have no value as a result).
>  There might be a better way to do this, but I don't have it right no=
w.

	while read line
        do
		(
			IFS=3D' '
                        set x $line
			shift
                        # now $1 is your command, $2 is sha1, $3 is rem=
ainder
			...
		)
	done

perhaps?

But more importantly, why do you even need to keep the bad ones in a
separate .badcmd and .badsha files?  Isn't that bloating your changes
unnecessarily, iow, if you issued your warning as you encounter them,
wouldn't the change become cleaner and easier to understand (and as
a side effect it may even become smaller)?  The _only_ thing that
you would get by keeping them in temporary files is that you can do
"one header and bunch of errors", but is it so common to make a bad
edit to the insn sheet that "a sequence of errors, one per line"
becomes more burdensome to the end user?

I would think

	stripspace |
	while read -r command sha1 rest
        do
        	...

and showing the warning as you detect inside that loop would be
sufficient.  Perhaps I am missing subtle details of what you are
doing.
