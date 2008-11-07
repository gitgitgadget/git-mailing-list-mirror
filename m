From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2 3/3] pack-objects: honor '.keep' files
Date: Thu, 06 Nov 2008 19:17:49 -0600
Message-ID: <BgEXN35P6wpio928OZi_34hs22vqUQxIAIGxR5hR8LqmfPIyw565Mg@cipher.nrlssc.navy.mil>
References: <-RiFxYEd9Wiq2fWX74zYGUiEwrzLeoFDb1KuG3-Xo-s@cipher.nrlssc.navy.mil> <LSyxMgVV7zAWRvSezvxyUc6-kz2gK6MRVKonKSf1pAmdqO-jeuMFIw@cipher.nrlssc.navy.mil> <GV8cY3fn8l5UV5cNoPN8bHchWt9u2tbZ8j_ypkiY-ZLfO1tx9d7ebA@cipher.nrlssc.navy.mil> <HBFmgmcvgPzZ0xq-fRUt98ZOBXGCvwxHGyEwF9bNcgpDgS-t-D3viw@cipher.nrlssc.navy.mil> <7v8wrwidi3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 02:19:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyG0H-0006Xk-Ng
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 02:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbYKGBR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 20:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752657AbYKGBR7
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 20:17:59 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:38416 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbYKGBR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 20:17:58 -0500
Received: by mail.nrlssc.navy.mil id mA71HoaO016612; Thu, 6 Nov 2008 19:17:50 -0600
In-Reply-To: <7v8wrwidi3.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 07 Nov 2008 01:17:50.0078 (UTC) FILETIME=[A68459E0:01C94076]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100275>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>>   <-a>
>>     -create a new pack containing all objects required by the repository
>>      including those accessible through alternates, but excluding objects
>>      in _local_ packs with .keep
> 
> I have a feeling that it is debatable if this "fattening to dissociate
> from alternates" is what people want.

I'm not sure I understand you here.

Andreas has suggested previously that 'repack -a' should pack everything,
including objects in packs with .keep. Is that what you mean?

With my current understanding it seems that that would muddy the semantics
of repack. If -a does not honor packs with .keep, then would it be intuitive
to expect that adding -l (i.e. exclude alternate packed objects) _would_
honor .keep?

>>   <-a -l>
>>      -Restrict operation to only local objects. Only has any effect with -a|-A.
>>      -Like -a, but additionally exclude objects in packs accessible through
>>       alternates.
> 
> Presumably you meant "exclude objects accessible through alternates,
> either in packs or in loose form"?  If so then I think it is a good thing
> to have.

Would that be an enhancement to the current behavior? I don't think I saw
any mechanism to exclude packing remote loose objects.

The documentation for pack-objects --local says:

  --local
         This flag is similar to --incremental; instead of ignoring  all
         packed objects, it only ignores objects that are packed and not
         in the local object store (i.e. borrowed from an alternate).

It only mentions packed alternate objects.

> 
> I am not sure if listing the behaviour by combination of flags is a good
> way to start thinking about this.  Wouldn't it be more productive to list
> what kinds of repacking are needed, and then label them with combination
> of flags?  Otherwise you would miss a potentially useful operation that
> cannot be expressed with the current set of flags you have.

I agree. I made a list of the options because I was trying to understand what
effect each option had, then I turned it into an email.

> I think the useful kinds are only these five:
> 
>  - scoop loose objects that exist in local repository into a new pack,
>    without touching existing packs at all; exclude anything available in
>    any existing pack or in alternate repository (either loose or packed);
>
>  - pack everything that is needed by the local ref, except the ones that
>    are borrowed from alternate repositories (either loose or packed), into
>    a single new pack.  There are two variants of this: eject what is
>    currently packed but unnecessary into loose format when existing local
>    packs are replaced with the new pack, or lose them (i.e. -A).
>
>  - fatten local repository by packing everything that is needed by the
>    local ref into a single new pack, including things that are currently
>    borrowed from alternates.  There are two variants of this: eject what
>    is currently packed but unnecessary into loose format when existing
>    local packs are replaced with the new pack, or lose them (i.e. -A).

You didn't say when local .keep should be honored, i.e. objects in local
packs with .keep should be excluded from repacking. always, never, only
with -l, new repack option?

-brandon
