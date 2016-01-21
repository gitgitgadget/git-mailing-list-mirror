From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] unpack-trees: fix accidentally quadratic behavior
Date: Thu, 21 Jan 2016 15:59:44 -0500
Organization: Twitter
Message-ID: <1453409984.16226.46.camel@twopensource.com>
References: <1453349156-12553-1-git-send-email-dturner@twopensource.com>
	 <xmqq60ynzfyq.fsf@gitster.mtv.corp.google.com>
	 <1453403398.16226.40.camel@twopensource.com>
	 <xmqqpowuyall.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 21:59:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMMKe-0002zh-Nu
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 21:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbcAUU7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 15:59:49 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34592 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbcAUU7r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 15:59:47 -0500
Received: by mail-qk0-f176.google.com with SMTP id x1so21198403qkc.1
        for <git@vger.kernel.org>; Thu, 21 Jan 2016 12:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=UKs/fax+yFYuFB7y+cw2KbCYfzOsLXm4IfO5ScDDjZ4=;
        b=yKWUMNDNOHLa7DxXPg8vN33yThDna0g5UQ7z9DX8igVAXpuGtDaW65eHg1nICM7D98
         PbP9UGuBTiFapHKr4x06luHQWZDtCJU3RfXMJPNKFNna5F92eRGSF5fgU+7D7g+8DCn1
         UF3vPs4nPrnfPmqoGT/wOSwBZuwbKMK9Y2Y7OVVJssxKIJglO0kvOL6l+GElm5K86W+d
         M8mKfjC+BaSKSms4DNJ0XRNp9KD/GVmppDwHoE7uVFgqm4EDnrvg3f37Qjm6VCweKqF4
         fnoQdNqtfsOyDRLnOgbRNHpibMIyo/Iyql6vHXm/xFG86wIiU4vo3F302fzvOLG/ZojY
         jwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=UKs/fax+yFYuFB7y+cw2KbCYfzOsLXm4IfO5ScDDjZ4=;
        b=YyvqijVFj63tn6qh8iwiOsGHCOoe8Rak+rXf6PWNHjtGKv9Ry2+bZ3KxK/ZE8Y98dm
         CBd1qkx00oSqLwjdMy2/IMdBFw0iLeGzWZcdfJtn7M2lgdClkaBIN5Xqq211KlfT449x
         FpvGElb+/JF/NMkJR49YaYc1i9MEPjAoKlbOkmV4nEadcKV82mpFC/c4Zz4CJG9eD4As
         6d+ynKwYZW1PFZ2PZNRALmp4ELE6UEOBDoHHhC3Qef/XPIe/JYL4u/e9jQ+kTar/Meve
         DWgATM5OuDD3q0zRkUmozFQoCy+offmTyamHPfKhpvnffUdt6VHOrHPemL4+HQciSgPe
         +qsw==
X-Gm-Message-State: ALoCoQnUjnGlnCUQrjVWxbS9u0ZNgK3oMESZjxB89L9IqplU7+0pZWm8BMM/ttYytGMPZ1pwCKEP+cvgxIo5GITekJTn1SFZnw==
X-Received: by 10.55.217.26 with SMTP id u26mr54793997qki.13.1453409986846;
        Thu, 21 Jan 2016 12:59:46 -0800 (PST)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id e127sm1338120qkb.34.2016.01.21.12.59.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jan 2016 12:59:45 -0800 (PST)
In-Reply-To: <xmqqpowuyall.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284526>

On Thu, 2016-01-21 at 11:51 -0800, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > On Wed, 2016-01-20 at 20:58 -0800, Junio C Hamano wrote:
> > > David Turner <dturner@twopensource.com> writes:
> > > 
> > > > While unpacking trees (e.g. during git checkout), when we hit a
> > > > cache
> > > > entry that's past and outside our path, we cut off iteration.
> > > > 
> > > > This provides about a 45% speedup on git checkout between
> > > > master
> > > > and
> > > > master^20000 on Twitter's monorepo.  Speedup in general will
> > > > depend
> > > > on
> > > > repostitory structure, number of changes, and packfile packing
> > > > decisions.
> > > > 
> > > > Signed-off-by: David Turner <dturner@twopensource.com>
> > > > ---
> > > 
> > > I haven't thought things through, but does this get fooled by the
> > > somewhat strange ordering rules of tree entries (i.e. a subtree
> > > sorts as if its name is suffixed with a '/' in a tree object)?
> > > 
> > > Other than that, I like this.  "We know the list is sorted, and
> > > after seeing this entry we know there is nothing that will match"
> > > is
> > > an obvious optimization that we already use elsewhere.
> > > 
> > > Thanks.
> > 
> > I think this is correct, because we first do the more complicated
> > check
> > (ce_in_traverse_path), and only check the ordering once that has
> > failed.  
> 
> But the patch does this:
> 
> > +			if (info->prev && info->traverse_path) {
> > +				int prefix_cmp = strncmp(ce->name,
> > info->traverse_path, info->pathlen);
> > +				if (prefix_cmp > 0)
> > +					break;
> > +				else if (prefix_cmp == 0 &&
> > +					 ce_namelen(ce) >= info
> > ->pathlen &&
> > +					 strcmp(ce->name + info
> > ->pathlen,
> > +						 info->name.path)
> > > 0) {
> > +					break;
> > +				}
> > +			}
> >  			continue;
> 
> The first break is correct, but I am not sure about the "else if"
> part.  Shouldn't it be doing something similar to the logic to "keep
> looking" that talks about "t-i", "t" and "t/a" at the end of the
> loop?

Rather than doing more complicated logic, let's just do the first
check; it seems about as fast for our repo, and I think will usually be
so.  does that seem reasonable to you?

> > The tests all pass, so this should be good.
> 
> Please don't ever say that again.  

OK.
