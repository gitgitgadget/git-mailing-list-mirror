From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Convert "struct cache_entry *" to "const ..." wherever possible
Date: Tue, 09 Jul 2013 09:15:48 -0700
Message-ID: <7va9lvwvyj.fsf@alter.siamese.dyndns.org>
References: <1373383740-24440-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 18:15:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwaa4-0006DP-Lb
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 18:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab3GIQPw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 12:15:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39783 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980Ab3GIQPv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jul 2013 12:15:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2ACC42FB1A;
	Tue,  9 Jul 2013 16:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SbSu45U/+S60
	Pe1CbUVv2hJNhS4=; b=Q8fC4uNShmBQQUI0OBH8octHjHC858HKOL9QPKRZJ6BQ
	gmbTGaGkunA8MC6JG06P8COmAsbNyrGcE0yUUGeZxKYPjL+I/0u18XZNysgpw6kp
	sFBUY4fqh29wHTr2XWBoceKo4x9eP2XGAWxLqQqIfWQPZ5gfOjaRoY0vlfy9+Ak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QX47ic
	x5lTLzUQofs/1c7sh+uX1LnM+UsmkEEyi2rx4ROKa7N3JoIHR/pmVMU7FJZjNu2s
	YHNbN3YWoghDla5X14pEwYF+NzimmoyFnLC3kFT3ZstK7rmJre/ESKYa2PiQupr3
	AaSFaglCSKinNvy/iRP5pYaUg7NqMAFgsN9tk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2098E2FB19;
	Tue,  9 Jul 2013 16:15:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DF562FB16;
	Tue,  9 Jul 2013 16:15:50 +0000 (UTC)
In-Reply-To: <1373383740-24440-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 9 Jul
 2013 22:29:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2569260-E8B2-11E2-AC7C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229965>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> I attempted to make index_state->cache[] a "const struct cache_entry =
**"
> to find out how existing entries in index are modified and where. The
> question I have is what do we do if we really need to keep track of o=
n-disk
> changes in the index. The result is
>
>  - diff-lib.c: setting CE_UPTODATE
>
>  - name-hash.c: setting CE_HASHED
>
>  - preload-index.c, read-cache.c, unpack-trees.c and
>    builtin/update-index: obvious
>
>  - entry.c: write_entry() may refresh the checked out entry via
>    fill_stat_cache_info(). This causes "non-const struct cache_entry
>    *" in builtin/apply.c, builtin/checkout-index.c and
>    builtin/checkout.c
>
>  - builtin/ls-files.c: --with-tree changes stagemask and may set
>    CE_UPDATE
>
> Of these, write_entry() and its call sites are probably most
> interesting because it modifies on-disk info. But this is stat info
> and can be retrieved via refresh, at least for porcelain
> commands. Other just uses ce_flags for local purposes.
>
> So, keeping track of "dirty" entries is just a matter of setting a
> flag in index modification functions exposed by read-cache.c. Except
> unpack-trees, the rest of the code base does not do anything funny
> behind read-cache's back.
>
> The actual patch is less valueable than the summary above. But if
> anyone wants to re-identify the above sites. Applying this patch, the=
n
> this:
>
>     diff --git a/cache.h b/cache.h
>     index 430d021..1692891 100644
>     --- a/cache.h
>     +++ b/cache.h
>     @@ -267,7 +267,7 @@ static inline unsigned int canon_mode(unsigne=
d int mode)
>      #define cache_entry_size(len) (offsetof(struct cache_entry,name)=
 + (len) + 1)
>    =20
>      struct index_state {
>     -	struct cache_entry **cache;
>     +	const struct cache_entry **cache;
>      	unsigned int version;
>      	unsigned int cache_nr, cache_alloc, cache_changed;
>      	struct string_list *resolve_undo;
>
> will help quickly identify them without bogus warnings.

Nicely done and a very interesting result.  I quickly eyeballed the
output of

$ git grep -e 'struct cache_entry' --and --not -e 'const struct cache_e=
ntry'

and the result matches what I would expect to see.
