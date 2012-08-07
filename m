From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v2 04/16] Modify write functions to prepare for other
 index formats
Date: Tue, 7 Aug 2012 14:50:39 +0200
Message-ID: <20120807125039.GB913@tgummerer>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-5-git-send-email-t.gummerer@gmail.com>
 <7v1ujk3iso.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 14:50:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyjFQ-00056W-Te
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 14:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542Ab2HGMun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 08:50:43 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44548 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997Ab2HGMum (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 08:50:42 -0400
Received: by wgbdr13 with SMTP id dr13so3826797wgb.1
        for <git@vger.kernel.org>; Tue, 07 Aug 2012 05:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+Oyj4pjYOUpJ0pzhzdkAenXqY9nFpnYYcGZo1PoWJfQ=;
        b=BxypBHqKnJMfE7WJiL92qDXyXRElBYgSFpDXFzWDM0MDCptgG7mfEsyqp+u3eZVD/G
         llVSEMG2U3VinydAoqp9Pcc7lbA0zhiNaXyXpZyU+4p3JyG16YThnu3izhkra8K8/fe0
         sye8OiJpxU3p1ptOyF7bawN8e2id7EGZifV9lsGwgXZaVae84ovLJIaDhFF25KhhhFfJ
         TLNVJLEbQ6qEFYYiEBsZ7Jp2UJ1IyQlpqv4lxgykjmpLy5XmBi1swLEjbdvUWZbbaEni
         zDXqtdLVhLgJmgu5m5WHqYwUk9c/7wE+Xtzx64pdNuUuMqKRVVVs5N6tA1MduPLigOPD
         e10Q==
Received: by 10.180.105.6 with SMTP id gi6mr27419161wib.4.1344343841054;
        Tue, 07 Aug 2012 05:50:41 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id eu4sm21166101wib.2.2012.08.07.05.50.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Aug 2012 05:50:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v1ujk3iso.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203028>



On 08/05, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > -static int ce_write(git_SHA_CTX *context, int fd, void *data, unsigned int len)
> > +static int ce_write_v2(git_SHA_CTX *context, int fd, void *data, unsigned int len)
> >  {
> 
> Mild NAK to name this function with any hint that it is for v2 only.
> The type of "data" is not "struct ondisk_index_entry_v2" and this is
> just a way to stream data to "fd" while hashing, which is similar in
> spirit to what csum-file.c "sha1file'"API does.  Perhaps we may want
> to update ce_write() interface to build on top of sha1file API?
> 
> At this step in the series, is it too early to split read-cache.c
> into two files, move all the v2 specific part to read-cache-v2.c,
> and keep static function names like write_index_ext_header() as they
> are?  After all, the main dispatch would become
> 
> > +int write_index(struct index_state *istate, int newfd)
> > +{
> > +	if (!istate->version)
> > +		istate->version = INDEX_FORMAT_DEFAULT;
> > +
> > +	return write_index_v2(istate, newfd);
> > +}
> 
> so read-cache-v2.c would need to export write_index_v2() but the
> functions to implement it like ce_write_entry() do not have to be
> exposed outside the file, no?

No I think it makes sense to split them at this point. I'll do it along
the lines of what Duy suggested with his patch. [1]

[1] http://thread.gmane.org/gmane.comp.version-control.git/202923/focus=202964
