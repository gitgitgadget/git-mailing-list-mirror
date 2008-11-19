From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix handle leak in builtin-pack-objects
Date: Wed, 19 Nov 2008 14:30:52 +0100
Message-ID: <81b0412b0811190530m79a11b9dx3771b9679e53e9e@mail.gmail.com>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com>
	 <alpine.LFD.2.00.0811190740570.27509@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 14:32:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2nA9-00063b-1b
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 14:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbYKSNay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 08:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753028AbYKSNay
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 08:30:54 -0500
Received: from rv-out-0506.google.com ([209.85.198.228]:62217 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772AbYKSNax (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 08:30:53 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3405370rvb.1
        for <git@vger.kernel.org>; Wed, 19 Nov 2008 05:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GAPadRdGXSY4RT3MSR3Ke6bqHC1I61e21mCAdY893LQ=;
        b=ReLprnv5U4E0WVlIcP2eEcUTZJx1hwwUaUzDFbjYOXACpSxktFxz0K5ctiwOAue5HM
         Q4N+brBcQEzS+5Nw9aDF9lpI3zccJfip8sUVMm8WVzrNnSfeT6L+3g04gLKm9q9AJcGd
         uSt+g++YSv5BTFCXm0B1OXM5CZaEOdqlQOTNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jubiB2jKLUu4w7VRq3YFA2Rf2msO5KrIbQ8+dty9lC1z8Pi7OyHhd+HcBhqtKSJUsH
         dXrKQg++I6En8TeE1zCkuXIR/KEq559E4c1xj3b8n9gTB7p8W6MleuFZzVZsTJkBlg2X
         TA0WjtUz2dgAglSUfbXj52n5Kmbqbd5yt5aOM=
Received: by 10.115.32.1 with SMTP id k1mr669133waj.66.1227101452549;
        Wed, 19 Nov 2008 05:30:52 -0800 (PST)
Received: by 10.114.157.9 with HTTP; Wed, 19 Nov 2008 05:30:52 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0811190740570.27509@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101342>

2008/11/19 Nicolas Pitre <nico@cam.org>:
> On Wed, 19 Nov 2008, Alex Riesen wrote:
>
>> The opened packs seem to stay open forever.
>>
>> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
>> ---
>>
>> I'm very unsure about the solution, though: it is really horrible code
>> to debug...
>
> What is the actual problem?  Pack windows are left open on purpose.
>

* expecting success: do_repack &&
     git prune-packed -v &&
     git verify-pack ${pack}.pack &&
     git cat-file blob $blob_1 > /dev/null &&
     git cat-file blob $blob_2 > /dev/null &&
     git cat-file blob $blob_3 > /dev/null
Counting objects: 3, done.
error: unknown object type 0 at offset 2032 in
.git/objects/pack/pack-8d1e04fc992cfbdb3ab72cf7abbf08cce8b1900.pack
Compressing objects: 100% (2/2), done.
fatal: unable to rename temporary pack file
.git/objects/pack/tmp_pack_s9Gijm->.git/objects/pack/pack-b8d1e04fc992cfbdbab72cf7abbf08cce8b1900.pack:
Permission denied
* FAIL 10: ... and then a repack "clears" the corruption
        do_repack &&
             git prune-packed -v &&
             git verify-pack ${pack}.pack &&
             git cat-file blob $blob_1 > /dev/null &&
             git cat-file blob $blob_2 > /dev/null &&
             git cat-file blob $blob_3 > /dev/null
