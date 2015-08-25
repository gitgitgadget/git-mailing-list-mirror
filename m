From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Tue, 25 Aug 2015 12:16:08 -0700
Message-ID: <xmqqzj1fxjpj.fsf@gitster.dls.corp.google.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<vpqzj1hkc5q.fsf@anie.imag.fr>
	<xmqq7fok2u57.fsf@gitster.dls.corp.google.com>
	<xmqqy4h01egr.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZQwW9hpg4p8+DE2oZA28Av7mLrqAhEdcro=esuqHe35Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 21:16:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUJhh-0007Wz-Cq
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 21:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010AbbHYTQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 15:16:13 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33028 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbbHYTQK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 15:16:10 -0400
Received: by pacti10 with SMTP id ti10so60010027pac.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 12:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OvygTaDKq2pdTwdvDWFISGDsZeI+KFU+Dbl/QA/BtbA=;
        b=SabxBFc8WD2JA5p38O1Eee8mtkf6FM7GOKfcqAvrc/Tw6J5AwLqI+Ev1wJks0hQj46
         d/IKIrBvWL9qxtu9V23Zw0t3OpYZX29DAAin6cjm8T92nnHeFk/ukaYAxP/19HypUCO0
         ErL/t3HbObaKs/Q6a76cv8CEqiqzrzIEhi95bOZDA90FDreNdrBuzZKBUze9TLCkmdKj
         zMYVYcFUQxp/xafB08mSDH/RChxm9htUaPPxpNS/pdwW09p56TinefPnNr8UvFjCLzFP
         BekUyk6uWbuW4cNIiUX6+1njsoejA11nuqcNnHednW5dsd7ZyhsqlLWCYTCoQEXrxp4E
         atmQ==
X-Received: by 10.67.14.6 with SMTP id fc6mr28099180pad.9.1440530170105;
        Tue, 25 Aug 2015 12:16:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id sm3sm18896900pab.20.2015.08.25.12.16.09
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 12:16:09 -0700 (PDT)
In-Reply-To: <CAOLa=ZQwW9hpg4p8+DE2oZA28Av7mLrqAhEdcro=esuqHe35Xg@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 25 Aug 2015 18:56:55 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276562>

Karthik Nayak <karthik.188@gmail.com> writes:

>> Here is what I see...
>>
>> ok 98 - verifying rfc1991 signature
>>
>> expecting success:
>>         echo "rfc1991" >gpghome/gpg.conf &&
>>         echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
>>         git tag -l -n1 rfc1991-signed-tag >actual &&
>>         test_cmp expect actual &&
>>         git tag -l -n2 rfc1991-signed-tag >actual &&
>>         test_cmp expect actual &&
>>         git tag -l -n999 rfc1991-signed-tag >actual &&
>>         test_cmp expect actual
>>
>> --- expect      2015-08-24 22:54:44.607272653 +0000
>> +++ actual      2015-08-24 22:54:44.611272643 +0000
>> @@ -1 +1 @@
>> -rfc1991-signed-tag RFC1991 signed tag
>> +rfc1991-signed-tagRFC1991 signed tag
>> not ok 99 - list tag with rfc1991 signature
>
> Thats weird, I just ran all tests, and nothing failed.

You may be missing GPG or RFC1991 prerequisites and not running this
particular test, which could be why you missed it.

Your builtin/tag.c calls show_ref_array_item() with 

	"%(align:16,left)%(refname:short)%(end)"

as the format, and "rfc1991-signed-tag" is longer than 16.

And immediately after showing that, there is this hack at the end of
show_ref_array_item() function, which I _think_ should not be there
in ref-filter.c:show_ref_array_item() in the first place.

	if (lines > 0) {
		struct object_id oid;
		hashcpy(oid.hash, info->objectname);
		show_tag_lines(&oid, lines);
	}

This belongs to the caller who knows that it is dealing with a tag.

But that broken design aside, the reason why this breaks is because
you do not have a separating SP after the aligned short refs.

I didn't check how wide the original is supposed to be, but perhaps
changing builtin/tag.c this way

		if (filter->lines)
-			format = "%(align:16,left)%(refname:short)%(end)";
+			format = "%(align:15,left)%(refname:short)%(end) ";
		else
			format = "%(refname:short)";
	}

may be one way to fix it.  Check the original "tag -l" output for
tags whose names are 14, 15, 16 and 17 display-columns wide and try
to match it.

And then move the tag-specific code at the end of
show_ref_array_item() to here:

	verify_ref_format(format);
	filter_refs(&array, filter, FILTER_REFS_TAGS);
	ref_array_sort(sorting, &array);

-	for (i = 0; i < array.nr; i++)
+	for (i = 0; i < array.nr; i++) {
		show_ref_array_item(array.items[i], format, QUOTE_NONE, filter->lines);
+		if (lines) {
+			struct object_id oid;
+			hashcpy(oid.hash, info->objectname);
+			show_tag_lines(&oid, lines);
+		}
+	}

perhaps.
