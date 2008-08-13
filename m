From: "Dana How" <danahow@gmail.com>
Subject: Re: pack operation is thrashing my server
Date: Wed, 13 Aug 2008 10:13:00 -0700
Message-ID: <56b7f5510808131013t4edfd31ar195177c82a91f93e@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	 <20080811030444.GC27195@spearce.org>
	 <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
	 <87vdy71i6w.fsf@basil.nowhere.org>
	 <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
	 <alpine.LFD.1.10.0808131024460.4352@xanadu.home>
	 <3E057C8D-FF72-47A2-BBA8-27A22AD67167@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, "Andi Kleen" <andi@firstfloor.org>,
	"Ken Pratt" <ken@kenpratt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	danahow@gmail.com
To: "Geert Bosch" <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 19:14:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTJvE-0006cz-UK
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 19:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbYHMRNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 13:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752223AbYHMRNE
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 13:13:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:44145 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbYHMRNC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 13:13:02 -0400
Received: by nf-out-0910.google.com with SMTP id d3so37958nfc.21
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 10:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hZT81hOvAIUcfATmhxyB1ZV5IUvTNy1+y2+tTePffkE=;
        b=gVRBZkQSAW9mx4wdw3ZRBni/Fm8QYhZLYjENmvRo82XaFtJBFUxYFPVvfJx1j9mHNJ
         eZfSMBgRVNdaMYvekrKkxwTQCbhsSIeYPFSYf19NV9jx8qf1iv7Ce63vDmTR/3/2I6NJ
         eEDonogB75jq5Zhrv12FUOs+om1mwyDQFzDjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VPbLUfv18VovJhIwDAGQAQKrZUpShSLkZFNXdXBSlFWqVUo5G9eMpQSmXGmf+Z2+d8
         uF1oU2ZLOHSKELiIe2ez3hw9z6TFs6lTFXthoIs8uFOv9N1OSHKFGaWWUqvmGVBhUgZF
         EFC0At/9A9G4xcdC8M596xZJzzWilrQRXnhPA=
Received: by 10.210.89.4 with SMTP id m4mr59003ebb.132.1218647580952;
        Wed, 13 Aug 2008 10:13:00 -0700 (PDT)
Received: by 10.210.139.2 with HTTP; Wed, 13 Aug 2008 10:13:00 -0700 (PDT)
In-Reply-To: <3E057C8D-FF72-47A2-BBA8-27A22AD67167@adacore.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92244>

Hi Geert,

I wrote the blob-size-threshold patch last year to which
Jakub Narebski referred.

I think there will eventually be a way to better handle large
objects in Git.  Some possible elements:
* Loose objects have a format which can be streamed
  directly into or out of packs.  This avoids a round-trip through zlib,
  which is a big deal for big objects.  This was the effect of the "new"
  loose object format to which Shawn referred.  This was
  removed apparently because it was ugly and/or difficult
  to maintain,  which I didn't understand since I didn't personally
  suffer.
* Loose objects actually _are_ singleton packs,  but saved
  in .git/objects/xx.  Workable,  but would never happen due to
  the extra pack header at the beginning it would add.  This
  takes advantage of the existing pack-to-pack streaming.
* Large loose objects are never deltified and/or never packed.
  The latter was the focus of my patch.
* Large loose objects are placed in their own packs in .git/packs .
  Doesn't work for me since I have too many large objects,
  thus slowing down _all_ pack operations.
All this is complicated by the dual nature of packfiles --
they are used as a "wire format" for serial transmission,
as well as a database format for random access.

The "magic" entropy detection idea is cute,  but probably not
needed -- using the blob size should be sufficient.  Trying to
(re)compress an incompressible _smallish_ blob is probably
not worth trying to avoid,  and any computation on sufficiently large
blobs should be avoided.

Hopefully I can return to this problem after New Year's.  And
perhaps with the expanding Git userbase,  more people will have
"large blob" problems ;-) and there will be more interest in
better addressing this usage pattern.

At the moment,  I am thinking about how to better structure
git's handling of very large repositories in a team entirely
connected by high-speed LAN.  It seems a method where
each user has a repository with deep history,  but shallow
blobs,  would be ideal,  but that's also very different from
how git does things now.

Have fun,

Dana How

On Wed, Aug 13, 2008 at 9:01 AM, Geert Bosch <bosch@adacore.com> wrote:
> On Aug 13, 2008, at 10:35, Nicolas Pitre wrote:
>>
>> On Tue, 12 Aug 2008, Geert Bosch wrote:
>>
>>> I've always felt that keeping largish objects (say anything >1MB)
>>> loose makes perfect sense. These objects are accessed infrequently,
>>> often binary or otherwise poor candidates for the delta algorithm.
>>
>> Or, as I suggested in the past, they can be grouped into a separate
>> pack, or even occupy a pack of their own.
>
> This is fine, as long as we're not trying to create deltas
> of the large objects, or do other things that requires keeping
> the inflated data in memory.
>
>> As soon as you have more than
>> one revision of such largish objects then you lose again by keeping them
>> loose.
>
> Yes, you lose potentially in terms of disk space, but you avoid the
> large memory footprint during pack generation. For very large blobs,
> it is best to degenerate to having each revision of each file on
> its own (whether we call it a single-file pack, loose object or whatever).
> That way, the large file can stay immutable on disk, and will only
> need to be accessed during checkout. GIT will then scale with good
> performance until we run out of disk space.
>
> The alternative is that people need to keep large binary data out
> of their SCMs and handle it on the side. Consider a large web site
> where I have all scripts, HTML content, as well as a few movies
> to manage. The movies basically should be copied and stored, only
> to be accessed when a checkout (or push) is requested.
>
> If we mix the very large movies with the 100,000 objects representing
> the webpages, the resulting pack will become unwieldy and slow even
> to just copy around during repacks.
>
>> You'll have memory usage issues whenever such objects are accessed,
>> loose or not.
>
> Why? The only time we'd need to access their contents for checkout
> or when pushing across the network. These should all be steaming operations
> with small memory footprint.
>
>>  However, once those big objects are packed once, they can
>> be repacked (or streamed over the net) without really "accessing" them.
>> Packed object data is simply copied into a new pack in that case which
>> is less of an issue on memory usage, irrespective of the original pack
>> size.
>
> Agreed, but still, at least very large objects. If I have a 600MB
> file in my repository, it should just not get in the way. If it gets
> copied around during each repack, that just wastes I/O time for no
> good reason. Even worse, it causes incremental backups or filesystem
> checkpoints to become way more expensive. Just leaving large files
> alone as immutable objects on disk avoids all these issues.
>
>  -Geert
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Dana L. How danahow@gmail.com +1 650 804 5991 cell
