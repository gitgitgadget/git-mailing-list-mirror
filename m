From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] cat-file: add --follow-symlinks to --batch
Date: Tue, 12 May 2015 14:42:47 -0700
Message-ID: <xmqqiobxealk.fsf@gitster.dls.corp.google.com>
References: <1431384645-17276-1-git-send-email-dturner@twopensource.com>
	<1431384645-17276-4-git-send-email-dturner@twopensource.com>
	<xmqqoalpzn3s.fsf@gitster.dls.corp.google.com>
	<1431455779.16652.20.camel@ubuntu>
	<xmqqh9rhftlh.fsf@gitster.dls.corp.google.com>
	<1431466646.16652.32.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 12 23:42:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsHx0-0006UZ-Mo
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 23:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933821AbbELVmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 17:42:50 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34988 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932689AbbELVmt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 17:42:49 -0400
Received: by igbyr2 with SMTP id yr2so121603178igb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 14:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1KPpSkP/fduTQrBm449VoW33RUNkf7yzb2nZV2/i2f4=;
        b=AIDOSwOxKOsTNcXty1w7sfS8dJtIIeNkP25XUKNI0I/j8FiGtM0a/OpOrFEbMtM1T5
         uRqJyRCwjF4/argvBR3lDO8F5nOJZZfM3ee9ggm/vTRI0ufSFC83DeJSBUF+r17htS8X
         4lQuPT0PDGSfsiU6MdGuacjsgf0Nm3LEDpP2tsVVw/3ucgs9sjOKXsYIJNg8vOCQOV13
         3cRlpOeJcZn9akQaBEz3TYEBjcJP+Rol0FlqpduKR7UHN15xTW3nRRKwArFvEByXAzne
         VwMFR90hUt1d1PnocDgtyULaVQZAPfXDiLmVuFqlLbikuOk9tM5nNv6WFzrEON/DV+QN
         FHyA==
X-Received: by 10.107.9.67 with SMTP id j64mr22984394ioi.39.1431466969229;
        Tue, 12 May 2015 14:42:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id kl1sm2075617igb.15.2015.05.12.14.42.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 14:42:48 -0700 (PDT)
In-Reply-To: <1431466646.16652.32.camel@ubuntu> (David Turner's message of
	"Tue, 12 May 2015 17:37:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268895>

David Turner <dturner@twopensource.com> writes:

> On Tue, 2015-05-12 at 13:07 -0700, Junio C Hamano wrote:
>> David Turner <dturner@twopensource.com> writes:
>> 
>> >>  * I am not sure if HEAD:link that points at HEAD:link should be
>> >>    reported as "missing".  It may be better to report the original
>> >>    without any dereferencing just like a link that points at outside
>> >>    the tree? i.e. "symlink 4 LF link".
>> >
>> > Unfortunately, a symlink loop might include relative symlinks
>> > (e.g. ../a).  If we return a relative symlink, the user will
>> > not be able to distinguish it from a non-loop, out-of-tree symlink.  So
>> > I think we may not return symlink 4 LF ../a for these cases.  
>> 
>> I do not follow.  Let's start from a shared example.
>> 
>>     HEAD:sub/link is a symbolic link whose value is ../nextlink
>>     HEAD:nextlink is a symbolic link whose value is sub/link
>> 
>> That's a loop.  Now, I think what I am sugesting is
>> 
>> 	$ git cat-file --batch-check --follow-symlinks <<\EOF
>> 	HEAD:sub/link
>>         HEAD:nextlink
>> 	EOF
>> 	symlink ../nextlink
>>         symlink sub/link
>> 
>> If you asked about sub/link and then got ../nextlink back, then
>> isn't it clear for the reading script that it is about nextlink
>> at the top-level?  Why can't it tell it from out-of-tree link?
>
> Because maybe sub/link was actually a link to ../../nextlink.

Then the output would have said "symlink ../../nextlink" and you can
tell these two cases apart, no?  Same for the other case.

> But I think I'm OK with implementing your proposed solution[1] of
> categorizing all of the possible cases.

I think that is the cleanest I can come up with offhand, and would
give the easiest input to scripters.  At least I think so for now,
but others may have even better ideas ;-)

Thanks.
