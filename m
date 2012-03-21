From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Wed, 21 Mar 2012 08:18:58 +0700
Message-ID: <CACsJy8C8Ds04Gr35xBgdjX+Wpm6vQB_qu4XYBz0_e+ugmNj1vA@mail.gmail.com>
References: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: elton sky <eltonsky9404@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 02:19:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAAD9-0006PI-Et
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 02:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758730Ab2CUBTb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Mar 2012 21:19:31 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:52889 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756314Ab2CUBTa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Mar 2012 21:19:30 -0400
Received: by wibhq7 with SMTP id hq7so767959wib.1
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 18:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Zi9SiwF62sZdwdF04T4z+Gu0i53LeT8KAGlSkBfYHIE=;
        b=YvKghSnm5ahgEPfm1V+WXid2X6UXa6XTqDjXNxrwkGWkEcVkKF98ISuUXPPo3fwWQL
         Tv6F789vZrLNsd0+X3IdaznTjbj+kvUPkS07yrhqYN1zCysG9VoAbAmichh5r64y2L4r
         I/N4ZYMs+FArFWEpfR6vbXsZ3sqeArPE+eyec/BJicSUCW6GnDQGRYCgjkRZYYTWGrD9
         yFi+fv11KzMa8WSZOD01Ejt5/EYiH8osL2YB9rkpDjakj5+qY2m6epXYqYFGIorRGz0k
         w+J9B/6Xbx5tqKc0hlane+jUn3D3p4StxHTxxqS/klljFaIBNkIOkCLAnY810hSCGh22
         9A+Q==
Received: by 10.180.24.4 with SMTP id q4mr33498961wif.7.1332292769182; Tue, 20
 Mar 2012 18:19:29 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Tue, 20 Mar 2012 18:18:58 -0700 (PDT)
In-Reply-To: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193556>

On Wed, Mar 21, 2012 at 6:10 AM, elton sky <eltonsky9404@gmail.com> wro=
te:
> From the idea, I realize the problem is that index is verified and
> rewritten on any operations which is unnecessary sometimes. And the
> objective is to reduce the number of operations to below logN.=C2=A0 =
As I
> am new to git, I=C2=A0 I couldn't give a detailed plan to this for no=
w. I
> should have gonna through more documents or codes but there's only on=
e
> week for application. So I have to jump up from nowhere :P

Understanding current index format would be a good start, I think:
Documentation/technical/index-format.txt. For reading index code, look
at read_index_from() in read-cache.c (many if not all index
manipulation are in this file)

> I got questions like: how each operations affect index?

=46or writing part, commands that call refresh_index() can update stat
info for many many entries. git-add, git-update, git-mv and git-rm can
add/remove entries from the index. Merge/checkout oeprations
(git-reset, git-checkout, git-merge..) can rewrite the whole index. I
think this proposal aims to speed up refresh_index and add/remove
operations, not the last one.

To speed up reading part (you can grep read_cache() to see how many
commands read index), you may need to do something with index
integrity check. Currently it calculates SHA-1 of the entire index,
then checks against the stored value at the end of index. Calculating
SHA-1 can be really expensive on big index.

> how cache tree data and index is stored?

Cache tree is stored as an optional index extension. It's also
documented in index-format.txt. Or you can look at cache-tree.[ch]
--=20
Duy
