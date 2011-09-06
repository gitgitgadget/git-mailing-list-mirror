From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] sha1_file: remove a buggy value setting
Date: Tue, 06 Sep 2011 09:26:53 -0700
Message-ID: <7vpqjdab76.fsf@alter.siamese.dyndns.org>
References: <1315304645-12009-1-git-send-email-Hui.Wang@windriver.com>
 <1315304645-12009-2-git-send-email-Hui.Wang@windriver.com>
 <1315304645-12009-3-git-send-email-Hui.Wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, <tali@admingilde.org>
To: Wang Hui <Hui.Wang@windriver.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 18:27:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0yUH-0004NX-LC
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 18:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589Ab1IFQ05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 12:26:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61935 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab1IFQ0z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 12:26:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62D974316;
	Tue,  6 Sep 2011 12:26:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bp7g44YdU7T1rmsGxJKzqdrvL6Q=; b=BGEe3D
	8GIPdx5NBapHDL+OCjHxRYE+thAqaPHKvGd82W1j5RT8lZRNPRrfc4mt5Q3qfUgo
	uS5fGWWNLe46htcHtLiLqQ7AVbhLotMDSFSHqmT5Bbzf/wuHRoxK0Pou8XSCMo39
	V1MWgAwDZbGP3y1znLFBlkq961XFAWCKxMt5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VvCwCGrr40lX6VQ/soEB6kxw2HtniW2k
	a4YpcWwSgeL/3ETODMmat2dDmgAu+s95xQecnnBj11eyYyY3IhG6wEuKQJ5JkKP1
	5Ml9rV07Z5+PbxeQPCUIcNAcgkIiwnkxz0KgKWKiy/NU4hrfDdCD4uHvsbsIIYBh
	kCz14uk/TRc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A7B44315;
	Tue,  6 Sep 2011 12:26:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEA584314; Tue,  6 Sep 2011
 12:26:54 -0400 (EDT)
In-Reply-To: <1315304645-12009-3-git-send-email-Hui.Wang@windriver.com> (Wang
 Hui's message of "Tue, 6 Sep 2011 18:24:02 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 08C1A4F4-D8A5-11E0-9BBF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180812>

Wang Hui <Hui.Wang@windriver.com> writes:

> From: Hui Wang <Hui.Wang@windriver.com>
>
> The ent->base[] is a character array, it has pfxlen characters from
> position 0 to (pfxlen-1) to contain an alt object dir name, the
> position pfxlen should be the string terminating character '\0' and
> is deliberately set to '\0' at the previous code line. The position
> (pfxlen+1) is given to ent->name.

Correct. Do you understand why?

We temporarily NUL terminate the ent->base[] so that we can give it to
is_directory() to see if that is a directory, but the invariants for a
alternate_object_database instance after it is properly initialized by
this function are to have:

 - the directory name followed by a slash in the base[] array;
 - the name pointer pointing at one byte beyond the slash;
 - name[2] filled with a slash; and
 - name[41] terminated with NUL.

Later, has_loose_object_nonlocal() calls fill_sha1_path() with the name
pointer to fill name[0..1, 3..40] with the hexadecimal representation of
the object name, which would result in base[] array to have the pathname
for a loose object found in that alternate. The same thing happens in
open_sha1_file() to read from a loose object in an alternate.

And you are breaking one of the above invariants by removing that slash
after the directory name. These callers of fill_sha1_path() will see the
directory name, your NUL, two hex, slash, and 38 hex in base[].

How would the code even work with your patch?
