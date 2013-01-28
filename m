From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 6/7] read-cache: refuse to create index referring to
 external objects
Date: Mon, 28 Jan 2013 12:48:26 +0700
Message-ID: <CACsJy8BJZgyEn1n2GWgAVSGhSkVUO-P=GXwR02OcDf0ziTTRaA@mail.gmail.com>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
 <1359016940-18849-6-git-send-email-pclouds@gmail.com> <7vpq0ubdec.fsf@alter.siamese.dyndns.org>
 <CACsJy8C3tLOHCK4Qc--W630do0M=xLKSMoYUxxv2_GDaUXaRww@mail.gmail.com> <7vpq0t3x60.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 06:49:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzhaq-0006DE-4P
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 06:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694Ab3A1Fs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 00:48:59 -0500
Received: from mail-oa0-f47.google.com ([209.85.219.47]:46290 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab3A1Fs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 00:48:57 -0500
Received: by mail-oa0-f47.google.com with SMTP id h1so2386296oag.20
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 21:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=mW7g7iRSBCeP2l7vpr+RUBv+djRvKjmswIGgC0YeboU=;
        b=Vvgotb3zG046cWDH5aVBiaQznT2U/f8eZi4Xn52dISquQ8qX9WuxoF9UvUe7p+LJH2
         hbcAjsg4aa0nadOG57OVj6DZY/Bkl3kovKMRygvr1IsRI2aHF1YkgyCxXPolXBXy+E0G
         JJSdBY5XLJmyAOeCZosiywvYKnX4b+mJNO0z+H1uydASvSnwo7aB7OkiVexN2COMSd3U
         7Z+VoTWIt6UINtJzZOmxboxOa1WoQiICWL3DOtxicHqKWAR4MnY/YxSWkUrXZoIOuMsB
         wQpEeQ1FSVa7nn3RjuPTzs6ENYUcj4KNbG+n6J30U5Zin+MZpjDVJ4udTsNg7UFqapSU
         dRWQ==
X-Received: by 10.182.159.5 with SMTP id wy5mr10322671obb.31.1359352137104;
 Sun, 27 Jan 2013 21:48:57 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Sun, 27 Jan 2013 21:48:26 -0800 (PST)
In-Reply-To: <7vpq0t3x60.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214805>

On Sat, Jan 26, 2013 at 2:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> This is not a tangent, but if you want to go this "forbid making our
> repository depend on objects we do not have but we know about after
> we peek submodule odb" route [*1*], write_sha1_file() needs to be
> told about has_sha1_file_proper().  We may "git add" a new blob in
> the superproject, the blob may not yet exist in *our* repository,
> but may happen to already exist in the submodue odb.  In such a
> case, write_sha1_file() has to write that blob in our repository,
> without the existing has_sha1_file() check bypassing it.  Otherwise
> our attempt to create a tree that contains that blob will fail,
> saying that the blob only seems to exist to us via submodule odb but
> not in our repository.

Another thing needs to be done for this to work. The current reading
order is packs first, loose objects next. If we create a local loose
duplicate of an alternate packed object, our local version will never
be read. Regardless the submodule odb issue, I think we should prefer
reading local loose objects over alternate packed ones.
-- 
Duy
