From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2] http*: cleanup slot->local after fclose
Date: Mon, 1 Jun 2009 21:52:33 +0800
Message-ID: <be6fef0d0906010652v4fc814f9j631795cbad61be9@mail.gmail.com>
References: <49F1EA6D.8080406@gmail.com> <20090530091755.GA13578@localhost>
	 <be6fef0d0905300231k5167f3efle9a450419bdfa1cb@mail.gmail.com>
	 <20090530093717.GA22129@localhost>
	 <be6fef0d0905300352o33694420m9c988daa554420a3@mail.gmail.com>
	 <20090530230153.527532b0.rctay89@gmail.com>
	 <20090531000955.953725d9.rctay89@gmail.com>
	 <7vy6sdssnk.fsf@alter.siamese.dyndns.org>
	 <20090531175413.962a55c3.rctay89@gmail.com>
	 <7vws7xqazi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 15:52:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB7wQ-0003G4-IN
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 15:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbZFANwe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2009 09:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbZFANwe
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 09:52:34 -0400
Received: from mail-pz0-f109.google.com ([209.85.222.109]:53239 "EHLO
	mail-pz0-f109.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbZFANwd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2009 09:52:33 -0400
Received: by pzk7 with SMTP id 7so6010830pzk.33
        for <git@vger.kernel.org>; Mon, 01 Jun 2009 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DkFmA46GIDDUXu7rdq8OQY224s+442R8BLjQ8yCpe+4=;
        b=ZvvgglBJBJWFW2qdiiTKVXkoDfGI0bYAtKvLJPgz7RNhMIpnDXTLmtU/ULFjqtQWSK
         cR6hQjKYOi3odwlAO2UgTjirv6APQsffz3u2KILCzTIJAokMeJJ6LTHd14lzrbE6oI7y
         uKVmG6i2zoyNYPpRhks9MmuNijdce0+vYwyy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eEJH8mwIWwBlyiClkm66VTIrIltb00/BGHsQtN68+6lHzRg6YO5a8WV3jm2oZjjiuc
         nCOF5fme+NgyGGLCxySdet28tWGHmKb0+VOctx0D08lO9aXLOS0PckDrR8ulAWItdzxy
         8w2HyPSdRAsnye8SxDr/833ObpqFifJt9gnCM=
Received: by 10.142.51.4 with SMTP id y4mr2122443wfy.131.1243864354186; Mon, 
	01 Jun 2009 06:52:34 -0700 (PDT)
In-Reply-To: <7vws7xqazi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120469>

Hi,

On Mon, Jun 1, 2009 at 4:21 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> That "*could*" leaves me puzzled even more. =A0Could you clarify?
>
> Do you mean "earlier, nobody tried to fclose(slot->local) twice, but =
with
> the four patches there are codepaths that do so, which triggered the =
bug
> reported by Clemens"? =A0But then the issue couldn't have happened wi=
thout
> those patches.
>
> If existing code always knew when slot->local is and is not valid wit=
hout
> having to rely on its NULLness, and that was the reason why nobody tr=
ied
> to fclose(slot->local) twice, then I'd agree that it is a bug waiting=
 to
> happen, and stuffing NULL to slot->local after the code fclose() it w=
ould
> be a good clean-up.

the problem isn't triggered by fclose(slot->local) being done twice,
but a ftell() being done on slot->local, which points to a FILE*
handle that has already been fclose()'d (that is what the valgrind log
provided by Clemens reported). The offending ftell() is found in
http.c::run_active_slot(), and the code there does indeed depend on
the NULLness of slot->local (it checks whether slot->local is NULL
before doing the ftell()).

run_active_slot() is used rather heavily, and users of slot->local
always neglect to set it to NULL doing a fclose() on the FILE* handle
it points to. This statement is true in both 'master', and 'pu'
('rc/http-push'). Therefore, I said "*could*": although the problem
Clemens reported occurs only in 'pu' (or more accurately, the first
four patches of 'rc/http-push'), it's not totally impossible for the
problem to occur without those four patches.

--=20
Cheers,
Ray Chuan
