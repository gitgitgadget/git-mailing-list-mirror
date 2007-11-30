From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Some git performance measurements..
Date: Fri, 30 Nov 2007 01:54:13 +0100
Organization: At home
Message-ID: <finmvm$da8$1@ger.gmane.org>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org> <alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org> <alpine.LFD.0.99999.0711282244190.9605@xanadu.home> <alpine.LFD.0.9999.0711282022470.8458@woody.linux-foundation.org> <alpine.LFD.0.99999.0711291208060.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 30 02:01:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxuFS-0000t3-HW
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 02:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934257AbXK3BAe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Nov 2007 20:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934242AbXK3BAe
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 20:00:34 -0500
Received: from main.gmane.org ([80.91.229.2]:52161 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934226AbXK3BAb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 20:00:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IxuD0-0003PK-JJ
	for git@vger.kernel.org; Fri, 30 Nov 2007 00:58:22 +0000
Received: from abvh222.neoplus.adsl.tpnet.pl ([83.8.205.222])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 00:58:22 +0000
Received: from jnareb by abvh222.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 00:58:22 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvh222.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66587>

<opublikowany i wys=B3any>

[Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,=20
 Linus Torvalds <torvalds@linux-foundation.org>]

Nicolas Pitre wrote:

> Well, see below for the patch that actually split the pack data into=20
> objects of the same type.  Doing that "git checkout" on the kernel tr=
ee=20
> did improve things for me although not spectacularly.

> +static int sort_by_type(const void *_a, const void *_b)
> +{
> +     const struct object_entry *a =3D *(struct object_entry **)_a;
> +     const struct object_entry *b =3D *(struct object_entry **)_b;
> +
> +     /*
> +      * Preserve recency order for objects of the same type  and reu=
sed deltas.
> +      */
> +     if(a->type =3D=3D OBJ_REF_DELTA || a->type =3D=3D OBJ_OFS_DELTA=
 ||
> +        b->type =3D=3D OBJ_REF_DELTA || b->type =3D=3D OBJ_OFS_DELTA=
 ||
> +        a->type =3D=3D b->type)
> +             return (a < b) ? -1 : 1;
> +     return a->type - b->type;
> +}

> +     qsort(sorted_by_type, nr_objects, sizeof(*sorted_by_type), sort=
_by_type);

Isn't there a better way to do this sorting? What is needed here is
(stable) _bucket_ sort / _pigeonhole_ sort (or counting sort), which
is O(n); quicksort is perhaps simpler to use, but I'm not sure if
faster in this situation.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
