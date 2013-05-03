From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] fast-export: improve speed by skipping blobs
Date: Fri, 03 May 2013 14:51:52 -0700
Message-ID: <7vhaijybnr.fsf@alter.siamese.dyndns.org>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 23:52:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYNth-0006fE-JP
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 23:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934464Ab3ECVwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 17:52:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65444 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934421Ab3ECVvz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 17:51:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 051771BC0B;
	Fri,  3 May 2013 21:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yiPRehvaWYDLWmqxa3hSUtXQMgA=; b=utG0ZR
	ZgXT+jocl1/GzQKSfxWkAGUroomoqRY7Qo1aPyJUFJiSvnReQdUlMiV9fcqOJAPG
	MLUegRkBBFj7NHur+rytKbz4KaRd6o96PomRop859rAfhvVWxomYWp82ihyc04An
	CkkMQk0lTuCKOdLPLLGUdH+MzG5/gwJpMTMwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vUCgjeJjClrVkf+N2vSmYY58dEBKb7kB
	bCXlRzjI2HFKKcWzuAMqCZdpelypFBL80tqbSQtws+tCA5PcDnHFtD+Qyw8S5hIb
	Ksrdo+86TyaWW9eFM6n+a73dMXKHNRUCl5YOqhoAINw069b42epXnqZxMkMBzoUa
	yeaI10ja+wM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECBDB1BC0A;
	Fri,  3 May 2013 21:51:54 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53D7A1BC09;
	Fri,  3 May 2013 21:51:54 +0000 (UTC)
In-Reply-To: <1367555502-4706-3-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 2 May 2013 23:31:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB3D319E-B43B-11E2-B6FD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223325>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> We don't care about blobs, or any object other than commits, but in
> order to find the type of object, we are parsing the whole thing, which
> is slow, specially in big repositories with lots of big files.
>
> There's no need for that, we can query the object information with
> sha1_object_info();
>
> Before this, loading the objects of a fresh emacs import, with 260598
> blobs took 14 minutes, after this patch, it takes 3 seconds.

OK.

>
> This is the way fast-import does it. Also die if the object is not
> found (like fast-import).
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---


>  builtin/fast-export.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index a4dee14..a5b8da8 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -613,6 +613,7 @@ static void import_marks(char *input_file)
>  		char *line_end, *mark_end;
>  		unsigned char sha1[20];
>  		struct object *object;
> +		enum object_type type;
>  
>  		line_end = strchr(line, '\n');
>  		if (line[0] != ':' || !line_end)
> @@ -627,17 +628,19 @@ static void import_marks(char *input_file)
>  		if (last_idnum < mark)
>  			last_idnum = mark;
>  
> -		object = parse_object(sha1);
> -		if (!object)
> +		type = sha1_object_info(sha1, NULL);
> +		if (type < 0)
> +			die("object not found: %s", sha1_to_hex(sha1));
> +
> +		if (type != OBJ_COMMIT)
> +			/* only commits */
>  			continue;
>  
> +		object = parse_object(sha1);
> +
>  		if (object->flags & SHOWN)
>  			error("Object %s already has a mark", sha1_to_hex(sha1));
>  
> -		if (object->type != OBJ_COMMIT)
> -			/* only commits */
> -			continue;
> -
>  		mark_object(object, mark);
>  
>  		object->flags |= SHOWN;
