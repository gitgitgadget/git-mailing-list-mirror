From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git update-ref --stdin : too many open files
Date: Mon, 22 Dec 2014 19:22:28 -0800
Message-ID: <20141223032228.GZ29365@google.com>
References: <54954E44.1080906@dachary.org>
 <xmqqoaqv8jmi.fsf@gitster.dls.corp.google.com>
 <5498D66B.5090807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Loic Dachary <loic@dachary.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 04:22:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3G3Q-0003Tv-DI
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 04:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294AbaLWDWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 22:22:32 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:58551 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbaLWDWb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 22:22:31 -0500
Received: by mail-ig0-f176.google.com with SMTP id l13so5254758iga.9
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 19:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ybAfDpC/SQxAaNPuw8d+Su0UAPqjUwjD59WoT2aGDDs=;
        b=jhcuFnBgbsiDCLImim3Xtq/jitjsEDdkKopAeasO/q0w4ZNqIgN/rrjPDw0+CE6LTR
         /jnCm1Suhw/GygVsuVT4OEVD55+HbrzqaGDQXQ/UGByLWhsSui24kabGOwGvdCi7Pt2X
         O5YfG3GA+X6dIN0vvDgDoPVJlqT+Mddp4oQQOd/27LH7AKbiS22TOIFxppyERXIXM4RZ
         yVKEYOmf7PRvJPZzRCWMlLetFPFqygoGziW4jcyxVBbmDW9bjg73a+WH1u72MitvYrt9
         SLvyvV7HAoxgE9nlnzKv/gGEMV78RKcUTir34vh14LpWCtL9zIXFUziEhL7HooypjOd/
         hgCA==
X-Received: by 10.50.176.129 with SMTP id ci1mr17974183igc.40.1419304951266;
        Mon, 22 Dec 2014 19:22:31 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d0f3:eebb:4e13:baf])
        by mx.google.com with ESMTPSA id qr1sm5798286igb.18.2014.12.22.19.22.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Dec 2014 19:22:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5498D66B.5090807@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261713>

Hi Stefan,

Stefan Beller wrote:
> On 22.12.2014 13:22, Junio C Hamano wrote:
>> Loic Dachary <loic@dachary.org> writes:

>>> fatal: Unable to create /home/gitmirror/repositories/Ceph/ceph/refs/heads/pull/1917.lock': Too many open files
[...]
>> Stefan, want to take a look?  I think we do need to keep the .lock
>> files without renaming while in transaction, but we do not have to
>> keep them open, so I suspect that a fix may be to split the commit
>> function into two (one to close but not rename, the other to
>> finalize by renaming) or something.

Makes sense.

> Sounds reasonable. Though by closing the file we're giving up again a
> bit of safety. If we close the file everyone could tamper with the lock
> file. (Sure they are not supposed to touch it, but they could)

At least on Linux, keeping a file open doesn't offer any protection
against someone else deleting it.  (It also doesn't offer any
protection against someone updating the ref directly. ;-)  Opening the
corresponding .lock file with O_EXCL is part of the contract for
updating refs.)

Thanks,
Jonathan
