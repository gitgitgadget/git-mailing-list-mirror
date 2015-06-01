From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] solving a bug with hunks starting at line 1 in git apply
Date: Mon, 01 Jun 2015 10:30:30 -0700
Message-ID: <xmqqeglv72vd.fsf@gitster.dls.corp.google.com>
References: <87k2vnqrv8.fsf@ensimag.grenoble-inp.fr>
	<xmqqiob773iy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 01 19:30:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzTXp-0004at-Jb
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 19:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbbFARad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 13:30:33 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33652 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095AbbFARac (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 13:30:32 -0400
Received: by igbpi8 with SMTP id pi8so66843845igb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=P18d5yORJR1V/dkdTuL/1/o98QWkCC7+SlSn0jglljo=;
        b=b5kfQ6vvM3VUlhdq0kv3JbYBEGOAFaOT3vVbVHC+Hkv7o5I0iD/LDKMcbcXH2SPRob
         U5EdRcPz85xZ3giNZxjZJcHvwUx59ZJL858539SGtjYojA83eQslcUnZTDr94++CEmZH
         fR8onlvjsv33IxMJ375wqXNW+xlavcfTOb76W2dVRphmZpEQtd41/nFCWRCX80l3sdmF
         hj353bJZmH8aGRwtWt6e10//QXbX3Ar8XGvsh1A4Dz729UbQ1hVCCsVdMdnPZ1E/L3IU
         3B/nweFlNXdb5yOi+vsSrHd2dooF3Z6t9l0vbk8msk1Sip2JjzRN1izduL7/Scyj81nU
         2zeA==
X-Received: by 10.50.61.130 with SMTP id p2mr15207802igr.9.1433179832243;
        Mon, 01 Jun 2015 10:30:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0e6:ec48:f0c0:da4d])
        by mx.google.com with ESMTPSA id g12sm10820241ioe.28.2015.06.01.10.30.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 10:30:31 -0700 (PDT)
In-Reply-To: <xmqqiob773iy.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 01 Jun 2015 10:16:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270442>

Junio C Hamano <gitster@pobox.com> writes:

> Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr> writes:
>
>> first original file:
>>
>> 10
>> 20
>> 30
>> 40
>>
>> for the following diff file:
>>
>> @@ -1,2 +1,2 @@
>>  20
>> -30
>> +35
>>  40
>>
>> The patch will not be applied with a git apply command, but it will
>> with a basic patch command.
>
> Doesn't that merely indicate a bug in "patch", though?

This needs a bit gentler explanation.  Imagine you are doing a usual
"git diff" with two lines of context, with a longer original.  A
change to do s/30/35/ would look like this:

@@ -1,5 +1,5 @@
 10
 20
-30
+35
 40
 50

And an attempt to apply this patch to an original that does not have
10, 20, 30, 40 and 50 in this order must fail.

On the other hand, if the change were instead s/20/35/, then the
diff output would look like this instead:

@@ -1,4 +1,4 @@
 10
-20
+25
 30
 40

Notice that the pre-context lines in this second example is only one
line.  Is it giving the same degree of safety if we rejected an
attempt to apply this patch only when the original does not have 10,
20, 30 and 40 in this order?

No.  Because we are doing two-line context patch, the patch is not
just saying "this change applies to a place where the first line is
10".  It also is saying "there is no line before that line".

To answer my own question in the previous message, we cannot tell
only from that example which of "git apply" and "patch" is wrong.
If you generated the patch with "git diff -U1", then "git apply"
that insists that there must be no line before that "20" is wrong.
If you generated the patch with "git diff" with the default two-line
context, then "patch" is wrong if it does not make sure "20" is the
first line.
