From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Decompression speed: zip vs lzo
Date: Thu, 10 Jan 2008 07:55:14 +0100
Message-ID: <e5bfff550801092255wc852252m9086567a88b1ae99@mail.gmail.com>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>
	 <7v4pdmfw27.fsf@gitster.siamese.dyndns.org>
	 <47855765.9090001@vilain.net>
	 <alpine.LSU.1.00.0801092328580.31053@racer.site>
	 <alpine.LFD.1.00.0801092234130.3054@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 07:56:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCrL4-0005BP-3e
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 07:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbYAJGzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 01:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752184AbYAJGzU
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 01:55:20 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:48290 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756223AbYAJGzR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 01:55:17 -0500
Received: by rv-out-0910.google.com with SMTP id k20so483734rvb.1
        for <git@vger.kernel.org>; Wed, 09 Jan 2008 22:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=c9K2DrekatkDJvdiiEA/oTqehCryI5iyPw6SJ+uGino=;
        b=ptN05epqtcysg0lo9wN+6AyCL97vrTyYYQ0J4UqGlk+sEvm+XZbkwbaCaHwLj0b62H1Gk7Uv3z550aaDPGQ9T8mtWZkFTMj2mRmy+nEsc4FffJNv7xOE31/RqB2a2SFY+lZv174GIolRwWtianZ3HwC/YNvtPPY+0oSUAa8OerE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SAsVrNl4lC4by9vX40joO1FgQwlSruYYXYscx17cpHvSif7n7QRz779wlkZGFDwDyppRYTvHBkxjszPzxBkBNm43uoMhUbpWbP5pFwAsYvNxaK1tUlc8Rz+icX1Y2CpVF69OJXq3kjQoUAX/4QSHRhMgU0ls/BPD0fVJB14APd0=
Received: by 10.140.134.15 with SMTP id h15mr973857rvd.48.1199948114851;
        Wed, 09 Jan 2008 22:55:14 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Wed, 9 Jan 2008 22:55:14 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801092234130.3054@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70046>

On Jan 10, 2008 4:41 AM, Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 9 Jan 2008, Johannes Schindelin wrote:
>
> > I agree that gzip is already fast enough.
> >
> > However, pack v4 had more goodies than just being faster; it also promised
> > to have smaller packs.
>
> Right, like not having to compress tree objects and half of commit
> objects at all.
>
>

Decompression speed has been shown to be a bottle neck on some tests
involving mainly 'git log'.

Regarding back compatibility I really don't know at what level git
functions actually need to know the compression format, looking at the
code I would say at very low level, functions that deal directly with
inflate() and friends are few [1] and not directly connected to UI,
nor to git config. Is this compression format something user should
know/care? and if yes why?

In my tests the assumption of a source files tar ball is unrealistic,
to test the final size difference I would like testing different
compressions on a big already packaged but still not zipped file.
Someone could be so kind to hint me on how to create such a package
with good quality, i.e. with packaging levels similar to what is done
for public repos?

This does not realistically tests speed because as Junio pointed out
the real decompressing schema is different: many calls on small
objects, not one call on a big one. But if final size is acceptable we
can go on more difficult tests.

Marco

[1] where inflate() is called:

-inflate_it() in builtin-apply.c
-check_pack_inflate() in builtin-pack-objects.c
-get_data() in builtin-unpack-objects.c
-fwrite_sha1_file() in http-push.c and http-walker.c  [mmm interesting
same function in two files, also the signature and the contents seems
the same....]
-unpack_entry_data() in index-pack.c
-unpack_sha1_header(), unpack_sha1_rest(), get_size_from_delta(),
unpack_compressed_entry, write_sha1_from_fd() in sha1_file.c
