From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] attr.c: respect core.ignorecase when matching
 attribute patterns
Date: Tue, 11 Oct 2011 09:54:07 -0700
Message-ID: <7v8vorh3kg.fsf@alter.siamese.dyndns.org>
References: <4E93BBA8.6080403@alum.mit.edu>
 <HBn1XX5GLcGG9WPqS0RC9Uscll_6Kbd741mHOR7uc_IFxdOpGSDGF7qEBPF66SbtO3keG4GcnkbtEvKDQ5D3bCDNiV9EPgEh-CMLKgbfFJcpVD5Gcb69-QoqTpHG_J9pDQG844LtNZU@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Oct 11 18:54:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDfat-00038d-2p
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 18:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754975Ab1JKQyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 12:54:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50742 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754970Ab1JKQyN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 12:54:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58D214351;
	Tue, 11 Oct 2011 12:54:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ngjdZfPfPw5Zd4E30RkzpJ4lG2Y=; b=suyq7d
	9X+nR9qzCFM3JUste0wJZCXA4sf3lM650y70qUpdkXKwk2zzqpo55Qky/eDMmRK+
	7nbMXzEtK5XL0md2DbDMSj6WAeaMAFYBdEMe+qYqZuqhbyMp5oNtA5XSabDIvpBk
	3ZyzVmk/9OzRkbZ89LrGfjeXR5EaNRk2poAMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xlk2VTTWBRhx29UlQnjv0eKVvd2juCek
	INx2tcOdq3qSE3wopmzRfd3C05y/cymhGwgcKHyKfYDUTDkBRf0JM9hg/EQJYfTx
	/27f5GGDAAu+DRlKNeUuoiwzWcsvqmaFrisN/9i6lXh8l05dpwSx7xXBF5ZJl5rO
	sOaKoaGJMAA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F3734345;
	Tue, 11 Oct 2011 12:54:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B61E94344; Tue, 11 Oct 2011
 12:54:09 -0400 (EDT)
In-Reply-To: <HBn1XX5GLcGG9WPqS0RC9Uscll_6Kbd741mHOR7uc_IFxdOpGSDGF7qEBPF66SbtO3keG4GcnkbtEvKDQ5D3bCDNiV9EPgEh-CMLKgbfFJcpVD5Gcb69-QoqTpHG_J9pDQG844LtNZU@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Tue, 11 Oct 2011 10:53:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3A6D7F6-F429-11E0-A760-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183305>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> ...  Currently, git builds the attr stack
> based on the path supplied by the user, so we don't have to do anything
> special (like use strcmp_icase) to handle the parts of that path that don't
> match the filesystem with respect to case.  If git instead built the attr
> stack by scanning the repository, then the paths in the origin field would
> not necessarily match the paths supplied by the user.

I find this description somewhat misleading. "check-attr" at the plumbing
level does take full path from the end user, but a common thing Git does
is to ask the system to learn the prefix to the current directory with
getcwd(3) append what fill_directory() enumerates as matching a pathspec
given by the user with readdir(3) to the prefix to form the full path, and
then feed that full path to git_check_attr().

Without anybody changing anything, we already do build the attr stack by
"scanning the repository" in that case, no?
