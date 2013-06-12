From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/45] pathspec: add copy_pathspec
Date: Wed, 12 Jun 2013 11:07:18 -0700
Message-ID: <7vmwqv42zt.fsf@alter.siamese.dyndns.org>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
	<1370759178-1709-5-git-send-email-pclouds@gmail.com>
	<CAPig+cTP8HuPzp=THuSTFtRW8uNgqxROWuQUG7_bYC_FSs5rpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 20:07:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmpSC-0006vN-6h
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 20:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755392Ab3FLSHX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 14:07:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59486 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754380Ab3FLSHW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jun 2013 14:07:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9165226B6C;
	Wed, 12 Jun 2013 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=s6XZuwh6Dn1E
	OWmZt45gF5qpc0E=; b=Qpxge5kofNAWRMl3tdXYGa7W6vAGbIz5k/a/qjU883cF
	nMPF1wxZyRHapp0TidN8SIsdEhDuRrNObu9EwIW0EqaazLNUOfENdWIYvSw5SriG
	JEvcB3Do79nYQp2bj5poJQniJYvS8gUM248zdPSWNg5KMpmSf/hHce778/KbNBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=k9Unl1
	01SzjVarulZFf3nddpoov/TEWfkSaJdhdjz1jQ14zu3fhr+jEuJC5+tYYEYFh7Dr
	Jp/HhPYlUOkGRgMVfrsFaCDJkhM2Bqkll1f3zbR6TwsLVTL9wWYcWDbBwhgtkyFv
	PBNjZnBvX+3tw0pJlBqV0GC6FalCJp7wHEIwA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8730726B6A;
	Wed, 12 Jun 2013 18:07:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EAE1E26B67;
	Wed, 12 Jun 2013 18:07:20 +0000 (UTC)
In-Reply-To: <CAPig+cTP8HuPzp=THuSTFtRW8uNgqxROWuQUG7_bYC_FSs5rpQ@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 9 Jun 2013 03:58:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED006D94-D38A-11E2-9B56-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227660>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Jun 9, 2013 at 2:25 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> The function is made to use with free_pathspec() because a simple
>> struct assignment is not enough (free_pathspec wants to free "items"
>> pointer).
>
> I had to read this about five or six times before I could parse and
> understand it. Perhaps rewrite something like this:
>
>     free_pathspec() frees pathspec->items, hence simple struct
>     assignment does not properly duplicate a pathspec. Introduce
>     copy_pathspec() to clone a pathspec correctly by deeply copying
>     the items member.

Thanks.  It might be worth that this is not a full "deep" copy,
perhaps like this:

    pathspec: add copy_pathspec
   =20
    Because free_pathspec wants to free "items" pointer in the pathspec
    structure, a simple structure assignment is not enough if you want
    to copy an existing pathspec into another.  Freeing the original wi=
ll
    damage the copy unless a deep copy is made.
   =20
    Note that the strings in pathspec->items->match and the array
    pathspec->raw[] are still shared between the original and the
    copy.
   =20
    Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
