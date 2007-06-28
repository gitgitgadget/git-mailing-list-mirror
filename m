From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Bug: segfault during git-prune
Date: Thu, 28 Jun 2007 11:52:04 +0100
Message-ID: <200706281152.08591.andyparkins@gmail.com>
References: <200706281134.58453.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 28 12:52:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3rbm-0001Kz-9i
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 12:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760965AbXF1KwP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 28 Jun 2007 06:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760771AbXF1KwO
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 06:52:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:2410 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760056AbXF1KwN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jun 2007 06:52:13 -0400
Received: by ug-out-1314.google.com with SMTP id j3so549789ugf
        for <git@vger.kernel.org>; Thu, 28 Jun 2007 03:52:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mbtezUu75SlzWiK9g/R6eJBHZRjkmWxVLM5ttr6f251M4bPjkA6/7vvN69YPipjUZyR8AmcJdHaN7kik3l1X54I6k9fEKQ9zGJqPKiR6ffmAqM4G54FLo2jdIHctepP3gK+p6gcqUjuR0+/GMmuakjmf8rWmlqE6QNIpLSC/k5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ih2NGM1thZ+LGf5ganei+kUfH7y0afpCLOFVcnr27VO3RIcIVBrHEc+xczLUWp6HVIz7xNH/I5FL83tX55V/dh598omzRw1m0E5uHQVi+81y8HEiO+hHlve0K3YLNH++ccbS/ugMnN3Yw1wsQ4nLazpCdhCr/XM8yVqrOPQWcO8=
Received: by 10.82.189.6 with SMTP id m6mr3470513buf.1183027931325;
        Thu, 28 Jun 2007 03:52:11 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z37sm2829796ikz.2007.06.28.03.52.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jun 2007 03:52:10 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <200706281134.58453.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51093>

On Thursday 2007 June 28, Andy Parkins wrote:

> So, I think there are two faults: git-prune is deciding that the obje=
ct is
> a blob, when it's actually a commit; and git-prune's error handling i=
s
> broken in that case, because it's continuing with the NULL pointer re=
turned
> by check_commit() when obj->type !=3D OBJ_COMMIT.

I can't figure it out I'm afraid.  I've done a bit of back tracing and =
found
the block that's generating the error; object.c:150

  } else if (type =3D=3D OBJ_COMMIT) {
    struct commit *commit =3D lookup_commit(sha1);
    parse_commit_buffer(commit, buffer, size);
    if (!commit->buffer) {
      commit->buffer =3D buffer;
      eaten =3D 1;
    }
    obj =3D &commit->object;
  }
=09
Now, lookup_commit() is returning NULL because check_commit() is being =
called
with a struct object whose type field is not OBJ_COMMIT.  Which it pres=
umably
got from lookup_object().  gdb tells me the object returned by lookup_o=
bject()=20
is

 {parsed =3D 0, used =3D 0, type =3D 3, flags =3D 0,
  sha1 =3D "\"\217\200e=C2=B90\022\0165=C3=BC\f\025L#t\207=C2=AB\002=C3=
=96J"}

Which seems to be the right hash, 228f8065b930120e35fc0c154c237487ab02d=
64a.

What should I do next?  I don't understand why lookup_object() is retur=
ning
an object with type blob instead of with type commit, when git-cat-file=
 says=20
that same object is a commit.



Andy
--=20
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
