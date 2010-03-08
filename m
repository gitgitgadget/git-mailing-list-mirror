From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-core: conflictstyle=diff3 doesn't actually use diff3
 compatible format
Date: Sun, 7 Mar 2010 22:54:54 -0600
Message-ID: <20100308045454.GA22672@progeny.tock>
References: <20100305215253.364.63583.reportbug@localhost>
 <20100305221950.GB5083@progeny.tock>
 <7vpr3itn89.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Monnier <monnier@iro.umontreal.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 05:55:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoV01-0003wc-VX
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 05:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800Ab0CHEzB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 23:55:01 -0500
Received: from mail-iw0-f202.google.com ([209.85.223.202]:41706 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab0CHEzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 23:55:00 -0500
Received: by iwn40 with SMTP id 40so639131iwn.1
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 20:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8TaC+2YPD+MbZNZzIQVK+xlOSj8VOW4MzW+XU4YoDM8=;
        b=wlxhYb4FvLp28T9AmeqQHrfD8BPC9299DsmzolbWtWwkduk+x5453PIg18CKeBbvby
         6WyrOk10ovP5lm4YSUcpx8hdRUthuolkOeVG+OoGND9oASreg6qKguRHpJFld+WFAF4x
         1QqPuBEfwuL9LnRBR4JHN49o8ZrVLN2wW1gYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=J0No62THo66q5h2alhxNqNlXhswFO1+RAoVsnBaZEexXcVTIVUnG9du8d6McF/5erX
         CdoDaHdkvGGPtZOoNKnpB592NWrDdKHPpKdQDDUWYqVuchPdT/XuttjrJGnS7TxCLQ7z
         OShJzwprebHX+ystJeBml4L2POK+LSVfCkLs4=
Received: by 10.231.169.144 with SMTP id z16mr303310iby.25.1268024098869;
        Sun, 07 Mar 2010 20:54:58 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm4247766iwn.11.2010.03.07.20.54.56
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 20:54:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vpr3itn89.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141750>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> I=E2=80=99d be interested to hear from xdiff people
>> whether it should be easy to add the ancestor name to the output.
>
> I don't think there was any xdiff people involved in this area.
>=20
> I suspect that our tools actually rely on the common ancestor markers=
 not
> having any extra cruft after them, so it would be introducing a bug i=
f you
> change this output without changing the places that read them (I know
> about "rerere", but there may be others).

I guess the relevant xdiff person was you. ;-)

Thank you for the quick response.  On the xdiff level, it looks like
all that is needed is to pass the ancestor label as a member of struct
s_xmparam, and then fill_conflict_hunk() could respect that.  Not
complicated at all.

=46or merge_trees() users, the ancestor label could be passed with
branch1 and branch2 in struct merge_options.

That leaves the question of merge_recursive().  With merge_recursive(),
there is more than one ancestor, so it is not completely clear what the
diff3 merge should do.  Currently it writes something like this:

 <<<<<<< HEAD
 Conflict resolution is hard;
 let's go shopping.
 |||||||
 <<<<<<< Temporary merge branch 1
 Who knows whose this is?
 |||||||
 Ancient history.
 =3D=3D=3D=3D=3D=3D=3D
 Another intermediate result.
 >>>>>>> Temporary merge branch 2
 =3D=3D=3D=3D=3D=3D=3D
 Git makes conflict resolution easy.
 >>>>>>> topic

which is hard to read [1].  Probably it would be better to use a consol=
idated
common ancestor, by cocatenating the internal common ancestors; in this
simple case, that would look like this:

 <<<<<<< HEAD
 Conflict resolution is hard;
 let's go shopping.
 ||||||||
 Ancient history.
 =3D=3D=3D=3D=3D=3D=3D=3D
 Git makes conflict resolution easy.
 >>>>>>>> topic

What should be the label of this possibly fictional merge base?

Jonathan

[1] For people and for rerere.  See http://bugs.debian.org/569645
