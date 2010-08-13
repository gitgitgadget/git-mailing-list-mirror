From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid rename/add conflict when contents are identical
Date: Thu, 12 Aug 2010 18:18:19 -0700
Message-ID: <7vd3tnmht0.fsf@alter.siamese.dyndns.org>
References: <5C4EA6C5B30E6B45A9164CB3A26A0D326F79D9AA04@azsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Schalk\, Ken" <ken.schalk@intel.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 03:18:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojiun-0004AT-NX
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 03:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760716Ab0HMBS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 21:18:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43745 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888Ab0HMBS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 21:18:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 011D5CD934;
	Thu, 12 Aug 2010 21:18:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TvsMmJLYHm2jVRPScCveQRk5ngg=; b=fCjzKu
	f5Dn8AI88HKZ0g6bvyBbehQurupFbN2uKB6/gFFusCB+XgogS2ZA2CVEQVoGAqr3
	kcloxj+jd9W8KBmhDHlyOyesMN7/sQ1NRHhixSi6C5xeUXqTzbhMo0GewSto2tK+
	TzbRnkADx+jkF55rt/mhm4oyUnZJSzd8R3JEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WtpRIC1bUa6r4FDJs9Ww9YSHo6RO8UTd
	6vB13L2JJPxCRELEaKliAqYA/3S+yPUHKQ2x925bhzZg457uXU2BPCsS+c9AUz8D
	3UNzLVx4QcHY/pO7SCtizsqqsmfsS0HymyK9f+VvY8yESQphWR1wXzGaUGH+U8w4
	MqH3yS93B64=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D2CE8CD932;
	Thu, 12 Aug 2010 21:18:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1ADF2CD92E; Thu, 12 Aug
 2010 21:18:20 -0400 (EDT)
In-Reply-To: <5C4EA6C5B30E6B45A9164CB3A26A0D326F79D9AA04@azsmsx503.amr.corp.intel.com>
 (Ken Schalk's message of "Mon\, 9 Aug 2010 14\:00\:31 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AAED387A-A678-11DF-B719-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153450>

"Schalk, Ken" <ken.schalk@intel.com> writes:

> diff --git a/merge-recursive.c b/merge-recursive.c
> index fb6aa4a..57c7a85 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -955,6 +955,18 @@ static int process_renames(struct merge_options *o,
>                                                         ren1->pair->two : NULL,
>                                                         branch1 == o->branch1 ?
>                                                         NULL : ren1->pair->two, 1);
> +                       } else if ((dst_other.mode == ren1->pair->two->mode) &&
> +                                  sha_eq(dst_other.sha1, ren1->pair->two->sha1)) {
> +                               /* Added file on the other side
> +                                  identical to the file being
> +                                  renamed: clean merge */
> +                               update_file(o, 1, ren1->pair->two->sha1, ren1->pair->two->mode, ren1_dst);
> +                               if (!o->call_depth)
> +                                       update_stages(ren1_dst, NULL,
> +                                                       branch1 == o->branch1 ?
> +                                                       ren1->pair->two : NULL,
> +                                                       branch1 == o->branch1 ?
> +                                                       NULL : ren1->pair->two, 1);
>                         } else if (!sha_eq(dst_other.sha1, null_sha1)) {
>                                 const char *new_path;
>                                 clean_merge = 0;

The logic seems to be clear enough.  Could you write a test script instead
of description in the commit log message, so that future changes to the
codebase won't break this improvement?

Thanks.
