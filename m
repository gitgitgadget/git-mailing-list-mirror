From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Introducing different handling for small/large transactions
Date: Thu, 15 Jan 2015 15:34:19 -0800
Message-ID: <xmqqppaf4o04.fsf@gitster.dls.corp.google.com>
References: <1421361371-30221-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: mhagger@alum.mit.edu, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 00:34:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBtvm-00061L-TH
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 00:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbbAOXeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 18:34:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752432AbbAOXeV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 18:34:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0582230766;
	Thu, 15 Jan 2015 18:34:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o8bmzUFow0bMvYkrTTbmfPzrIPY=; b=CLhE94
	iKhItxwLJKbfrCfwVavKPMkghX0J7iliPi5EOwPlz7TDDFXOnIGDhLSaHFSblU4X
	6ClX98TBX20l0R002z+DN7wMuBafgz6Dk0V82sJbRxI48ErvavCX6OfWPZyW13sK
	HlBUgGudstiUzKUbF9qy4cMVCWWu0Bix9je2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SoT+GC6acoMChTE7tm1JOpm8l3UZrRWU
	nc3VM/k5rpWFtQQSd/yH1lGDlrODEhb6bnAupAem+AVpMgT/dJOe9YN16P5SiJOG
	vmXRWUfAU7ryN3gZt54T6mKIblkP7MGU7nto26A4e1CD1NUwyBYyUPmkWHGX8Z1q
	Ap6ydetMJXE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F084830765;
	Thu, 15 Jan 2015 18:34:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7AAD630763;
	Thu, 15 Jan 2015 18:34:20 -0500 (EST)
In-Reply-To: <1421361371-30221-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 15 Jan 2015 14:36:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0793375A-9D0F-11E4-A489-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262523>

Stefan Beller <sbeller@google.com> writes:

> In ref_transaction_commit
> 	* commit the .lock file to its destination
> 	* in case this is a deletion:
> 		* remove the loose ref
> 		* and repack the packed refs file if necessary

Don't you need to repack and then remove the loose one, though?
Otherwise you would expose a stale packed ref in the middle to the
other readers, no?

> The larger transactions would be handled differently by relying
> on the packed refs file:
> In ref_transaction_update:
> 	* detect if we transition to a large transaction
> 	  (by having more than one entry in transaction->updates)
> 	  if so:
> 		* Pack all currently existing refs into the packed
> 		  refs file, commit the packed refs file and delete
> 		  all loose refs. This will avoid (d/f) conflicts.
>
> 		* Keep the packed-refs file locked and move the first
> 		  transaction update into the packed-refs.lock file
>
> 	* Any update(delete, create, update) is put into the locked
> 	  packed refs file.

I am not sure if you mean (a) keep updates only in-core, to be
flushed at the commit time, or (b) each and every update in the
large transaction results in rewriting the entire packed-refs.lock
file, only to be renamed to the final name at the commit time.
I am hoping it would be the former.

> 	* Additionally we need to obtain the .lock for the loose refs
> 	  file to keep guarantees, though we should close the file
> 	  descriptor as we don't wand to run out of file descriptors.

Yes, this last point is important.
