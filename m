From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] upload-pack: avoid parsing objects during ref advertisement
Date: Tue, 29 Jan 2013 00:10:59 -0800
Message-ID: <CAJo=hJubUF2mmkzXU77kQ5uj1cbBZrnLcw2u736wMqxhs39jdQ@mail.gmail.com>
References: <7vipkpn87d.fsf@alter.siamese.dyndns.org> <20120106191740.GA12903@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 09:11:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U06ID-0001iW-49
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 09:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493Ab3A2ILV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 03:11:21 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:45387 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747Ab3A2ILU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 03:11:20 -0500
Received: by mail-ie0-f171.google.com with SMTP id 10so99052ied.16
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 00:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=rCECkpGR8zqU3OjdjP5Nwg2uxyaDqYnXfHasg3rZ9WM=;
        b=DJ2V1D5eAcrZ8OGRx4hSERWogROjIRe3pjtlrgoBOK237jdTkDlUodcgTV9El6P6tI
         vqwPLLsGBqSX5lVsR3clOVMO0sKzW2G2S730ClmXSf3svI1mdAFxzALVPhyNJXjckDOO
         uO5EGoIRD+ivP/H0jVul/bgkHcNXLxLaVvPPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-gm-message-state;
        bh=rCECkpGR8zqU3OjdjP5Nwg2uxyaDqYnXfHasg3rZ9WM=;
        b=JC9pIpA6IMTBom7XmewriSLxPPmlIiGxo6z46EdHl4opky8UNrUbciP2lCKngKCWUc
         Ct7NdrnMP+aMxnXU1/YdamENgUNQ3Et0mjwwKsEknzLZ32ja2cJzfnTgYb4jqjOdLrL7
         Vu8gGXYNBFuPi1HGOI+2qNfBZrtqgMsKu3wHdBTL+XRNAm3ewVeUTrLUk+piCDtI8yV7
         2e2u5u/5CgqTk3ItW89RqxJxvwhMxTW24pFxaCFubyN7slyPnhSjA69oYKvyHKMpVmz0
         BNip1gBfaaCWIZ/kmtL3rlqXdeXk/BNVgxeq7vsZqU6d5wgMKKUtCVl17ZDNqTgf1Quz
         XkfA==
X-Received: by 10.42.30.132 with SMTP id v4mr63524icc.34.1359447079922; Tue,
 29 Jan 2013 00:11:19 -0800 (PST)
Received: by 10.64.170.100 with HTTP; Tue, 29 Jan 2013 00:10:59 -0800 (PST)
In-Reply-To: <20120106191740.GA12903@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQmIg+zuZysXklwRzxBo1o+vX3NclrzJEYwjq4U0FaQkTdjCUMF3hQra28ENS2Yp7fecc32K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214911>

On Fri, Jan 6, 2012 at 11:17 AM, Jeff King <peff@peff.net> wrote:
> When we advertise a ref, the first thing we do is parse the
> pointed-to object. This gives us two things:
...
> The downside is that we are no longer verifying objects that
> we advertise by fully parsing them (however, we do still
> know we actually have them, because sha1_object_info must
> find them to get the type). While we might fail to detect a
> corrupt object here, if the client actually fetches the
> object, we will parse (and verify) it then.

As you explain, its not necessary to verify during the advertisement
phase. Its fine to delay verification to when a client actually
"wants" the object.

> On a repository with 120K refs, the advertisement portion of
> upload-pack goes from ~3.4s to 3.2s (the failure to speed up
> more is largely due to the fact that most of these refs are
> tags, which need dereferenced to find the tag destination
> anyway).

Why aren't we using the peeled information from the packed-refs file?
JGit does this and it saves a lot of time on advertisements from a
well packed repository.
