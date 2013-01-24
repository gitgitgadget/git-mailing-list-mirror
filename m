From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] Revoke write access to refs and odb after importing
 another repo's odb
Date: Thu, 24 Jan 2013 12:58:16 +0700
Message-ID: <CACsJy8B-mCBFF0YUCU5BRCRhHJjZDfQY9+9ETBrJzLOe=19NXA@mail.gmail.com>
References: <1358948067-2792-1-git-send-email-pclouds@gmail.com>
 <7v1udbj0kt.fsf@alter.siamese.dyndns.org> <51004A37.6040301@web.de> <7vwqv3fw2b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 06:59:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyFq8-0000Mf-Kw
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 06:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787Ab3AXF6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 00:58:48 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:39758 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab3AXF6r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 00:58:47 -0500
Received: by mail-ob0-f176.google.com with SMTP id v19so173200obq.35
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 21:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=KJl/3H1osYXjYucNoALfzfbtzKoVb28rK57i8vIxjlM=;
        b=Jq9JeZ3IRqQv7wTu9s86czxpibdBoSiCaQ0GLqc72EB8ytykTQWPTesHIKBScgLL+Z
         erl17WOMlby2elF0BcGq1CjrwMbXdIIQB38IbrBMNtuyvzGl2QodeZ67KXRIeGM7q451
         OvGiMKbLKRz1cXNrP9IOuxTOPQw7Rjq9fHj1m0NLWRgdC8xThaD9kw80bdMO6OXMTK+B
         sMuzt66Qk1Ob52/f5ej9At3Uviml/IrkjbOrxGrH+HNmhx1S7YFQqh7OehL8v6PCs8RS
         JnzmA/Hcgz6m7kDEVYKXL8pmCPYgdi7pZ8jXEEdN5vxq+3JdtirUgKTj2heQDaS1KNyl
         /nrA==
X-Received: by 10.60.8.134 with SMTP id r6mr589822oea.53.1359007126543; Wed,
 23 Jan 2013 21:58:46 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Wed, 23 Jan 2013 21:58:16 -0800 (PST)
In-Reply-To: <7vwqv3fw2b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214395>

On Thu, Jan 24, 2013 at 4:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>> This is a false positive. The merge algorithm picked a fast-forward
>> in a submodule as a proper merge result and records that in a
>> gitlink. But as Duy pointed out this could be easily fixed by
>> turning the readonly flag off in that case.
>
> I see that as "easily circumvented and not an effective protection",
> though.
>
> In theory, adding a gitlink to the index, removing a gitlink to the
> index and modifying an existing gitlink in the index to another
> gitlink in the index and writing the resulting in-core index out to
> the on-disk index should be allowed, even after objects from the
> submodule object database have contaminated our in-core object pool,
> as long as you do not run cache_tree_update().  I am not sure if that
> single loophole would be sufficient, though.

The problem is we don't know which entries are updated in index. We
don't keep track of them. And I think in the unpack-trees case, we
scape the whole index then copy over, making it look like the whole
index is updated (even with the same content). One way to check this
is verify the source of all non-gitlink entries in index before
writing to disk (only when readonly flag is on, of course).
sha1_object_info_extended() should help (or be extended to do the
job). Hmm.. if we do this, we could also verify if new sha-1 objects
do not refer to an external source, if so allow them to be created.
-- 
Duy
