From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] index-format.txt: be more liberal on what can
 represent invalid cache tree
Date: Wed, 12 Dec 2012 17:55:01 -0800
Message-ID: <7v8v921zt6.fsf@alter.siamese.dyndns.org>
References: <7v4njr5eac.fsf@alter.siamese.dyndns.org>
 <1355361287-10875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 02:55:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tiy1K-0003Iw-7I
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 02:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233Ab2LMBzI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2012 20:55:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57490 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755020Ab2LMBzH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2012 20:55:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5210A805;
	Wed, 12 Dec 2012 20:55:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5nds+JZbiY45
	UO30COYkjw75qK0=; b=tvokeVXUlDl8rj9Or3fj9CHaueNv9BpUPqmieZci9hXh
	w/8ZXyWIUFfWdpDQGnGfAdFzPkF8IkdOBj+7PPft4yfcPsk0hypI9hMTLbRZYadR
	3iY/ubQIGhAwvMR9aQ9cKso9rMEEL7WLuUn4pSgF6WYCiF9Q1srRG7gtxUE0HgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Y/IOsU
	8lV851WZxEwqHaS8jjtvHZvC4EFcVZwL8cJgk15qdZ97ivONIXL/oo1wiF7Nay0X
	eid1Pg6u83Ycu9B+UNoVW5eEhkoVQMykZGjy7K+sq8juwe2HupFEf5txF+bNVZmD
	R/hDcRtWnYFeHoo5P0LFIW+qhxoGLuaZBOGPg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92080A804;
	Wed, 12 Dec 2012 20:55:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89D14A802; Wed, 12 Dec 2012
 20:55:05 -0500 (EST)
In-Reply-To: <1355361287-10875-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 13 Dec
 2012 08:14:47 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1DA06384-44C8-11E2-8701-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211431>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  How would that work with existing versions? If you write -2 in
>  cache-tree, the next time 1.8.0 updates cache tree it writes -1 back=
=2E
>  That loses whatever information you attach to -2. A new cache-tree
>  extension is probably better.

You can easily imagine a definition like this:

 - If non-negative, the entry is valid and it is the number of index
   entries that are covered by this subtree;

 - If -1, the cached-tree does not know the object name of the tree
   object, and nothing else is known. The caller needs to walk the
   index to skip the entries that could have been covered by this
   subtree, if the cached tree information were valid;

 - If less than -1, the cached-tree does not know the object name of
   the tree object, but we know the number of index entries that are
   covered by this subtree.  The caller, instead of walking the index,
   can subtract the count from -1 and skip that many entries to find
   the index entry after the part that is inside this directory.

Newer Git may write -201 and newer Git may be able to take advantage
of the new information encoded there, saving 200 calls to
prefixcmp(), while given the same index, older Git will operate just
as correctly as before.  An older Git may write that part of the
cache-tree back with -1, defeating the optimization when a newer Git
reads it back, but by definition the older Git does not know what to
write to help that optimization that did not exist when it was done,
and writing -1 will not confuse the newer Git.
