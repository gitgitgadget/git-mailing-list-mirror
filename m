From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] reflog: silence -O3 -Wuninitialized warning
Date: Wed, 16 Mar 2011 04:47:03 -0500
Message-ID: <20110316094639.GA8180@elie>
References: <20110316024959.GA24932@elie>
 <7vfwqnabbi.fsf@alter.siamese.dyndns.org>
 <4D807E66.40504@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 10:47:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PznK7-00070A-Kh
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 10:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445Ab1CPJrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 05:47:11 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62117 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab1CPJrK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 05:47:10 -0400
Received: by ywj3 with SMTP id 3so581802ywj.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=DcZT/w2SWtf8QSsr+WP7b4UQVEi/KZ1WzedpFcVeBOo=;
        b=XrXI7qgd6Tkg5obas6gdYBw+o3lMl+DlFjrSE3zp3IS8LqxlbYBjHYZiLfC8gCwBGv
         TbNkKJBRvw3bFcbN+P1BCjdXQidmqHl6nqrlytcxRZLBZTv7pdO4aG1zMbwbQ+nrzu6g
         Qduz5AMz3BnnWEpJkGoktS2evWI2KbT5uCddw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PM/JN3mDL8YSAx0AeBPGJeudZishNRAzSVJH3uNcwoPCO2a2rnHHQ73TYaQpbh2nBK
         3JGtGAwcEXnhjwWIshYo9JpSzJSKQCB2vu8ApaCkCXCxT2TJc3rxMqxelMeSUZzkT5D2
         b/PoSdm9qzajMFaGXXtQGvO5Ifc0Mke8sBIr4=
Received: by 10.91.209.3 with SMTP id l3mr1170487agq.29.1300268829099;
        Wed, 16 Mar 2011 02:47:09 -0700 (PDT)
Received: from elie ([69.209.56.53])
        by mx.google.com with ESMTPS id x32sm1019014ana.12.2011.03.16.02.47.07
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 02:47:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D807E66.40504@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169128>

Johannes Sixt wrote:

> 	unsigned long expire = 0;

The main downside is that that prevents valgrind from discovering when
the variable really is used uninitialized.  But I do agree that

	unsigned long expire = expire;

is ugly, which is part of why I did not use the latter workaround in
this patch.

Since the makefile already controls what options are passed to msvc,
is there some simple way to suppress the warning from "expire =
expire"?  If not, I would find it tempting to make this and similar
examples look like "unsigned long expire;", treat the warning as
evidence that either

 - the code is too complicated or does not give sufficient hints
   to the compiler about control flow, or
 - the compiler has a bug

and use -Wno-uninitialized for -Werror builds.
