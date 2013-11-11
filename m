From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2013, #01; Fri, 1)
Date: Mon, 11 Nov 2013 14:25:10 -0800
Message-ID: <xmqq1u2mlgop.fsf@gitster.dls.corp.google.com>
References: <xmqqob6320rt.fsf@gitster.dls.corp.google.com>
	<52743547.7020001@ramsay1.demon.co.uk>
	<xmqqeh6w131e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Nov 11 23:25:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfzv9-00042V-On
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 23:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420Ab3KKWZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 17:25:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64130 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951Ab3KKWZS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 17:25:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0751352546;
	Mon, 11 Nov 2013 17:25:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=IYqumY4tEatpjcuhrlBvLMAVYag=; b=t/x/L1MTSw7n3NSG87Fm
	tkpvUTOOR1dLtZkwxkQCqZthcOHxWESUTDIyiM94qvf0uSBqUbdzb8ZwbynyPGsN
	d/M53XtLeRwbJWYjQw1E/MRpu6a8IMPMosk2F2MvXXeZyTqcsbzsd+8c4UBj5+9m
	M8VfbWU1CL+/N7mhRVlCNCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=amFk48yc6puEStVBkT3QIh61Q8BR7YUH++o8UqydhAwwKx
	I0r50Q2NOo/nBM981bQ7zb+hw4E3CbsrCr5ILbOt7G2QU3rZW5Wvv9xfZ+Id7AjM
	y1PoaQB0Z2qV5FTZYeo44fXD4uAOF2AQFHSCQLgkYc/JjHiIvBdBpABSd26fM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E528152545;
	Mon, 11 Nov 2013 17:25:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 387F252540;
	Mon, 11 Nov 2013 17:25:16 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 23C513D6-4B20-11E3-8758-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237662>

Junio C Hamano <gitster@pobox.com> writes:

>> Commit ad24a30ef ("fast-export: add new --refspec option", 31-10-2013)
>> causes sparse to complain:
>>
>>       SP builtin/fast-export.c
>>   builtin/fast-export.c:739:55: warning: Variable length array is used.
>>
>> Do we want to use this C99 feature?
>
> Good eyes, and no---this needs to be fixed before going forward.
>
> Thanks for spotting.

I'm tempted to squash this in to the problematic commit, if nobody
comes up with a better fix soonish, before merging the series to
'next'.

 builtin/fast-export.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 8ed41b4..7d02f63 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -736,9 +736,10 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		usage_with_options (fast_export_usage, options);
 
 	if (refspecs_list.nr) {
-		const char *refspecs_str[refspecs_list.nr];
+		const char **refspecs_str;
 		int i;
 
+		refspecs_str = xmalloc(sizeof(const char *) * refspecs_list.nr);
 		for (i = 0; i < refspecs_list.nr; i++)
 			refspecs_str[i] = refspecs_list.items[i].string;
 
@@ -746,6 +747,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		refspecs = parse_fetch_refspec(refspecs_nr, refspecs_str);
 
 		string_list_clear(&refspecs_list, 1);
+		free(refspecs_str);
 	}
 
 	if (use_done_feature)
