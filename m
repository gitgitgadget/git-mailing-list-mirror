From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] reset: support "--mixed --intent-to-add" mode
Date: Tue, 04 Feb 2014 11:09:54 -0800
Message-ID: <xmqqvbwu8zjx.fsf@gitster.dls.corp.google.com>
References: <CACsJy8BXGZ+1Oqrpcky5JPCtZRwvxmxhXGfuEqY9Ct4Pt8FmJg@mail.gmail.com>
	<1391480409-25727-1-git-send-email-pclouds@gmail.com>
	<1391480409-25727-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 20:10:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAlNl-0005J3-3q
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 20:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbaBDTKA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Feb 2014 14:10:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62565 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753984AbaBDTJ7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Feb 2014 14:09:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7282A670DA;
	Tue,  4 Feb 2014 14:09:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LyyohfY3LtoE
	oWM6002q5QroG6g=; b=Uv5wG4uSYbypI6Cow7qFAlhDDizVjwXexPknEgXbpUKj
	bArzMeeqAvtk89Ju+q+9Idb13SsbvAvFuhC/ntNlkmPjKFVy++R7Y7uESgMLmdVu
	fN/GdvtAmNk8ZafSA0it5QHs02a3B8KjYNC8aaVUYnH/NcPnkSP4vQhl+rruoAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OfNFFw
	GWKTmHzEwpQ8OLaWfJ84TxcjV0hohfCzfKM+OcknwAPOYR3va7pxwxRMGzsSPLtN
	Q5qTeC9uVdSVpTXJQSFK0tp88KO2jrtX62CkVzToJcm9D5cVNxsUOOUgiVt9ew0w
	vgjDfquQYf3PUl7EPKoNzqDDCL5iSQ480xPvc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D989670D8;
	Tue,  4 Feb 2014 14:09:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CEB5670D7;
	Tue,  4 Feb 2014 14:09:57 -0500 (EST)
In-Reply-To: <1391480409-25727-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 4 Feb
 2014 09:20:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F00F24BC-8DCF-11E3-BC83-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241540>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -128,13 +129,20 @@ static void update_index_from_diff(struct diff_=
queue_struct *q,
>  				    one->path);
>  			add_cache_entry(ce, ADD_CACHE_OK_TO_ADD |
>  				ADD_CACHE_OK_TO_REPLACE);
> +		} else if (*intent_to_add) {
> +			int pos =3D cache_name_pos(one->path, strlen(one->path));
> +			if (pos < 0)
> +				die(_("%s does not exist in index"),
> +				    one->path);
> +			set_intent_to_add(&the_index, active_cache[pos]);

While I do not have any problem with adding an optional "keep lost
paths as intent-to-add entries" feature, I am not sure why this has
to be so different from the usual add-cache-entry codepath.  The
if/elseif chain you are touching inside this loop does:

 - If the tree you are resetting to has something at the path
   (which is different from the current index, obviously), create
   a cache entry to represent that state from the tree and stuff
   it in the index;

 - Otherwise, the tree you are resetting to does not have that
   path.  We used to say "remove it from the index", but now we have
   an option to instead add it as an intent-to-add entry.

So, why doesn't the new codepath do exactly the same thing as the
first branch of the if/else chain and call add_cache_entry but with
a ce marked with CE_INTENT_TO_ADD?  That would parallel what happens
in "git add -N" better, I would think, no?
