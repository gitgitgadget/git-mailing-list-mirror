From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 03/11] ref-filter: implement '--points-at' option
Date: Mon, 29 Jun 2015 10:40:18 -0700
Message-ID: <xmqqmvzibegt.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
	<1435222633-32007-1-git-send-email-karthik.188@gmail.com>
	<1435222633-32007-3-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 19:40:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9d2m-0004FR-1t
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 19:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbbF2Rk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 13:40:26 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33720 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbbF2RkV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 13:40:21 -0400
Received: by igcur8 with SMTP id ur8so43015428igc.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 10:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0/wlctKwhfelVoh/xNq8nvNtjGDhd0UUeSax3/aIQQc=;
        b=Sl2IU1B4FQIbdb0jvFb7QDVj3JS/xA1+cGxo3r5u2q60tgVKKZCBQ9AQUDfHLU/93l
         JkRv6YrHIcSam8/xQe8b70iSKe3lYVDxCr+IBjIA3Q1DxdGyY+d5rgs30lRjWYuMWlf/
         rxt3ynpsRKqPjqCqZj4AUyAV7PbLsuJ7Qua3lvIMGvlaPOhcUZcJ/5hghNS/IWtP5Pj3
         d2p5tx7B/+f4GyRdbw+5rQA1Kaci7JE7PJx9MbLoUZpRqVVDJdcQHpRNFd7viTmX8wFm
         VYVXXw0FZ8C/XKYb8P/bY6V3EtoZ+UcVp1cyRpFJFAXQtYfJX/nNFZW06/LqrTh+f/MX
         KX9g==
X-Received: by 10.43.139.6 with SMTP id iu6mr21140880icc.32.1435599620654;
        Mon, 29 Jun 2015 10:40:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:946c:210:22fc:378d])
        by mx.google.com with ESMTPSA id g81sm3829223ioi.20.2015.06.29.10.40.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 10:40:19 -0700 (PDT)
In-Reply-To: <1435222633-32007-3-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 25 Jun 2015 14:27:05 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272978>

Karthik Nayak <karthik.188@gmail.com> writes:

> +/*
> + * Given a ref (sha1, refname) see if it points to one of the sha1s
> + * in a sha1_array.
> + */
> +static int match_points_at(struct sha1_array *points_at, const unsigned char *sha1,
> +			   const char *refname)
> +{
> +	struct object *obj;
> +
> +	if (!points_at || !points_at->nr)
> +		return 1;
> +
> +	if (sha1_array_lookup(points_at, sha1) >= 0)
> +		return 1;
> +
> +	obj = parse_object_or_die(sha1, refname);
> +	if (obj->type == OBJ_TAG &&
> +	    sha1_array_lookup(points_at, ((struct tag *)obj)->tagged->sha1) >= 0)
> +		return 1;
> +
> +	return 0;
> +}
> +

Interesting.  I think the change done while copying the code does
not change anything from the original (other than that the helper
lost its ability to return the peeled object name), and I think you
shouldn't make any change while copying the code that would change
the benaviour, but I notice a few things that we might want to keep
in mind and revisit them later (i.e. might be a good idea to add
NEEDSWORK comment to record them near the function):

 - The original only peeled one level of indirection, so does this
   implementation.  But is that really what we want, I wonder?

   After doing:

   $ git tag -a -m 'annotated' atag $commit
   $ git tag -a -m 'annotated doubly' dtag atag

   atag^0, dtag^0 and $commit all refer to the same commit object.
   Do we want to miss dtag with --point-at=$commit?

 - As we are in for-each-ref (or eventually tag -l) that is walking
   the cached refs, we may know what refname peels to without
   parsing the object at all.  Could it be more efficient to ask
   peel_ref() for the pointee without doing parse_object()
   ourselves?
