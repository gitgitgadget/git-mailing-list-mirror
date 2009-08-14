From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: Re: [PATCH] Fix "unpack-objects --strict"
Date: Fri, 14 Aug 2009 08:03:07 +0200
Message-ID: <20090814060307.GA31721@auto.tuwien.ac.at>
References: <20090813103231.GY14475@mail-vs.djpig.de> <20090813111933.GZ14475@mail-vs.djpig.de> <7vd46zbjae.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 08:03:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbpsk-0000i8-3t
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 08:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989AbZHNGDJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 02:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755987AbZHNGDJ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 02:03:09 -0400
Received: from odin.auto.tuwien.ac.at ([128.130.60.3]:58213 "EHLO
	mail.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755959AbZHNGDI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 02:03:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.auto.tuwien.ac.at (Postfix) with ESMTP id B0E0810C1C3F;
	Fri, 14 Aug 2009 08:03:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at odin.auto.tuwien.ac.at
Received: from mail.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (odin.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZtkmZ75xyFTf; Fri, 14 Aug 2009 08:03:07 +0200 (CEST)
Received: from thor.localdomain (thor.auto.tuwien.ac.at [128.130.60.15])
	by mail.auto.tuwien.ac.at (Postfix) with ESMTP id 9FA9C1000DC5;
	Fri, 14 Aug 2009 08:03:07 +0200 (CEST)
Received: by thor.localdomain (Postfix, from userid 3001)
	id 9A7D86800645; Fri, 14 Aug 2009 08:03:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd46zbjae.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125898>

On Thu, Aug 13, 2009 at 12:33:45PM -0700, Junio C Hamano wrote:
> diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
> index 557148a..109b7c8 100644
> --- a/builtin-unpack-objects.c
> +++ b/builtin-unpack-objects.c

What about this check:
> @@ -184,7 +184,7 @@ static int check_object(struct object *obj, int t=
ype, void *data)
>       if (!obj)
>  		return 0;

This is neccessary to skip already written objects (eg. blobs,
obj_list[i].obj =3D=3D NULL). The return code is not important in this
case.

I'm not sure, if fsck_walk can call check_object with obj =3D=3D NULL
under some (rare) conditions. If yes, the return code should be
changed to 1.

> We probably should write everything as they become unpackable (i.e. a=
s
> their delta bases becomes available) while keeping track of object na=
mes
> (but not data) of structured objects that we received, and running on=
ly
> one level of reachability check on them at the end.  That would certa=
inly
> reduce the memory consumption and may simplify the complexity of the =
code
> at the same time.

This would defeat the whole idea of the this check: If the
precondition (fsck returns OK for a repository) is met, unpack-objects
(and index-pack) with --strict should gurantee, that this is still
true after receiving the objects (even if somebody intentionally tries
to corrupt the repository).

As we assume, that all objects (and all their ancestors) already
present in the repository are OK, we only have to check new objects
and verify, that linked objects in the repository are of the correct
type.

As soon as we start to write objects without all linked objects
already present in the repository, the repository can get inconsistant.

Lets assume, unpack-objects/receive-pack is changed according to your p=
roposal:
* writeout all objects, as received
* checking reachability of new objects
* update refs, if everything is OK

Then a corruption HOWTO would be:

To introduce a object with one of its linked objects missing, left it
out of the pack and push it into the repository. unpack-objects will
unpack all objects and fail updating the ref (but leave all objects in
the repository). As second step, simply send a ref update request,
which should succed, as the object is present in the repository.

A variant: set the SHA1 of the missing object to the SHA1 of a object
of another type. In the second step, you can sent this object to
unpack-objects, which will unpack it, as it does not know, that the
object is already referenced in the repository.

Deleting objects in the case of an error is also not an option, as a
parallel push operation could have already used the object.

mfg Martin K=F6ger
