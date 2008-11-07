From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] pack-objects: honor '.keep' files
Date: Thu, 06 Nov 2008 16:30:28 -0800
Message-ID: <7v8wrwidi3.fsf@gitster.siamese.dyndns.org>
References: <-RiFxYEd9Wiq2fWX74zYGUiEwrzLeoFDb1KuG3-Xo-s@cipher.nrlssc.navy.mil>
 <LSyxMgVV7zAWRvSezvxyUc6-kz2gK6MRVKonKSf1pAmdqO-jeuMFIw@cipher.nrlssc.navy.mil> <GV8cY3fn8l5UV5cNoPN8bHchWt9u2tbZ8j_ypkiY-ZLfO1tx9d7ebA@cipher.nrlssc.navy.mil> <HBFmgmcvgPzZ0xq-fRUt98ZOBXGCvwxHGyEwF9bNcgpDgS-t-D3viw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Nov 07 01:32:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyFH1-0003ia-8C
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 01:32:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815AbYKGAav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 19:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324AbYKGAav
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 19:30:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50984 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807AbYKGAau (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 19:30:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0CDDA921DB;
	Thu,  6 Nov 2008 19:30:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9C596921D3; Thu, 
 6 Nov 2008 19:30:30 -0500 (EST)
In-Reply-To: <HBFmgmcvgPzZ0xq-fRUt98ZOBXGCvwxHGyEwF9bNcgpDgS-t-D3viw@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu, 06 Nov 2008 17:22:41 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 534F436C-AC63-11DD-8E9A-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100272>

Brandon Casey <casey@nrlssc.navy.mil> writes:

>   <-a>
>     -create a new pack containing all objects required by the repository
>      including those accessible through alternates, but excluding objects
>      in _local_ packs with .keep

I have a feeling that it is debatable if this "fattening to dissociate
from alternates" is what people want.

>   <-a -l>
>      -Restrict operation to only local objects. Only has any effect with -a|-A.
>      -Like -a, but additionally exclude objects in packs accessible through
>       alternates.

Presumably you meant "exclude objects accessible through alternates,
either in packs or in loose form"?  If so then I think it is a good thing
to have.

I am not sure if listing the behaviour by combination of flags is a good
way to start thinking about this.  Wouldn't it be more productive to list
what kinds of repacking are needed, and then label them with combination
of flags?  Otherwise you would miss a potentially useful operation that
cannot be expressed with the current set of flags you have.

I think the useful kinds are only these five:

 - scoop loose objects that exist in local repository into a new pack,
   without touching existing packs at all; exclude anything available in
   any existing pack or in alternate repository (either loose or packed);

 - pack everything that is needed by the local ref, except the ones that
   are borrowed from alternate repositories (either loose or packed), into
   a single new pack.  There are two variants of this: eject what is
   currently packed but unnecessary into loose format when existing local
   packs are replaced with the new pack, or lose them (i.e. -A).

 - fatten local repository by packing everything that is needed by the
   local ref into a single new pack, including things that are currently
   borrowed from alternates.  There are two variants of this: eject what
   is currently packed but unnecessary into loose format when existing
   local packs are replaced with the new pack, or lose them (i.e. -A).
