From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v4 12/14] fix 'git update-index --verbose --again' output
Date: Fri, 08 Nov 2013 11:27:30 +0100
Message-ID: <527CBC92.5000306@gmail.com>
References: <527BA483.6040803@gmail.com> <527BA706.6010307@gmail.com> <xmqqiow3q2sh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 08 11:27:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VejI1-0004P2-FX
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 11:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757143Ab3KHK1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 05:27:35 -0500
Received: from mail-wg0-f43.google.com ([74.125.82.43]:61547 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756753Ab3KHK1b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 05:27:31 -0500
Received: by mail-wg0-f43.google.com with SMTP id b13so1755742wgh.10
        for <git@vger.kernel.org>; Fri, 08 Nov 2013 02:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=A/jOn+2VmmbZ1IudUQY4JWfHtX/1IZLzjpKq6ClX9Uc=;
        b=HXrzacus0cYgyBVAB9BmwBo+W5d+ZyERYmy2i3lJWhKZnG8ls0C80sIVXqVyixC0Q5
         SyhvDhmtXksQTz0q0/IATn+KQsfEb4bwRK7s6OnD/oMpdB3Z+T/ZqtpGlcbvkOf/suyV
         I9oBYW++LJJTLgiyaVD9/9sk1BBi++tivUbJq/3UHrs/xjyyUQ49qnK9UWus7Ksltm+R
         pbNfoyo+1UsRzvurzaUzpqFlaeHVbPCc6ydMUh60uJhBf+M+5qqvspolTxwfT0mNMjyk
         QL/mir507OftN7ZJ/M2oHXhToFUaNBC1rSmNLI9dcs97a5FvHWq65y2mZpn2WAJHKSOW
         /j+w==
X-Received: by 10.180.11.37 with SMTP id n5mr1714706wib.25.1383906450118;
        Fri, 08 Nov 2013 02:27:30 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id gg20sm5185787wic.1.2013.11.08.02.27.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 08 Nov 2013 02:27:28 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqiow3q2sh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237451>

Am 07.11.2013 23:12, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> 'git update-index --verbose' consistently reports paths relative to the
>> work-tree root. The only exception is the '--again' option, which reports
>> paths relative to the current working directory.
>>
>> Change do_reupdate to use non-prefixed paths.
> 
> Interesting.
> 
> This looks like a genuine fix unrelated to the use of the new hashmap.
> 

Indeed, #13 as well (and #4, #5, for that matter). I stumbled across this when analysing Thomas' last valgrind report.

Note that #12, #13 are prequels to #14, which adds a "char *path = xstrdup(ce->name); ... free(path)" around the update_one call.

>>
>> Signed-off-by: Karsten Blees <blees@dcon.de>
>> ---
>>  builtin/update-index.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>> index e3a10d7..d180d80 100644
>> --- a/builtin/update-index.c
>> +++ b/builtin/update-index.c
>> @@ -579,7 +579,7 @@ static int do_reupdate(int ac, const char **av,
>>  		 * or worse yet 'allow_replace', active_nr may decrease.
>>  		 */
>>  		save_nr = active_nr;
>> -		update_one(ce->name + prefix_length, prefix, prefix_length);
>> +		update_one(ce->name, NULL, 0);
>>  		if (save_nr != active_nr)
>>  			goto redo;
>>  	}
