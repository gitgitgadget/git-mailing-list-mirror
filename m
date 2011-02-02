From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Q: does index-pack work in place on windows?
Date: Wed, 2 Feb 2011 21:30:15 +0100
Message-ID: <AANLkTi=m+kERSH7TJFjuRaUfA7FR03zwNn2PKFxrqiOp@mail.gmail.com>
References: <7v39o6xk5q.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 02 21:30:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkjLe-0000jS-3N
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 21:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283Ab1BBUah convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Feb 2011 15:30:37 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62439 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab1BBUag convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Feb 2011 15:30:36 -0500
Received: by eye27 with SMTP id 27so312187eye.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 12:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=1kTP7Uqi5xeVWE7uWnEw2l9mmEeGeWZoiZq3a8rW/zo=;
        b=lKyEr8d7e5QVRcFZyXGWjM8DC25JTmC/z9UI3+844KkygpWWa6mOEhs30xNrqvUI5D
         Fl4GPI9v53NgnXdqmu7ze1kKCEknJ1vrt89FSjVtaEHQW2QqvSUBfcQh1zN5tf3iCQgn
         POmzXo9Sr4Ul4E5dDb3cNFa4hXSkTwEltdGYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=GKPHTx32ey9q3tyQ2Tj2X+9Ccp0qZvfF33JzMSWLiGyKhJb9dr2Y/DUyue+bkCuU1r
         66EVqUACe17qd64p9jAozemkE/AtAcEVJ9fQB6u7ti9AGIDAMOto487hgaj7cKT/JoUD
         HIs29Xk0JMFaXtHF218OsmF93hdVpcE2nK13g=
Received: by 10.223.112.1 with SMTP id u1mr9090761fap.109.1296678635248; Wed,
 02 Feb 2011 12:30:35 -0800 (PST)
Received: by 10.223.116.210 with HTTP; Wed, 2 Feb 2011 12:30:15 -0800 (PST)
In-Reply-To: <7v39o6xk5q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165936>

On Wed, Feb 2, 2011 at 9:21 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> ... or any other (operating / file) system where you cannot unlink a =
file
> that is open?
>
> When you run
>
> =A0 =A0$ git clone git://some.where/repo/sitory.git local
> =A0 =A0$ cd local
> =A0 =A0$ git index-pack .git/objects/pack/pack-*.pack
>
> there is a call to write_idx_file() in builtin/index-pack.c, that fee=
ds
> the correct (and existing) name of the corresponding pack idx file.
>
> The callee in pack-write.c, after sorting the list of objects contain=
ed in
> the pack, does this:
>
> =A0 =A0 =A0 =A0if (!index_name) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0static char tmpfile[PATH_MAX];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fd =3D odb_mkstemp(tmpfile, sizeof(tmp=
file), "pack/tmp_idx_XXXXXX");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0index_name =3D xstrdup(tmpfile);
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unlink(index_name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fd =3D open(index_name, O_CREAT|O_EXCL=
|O_WRONLY, 0600);
> =A0 =A0 =A0 =A0}
>
> and then writes out the pack index to the file descriptor. =A0But ind=
ex-pack
> uses the usual has_sha1_file() and read_sha1_file() interface to vali=
date
> the "existing" objects, and is likely to have mmapped the .idx file w=
hen
> it called use_pack_window(). =A0Which makes me suspect that this unli=
nk (or
> the open that immediately follows) may fail on systems that do not al=
low
> unlink on inode that has still users.

=2E..and you're right:

$ git index-pack
=2Egit/objects/pack/pack-d634271f4d7ca70c00148e967a343c3c46cd7705.pack
Unlink of file '.git/objects/pack/pack-d634271f4d7ca70c00148e967a343c3c=
46cd7705.idx'
failed. Should I try again? (y/n)? n
fatal: unable to create
'.git/objects/pack/pack-d634271f4d7ca70c00148e967a343c3c46cd7705.idx':
=46ile exists
