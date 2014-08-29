From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fsck exit code?
Date: Fri, 29 Aug 2014 13:47:26 -0700
Message-ID: <xmqqd2bj58gx.fsf@gitster.dls.corp.google.com>
References: <1409177412.15185.3.camel@leckie>
	<20140829185325.GC29456@peff.net>
	<xmqqha0v5cgn.fsf@gitster.dls.corp.google.com>
	<1409343480.19256.2.camel@leckie> <20140829203145.GA510@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 22:47:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNT5F-0001JO-Nj
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 22:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbaH2Urn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 16:47:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63838 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719AbaH2Url (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 16:47:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E7175365B2;
	Fri, 29 Aug 2014 16:47:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dJieo1JfYigIfSIh6aiZYRVuawY=; b=ksp9xY
	6erUFdb1o2emVgIHnCJLjQrF9MLZHI41kDvPiZK9OOq+vSI4ocRQqgyq/Ps+KMLz
	RmndKNQf/9qlXbxy0G+M4I0uZ5E+JSRgSyNDHNG+NSBMc9efiGoYHJha8VwJhEjl
	dcBlGiWPryWpAsdTfAfy9Nl0S+XnItsbbZhs0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QyLIMeTA7CLzdAhpBgUgNBNGaOwUfRV1
	rbsi6kOJ1f66CK0R5f0Bl/X5w9KviJEZeXd7VACrQO2RbfrtCPCsB6sr86ii35Mj
	exiF98THco7jZ/b9/jmSvH/jQERSkdteiiftbh/I/ufzIx+W031cEuy7sk2hXOeb
	17yYhZWyjZc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DB699365B1;
	Fri, 29 Aug 2014 16:47:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 96283365A2;
	Fri, 29 Aug 2014 16:47:28 -0400 (EDT)
In-Reply-To: <20140829203145.GA510@peff.net> (Jeff King's message of "Fri, 29
	Aug 2014 16:31:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B09BCDC2-2FBD-11E4-A832-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256189>

Jeff King <peff@peff.net> writes:

> On Fri, Aug 29, 2014 at 04:18:00PM -0400, David Turner wrote:
>
>> > Even if git does not die, whenever it says broken link, missing
>> > object, or object corrupt, we set errors_found and that variable
>> > affects the exit status of fsck.  What does "some errors" exactly
>> > mean in the original report?  Dangling objects are *not* errors and
>> > should not cause fsck to report an error with its exit status.
>> 
>> error in tree 9f50addba2b4e9e928d9c6a7056bdf71b36fba90: contains
>> duplicate file entries
>> 
>> (at least -- there might be more, but that's the one that bit me)
>
> I think that we just don't set "errors_found" in fsck_obj (nor do we in
> fsck_obj_buffer, but in that case its caller is verify-pack, which
> propagates the return code). Maybe (completely untested):

Sounds about right.  David may have more or there may be not.  Let's
not forget to collect them and roll the fixes into a single update.

Thanks.

> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index d42a27d..29de901 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -388,7 +388,8 @@ static void fsck_sha1_list(void)
>  		unsigned char *sha1 = entry->sha1;
>  
>  		sha1_list.entry[i] = NULL;
> -		fsck_sha1(sha1);
> +		if (fsck_sha1(sha1))
> +			errors_found |= ERROR_OBJECT;
>  		free(entry);
>  	}
>  	sha1_list.nr = 0;
