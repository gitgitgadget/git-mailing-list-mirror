From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/3] index-pack: eliminate unlimited recursion in get_delta_base()
Date: Tue, 10 Jan 2012 20:03:56 +0700
Message-ID: <CACsJy8A-FOpjDeTpxMze7jouceWMJHND_V2fyV5pLNKF8xp8kQ@mail.gmail.com>
References: <1324901080-23215-1-git-send-email-pclouds@gmail.com>
 <1326081546-29320-4-git-send-email-pclouds@gmail.com> <7vvcokcwvt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 14:06:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkbP7-0003k8-V4
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 14:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267Ab2AJNEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 08:04:41 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36132 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756226Ab2AJNE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 08:04:29 -0500
Received: by bkvi17 with SMTP id i17so381043bkv.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 05:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5fwf5ZhGBeRCbmUXFaBvJui9QbPNMZ3cchYqQ3I4F+Q=;
        b=XfokmJ8sn8UjRlOsDqsMMbIhKeYWo8lrRo6ePStJgaWJIekf8UwAKkgebkl9O1psRv
         wQtekOI6VMoBHRMo+J699Dcqe3GoqgajgeDn0QwdQUjNrcy4uRnrD80VmjLRWn44jOhY
         qO/TNfMh/QmySE4YJoD6zbqN/3/GtHOu19tP0=
Received: by 10.204.156.83 with SMTP id v19mr8802321bkw.40.1326200667707; Tue,
 10 Jan 2012 05:04:27 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Tue, 10 Jan 2012 05:03:56 -0800 (PST)
In-Reply-To: <7vvcokcwvt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188247>

2012/1/10 Junio C Hamano <gitster@pobox.com>:
> In parse_pack_objects(), we have two passes. The first pass scans to
> enumerate the objects that appear in the pack and sift them into base and
> delta objects, and the second one starts from a base object, resolves its
> immediate children with find_unresolved_daltas(), but that function recurses
> many times, bound only by the number of objects in the pack, which is the
> issue you are trying to address with this series.
>
> I wonder if a cleaner approach is to change the loop in the second pass in
> such a way that (1) the function it calls resolves _only_ the immediate
> children of the object we know its final shape (either because the object
> was recorded in the deflated form in the pack, or we have already resolved
> it in earlier iteration), and (2) the loop goes over the objects[] array
> not just once, but until we stopped making progress.

So basically:

 - remove the recursion code from get_base_data()
 - update find_unresolved_deltas() to mark resolved objects handled
 - put find_unresolve_deltas() call into a loop to go through all
unhandled objects

correct? Yeah I think it's simpler than current code.

> It would require us to be able to tell, by looking at objects[i], if the
> object itself has already been handled (perhaps you can look at its
> idx.sha1 field for this purpose) and if we have already handled its
> immediate delta children (you may need to add a bit to struct object_entry
> for this).
-- 
Duy
