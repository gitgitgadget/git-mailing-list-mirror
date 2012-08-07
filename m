From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v2 08/16] Make in-memory format aware of stat_crc
Date: Tue, 7 Aug 2012 21:02:45 +0200
Message-ID: <20120807190245.GA867@tgummerer.surfnet.iacbox>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-9-git-send-email-t.gummerer@gmail.com>
 <7vobmo23n8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 21:03:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Syp3U-0002Bo-Sg
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 21:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412Ab2HGTCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 15:02:55 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64277 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641Ab2HGTCy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 15:02:54 -0400
Received: by pbbrr13 with SMTP id rr13so94560pbb.19
        for <git@vger.kernel.org>; Tue, 07 Aug 2012 12:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=S7Y64Gu8E70Ld8sYpvCt0L7oqw4gOCVSvXxkmlZJKJs=;
        b=gCO8FiOBZ9BmJWuv0NMkXa/SjYMc/nYT1eofKixLSwLrM1S7adUKMN75UJPsAiq9Zj
         MsTSSsqPYZMJ8m6b5WT6m2sJAireHB0x1yyTqxZIEYOL/mJWB8YxEXeKms/nTNWea7o0
         YIzOhL5sm+aQGthLvPK8nScwPvbWKqr3aoCofnT6eVDzCQQrPHWXL27YkrdRUOq2PGpt
         RZ783CjXvwpTtMjJZPsmkK8F/7Blm9RlhH3T+6al6xuLm8kIDi/7pJN9pGsE/Lnpwsef
         Ti3i4UXgIYiN0FCWpEtdhi1KebtzAEmuCoGHpgt/DRJ+uSR4QAnau05wlPjQSsj0AWVN
         0E/g==
Received: by 10.68.196.225 with SMTP id ip1mr29946725pbc.6.1344366174410;
        Tue, 07 Aug 2012 12:02:54 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPS id qx8sm8252877pbc.63.2012.08.07.12.02.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Aug 2012 12:02:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vobmo23n8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203036>

On 08/05, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > +	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
> > +	stat = htonl(ce->ce_ino);
> > +	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
> > +	stat = htonl(ce->ce_size);
> > +	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
> > +	stat = htonl(ce->ce_dev);
> > +	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
> > +	stat = htonl(ce->ce_uid);
> > +	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
> > +	stat = htonl(ce->ce_gid);
> > +	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
> > +	return stat_crc;
> 
> What are these (Bytef *) casts are about?  We do not use it in any
> of our existing calls to crc32().

>From a quick look over the existing calls, their argument is
always either a void* or a char* pointer.  Using pointers other
than those two or Bytef* gives compiler warnings.  I can cast
to either void* or char* if that's preferred.
