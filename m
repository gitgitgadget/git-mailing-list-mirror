From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/4] sha1_name: introduce getn_sha1() to take length
Date: Wed, 04 Apr 2012 09:35:26 +0200
Message-ID: <vpqr4w40x1d.fsf@bauges.imag.fr>
References: <1333029495-10034-1-git-send-email-artagnon@gmail.com>
	<1333029495-10034-2-git-send-email-artagnon@gmail.com>
	<20120403220817.GE19858@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 09:35:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFKkl-0000wW-1t
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 09:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550Ab2DDHfe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 03:35:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45962 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447Ab2DDHfd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 03:35:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q347UC9q032517
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Apr 2012 09:30:12 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SFKkZ-0002Ci-7M; Wed, 04 Apr 2012 09:35:27 +0200
In-Reply-To: <20120403220817.GE19858@burratino> (Jonathan Nieder's message of
	"Tue, 3 Apr 2012 17:08:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 04 Apr 2012 09:30:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q347UC9q032517
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1334129414.76032@9fQ5qrpfK2GT6mpF+FN2ow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194684>

Jonathan Nieder <jrnieder@gmail.com> writes:

> (cc-ing Cl=E9ment who is one of the last people to change this family=
 of
>  APIs, and Matthieu who knows these codepaths well and may have been =
a
>  mentor for that project)

I wouldn't say I know them well, but I did touch them in the past.

> Holy cow this function is going crazy.  So let's take a survey of
> the public functions in this family.
>
>  [... nice explanations of different functions ...]

Good job. I think your explanations could actually be added as comments
to cache.h to document the corresponding functions.

> My first reaction is that the meaning of the _1 suffix is not going t=
o
> be obvious to newcomers.  Any ideas for addressing that?

It seems I'm the one who introduced get_sha1_with_context_1. I meant
"internal variant of the one without _1", which is a convention used in
other places of Git's code, but usually as static functions, not in .h
files.

> "get_sha1_with_context_1" has no external callers so it could probabl=
y
> be made private.

I kept it public as a very small implementation detail: I tried not to
introduce performance penalty, hence made get_sha1_with_mode inline
(since it is really a trivial wrapper). But we probably wouldn't notice
the difference in performance making the _1 version private and losing
the "static inline"-ness of the public version.

Another way to say this is: get_sha1_with_context_1() does the real job
(perhaps it should be called get_sha1_real()?), and others are
convenience wrappers. Since convenience wrappers are convenient, nobody
use the actual function directly.

> Or maybe it makes sense to bite the bullet and add the length
> argument to all callers:

I don't think so. Convenience wrappers are meant to be simple to call,
and I don't think we want to force everybody to call strlen() before
calling them.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
