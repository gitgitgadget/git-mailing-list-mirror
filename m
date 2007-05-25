From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Enhance unpack-objects for extracting large objects
Date: Fri, 25 May 2007 12:49:08 -0700
Message-ID: <56b7f5510705251249u74b754f1y4f8cafd5f5c35f19@mail.gmail.com>
References: <46569C37.5000201@gmail.com>
	 <7vsl9kr9mz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 21:49:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrfn1-0000hw-Mg
	for gcvg-git@gmane.org; Fri, 25 May 2007 21:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbXEYTtL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 15:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754301AbXEYTtL
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 15:49:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:24362 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbXEYTtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 15:49:09 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1194796ugf
        for <git@vger.kernel.org>; Fri, 25 May 2007 12:49:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f7Gd5r6KWLqhi5w/HwT2yRsi3iQMm608xN1/3alXs2/jxfueEkYnszUPssnAAZ2dh8Aq0Pb/zMC7kJKws9b7ThkDj+lMuwVjTEMdUCU4yoxxerdVMB1bqAPj2PTlsoFa++gC5rMw1dh65u71DZQr1yjk4A+gDtGLxa1s9VL5Diw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bf0Kdw7p7ce28zCgllLsG7ZBP5NRUNTLetyqcv+msBJwXS1dbVgdCLumlCv4QDLaiRCRD0cZQDZilbpaudNgjesBzwOtYcB6VnNnHJrEkiVU6bdoIWKwH1x94stdT7Ll5np7Tl/MyDQv7fnaWjGtiloVEh02FDoav+Z53g08u20=
Received: by 10.78.205.7 with SMTP id c7mr1045706hug.1180122548557;
        Fri, 25 May 2007 12:49:08 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Fri, 25 May 2007 12:49:08 -0700 (PDT)
In-Reply-To: <7vsl9kr9mz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48402>

On 5/25/07, Junio C Hamano <junkio@cox.net> wrote:
> Dana How <danahow@gmail.com> writes:
> > Nicolas Pitre wrote:
> >> I wouldn't mind a _separate_ tool that would load a pack index,
> >> determine object sizes from it, and then extract big objects to write
> >> them as loose objects ...
> >
> > Below we add two new options to git-unpack-objects:
> >
> > --min-blob-size=<n>::  Unpacking is only done for objects
> > larger than or equal to n kB (uncompressed size by Junio).
>
> Elsewhere you wanted to use --max-* and that was counted in megs;
> isn't using kilo here and meg there inconsistent?
For git-repack --max-pack-size=N I used MB to be consistent
with git-fast-import.  I think it makes sense to use MB everywhere
we talk about packfile size.

For the old degunking patch's -max-blob-size=N ,  and this patch's
-min-blob-size=N ,  I was using KB to describe blob size.
It looked like I needed finer granularity,  at least for experiments.

I think if we always use MB for packfile sizes, and KB
for blob sizes,  we should be OK.

> > --force::  Loose objects will be created even if they
> > already exist in the repository packed.  This is an option
> > I've wanted before for other reasons.
>
>         ... but if they already exist in the repository as loose
>         objects, do not replace it.
>
> Usually we do not overwrite existing loose objects and it is one
> of the security measure --- if you have an object already, that
> cannot be touched by somebody who maliciously creats a hash
> colliding loose object and tries to inject it into your
> repository via unpack-objects.  It's good that you kept this
> behaviour intact.
I agree.
I'll add the "... but" part to the corrected patch's commit msg.

> > -Objects that already exist in the repository will *not* be unpacked
> > -from the pack-file.  Therefore, nothing will be unpacked if you use
> > -this command on a pack-file that exists within the target repository.
> > +By default,  objects that already exist in the repository will *not*
> > +be unpacked from the pack-file.  Therefore, nothing will be unpacked
> > +if you use this command on a pack-file that exists within the target
> > +repository,  unless you specify --force.
> I would want to add:
>         If an object already exists unpacked in the repository,
>         it will not be replaced with the copy from the pack,
>         with or without `--force`.
OK, that's clearer.

> > -static const char unpack_usage[] = "git-unpack-objects [-n] [-q] [-r] < pack-file";
> > +static const char unpack_usage[] =
> > +"git-unpack-objects [-n] [-q] [-r] [--force] [--min-blob-size=N] < pack-file";
>
> Maybe we would want to call it '-f' for consistency.  Another
> possibility is the other way around, giving others a longer
> synonyms, like --quiet, but this command is plumbing and I do
> not think long options matters that much, so my preference is to
> do '-f' not '--force'.
I picked the longer one only because I didn't view it as frequently used.
But it will be more used than min-blob-size.  I'll change it to -f.

>  * You already have the size here, so if min_blob_size is set
>    and the size is larger, you do not even have to call
>    write_sha1_file() at all.
The way I read the code,  it looks like unpack-objects needs
the last argument always to be initialized with the SHA-1 computed
from the object contents.  Therefore I always need to call
write_sha1_file(),  even if I don't want it to write anything.

> So "ignore" means:
>         negative:       never write it out, even if it does not exist.
>         zero:           do not write it out if it is available (in pack,
>                         or loose, either local or alternate), do
>                         write it out otherwise; it is the same
>                         as the current behaviour of write_sha1_file().
>         positive:       always write it out.
> That does not sound like "ignore".
I agree "ignore" is confusing;
I will change it to "when",  which is more consistent with the
_maybe prefix on the function name.

> My suggestion would be:
I like this suggestion,  but since I need to call the function
to get the SHA-1,  I don't think I can follow it.

I'll send you an updated patch in a moment.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
