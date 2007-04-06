From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 08/13] prevent try_delta from using objects not in pack
Date: Fri, 6 Apr 2007 11:17:21 -0700
Message-ID: <56b7f5510704061117q2a833904g130246c164dd8e3f@mail.gmail.com>
References: <56b7f5510704051535ya98e86eu7f786f118c4fe229@mail.gmail.com>
	 <alpine.LFD.0.98.0704052100420.28181@xanadu.home>
	 <56b7f5510704051928l5d1f5a02yccc8e57c222e5f64@mail.gmail.com>
	 <alpine.LFD.0.98.0704052320560.28181@xanadu.home>
	 <56b7f5510704052047r30166e53kffbdd8bf71885264@mail.gmail.com>
	 <alpine.LFD.0.98.0704060859230.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Apr 06 21:59:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZt0H-0000nI-2z
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 20:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934136AbXDFSRX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 14:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934138AbXDFSRX
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 14:17:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:36037 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934136AbXDFSRW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 14:17:22 -0400
Received: by wr-out-0506.google.com with SMTP id 71so648357wri
        for <git@vger.kernel.org>; Fri, 06 Apr 2007 11:17:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cIcUwf9EW1LW2a4oplcXfCrBO6wuFUxmVykv/cTStOky++jWSBzTc9uzaB+QsRHK6qTLdkJZ5cDZD+djRWf50T3bLyMTbGRD/BC1DX54fDYfevKJPKEHdf2ldMx0hocOzabNCYUZaYR85v4KA3/WikrdncAg0mDDZX/oDkscNws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OYkmxebpD30XiPVZN/Ys1QXz2JjqxnUmJ/wkEFpKUxOQZ+tCgutQhe4XS+X9XGRNiFhbUOrN1qwBCdl3pg7AnEeepLN5zcTZMHqGOK3cOiNti3fUTEdK3CmAqxOs1V4cQoWS/Tv9GKWYN4G2R0lsnUjJbxOxtTRwVKo6G40UOrI=
Received: by 10.114.209.1 with SMTP id h1mr1296501wag.1175883441103;
        Fri, 06 Apr 2007 11:17:21 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Fri, 6 Apr 2007 11:17:21 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0704060859230.28181@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43915>

On 4/6/07, Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 5 Apr 2007, Dana How wrote:
> > Currently we have get_object_list -> traverse_commit_list ->
> > show_{commit,object} -> add_object_entry ,  which is all
> > called way before get_object_details -> check_object -> sha1_object_info .
> > Can I safely move the sha1_object_info calll earlier into
> > add_object_entry so I will know the size for pruning?
>
> I think so, yes.  And actually this call to sha1_object_info() has been
> bothering me for a while.
>
> There are currently two ways to get the list of objects to pack: one is
> from stdin where objects are listed with their SHA1's, the other one
> uses the internal revision walking code.  In the later case we _already_
> have the information that sha1_object_info() later provides making it
> rather wasteful by forcing a second object header parsing.
Perhaps I'll add the early call (or actually, re-use the info if I can find it),
and change the second call to only happen if the size is zero,
since that's how it starts out in the current add_object_entry.

> However... aren't you more interested in the _compressed_ blob size than
> its raw size?
Yes!  So I am leaning towards disposing of --blob-limit anyway,
which was in part a poor response to a bug in --pack-limit.
Please see the other email I sent out so far today.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
