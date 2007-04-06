From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 09/13] drop objects larger than --blob-limit if specified
Date: Fri, 6 Apr 2007 11:09:16 -0700
Message-ID: <56b7f5510704061109n2878a221p391b7c3edba89c63@mail.gmail.com>
References: <56b7f5510704051536s7de9638fs8cd811d580f6a7dc@mail.gmail.com>
	 <alpine.LFD.0.98.0704052103410.28181@xanadu.home>
	 <56b7f5510704051919v7daac590m6ac52c4fcabd5321@mail.gmail.com>
	 <alpine.LFD.0.98.0704052257200.28181@xanadu.home>
	 <Pine.LNX.4.64.0704060845120.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, "Junio C Hamano" <junkio@cox.net>,
	git@vger.kernel.org, danahow@gmail.com
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 06 22:01:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZssD-0007l9-EF
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 20:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993040AbXDFSJT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 14:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993049AbXDFSJT
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 14:09:19 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:64154 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993040AbXDFSJR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 14:09:17 -0400
Received: by nz-out-0506.google.com with SMTP id s1so564288nze
        for <git@vger.kernel.org>; Fri, 06 Apr 2007 11:09:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pIiDk4mD2hqXcH7Pu2TtnisVbfO2NIVVRf/WLeFKN/0WUxfDQcCmqK7LM1Iq6lDNtLEQ8ew2V/vJ1vQ1Y7xdIVfkQPfvdlOkX+mDhnlE2oQZZN9Ad4AwfHhE4YvuVbKuH5dX+9/Ta3SDj1vFhVPJ86wJ0e4PJtKV3A9nUWMZFZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KDTnAEuZ8HfuWPDopjSvXrAUF21Sp/hFVtW8yjUb2Nx52Ft4LyzrRal2ZHJNcFsvv585J5maWfqMOM5DNrmleCGQgpzh4twFUZXcsevoTCS+Gdju5OlGDxbIJXO0LjuK3Q/mfSq7WMU3AC72O11yZBhcmMEOOQLRVV2RC2zwQNY=
Received: by 10.114.168.1 with SMTP id q1mr1291542wae.1175882956333;
        Fri, 06 Apr 2007 11:09:16 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Fri, 6 Apr 2007 11:09:16 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704060845120.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43917>

On 4/6/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Thu, 5 Apr 2007, Nicolas Pitre wrote:
> > > (2) Pack the object any way and let the packfile size exceed
> > >     my specification.  Ignoring a clear preference from the user
> > >     doesn't seem good.
> > It is not indeed.
>
> Well, I think there is an easy solution.
>
> Just go back and say that when the user limits the size, it limits the
> offset at which objects can *start*.
Yes,  this is what my original, unsplit patch did in order to support
the --pack-limit && --stdout combination, since lseek doesn't
always work on stdout.

> Not only is that the only thing that the index file itself cares about, it
> also means that
>
>  - you don't ever need to undo anything at all (because you know the
>    starting offset) when you begin packing a new object.
Yes, that was true.

>    This should simplify your patch a lot.
It removes the calls to, and the additions of, sha1mark() and sha1undo()
in csum-file.[ch].  The changes to builtin-pack-objects.c are almost
the same -- an "if" moves from after the write_object() to before.

>  - the object size issue just goes away. Sure, the pack-file limit looks a
>    bit strange (it's no longer a hard limit on the *size* of the
>    pack-file, just on the object offsets), but let's face it, we really
>    really don't care.
>
> And in practice, by setting the pack-file limit to 2GB (or even 1GB), you
> never ever have to worry about the 32-bit filesystem limits any more,
> unless your repository is fundamentally so screwed that you simply
> *cannot* reporesent it well on something like FATFS (ie any object that is
> 2GB in size will probably have a blob that is even bigger, and FATFS
> already has problems with it).
>
> So in practice, just limiting the index offsets is what you really want
> anyway.
I agree with your arguments, but packs have different uses
and to me there are several differing (non-)reasons for --pack-limit.
* To split packs into smaller chunks when the .pack format is used as a
  communications protocol. But the discussion has converged to
  "we're not going to split packs at the transmitter". I agree with this
  conclusion,  since it would make the total transmission larger (loss
of deltas).
  Since no .idx file is sent there is no requirement for --pack-limit here.
* To avoid offsets larger than 31 bits in .idx files.  Your proposal,
  and what I was doing for --pack-limit && --stdout, is sufficient to
address this.
* Avoiding (e.g.) 2GB+ files when none already exist in the repository --
  either the filesystem doesn't support anything beyond the limit,
  or we don't want to use a >31b off_t with mmap.  (Perhaps
  the latter case is completely avoided by some glibc 64b trickery,
  but is that always true?)  Only the write rollback approach can address this.
* Creating .pack files that fit on e.g. CDROM etc.
The 2nd and 3rd cases are what I'm thinking about,
which is why the first version of my patch did both.

Anyway, now that I understand Nicolas's issues with the patchset,
and realize I agree with his concerns, I'm going to let this percolate
a little bit until I've got the least number of added behaviors and
command line options.  At the moment I'm leaning towards killing my
--blob-limit idea, keeping --pack-limit based on rollback but with the
additional twist that the first object written to a packfile is never
"rolled back" [meaning (a) everything is packed to make Nicolas happy,
(b) any illegally-sized pack has only one object and could be removed
to make me happy, and (c) my patchset has one less bug], and
adding --index-limit which is what normal people might use on a large
repository [and could be made the default later].  So I think what you
discuss is the most common use for limiting.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
