From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Mixing and matching multiple projects
Date: Fri, 17 Feb 2012 15:06:22 -0500
Message-ID: <201202172006.q1HK6MJg030775@no.baka.org>
References: <7vhayptght.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 21:06:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyU51-0008Fw-3j
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 21:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207Ab2BQUG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 15:06:26 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from tsutomu.baka.org ([66.114.72.182]:56696 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985Ab2BQUGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 15:06:25 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q1HK6MI8024562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 17 Feb 2012 15:06:23 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q1HK6MJg030775;
	Fri, 17 Feb 2012 15:06:22 -0500
In-reply-to: <7vhayptght.fsf@alter.siamese.dyndns.org>
Comments: In reply to a message from "Junio C Hamano <gitster@pobox.com>" dated "Fri, 17 Feb 2012 11:19:26 -0800."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190978>


In message <7vhayptght.fsf@alter.siamese.dyndns.org>, Junio C Hamano wr=
ites:

        /s/xyzzy/.git       -- the superproject
        /s/xyzzy/os/.git    -- the "os" submodule
        /s/xyzzy/u/.git     -- the "userspace" submodule

    At the working tree level, he can add /s/xyzzy/os/drivers/frotz/ di=
rectory
    and populate its sources there. Everything else is already set up t=
o build
    and link to it properly. But how would he add that directory to git=
?

    But I wonder if we can do without forking the /s/xyzzy/os/.git subm=
odule?

    I am wondering if people who have used submodules and/or nested
    projects more than I have better solutions to this puzzle.

Using gitslave [http://gitslave.sf.net] instead of git-submodules, you
can *almost* get there.

Specifically, gitslave allows the superproject /s/xyzzy to attach a
subproject at /s/xyzzy/os/drivers/frotz (either recursively through
/os which you don't want to do or directly).

However, the problem is the .gitignore in the os subproject.  If we
didn't have some way to ignore drivers/frotz, various git commands
would get annoyed.  Adding it in the os subproject requires forking
which you said you didn't want to do.  However, you could use
core.excludesfile in the os subproject to ignore the necessary file.

gitslave doesn't support automatically using core.excludesfile (and
indeed would automatically make an entry in os/.gitignore when you set
up the hierarchy).  However, it isn't a lot of work to revert that
=2Egitignore commit and set up core.excludesfile; but setting up
core.excludesfile on every clone might get annoying.  It probably
wouldn't be too difficult to tearch gitslave how to do that
automagically.

Is using this third party tool and making the necessary changes or
manually doing the work after every clone worth it?  Do you need the
git-submodule semantics of freezing the subprojects at a particular
SHA instead of floating at the tip of a branch?  Are the branches used
between xyzzy and os desynchronized?  Only you can judge.  Actually it
seems possible that you could use gitslave for os/drivers/frotz and
git-submodules for os.  Whether that is wise=E2=80=A6

I would be open to moving gitslave into contrib similar to what
git-subtree is under the process of doing, but gitslave would
certainly need some cleanup since it grew rather organically.

					-Seth Robertson
