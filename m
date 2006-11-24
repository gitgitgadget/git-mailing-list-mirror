X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 0/4] Series short description
Date: Fri, 24 Nov 2006 15:37:31 +0000
Message-ID: <b0943d9e0611240737h572bc5f8g3e9b34edf22fe1a5@mail.gmail.com>
References: <20061123230721.9769.38403.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 24 Nov 2006 15:37:53 +0000 (UTC)
Cc: "GIT list" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uD5VriWUBWObsp6tv9IrX4lfVBSMSCzVOyBqn571pu/NnkvN/39M8ZphXximIAu6sT47wp/MuUViGrreTfWxPIE4z10Pi+xEoUGA/Y3hBwIsQllgQh3TiCDF7MFDEUFNkjIbaX2YbGkBOlGAEPvr90Kg4MopeHLPlbkBN/SDwtA=
In-Reply-To: <20061123230721.9769.38403.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32227>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnd7c-0000I6-PN for gcvg-git@gmane.org; Fri, 24 Nov
 2006 16:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934356AbWKXPhd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 10:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934951AbWKXPhd
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 10:37:33 -0500
Received: from nz-out-0102.google.com ([64.233.162.204]:23176 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S934356AbWKXPhc
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 10:37:32 -0500
Received: by nz-out-0102.google.com with SMTP id s1so465662nze for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 07:37:32 -0800 (PST)
Received: by 10.64.185.7 with SMTP id i7mr11689083qbf.1164382651840; Fri, 24
 Nov 2006 07:37:31 -0800 (PST)
Received: by 10.65.133.7 with HTTP; Fri, 24 Nov 2006 07:37:31 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
Sender: git-owner@vger.kernel.org

On 23/11/06, Yann Dirson <ydirson@altern.org> wrote:
> The following adds a --patch flag to "stg refresh".  I mainly needed it to
> edit the log message in patches down the stack, but with some work it could
> be used to record changes in another file and come back.
>
> That would require to pop patches with --keep,

pop_patches(keep=True) allows this (I already added it to your patch).
This option actually applies the reverse of the patch between the
current index and the bottom of the last patch to be popped. If it
fails, it doesn't affect the current tree and reports an error.

> and if we ask to only record
> a subset of the changes, we would need to implement "push --keep" first.

The "push --keep" is a bit more complicated to implement since it
would usually have to generate commits (pop doesn't need to) since
usually the base of the pushed patches might have changed (especially
with the refresh --patch). It is even more complicated if the changes
you want to preserve affect a file modified by the pushed patches.

A solution I see is to generate a temporary diff, push the patches you
want and fold this temporary diff (the diff can be temporarily written
to a local file so that you don't lose them in case of an error or
Ctrl-C). If the push fails (conflicts) or the diff no longer applies,
just undo the push and re-apply the diff. There is no way to simply
check whether all the patches apply (git-apply --check) since you
can't generate a single diff for all the pushed patches (which might
not be in the committed order).

-- 
