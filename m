From: Greg Price <price@ksplice.com>
Subject: Re: [PATCH] pack-refs: remove newly empty directories
Date: Tue, 6 Jul 2010 15:13:55 -0400
Message-ID: <AANLkTilsfURYKOQC-kAtNrr1cTmULOXDTn0zxicgb9-S@mail.gmail.com>
References: <1278368848-7037-1-git-send-email-price@ksplice.com>
	<m2y6doqwch.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Jul 06 21:14:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWDaq-0007SE-SA
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 21:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130Ab0GFTN6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 15:13:58 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51914 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733Ab0GFTN5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 15:13:57 -0400
Received: by wwb24 with SMTP id 24so2143959wwb.1
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 12:13:56 -0700 (PDT)
Received: by 10.213.32.140 with SMTP id c12mr4507344ebd.99.1278443635821; Tue, 
	06 Jul 2010 12:13:55 -0700 (PDT)
Received: by 10.213.14.129 with HTTP; Tue, 6 Jul 2010 12:13:55 -0700 (PDT)
In-Reply-To: <m2y6doqwch.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150397>

On Tue, Jul 6, 2010 at 2:49 PM, Andreas Schwab <schwab@linux-m68k.org> =
wrote:
> What happens if a parallel running git wants to update a ref in one o=
f
> the now-empty directories? =C2=A0Can it get a spurious error after it=
 has
> called safe_create_leading_directories?

Good question!  I asked the same question. =3D)  It can get the same
kind of error that happens if two parallel running git processes try
to update the same ref.

Anything that tries to update a ref will call lock_ref_sha1_basic(),
which calls safe_create_leading_directories() to make the directory
and then hold_lock_file_for_update() to open(O_CREAT|O_EXCL) a lock
file inside the directory.  So if the prune happens after the open(),
it will simply not remove the directory and all is well.  If it
happens between the safe_create_leading_directories() and the open(),
then the open() will fail.  This is also what happens if the lock has
been taken by another git process updating the same ref.  Currently
lock_ref_sha1_basic() chooses to have the process die in this case and
print an error message.

Similarly the prune could remove a directory just before
safe_create_leading_directories() creates one inside it.  Then
safe_create_leading_directories() will fail and loc_ref_sha1_basic()
will print an error message and return failure.  In both cases, since
we are exposed to a similar failure if a parallel process is updating
the same ref (a common operation) rather than packing refs (an
uncommon operation), I don't think this is a problem.

Greg
